From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH] git-p4: Corrected typo.
Date: Sat, 29 Jan 2011 02:41:49 +0000
Message-ID: <AANLkTimLQxiB=dnd6=iB5uEpzOSfqks=FDJ=xORehuw8@mail.gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
 <1290648419-6107-1-git-send-email-vitor.hda@gmail.com> <AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
 <AANLkTikeB724f_vE6qvu1h1o5JG150mcmaHVBjLkOEWP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 29 03:42:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pj0m7-000372-TR
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 03:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab1A2CmU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 21:42:20 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61055 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab1A2CmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 21:42:20 -0500
Received: by qyk12 with SMTP id 12so4286558qyk.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 18:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Y6dFC4OQgjRTLsONXKW/R2IkLmWt+2UxQJThxRvklEo=;
        b=KIJr+aDJRJKVKWGepLT/ND/N1QmCKAjm8hVDpaZOEkg9RwMEgmXu0/QSYSYSW3udm/
         KaWcEeMzAPJiFtq7C6we8npwp9P5tEgCeQO9kacAfPtwBNS3ZFeA2w/tx1Gk38aYBRbH
         UCZerUk6Y83MvovRJg+nMOl0RzB1UgqsS+K28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=whKndXU/T7yuBRrtDls7OMpgYVznZ41vRHxdmZA805Gb8Q//qHIdxHqRZzL26034Qo
         1W+4ZEtg677MK9PYVXnKc2Vl6vjbyAcBc3f8D4bLYv6IYm5NKb1nv3eS5AD+2AqFfnvt
         MHwqZtCf8EmOikpL3ScXy0rP1c/h2OShmpgiE=
Received: by 10.229.213.13 with SMTP id gu13mr1565801qcb.196.1296268939123;
 Fri, 28 Jan 2011 18:42:19 -0800 (PST)
Received: by 10.220.192.8 with HTTP; Fri, 28 Jan 2011 18:41:49 -0800 (PST)
In-Reply-To: <AANLkTikeB724f_vE6qvu1h1o5JG150mcmaHVBjLkOEWP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165650>

Hi Thomas,

=46irst of all I'd like to thank you on your feedback. It's my first tr=
y
on creating submitting a patch, so having someone's guidance helps a
lot :)

I'll rebase my patches against the head of the tree and squash the fix
to avoid multiple commits. While I do that I'll also review my commit
message and sign-off the patches according to what you said. Hopefully
I will be able to do this during this weekend.

=46rom git-diff-tree man page:

"""
-M[<n>]
    Detect renames. If n is specified, it is a is a threshold on the
similarity index (i.e. amount of addition/deletions compared to the
file=92s
    size). For example, -M90% means git should consider a delete/add
pair to be a rename if more than 90% of the file hasn=92t changed.
"""

But from my latest tests I think that this option is ignored in
diff-tree (I think it's only used in git log). With this in mind I'll
need to add some code to implement the check of the score value of
diff-tree output string. Again from its man page:

"""
Status letters C and R are always followed by a score (denoting the
percentage of similarity between the source and target of the move or
copy), and are the only ones to be so.
"""

Thanks,
Vitor

On Fri, Jan 28, 2011 at 3:19 PM, Thomas Berg <merlin66b@gmail.com> wrot=
e:
> Hi,
>
> On Fri, Jan 28, 2011 at 12:35 AM, Vitor Antunes <vitor.hda@gmail.com>=
 wrote:
>> Hi everyone,
>>
>> Could anyone comment the 3 patches I sent (being this the last one)?
>>
> [...]
>> On Thu, Nov 25, 2010 at 1:26 AM, Vitor Antunes <vitor.hda@gmail.com>=
 wrote:
>>> ---
>>> =A0contrib/fast-import/git-p4 | =A0 =A02 +-
>>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p=
4
>>> index 0ea3a44..a466847 100755
>>> --- a/contrib/fast-import/git-p4
>>> +++ b/contrib/fast-import/git-p4
>>> @@ -618,7 +618,7 @@ class P4Submit(Command):
>>> =A0 =A0 =A0 =A0 if len(detectRenames) > 0:
>>> =A0 =A0 =A0 =A0 =A0 =A0 diffOpts =3D "-M%s" % detectRenames
>>> =A0 =A0 =A0 =A0 else:
>>> - =A0 =A0 =A0 =A0 =A0 =A0diffOpts =3D ("", "-M")[self.detectRenames=
]
>>> + =A0 =A0 =A0 =A0 =A0 =A0diffOpts =3D ("", "-M")[self.detectRename]
>>>
>
> This appears to me to be a bugfix for one of the other patches you
> sent, is that right?
>
> If so, maybe you could squash it with the previous patch and re-send
> it all to the list?
>
> My other comments for now are:
> - you have forgotten to sign off on the patches
> - commit messages are normally in imperative rather than past tense
> (see Documentation/SubmittingPatches in git)
>
> - In your first patch you wrote:
>> The detectRenames option should be set to the desired threshold valu=
e.
> I'm not sure what threshold value you refer to here, and what values
> you can set it to. Am I missing something?
> (I'm not very familiar with git rename detection options)
>
> I'm a git-p4 user, so I can test your changes and look a bit more at
> your code. Someone verifying it could help getting the patches
> applied.
>
> Thanks for improving git-p4!
>
> Cheers,
> Thomas Berg
>



--=20
Vitor Antunes
