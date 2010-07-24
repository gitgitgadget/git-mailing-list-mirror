From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: RFC: Between git-subtree and git-submodules
Date: Fri, 23 Jul 2010 20:57:06 -0400
Message-ID: <AANLkTinyjinsGS2ddyMOW=3zDN1ThJcpF+dc4cBE6L9D@mail.gmail.com>
References: <AANLkTi=tDRfgzzcbp0jV=+hQ+Cs2fhNF0vK8JL1COoFu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Jul 24 02:57:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcT3i-0005ms-O7
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 02:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab0GXA5c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 20:57:32 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46158 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab0GXA5b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 20:57:31 -0400
Received: by wwf26 with SMTP id 26so1183780wwf.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 17:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6DCZ1EgqLrvVzXPz5cRimVueCD8HUwBMSB9JNpgBtJw=;
        b=PvjkeE2tp6X4cFdbWkPr2vS7EWByFqCApZ8TwgQ7UvQPsLT6nnxr1iePA1t/ZTPs7A
         IVXwbcGN5TO841HbTxRu11PL30KVDL7Q5nfWvBBguD9YhjbMAq6Pt5wyXhjR77YX+AE4
         XdCGxMSe6nkgStA44JE5ZrBcDRqHMcgodQCic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bZAfpygIajMJ3m8d4ie0WbdRbjOio35n91+x6R1ahkMfJ1VGA5UDxGMv3mphAuEyGK
         ribbazO9MRYAE5PugbKVf+6XCfqgfQKgQnDzmHzzbnyjjd142BpSm7c1vyBWifIEtZ0c
         1nMtzE0JnG2JLiUNvfUPfloJRUPCGtj7ZCd4g=
Received: by 10.216.159.202 with SMTP id s52mr4263335wek.33.1279933046313; 
	Fri, 23 Jul 2010 17:57:26 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Fri, 23 Jul 2010 17:57:06 -0700 (PDT)
In-Reply-To: <AANLkTi=tDRfgzzcbp0jV=+hQ+Cs2fhNF0vK8JL1COoFu@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151587>

On Fri, Jul 23, 2010 at 8:13 PM, Santi B=E9jar <santi@agolina.net> wrot=
e:
> =A0First my requirements:
>
> 1) Everything[a] must be available from the same repository/branch (s=
o I'm not
> =A0 worried about repository size)
> 2) The history must be as clean as possible
> 3) The directory content must be equal to the external module, at lea=
st when
> =A0 you add/update it[b]
> 4) The external module should be able to switch back and forth betwee=
n
> =A0 different versions.
>
> [a] Everything means all that you need to checkout all the commits in=
 the
> superproject not in the submodule.
> [b] A consequence of #3 is that I lose all
> change I've made in the subdirectory, if they are important I have to=
 extract
> them, apply them and add the module back.
>
> git-submodule is rule out because of #1 but accomplish #2, #3 and
> #4. git-subtree is rule out because of #2 (even with --squash).
> [It fails at] #3 and #4
> without --squash but accomplish #1 and #4 with --squash. So I need so=
mething
> in between or a mixture of both.

I admit to having had some trouble parsing the above, so I moved some
punctuation marks around.  Please let me know if I've made a mistake.

If I understand correctly, you're claiming (indirectly) that
git-subtree without --squash does not accomplish #1.  I don't see how
this is the case.  Am I misreading?  I think git-subtree accomplishes
#1 in both modes.

I don't understand what you mean when you say (#2) git-subtree doesn't
keep your history "as clean as possible."  What is "as clean as
possible" and what part of git-subtree's history results don't you
like?  (Of course it's very different with and without --squash.)

With #3, I can see that you want something different than I do; you
want to silently revert your own patches out of the submodule's
history, when you upgrade the submodule to a new version.  Personally,
I find this concept a bit objectionable (it's like "git merge -s
ours"), but okay, it's pretty easy to implement, and you've submitted
a patch to git-subtree that does it.  My question is: why would you
want this?  Isn't it clearer to 'git revert' the patches you don't
want?

And for #4, it's true that git-subtree without --squash does not allow
you to easily rewind to an older version of the submodule, while with
--squash it does.

It sounds to me like, if we added your patch to git-subtree, then
git-subtree --squash would solve #1, #3, and #4.  And maybe we could
fix #2 as well. Correct?

Thanks,

Avery
