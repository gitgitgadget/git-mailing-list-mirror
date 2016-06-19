Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A8120189
	for <e@80x24.org>; Sun, 19 Jun 2016 17:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbcFSRFK (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 13:05:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35598 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbcFSRFI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2016 13:05:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id a66so3746471wme.2
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 10:05:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gw4sQQ0YheReb0a77JfgE2hIZjsvPkkUC82szF1A1a0=;
        b=LOjl50q27mF8Om22lRsbUsqcbAmeT999rpX/cQyJD+yy5K4JAe7BD/8AaT5euM1rSv
         9AwVTepqdUNxxYMgoVCs/aZEaCyjKt0PD9lK5LbQ8z0IGDIMc3I+OxPsH2CPRg0nwpJ8
         PuOlgXVl8iOnIgN7xhSVvdV+YLi6bgk/kMhLTY/Jb+ToUQD9OyjYO+pJ44jmSLyRspl9
         vflh+gVEnIJGvO0iE3usYlLaWKr9cCYQGg6zYr4N1GHoj9tFLY+MGU6URu16ZslLSTB3
         2PgqkvYuH1McSmiHZP/0J5UmF2QHEKu/VV0JqH7whxxa0leT3NqVasTD+MSOVNBQxx6d
         kbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gw4sQQ0YheReb0a77JfgE2hIZjsvPkkUC82szF1A1a0=;
        b=R0hMINI+8lhHVXdnc1MX16jmSAG/8RPsYOhMvQe6+hxlxCiLpqzFNtMg5sMJUsVsUe
         UVg8e+Yz4yvl2hlwwM1rFTaI9Tv5tTM6KW3rdFaD7ODlo1pBJ+DvtG+Ce5Ux88FEK0pK
         dqpFidj9npbs19zd1IaWGOifV71VbYKrK7w2AOctbp1g5j1RKqZv2S44KNzdpkoxmmgC
         cmVsRspwiz+c6RSbpww3zy+DPGVZnEzPYgAO8iOqu1cHE2n6e8GjXNSOow00dUQ+Mnt7
         /J4egi0qZbtGu5ODKTGmXHaZ8rijTYoNyMlduT72LOK6JrpplRzA7HtYDk2zLcUrCSnO
         s6XQ==
X-Gm-Message-State: ALyK8tKKF17yWnqgrYrkZICXUKkhs4R/J0DxBKPgrADNSMkvW+QeS1lfKklDBIjuEXifqw==
X-Received: by 10.194.52.74 with SMTP id r10mr10650725wjo.50.1466355906171;
        Sun, 19 Jun 2016 10:05:06 -0700 (PDT)
Received: from neu4sfhg12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 124sm4336182wml.12.2016.06.19.10.05.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jun 2016 10:05:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: enable web server tests t55xx on Linux
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <1463647511-54811-1-git-send-email-larsxschneider@gmail.com>
Date:	Sun, 19 Jun 2016 19:05:04 +0200
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6C0F6649-C238-475E-BAA5-5F3A0EC5DA2D@gmail.com>
References: <1463647511-54811-1-git-send-email-larsxschneider@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 19 May 2016, at 10:45, larsxschneider@gmail.com wrote:
> 
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Install the "apache" package to run the Git web server tests on
> Travis-CI Linux build machines. The tests are already executed on OS X
> build machines since the apache web server is installed by default.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> .travis.yml | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index adab5b8..3c54080 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -18,6 +18,7 @@ addons:
>   apt:
>     packages:
>     - language-pack-is
> +    - apache2
> 
> env:
>   global:
> @@ -30,6 +31,7 @@ env:
>     - DEFAULT_TEST_TARGET=prove
>     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>     - GIT_TEST_OPTS="--verbose --tee"
> +    - GIT_TEST_HTTPD=true
>     - GIT_TEST_CLONE_2GB=YesPlease
>     # t9810 occasionally fails on Travis CI OS X
>     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
> --
> 2.5.1
> 

Hi Junio,

is there any chance to pick this up? It would enable the web server
tests on Travis CI.

Thanks,
Lars

