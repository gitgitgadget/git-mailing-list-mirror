From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 01/12] git p4 test: remove bash-ism of combined export/assignment
Date: Sat, 15 Sep 2012 22:25:01 +0100
Message-ID: <5054F22D.2020909@diamand.org>
References: <1347221773-12773-1-git-send-email-pw@padd.com> <1347221773-12773-2-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 23:26:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCzsO-0005Ey-Vf
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651Ab2IOVZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:25:05 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63632 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab2IOVZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:25:04 -0400
Received: by wibhr14 with SMTP id hr14so1054649wib.1
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 14:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=+tI8m0LgIBltvIKzwFPrRPNk38Ti9Cm9xCeQmRwKqrU=;
        b=Z+/+F0CMmYxP/R5b11Suze85wAk1aMIwFcutrM1zPGOYCb1qqVNdez5uxtrn1sCPn3
         EUMZuHNGkgugPkzfJeHQPDbudmKFicPtlnv83PoYpXsIVmKKlZryY+fF0mLTLYZzb7ek
         eSTqxb8GuIinXokDOMvFTpkdQJc33ZpxmI41uzZKL2LMkM4ghThHuLF5hWdRCZ9HXT3G
         1QFVIN7Ex8Z3P904En0uCgPgDg5m6n0TaDERtxIXZSxCqp24C/keca1JKJDhqj84izKp
         93OBG/va9CD9OS3xjVV0y5CVU3a23nH0MnSi2tHHwwU9i+ZPcgC8bIuCivbhtPWBIaTf
         4eaQ==
Received: by 10.180.97.106 with SMTP id dz10mr6536500wib.21.1347744302694;
        Sat, 15 Sep 2012 14:25:02 -0700 (PDT)
Received: from [86.6.26.120] (cpc21-cmbg14-2-0-cust119.5-4.cable.virginmedia.com. [86.6.26.120])
        by mx.google.com with ESMTPS id r9sm10917031wia.2.2012.09.15.14.25.01
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 14:25:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <1347221773-12773-2-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQmsai9UUiv5wGQonIGYu2ar7jXqHm36gYG0RZea9A5s5EOEAVlimQyBzGysdqgjqYqxkmO2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205581>

Looks good to me, ack.

On 09/09/12 21:16, Pete Wyckoff wrote:
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   t/lib-git-p4.sh | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 2d753ab..482eeac 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -26,9 +26,10 @@ testid=${this_test#t}
>   git_p4_test_start=9800
>   P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
>
> -export P4PORT=localhost:$P4DPORT
> -export P4CLIENT=client
> -export P4EDITOR=:
> +P4PORT=localhost:$P4DPORT
> +P4CLIENT=client
> +P4EDITOR=:
> +export P4PORT P4CLIENT P4EDITOR
>
>   db="$TRASH_DIRECTORY/db"
>   cli=$(test-path-utils real_path "$TRASH_DIRECTORY/cli")
