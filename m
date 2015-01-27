From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-push.txt: document the behavior of --repo
Date: Tue, 27 Jan 2015 17:07:19 -0500
Message-ID: <CAPig+cQCf+vKbZ5ydFSNmGCUvmCkQW-DEPhO1JAAap1VorhXsA@mail.gmail.com>
References: <xmqqppa1mrku.fsf@gitster.dls.corp.google.com>
	<d8bed5c1736a4a291208227b0f54c1039d67f5cc.1422361902.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Prem <prem.muthedath@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:07:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGEI9-0002zU-KL
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 23:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759982AbbA0WHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 17:07:21 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:56771 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780AbbA0WHU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 17:07:20 -0500
Received: by mail-yh0-f42.google.com with SMTP id a41so7249499yho.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iicxyLtK/22LNYVkQWYEV5QEbcUaCIyfkp0Faq0aTRs=;
        b=J0vS+zAfW2Pp7yZTa4IFH+H80h8henH8am9g68Xs6d8Fjf46HsPDgwZPfN/UqmWJ5n
         B+LBsCo3gQXYFuf6Bbi7iEqJI81b565H8Ib6bVXuScTDeyXRAR7LO7wm8HaQiCITij+t
         mUWI5p2YYliV4h5u815v4aMVSqaBpbVViGsHcBeEqx9kmElWWtHHnahXhafIZ1OljXo9
         MBmknRM7lofbMCR28zTfHm7w94yottoLS/3gOIdIVNcjNCQc9wBn9tJGd+YOD2X14SPr
         rCpBr5TxvA+TdpN2q/X9k2e2G0Nku90ajuXb2SjEqt9Gu/90bbl7Sb8Iz1lMDafNfzCs
         AlPw==
X-Received: by 10.236.202.238 with SMTP id d74mr41597yho.166.1422396439711;
 Tue, 27 Jan 2015 14:07:19 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 27 Jan 2015 14:07:19 -0800 (PST)
In-Reply-To: <d8bed5c1736a4a291208227b0f54c1039d67f5cc.1422361902.git.git@drmicha.warpmail.net>
X-Google-Sender-Auth: rqNP_modeyS3EFNiNiyoZ1S5YG8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263092>

On Tue, Jan 27, 2015 at 7:35 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> As per the code, the --repo <repo> option is equivalent to the <repo>
> argument to 'git push'. [It exists for historical reasons, back from the time
> when options had to come before arguments.]
>
> Say so. [But not that.]
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index ea97576..0ad31c4 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -219,22 +219,8 @@ origin +master` to force a push to the `master` branch). See the
>  `<refspec>...` section above for details.
>
>  --repo=<repository>::
> -       This option is only relevant if no <repository> argument is
> -       passed in the invocation. In this case, 'git push' derives the
> -       remote name from the current branch: If it tracks a remote
> -       branch, then that remote repository is pushed to. Otherwise,
> -       the name "origin" is used. For this latter case, this option
> -       can be used to override the name "origin". In other words,
> -       the difference between these two commands
> -+
> ---------------------------
> -git push public         #1
> -git push --repo=public  #2
> ---------------------------
> -+
> -is that #1 always pushes to "public" whereas #2 pushes to "public"
> -only if the current branch does not track a remote branch. This is
> -useful if you write an alias or script around 'git push'.
> +       This option is equivalent to the <repository> argument; the latter
> +       wins if both are specified.

To what does "latter" refer in this case? (I presume it means the
standalone <repository> argument, though the text feels ambiguous.)

Also, both the standalone argument and the right-hand-side of --repo=
are spelled "<repository>", so there may be potential for confusion
when talking about <repository> (despite the subsequent "argument").
Perhaps qualifying it as "_standalone_ <repository> argument" might
help.

>  -u::
>  --set-upstream::
> --
> 2.3.0.rc1.222.gae238f2
