From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: Use -m when running p4 changes
Date: Fri, 17 Apr 2015 00:15:28 +0100
Message-ID: <55304290.9070907@diamand.org>
References: <CALM2SnY62u3OXJOMSqSfghH_NYwZhzSedm3-wcde-dQCX6eB9Q@mail.gmail.com>	<CAE5ih79UcJfuhzgTdTPy2K51sa6--4bvaVaKL3nsUcC2kq4Ffg@mail.gmail.com> <CALM2SnafBHz8YeWtUtQDUgLBP_s9AiJy=9UC6XveqP0zrYMEqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Lex Spoon <lex@lexspoon.org>
X-From: git-owner@vger.kernel.org Fri Apr 17 01:16:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yit0s-0008JV-Hm
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 01:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbbDPXP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 19:15:58 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33142 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbDPXP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 19:15:56 -0400
Received: by wgin8 with SMTP id n8so96484819wgi.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 16:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=p/jTjIa4+QBD4tljL2oj5OTPIue3PfricBA8S126CFE=;
        b=Pj1PjbPq7HgzJPn1fXqiRfhw6UhKywOjsLf+FBL9Vc9GK/C0/GTWs5QzS1N207oLu6
         2mfMn1sh//HxP6iYD4JZEtmmaYMLRNkkKl0+kEmhfb50QfHdUSaiRfrDryXF3wS47HQd
         hqVQ6b6+28XE+3ZVUtWqS14DMgg8lLPiqz9E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=p/jTjIa4+QBD4tljL2oj5OTPIue3PfricBA8S126CFE=;
        b=LC8WDHol0rncBKxYI//G+Jqb3GRarryadczwkY120Mo/X98javKPcoI1u1p2PgvqsZ
         KIckrtS14r+/2i2nBNcBt1WybneB0oZDMiLhLT+XAvnBw1FBwow+CapXm1Z96IT4oac+
         02KRw8c95B+G2FZS2gapCFuu2fQ3pl5vU1hOCjUtj0IZOtEaF0OHkW4llV1Zieiini/H
         OkJKFno2eor0NphPV7m64jySUt9OC1LUbQ1dd+K6RbHSKRVXicS/Fb3oO9XIlh8OHkkK
         D9pvlJOxqA86bHoWPY5IyUkZzQ0WMYcNtsKRqpHuabfCaECYFRgtEoU4w66SPzz3ShHD
         NX0A==
X-Gm-Message-State: ALoCoQkt5cHye/WmdShpFO7nmKGXo1MOrVfXc8SIF7VYNTtj1Kag5g1hohHIUmIQcB/ZN/Q1fxt4
X-Received: by 10.180.187.12 with SMTP id fo12mr9427557wic.40.1429226154992;
        Thu, 16 Apr 2015 16:15:54 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id e10sm233627wij.11.2015.04.16.16.15.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 16:15:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <CALM2SnafBHz8YeWtUtQDUgLBP_s9AiJy=9UC6XveqP0zrYMEqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267339>

On 15/04/15 04:47, Lex Spoon wrote:
>  From 9cc607667a20317c837afd90d50c078da659b72f Mon Sep 17 00:00:00 2001
> From: Lex Spoon <lex@lexspoon.org>
> Date: Sat, 11 Apr 2015 10:01:15 -0400
> Subject: [PATCH] git-p4: Use -m when running p4 changes

This patch didn't want to apply for me, I'm not quite sure why but 
possibly it's become scrambled? Either that or I'm doing it wrong! If 
you use git send-email it should Just Work.

As an aside could you post reworked versions of patches with a subject 
line of [PATCH v2], [PATCH v3], etc, so reviewers can keep track of 
what's going on?

Note to other reviewers: the existing git-p4 has a --max-changes option 
for 'sync', but this doesn't do the same thing at all. It doesn't limit 
the number of changes requested from the server, it just limits the 
number of changes pulled down, after the p4 server has supplied those 
changes. This confused me at first!

Lex - I should have mentioned this before, but would you be able to add 
some documentation to Documentation/git-p4.txt to explain what your new 
option does? It would help to distinguish between your option and the 
existing --max-changes option.

I've put a few remarks below in your shell script; there are a few minor 
issues that could do with being tidied up.

Thanks!
Luke

<snip>

> diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
> new file mode 100755
> index 0000000..73e545d
> --- /dev/null
> +++ b/t/t9818-git-p4-block.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +
> +test_description='git p4 fetching changes in multiple blocks'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> + start_p4d
> +'
> +
> +test_expect_success 'Create a repo with 100 changes' '
> + (
> + cd "$cli" &&

This doesn't look like enough indentation. The tests normally get a hard 
tab indent at each level.

> + touch file.txt &&
> + p4 add file.txt &&
> + p4 submit -d "Add file.txt" &&
> + for i in 0 1 2 3 4 5 6 7 8 9
> + do
> + touch outer$i.txt &&
> + p4 add outer$i.txt &&
> + p4 submit -d "Adding outer$i.txt" &&
> + for j in 0 1 2 3 4 5 6 7 8 9
> + do
> + p4 edit file.txt &&
> + echo $i$j > file.txt &&

Please put the file argument immediately after the redirection, i.e.

    echo $i$j >file.txt &&

(Which you've done below in fact).

> + p4 submit -d "Commit $i$j"
> + done
> + done
> + )
> +'
> +
> +test_expect_success 'Clone the repo' '
> + git p4 clone --dest="$git" --changes-block-size=10 --verbose //depot@all
> +'
> +
> +test_expect_success 'All files are present' '
> + echo file.txt >expected &&
> + test_write_lines outer0.txt outer1.txt outer2.txt outer3.txt
> outer4.txt >>expected &&
> + test_write_lines outer5.txt outer6.txt outer7.txt outer8.txt
> outer9.txt >>expected &&
> + ls "$git" >current &&
> + test_cmp expected current
> +'
> +
> +test_expect_success 'file.txt is correct' '
> + echo 99 >expected &&
> + test_cmp expected "$git/file.txt"
> +'
> +
> +test_expect_success 'Correct number of commits' '
> + (cd "$git"; git log --oneline) >log &&

Use "&&" rather than ";"

> + test_line_count = 111 log
> +'
> +
> +test_expect_success 'Previous version of file.txt is correct' '
> + (cd "$git"; git checkout HEAD^^) &&

As above.

> + echo 97 >expected &&
> + test_cmp expected "$git/file.txt"
> +'
> +
> +test_expect_success 'kill p4d' '
> + kill_p4d
> +'
> +
> +test_done
>

Looks good other than that (+Junio's comments).

Thanks!
Luke
