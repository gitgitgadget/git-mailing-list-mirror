From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: git grep --no-index and absolute paths don't work?
Date: Fri, 21 Oct 2011 19:35:23 +0200
Message-ID: <CAKPyHN3oLC-F2pBZtBu4494V5UR6-yALzCsTkDmG7-a13YCnng@mail.gmail.com>
References: <CAKPyHN138OZRt_3PT5ChuTpSEuOdybnyAj8Baqr=3OD=y==jgw@mail.gmail.com>
	<7vipni8el6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 21 19:35:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHJ0E-0000Ii-OC
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 19:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111Ab1JURfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 13:35:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36873 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab1JURfY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2011 13:35:24 -0400
Received: by vws1 with SMTP id 1so3150427vws.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2s85NCBn3jLb6o3Lgc57W7xWxyGntChzfYU8EYgzW0M=;
        b=V926cbOfGMwnP4DLsWIRsnQ7oogpNJw/BBE98wsMwfYCAzCidaDx9fQmlX5fLPWf/F
         smQVTREzKPQQRFRVJ4CkF/g0WrMqMuPNamvg5iadIIzjUbZO7kZxulMaJy3XjZ0kxzg+
         PVdNEA80P6QZ4zNNwlW8yHFgHytPzyn3kKAbg=
Received: by 10.52.72.196 with SMTP id f4mr15343621vdv.68.1319218523077; Fri,
 21 Oct 2011 10:35:23 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Fri, 21 Oct 2011 10:35:23 -0700 (PDT)
In-Reply-To: <7vipni8el6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184073>

On Fri, Oct 21, 2011 at 19:00, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> I'm currently =C2=A0totally confused, that a
>>
>> =C2=A0 =C2=A0 git grep --no-index foo /usr/include
>>
>> does not work. I know that the documentation says "in the current
>> directory" for the --no-index flag.
>
> I think "in the current directory" is just contrasting with "in the w=
ork
> tree, ..." at the beginning of the DESCRIPTION section. We could say =
"in
> the files" instead for clarity, and then add "when pathspec is not gi=
ven,
> files in the current directory is searched" or something.
>
> The intent of "--no-index", originating from "git diff --no-index", i=
s to
> allow git tools to be used in non-git context, i.e. to files on the
> filesystem.
>
> "git grep --no-index" which is a later invention in the 1.7.0 era did=
n't
> fully ignore "git"ness, and one such instance you fixed in this threa=
d:
>
> =C2=A0 =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/1=
81484/focus=3D181485
>

Thats why I'm completely rattled after trying an absolute path with
--no-index and it didn't worked.

> I think this path normalization is another instance of us knowing a b=
it too
> much of "git" even when we are told with "--no-index" that we are not
> operating on a working tree associated with git.
>

So we agree that this is a bug. Good. I will try to have a look into th=
is.

Bert
