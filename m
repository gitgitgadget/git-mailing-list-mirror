From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3 1/2] git-p4: add test case for "Translation of file
 content failed" error
Date: Mon, 21 Sep 2015 08:47:32 +0100
Message-ID: <55FFB614.7000908@diamand.org>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com>	<1442766131-45017-2-git-send-email-larsxschneider@gmail.com>	<CAPig+cThcNa2Xg6GDkNKKeOMOzApTi_FQfQz_KRAbF8-PWY5Eg@mail.gmail.com>	<4DB8A17D-A670-4E84-8FA8-9B05F2DCE1CB@gmail.com> <CAPig+cSFbYzLi8daS55B_sdvDPW4q6yOC5Hm75+Rmr-s1aFRHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 09:47:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdvpG-00079S-OI
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 09:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991AbbIUHrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 03:47:36 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35596 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863AbbIUHre (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 03:47:34 -0400
Received: by wicge5 with SMTP id ge5so103305891wic.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=COrbmYWwFWsDLS3xNnfRYIZUOWFMLYIx77cV1o+guKk=;
        b=ZaBXSOrjKXriGdhEaMaOT9QZIiNXGupSXYuCFA5+jpopkufRVSfTwfnbEvTDpWs7xc
         5yxs1L2K8ECXHPNqinqf4W5Hngawz51ecGLP+iydJ0v2MZ599BDDZPa8VXOm32aZUSRV
         YElq3OWa5wtvXbCV27odlMgbRm68rt6MqPcFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=COrbmYWwFWsDLS3xNnfRYIZUOWFMLYIx77cV1o+guKk=;
        b=macPHs/81byuovUPWd/d885fA45RPIRz/M7FoLN7o3VeXMUN9KWGS8hLVS7zru0IcH
         jlz22VuYOnjjelZB4k2FtWEg6DgDJXDkF04LYnX0QN5GEpu+VEL2MQEK3qkYgFgNbyn2
         /SbecFGrYFqzCyAxGGj1Ly36fajtUSifA9aySFFfcMi9IBTIdgvQSmnPtPJlYv9fzL5F
         tHV2WeH+ffOHxkzw0iaexj/orum2kgpURnXZmAW15W11euZm6OPVkyx/XiPqGCK00//A
         UwLOyyQz4zoEQSzcVcfvoQAFd9+aWf44ZVkhH/AHKn3ASE1LA0h9hNdBxhf2bNDTsG3j
         Cbmg==
X-Gm-Message-State: ALoCoQn377uNwnL07TdqJbAAuAqukgxnP3UJfWoFeOrBJvIgNUg+u2btUfJ6gkaNPr8okQgJVwRT
X-Received: by 10.180.12.241 with SMTP id b17mr12819632wic.55.1442821653229;
        Mon, 21 Sep 2015 00:47:33 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id ja14sm1135903wic.7.2015.09.21.00.47.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2015 00:47:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAPig+cSFbYzLi8daS55B_sdvDPW4q6yOC5Hm75+Rmr-s1aFRHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278284>

On 20/09/15 23:29, Eric Sunshine wrote:
> On Sun, Sep 20, 2015 at 5:34 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>
>> What is the preferred way by the Git community? Combine patch and
>> test in one commit or a patch commit followed by a test commit? I
>> would prefer to have everything in one commit.
>
> If the tests are in a separate patch, Junio seems to prefer adding
> them after the problem is fixes; the idea being that tests are added
> to ensure that some future change doesn't break the feature, as
> opposed to showing that your patch fixes a bug.
>
> Whether or not to combine the fix with the new tests often depends
> upon the length of the patches and how easy or hard it is to review
> them. In this case, the fix itself is fairly short, but the tests are
> slightly lengthy, so there may not be a clear cut answer. As a
> reviewer, I tend to prefer smaller patches, however, this situation
> doesn't demand it, so use your best judgment.

I think in the past we have a test added that demonstrates the problem, 
with "test_expect_failure", followed by the fix, which also flips the 
test to "test_expect_success".

Luke
