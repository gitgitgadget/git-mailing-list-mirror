From: Ilya Bobyr <ilya.bobir@gmail.com>
Subject: Re: [PATCH 1/2] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Mon, 03 Mar 2014 15:08:58 -0800
Message-ID: <53150B8A.9050709@gmail.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com> <C65A743B56974711A3806272E9B2C1DD@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Philip Oakley <philipoakley@iee.org>,
	Ilya Bobyr <ilya.bobyr@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 00:09:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbyz-0002ET-Fc
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755AbaCCXJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:09:08 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54421 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbaCCXJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:09:07 -0500
Received: by mail-pa0-f50.google.com with SMTP id kq14so4400959pab.37
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 15:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Y5zbN6rTuEqbAddCn63V+oyBvnHyPv8nhCdf10c7i0o=;
        b=asd6Jec0OXtILJMHl1u7mGyyO2Rzda+IVUSWV8N3Z0wbZ8jtyRSGq2xWkXhbQoTm/H
         NsWuElpfCac6kApRN3g0R4cgg4DFWbhxaBf7tn/4JhhwnILF4qluLupIIJZ5Os+qgcM4
         +Qem4Yiw0amA7g+7d7XAu+hyKsPvHKAax099iPR31hvnj5PpFY2e4VJoJeOCUOm0/7Y5
         oUUzqbPM301+wd2xgtKFAylMap8EJplRDCwqIeQgVAn7J2LiacgU2FTg5nDIMbWr1jQV
         Btqnw4uny6irszrDyh3QQrHQyNDRRHne/+/6jfailn11O9ej+wD11f8S1+uXGmN3jlbb
         4vVw==
X-Received: by 10.69.26.228 with SMTP id jb4mr22052162pbd.83.1393888146030;
        Mon, 03 Mar 2014 15:09:06 -0800 (PST)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id vf7sm40480362pbc.5.2014.03.03.15.09.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2014 15:09:05 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Thunderbird/27.0
In-Reply-To: <C65A743B56974711A3806272E9B2C1DD@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243302>

On 3/3/2014 7:11 AM, Philip Oakley wrote:
> From: "Ilya Bobyr" <ilya.bobyr@gmail.com>
>> We used to show "(missing )" next to tests skipped because they are
>> specified in GIT_SKIP_TESTS.  Use "(matched by GIT_SKIP_TESTS)" instead.
>
> The message below forgets the "by".

I'll fix the commit message.  I think the output is long enough, while 
"by" does not add any information.

> Otherwise looks sensible.

Thanks for looking at it :)

>
>> ---
>> t/test-lib.sh |   13 ++++++++-----
>> 1 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 1531c24..89a405b 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -446,25 +446,28 @@ test_finish_ () {
>>
>> test_skip () {
>>  to_skip=
>> + skipped_reason=
>>  if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
>>  then
>>  to_skip=t
>> + skipped_reason="matched GIT_SKIP_TESTS"
>
> s/matched GIT_SKIP_TESTS/matched by GIT_SKIP_TESTS/
>
>>  [...]
