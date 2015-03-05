From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/2] git-C: Add test to check "git -C ''"
Date: Thu, 05 Mar 2015 16:32:12 +0530
Message-ID: <54F837B4.2060003@gmail.com>
References: <1425553031-22264-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 12:03:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTTY2-0005Af-OR
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 12:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbbCELCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 06:02:23 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33523 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbbCELCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 06:02:19 -0500
Received: by padet14 with SMTP id et14so45202003pad.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 03:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0dZUjz48gjCkxU/eHkHYD1TX3Ln2pPuU5rkBjFGG3ag=;
        b=OtEduGYKql2cSFFF4elCWsafE0fsWKBlb/Dyzu+GBwqFiHGNmgDQfIIKH8BBbZEK42
         SmYRMhcbqrdqPNNwsVPpZJxJORwAPHI74pLJTnUco3cZ9yLkiGGloxYJ+RY+Mks4jei0
         ZDG71Qs4q1y8smvyvsChnYGWldaWprPXOE2KecZPmnzzWLDiZQGCuBC+vE0FpGknSfmj
         NW28/c/fmURQ2as/iEgsxEnTIBiOsJAZOC5HikOse2ovvQFHI9IxKiPzruTV4lCyYFl9
         XOY1firvk3MizZu6/9E9bQPgDlvJ4FjiOlD+gIrxHbX6QOxuaWGhsH6IUoc64WK0MQyD
         VnSA==
X-Received: by 10.70.28.99 with SMTP id a3mr14534434pdh.81.1425553338746;
        Thu, 05 Mar 2015 03:02:18 -0800 (PST)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id ei3sm6547225pbc.91.2015.03.05.03.02.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 03:02:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1425553031-22264-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264830>


On 03/05/2015 04:27 PM, Karthik Nayak wrote:
> Add a test to check whether "git -C ''" works
> without giving an error. This is achieved by
> adding a commit and checking the log using
> "git -C ''" and comparing the log message with
> the commit message.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   t/t0056-git-C.sh | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
> index 99c0377..1cefd4a 100755
> --- a/t/t0056-git-C.sh
> +++ b/t/t0056-git-C.sh
> @@ -1,3 +1,4 @@
> +
>   #!/bin/sh
>
>   test_description='"-C <path>" option and its effects on other path-related options'
> @@ -81,4 +82,13 @@ test_expect_success 'Relative followed by fullpath: "-C ./here -C /there" is equ
>       test_cmp expected actual
>   '
>
> +test_expect_success 'Should not barf when "git -C "" cmd" is used' '
> +    echo 1 > a.txt &&
> +    msg="initial a.txt" &&
> +    (git add a.txt && git commit -m "$msg") &&
> +    echo "$msg" >expected &&
> +    git -C "" log --format=%s >actual &&
> +    test_cmp expected actual
> +'
> +
>   test_done
>
Ignore This, Didnt connect it to the first patch!
