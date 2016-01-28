From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] stash: use "stash--helper"
Date: Thu, 28 Jan 2016 12:59:41 -0800
Message-ID: <CAGZ79kaPQP+-LpW8ExM2wmfftW4_oa7tB5XdfsdC8XHwH4aFOA@mail.gmail.com>
References: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
	<0000015289f33e85-713596a1-2718-4c3a-bf3c-4a0f1048d401-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthias Asshauer <mha1993@live.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 21:59:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOtfP-00056p-5H
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 21:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086AbcA1U7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 15:59:43 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:33057 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbcA1U7l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 15:59:41 -0500
Received: by mail-io0-f176.google.com with SMTP id f81so68145699iof.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 12:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QSoRjrykGpCs89BoMKmqv630ymuElkWRCAmPFTjCVK4=;
        b=N0iPcDaK9RYAUawKe4UUDZpV3lRZY3VyHtUoAxTKBUoG9Q1DiaoEog0mh8NIJl5/Dk
         Ze6h1LvLnr0GXX2upuVc9oCjcWMtn9xZfOECSRtEhMvxFQ0fmgPn1ktHRvUAA1MxpfYa
         C0wQs9ejJL5xPpep8Zl0lOcID5eh5EmwP6xC+4IciBD8w2XYuSulvZUhMpaP3BwWeGJ7
         5svT88iHT4WPTm09UdMuB2wYJbo5+UoWyuNi7wlNSRGKVEYS8OT83VbgeOouvdUsoNcg
         GuIkdVIL6qXemDrbTifTSgUVBzLXMY230uLzXzRC++nkl/D/WMS8qB44P8nfnz54R4TK
         GPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QSoRjrykGpCs89BoMKmqv630ymuElkWRCAmPFTjCVK4=;
        b=EvZ9M2Btkr0xQ7dk51+oW3N2vdXqCr8k1/LwFVLRKIBjJ3RtqHrZKczIqNf0Hs+Eoa
         jfSDLcs3rtSyyyzM2FaS4rTEjn02WEUuBXakzYLVcqGinPC+IBlDzlcwcJvhXnSrz59M
         f66BwGDrujcAMkNXg6ccacU3d2YUdz0G/16rU1XVKfBSUe0xXQdvGkheRYPXtSUlib0B
         4l9PJSWfxI4QDxqDqCMWKNiEBHJt54wVBpGPTa9NLxs//vafsohlMc6DlZ9XNPhnN1oy
         Llp7G7S3oG1+tyL1oIi4ebQYj7bq4eFkN0uIvJV0YKE1u4QgTbliBQOu+q5gQ9w0PgK+
         q83w==
X-Gm-Message-State: AG10YORJQLP/ihBf7HQEwXqh+Fw9k0xG7UdEwmUvFbs+DX/xwraheLO4elDxZUcyhqroNXb1nffBBzRRQee5t1hA
X-Received: by 10.107.168.149 with SMTP id e21mr2981642ioj.96.1454014781106;
 Thu, 28 Jan 2016 12:59:41 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 28 Jan 2016 12:59:41 -0800 (PST)
In-Reply-To: <0000015289f33e85-713596a1-2718-4c3a-bf3c-4a0f1048d401-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285029>

On Thu, Jan 28, 2016 at 12:36 PM, Matthias Asshauer <mha1993@live.de> w=
rote:
> From: Matthias A=C3=9Fhauer <mha1993@live.de>
>
> Use the new "git stash--helper" builtin. It should be faster than the=
 old shell code and is a first step to move
> more shell code to C.

You had some good measurements in the coverletter, which is not going t=
o be
recorded in the projects history. This part however would be part of th=
e commit.
So you could move the speed improvements here (as well as the other rea=
soning)
on why this is a good idea. :)

>
> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> ---
>  git-stash.sh | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index c7c65e2..973c77b 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -112,15 +112,7 @@ create_stash () {
>         then
>
>                 # state of the working tree
> -               w_tree=3D$( (
> -                       git read-tree --index-output=3D"$TMPindex" -m=
 $i_tree &&
> -                       GIT_INDEX_FILE=3D"$TMPindex" &&
> -                       export GIT_INDEX_FILE &&
> -                       git diff --name-only -z HEAD -- >"$TMP-stagen=
ames" &&
> -                       git update-index -z --add --remove --stdin <"=
$TMP-stagenames" &&
> -                       git write-tree &&
> -                       rm -f "$TMPindex"
> -               ) ) ||
> +               w_tree=3D$(git stash--helper --non-patch "$TMPindex" =
$i_tree) ||
>                         die "$(gettext "Cannot save the current workt=
ree state")"
>
>         else
>
> --
> https://github.com/git/git/pull/191

Oh I see you're using the pull-request to email translator, cool!

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
