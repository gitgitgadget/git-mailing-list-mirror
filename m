From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Clarify pre-push hook documentation
Date: Sun, 23 Mar 2014 21:40:52 -0400
Message-ID: <CAPig+cSCGRkWioaEnCjKS4c981dnCVbeej-9bCTztfc-wnbhbA@mail.gmail.com>
References: <1395601267-78377-1-git-send-email-dcow90@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: David Cowden <dcow90@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 02:41:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRttC-0007HV-L7
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 02:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbaCXBk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 21:40:57 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:35757 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbaCXBkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 21:40:53 -0400
Received: by mail-yh0-f44.google.com with SMTP id f10so4558549yha.3
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 18:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0o9KvIbn0Pp7mt3zFqviYNKo73vCFpHK4qfXDhA8Emg=;
        b=C20Sa/5Evm0X/AZNyUb/yOkPI4IIiCNgYh67mrQVyE+Fwr0EtiJ7TkkuYcoyxiYZq8
         wvsvmXxaaiC/rRn6B9ZXgSPx4VNUV+NK3xHJAURDMs+A+KtWgu9q+BOBqa/TBX3qe86+
         //u+UMB55YfESY/WYZP6Qi5XJ+bHEGQcviIif/lunEXblv+1r52XGfzU/Xs3m47+Af+u
         21rJgLFvprwwZmqH2d5EvPYIMX0a5ZsDNcSuu4+yo6+Q004NgGVVQf0K9pFH35yOjmHO
         JiEkW8DbJFlSD2p6uIZ2u5SFN9E1YrKTj0rkhQ578HkKHT93M4PHDse8aGrp9n1DESnz
         Wh7Q==
X-Received: by 10.236.142.198 with SMTP id i46mr86315079yhj.66.1395625252822;
 Sun, 23 Mar 2014 18:40:52 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Sun, 23 Mar 2014 18:40:52 -0700 (PDT)
In-Reply-To: <1395601267-78377-1-git-send-email-dcow90@gmail.com>
X-Google-Sender-Auth: JwTmuaD4bNSsOeEd5ctf-V5UEiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244810>

On Sun, Mar 23, 2014 at 3:01 PM, David Cowden <dcow90@gmail.com> wrote:
> The documentation as-is does not mention that the pre-push hook is
> executed even when there is nothing to push.  This can lead a new
> reader to beilieve there will always be lines fed to the script's
> standerd input and cause minor confusion as to what is happening

s/standerd/standard/

> when there are no lines provided to the pre-push script.
>
> Signed-off-by: David Cowden <dcow90@gmail.com>
> ---
>
> Notes:
>     c.f. http://stackoverflow.com/questions/22585091/git-hooks-pre-push-script\
>     -does-not-receive-input-via-stdin
>
>  Documentation/githooks.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index d954bf6..a28f6f7 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -203,6 +203,10 @@ SHA-1>` will be 40 `0`.  If the local commit was specified by something other
>  than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
>  supplied as it was originally given.
>
> +The hook is executed regardless of whether there are changes to push or not.
> +In the event that there are no changes, no data will be provided on the
> +script's standard input.
> +
>  If this hook exits with a non-zero status, 'git push' will abort without
>  pushing anything.  Information about why the push is rejected may be sent
>  to the user by writing to standard error.
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
