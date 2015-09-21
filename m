From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3 1/2] git-p4: add test case for "Translation of file
 content failed" error
Date: Mon, 21 Sep 2015 08:49:21 +0100
Message-ID: <55FFB681.50500@diamand.org>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com> <1442766131-45017-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 09:49:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdvqp-0001D5-6M
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 09:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbbIUHtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 03:49:23 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34959 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbbIUHtW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 03:49:22 -0400
Received: by wicge5 with SMTP id ge5so103368391wic.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xTyRinCCuWav0zDtF7+T8XuXwGzjcCo2gH9+RqpwQAU=;
        b=MzbW/fLuVoDpBbAbNKHD/LJcUXshz331h3AC7j9HZMioV82h1uLKmJdfevM+SeO4Hc
         aMZCjgNZp5Rk2cE0mgtT2YbvxGKf+abAtZwq8IFcQtSMWDHUkljsDKekSq7ytRpaJnEO
         CmkHNLW86PrCiME2jXx9kwosPXtcsgVu8CVT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xTyRinCCuWav0zDtF7+T8XuXwGzjcCo2gH9+RqpwQAU=;
        b=gK/G65CigZipVYdnunwGNwgnhGX3fR5BQPgTU5rtJysHhr1o5TxKflsJXciaM+FNDz
         GRIG/2EjF0ILXE+9kcuKOQkrA4t3/iV7H63Ah8FolDMkZ46LK2IprKJNcx/AnqGyjfWu
         /+WEzW6PwtP0QWzMds7u0//77JyncmZdqegg+AI3lW8qF7kPPIPNDuCLD3IsANAlH93h
         TGovNfUOd/oCHYv3BvNo+U8yu/iCiI0FUELnwKMF8hbDLlmBW1XGUV8AhQEnJrIEz+tF
         1HNCtxOKFjO3SnzoibJE4RwjFdPItUSY5JbBdX4t/IEpSATyz7PmJM/p2xOWeAhiBCDI
         dPhw==
X-Gm-Message-State: ALoCoQnJrgbI9vi+t+T9ixAcv63QEQw8JyXLG2qLKpvwJ5FRIWbmQ2XtkBvW02UF0MTJsIoQu6iR
X-Received: by 10.194.175.104 with SMTP id bz8mr21409610wjc.42.1442821761281;
        Mon, 21 Sep 2015 00:49:21 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id lh3sm22626100wjc.44.2015.09.21.00.49.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2015 00:49:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1442766131-45017-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278285>

On 20/09/15 17:22, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>

When I run this, I get errors reported on the sed usage:

t9824-git-p4-handle-utf16-without-bom.sh:25: error: sed -i is not 
portable:             sed -i.bak "$ d" depot/file1,v &&
t9824-git-p4-handle-utf16-without-bom.sh:25: error: sed -i is not 
portable:             sed -i.bak "$ d" depot/file1,v &&


Luke


>
> A P4 repository can get into a state where it contains a file with
> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
> attempts to retrieve the file then the process crashes with a
> "Translation of file content failed" error.
>
> More info here: http://answers.perforce.com/articles/KB/3117
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   t/t9824-git-p4-handle-utf16-without-bom.sh | 49 ++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100755 t/t9824-git-p4-handle-utf16-without-bom.sh
>
> diff --git a/t/t9824-git-p4-handle-utf16-without-bom.sh b/t/t9824-git-p4-handle-utf16-without-bom.sh
> new file mode 100755
> index 0000000..517f6da
> --- /dev/null
> +++ b/t/t9824-git-p4-handle-utf16-without-bom.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description='git p4 handling of UTF-16 files without BOM'
> +
> +. ./lib-git-p4.sh
> +
> +UTF16="\227\000\227\000"
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'init depot with UTF-16 encoded file and artificially remove BOM' '
> +	(
> +		cd "$cli" &&
> +		printf "$UTF16" >file1 &&
> +		p4 add -t utf16 file1 &&
> +		p4 submit -d "file1"
> +	) &&
> +
> +	(
> +		cd "db" &&
> +		p4d -jc &&
> +		# P4D automatically adds a BOM. Remove it here to make the file invalid.
> +		sed -i.bak "$ d" depot/file1,v &&

This line is the problem I think.


> +		printf "@$UTF16@" >>depot/file1,v &&
> +		p4d -jrF checkpoint.1
> +	)
> +'
> +
> +test_expect_success 'clone depot with invalid UTF-16 file in verbose mode' '
> +	git p4 clone --dest="$git" --verbose //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		printf "$UTF16" >expect &&
> +		test_cmp_bin expect file1
> +	)
> +'
> +
> +test_expect_failure 'clone depot with invalid UTF-16 file in non-verbose mode' '
> +	git p4 clone --dest="$git" //depot
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
>
