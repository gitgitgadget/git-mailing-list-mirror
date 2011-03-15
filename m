From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] Documentation: running test with --debug keeps "trash"
 directory
Date: Tue, 15 Mar 2011 20:58:14 +0100
Message-ID: <4D7FC4D6.9010100@gmail.com>
References: <4D7E717A.8010605@gmail.com> <7vy64hbd6c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:58:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzaNu-0006sv-24
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 20:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295Ab1COT6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 15:58:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42429 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429Ab1COT6U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 15:58:20 -0400
Received: by bwz15 with SMTP id 15so909579bwz.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=XHQdBuRZlG/YGcAo6jDLLEHS7Mn+zAS1X3zWO/C0hHE=;
        b=c42+UZ4mSwbUupUSANx0Rp8KbPPWKT9oolB+PKVMTtUen0sJgcEKge24I/WDyzLonO
         GDRX1eEK9oCzJyIHUBRQVIDn9tmCaOuAQZzYyx5FW7+JORvTvoMqmPKM8ZYhAHA9m6qN
         AQr6bUAKh1WEoba6dl22lq+0BoztrxnHEUbQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=v31Rh3KSZCqSS6hZi5WhgivAP8V7Edrls2ZP06IhW2CMTWaE6UbUOQ2CPN9j4LwYGG
         1SFIgkgW5toMFWNTprhBQ4w+yy9oMo9T67VwGzCd/DYWfS3NPq4svMIrXu4Us2vFS+bK
         GpyqB3rKBS9okEG2cMIsCnmvvXHzd1QTvSa8U=
Received: by 10.204.7.213 with SMTP id e21mr1676102bke.209.1300219098758;
        Tue, 15 Mar 2011 12:58:18 -0700 (PDT)
Received: from [192.168.1.101] (aene182.neoplus.adsl.tpnet.pl [79.191.82.182])
        by mx.google.com with ESMTPS id u23sm124654bkw.21.2011.03.15.12.58.16
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 12:58:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7vy64hbd6c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169089>

W dniu 14.03.2011 22:32, Junio C Hamano pisze:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> 
>> Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
>> ---
>>  t/README |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> It wasn't documented and I didn't notice it at first and found
>> it out only after I've started implementing --keep-trash option.
>>
>> diff --git a/t/README b/t/README
>> index 78c9e65..5db567e 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -79,6 +79,9 @@ appropriately before running "make".
>>  --debug::
>>  	This may help the person who is developing a new test.
>>  	It causes the command defined with test_debug to run.
>> +	The "trash" directory (used to store all temporary data
>> +	during testing) is not deleted even if there are no
>> +	failed tests.
> 
> missing is "...so that you can inspect its contents after the test
> finished." at the end.

If you think it's needed here's a patch. 
I'm not sure - maybe it should be "after the test finishe_s_"? I'm not
native English speaker though...

---8<---
From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date: Mon, 14 Mar 2011 18:50:47 +0100
Subject: [PATCH] Documentation: running test with --debug keeps "trash" directory


Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 t/README |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 78c9e65..165e7cf 100644
--- a/t/README
+++ b/t/README
@@ -79,6 +79,10 @@ appropriately before running "make".
 --debug::
 	This may help the person who is developing a new test.
 	It causes the command defined with test_debug to run.
+	The "trash" directory (used to store all temporary data
+	during testing) is not deleted even if there are no
+	failed tests so that you can inspect its contents after
+	the test finished.
 
 --immediate::
 	This causes the test to immediately exit upon the first
-- 
1.7.4.1.228.g9e388


-- 
Piotr Krukowiecki
