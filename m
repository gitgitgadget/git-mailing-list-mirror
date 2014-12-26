From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] send-email: Much readable error output
Date: Sat, 27 Dec 2014 00:38:17 +0100
Message-ID: <87k31e56dy.fsf@gmail.com>
References: <1419595599-19974-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, 0xAX <kuleshovmail@gmail.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 27 00:38:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4eSe-0008Jy-Vf
	for gcvg-git-2@plane.gmane.org; Sat, 27 Dec 2014 00:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbaLZXiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2014 18:38:21 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:51779 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaLZXiU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2014 18:38:20 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so15083869wgh.23
        for <git@vger.kernel.org>; Fri, 26 Dec 2014 15:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=po7Pdi5viR/0eiOdJ2UnwNZMgfoBUshTJD/bFoSvBUo=;
        b=IV6+jY6L6loDI7NhwAg0gMUwiRBjnW4GEi/Vkzqtvyw7GwK9N7Knbuiyepf3HzKqSl
         B3FE5qLLqUbpqly/iydHgssSOXdKY8X6gOlpUtqxBNHhYJHGdotIAVe2Ahouqv6vJo3G
         Yi1mXx766NqMRSWF81gKaJ/lUMvTM+BcNa5A3/pdTSaERooszS916mzHV3JCYGi/KUKk
         wLbYFHz8wOjE2MKX/jOr7VhO2CA3ZYmO5PNnnGPOrMhJur0VPjxldnPd29oBSi75fY8Z
         pyBEBPRVOdw4c4SDaJwzLA+5ppjOB8G/3s19IjI12NwzwIuHDpf1XA2nDVViVENsE7IU
         lrLw==
X-Received: by 10.194.62.235 with SMTP id b11mr6615248wjs.73.1419637099065;
        Fri, 26 Dec 2014 15:38:19 -0800 (PST)
Received: from localhost ([95.232.108.220])
        by mx.google.com with ESMTPSA id gl5sm33074118wib.0.2014.12.26.15.38.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Dec 2014 15:38:18 -0800 (PST)
In-Reply-To: <1419595599-19974-1-git-send-email-kuleshovmail@gmail.com>
User-Agent: Notmuch/0.19~rc1+3~g0d8251d (http://notmuchmail.org) Emacs/24.4.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261833>

Hi,

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Signed-off-by: 0xAX <kuleshovmail@gmail.com>

Please use your full name for the sign-off.

> ---
>  git-send-email.perl | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 82c6fea..6a995c4 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1274,11 +1274,11 @@ X-Mailer: git-send-email $gitversion
>  		}
>
>  		if (!$smtp) {
> -			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
> -			    "VALUES: server=$smtp_server ",
> -			    "encryption=$smtp_encryption ",
> -			    "hello=$smtp_domain",
> -			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
> +			die "Unable to initialize SMTP properly. Check config and use --smtp-debug.\n",
> +			    "VALUES: server=$smtp_server\n\t",
> +			    "encryption=$smtp_encryption\n\t",
> +			    "hello=$smtp_domain\n\t",
> +			    defined $smtp_server_port ? "port=$smtp_server_port\n" : "\n";

Minor nits:
  - I think this would be easier to read if the \t was on the line which
    should be indented.
  - If $smtp_server_port is not defined we produce an unnecessary empty line

>  		}
>
>  		smtp_auth_maybe or die $smtp->message;
> --
> 2.2.1.202.g98acd41
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
