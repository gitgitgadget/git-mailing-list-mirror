From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH/GSoC] add a add.patch config variable
Date: Fri, 25 Mar 2016 08:01:26 +0100
Message-ID: <CAP8UFD0KZk1nTgR8gdbedsAuw2ztWZDWri6EkeEkf8FhwS9yag@mail.gmail.com>
References: <1458853787-29807-1-git-send-email-d.f.fischer@web.de>
	<1458853787-29807-2-git-send-email-d.f.fischer@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: XZS <d.f.fischer@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 08:01:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajLkS-0002rD-Tf
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 08:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbcCYHB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 03:01:29 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37489 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbcCYHB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 03:01:28 -0400
Received: by mail-wm0-f52.google.com with SMTP id p65so13296918wmp.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=YuETS7tVF4atMbZZHvPzlUwtOo8bq6jW8GWm7JL4U8c=;
        b=ZsyFVy3MPgQdT27thpnuc9/P5FpCOVpxZD3qd/tKUW8Y1Hbtmxo4XKX/8qzuJqUtLr
         +9DB7+BbdJW2v6uKFMRTBh84WzbhnMXGtBZmgSYoGpLw/QwqiqFdZmXrKakyuloL/85v
         pu9MrwJtcmNEBHZtiAi8de/DBJUtdol3tDYa8cu7UKMmbD23AywUa5GmWVhjsfT6oc2M
         0rrNA+PTHrSCLrU/3oM3DFqM1jSkDIzWVwUN2TTvA8lvDO9Fqg3Y7n64DIH7txjYruTX
         L7tUQj0yNK0exzd0DSJCpU83NgoRPaSTqygXjpWgN8cFFbNXMD2CwirPRMxM9zDmisFz
         +qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YuETS7tVF4atMbZZHvPzlUwtOo8bq6jW8GWm7JL4U8c=;
        b=hLgi2nLS7nukkouXkI3hEgEl4Tn0LQGEB6dfJq3Re8B7mS0MLfpsjbRgxT77esir8q
         I6gAtt/hDcuM/nOcKW0FB9I2lQmkcCgHqzOCApUe628pMCtQGi5IDjZORDMjDNmb6ckB
         kr5aqTPPnLfW1fgVOSHdd24kaYod6nPig2GmuUItAxlyOBLdEJZCylmhQPzXDqkrRx5I
         7Sv4u6r38mRMSnyA5g37QXs54gxv66ZNAoqfl651PufXzQ7VaGDp/CPEe+RXQ12ssgNC
         eE9D//DxwreLYb8TELP7dWfDt2cQtP33hN0YXkADW92cgV2ZWVr3hzI8rHLeKzMu7Ynq
         U7WA==
X-Gm-Message-State: AD7BkJIjVr1b9pxd1sodbnNZZeQVL5iaLKVQ36cpafzGDa46OVfVR7Xm6tNTtFNuxGDntV+4MGpAqOBoRwduEA==
X-Received: by 10.194.60.200 with SMTP id j8mr13359651wjr.124.1458889286837;
 Fri, 25 Mar 2016 00:01:26 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Fri, 25 Mar 2016 00:01:26 -0700 (PDT)
In-Reply-To: <1458853787-29807-2-git-send-email-d.f.fischer@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289856>

On Thu, Mar 24, 2016 at 10:09 PM, XZS <d.f.fischer@web.de> wrote:
>
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index deae948..25e4b2e 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -380,4 +380,13 @@ test_expect_success 'patch mode ignores unmerged entries' '
>         test_cmp expected diff
>  '
>
> +test_expect_success 'patch mode can be activated per option' '
> +  git config add.patch true &&
> +  git reset --hard &&
> +  echo change >test &&
> +  echo y | git add -p > output &&

Why are you using "-p" if you want to test that the config option works?

> +  cat output &&
> +  grep "Stage this hunk \[y,n,q,a,d,/,e,?\]?" output
> +'
> +
>  test_done
