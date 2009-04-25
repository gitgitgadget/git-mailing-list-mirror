From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 19:01:48 -0500
Message-ID: <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904240051.46233.johan@herland.net>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <20090424231632.GB10155@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 02:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxVMb-0000Ro-1C
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 02:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbZDYABv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 20:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbZDYABu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 20:01:50 -0400
Received: from mail-qy0-f111.google.com ([209.85.221.111]:57169 "EHLO
	mail-qy0-f111.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbZDYABt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 20:01:49 -0400
Received: by qyk9 with SMTP id 9so2662272qyk.4
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a6yc++BtkeBXrOsSp8s75u78aEJwQK8uR5aOsFVG1rg=;
        b=eCE0uRVA7PU5I5J6XUcNyEBu6azy+xvswcJwNUwEO5Xw0+PhjZt8KA3BRluX+VTP6v
         q8u68Pzg+pct6GSTr+XDVlpp/6afA/taTrRoyI9RaOumlSL3sz3s+XAJ0q/0QDS1EUn6
         XAF4yAdFIzA3VuQ1pOJ3ZGBFmUNJKdVqn94pI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N0I9m5c9KrwZsaNmxPT3gEOcsDHkUdedGoVU1njC9DP6PqX19h1Ky4X2U/PaVqYuWs
         FJ4Snr+tF6Gz/9HTNodA6/3bYpVlgxKIzjJDZQaEqAiP8+O0bmRjAosYYEXGvTNURBzv
         yInqNRAPqW3nx3iz1BeITZnzNbuzHh+JWDF88=
Received: by 10.224.37.4 with SMTP id v4mr3680634qad.66.1240617708602; Fri, 24 
	Apr 2009 17:01:48 -0700 (PDT)
In-Reply-To: <20090424231632.GB10155@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117525>

2009/4/24 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> In fact, I think it's important to note that the notation:
>>
>> =A0 =A0 git show master:Makefile
>>
>> actually involves a translation from a Unix filesystem address to a
>> git object address that is then used to find the relevant data.
>
> Hm? Resolving master:Makefile means to first find what master is, mos=
t
> likely the shortname for refs/heads/master. That usually references a
> commit object (by its name). The "<tree-ish>:<path>" syntax then caus=
es
> git to lookup the tree referenced by that commit (again, by its name)=
=2E
> And then the tree entry for "Makefile" is looked up, leading to the n=
ame
> for the object identified by "master:Makefile".

=46irstly, your head is too bound to low-level implementation.

Secondly, you've basically just expounded upon what I said. The
Makefile part is for humans to write using a filesystem path (address)
that is mapped into what I call a git address. The point is that the
user is interfacing between two theories of content storage.

>> In fact, I think masking this kind of thing with a catch-all word
>> 'reference' is a bad idea.
>
> "master:Makefile" is not a reference. Just "master" is a shortname fo=
r a
> reference, the full name might be refs/heads/master.
>
> git has:
> =A0- object names (which happen to be SHA-1 hashes).
> =A0- references (which reference objects by their names)
> =A0- symbolic references (which reference other references by their n=
ames)
>
> The "<tree-ish>:<path>" syntax is not called "reference".

I will admit that I used this term wrongly then, and that git has a
set of terminologies much closer to what I proposed:

    * object addresses: object names
    * pointers: references
    * handle: symbolic reference (I don't know, I just now made that on=
e up)

I was under the impression that object names were in fact called
references and that things like '[refs/heads/]master' were just
considered conveniences. I'm glad to have been disabused; though I
like my terms better ;-D

>> Rather than being hidden, it should be exposed: I think it would be
>> beneficial to use the word 'address' rather than 'reference' when
>> talking about the SHA-1 names. Then HEAD could be called a pointer
>> variable, etc.
>
> What's wrong with just calling the object name "object name"?

What's wrong with calling the object address "object address"?

As I've stated: "address", "pointer", and "handle" are an analogy to
terminology that has been around for ages. In fact, another name for
"pointer" is "reference".

> are something different, and the above "master:Makefile" is yet a
> different thing, using the "extended SHA1" syntax to identify an obje=
ct.

It is certainly something different. It's an interface between
theories of content storage.

>> So, a pointer variable's value is an object address that is the
>> location of an object in git 'memory'. I think using this approach
>> would make things significantly more transparent.
>
> But then HEAD would be a pointer pointer variable (symbolic ref), unl=
ess
> you have a detached HEAD.

We call those handles.
