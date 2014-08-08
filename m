From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v9 5/8] config: add `git_die_config()` to the config-set
 API
Date: Fri, 08 Aug 2014 17:44:57 +0530
Message-ID: <53E4BF41.1010802@gmail.com>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>	<1407412759-13833-6-git-send-email-tanayabh@gmail.com> <xmqqd2ccku3m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 14:15:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFj4g-0007td-9B
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 14:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbaHHMPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 08:15:06 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:39786 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989AbaHHMPE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 08:15:04 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so6876790pde.23
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=G/jQgaArDyMRHArtYgkt21E0Jf1LdC9CLVy51YoGpXE=;
        b=u15tFjhJujLZolxq3yZhMf/rzfMZP7HN3TIwTlbrE7Tye0q41eR6UsLvQDZXEzs1GX
         fzSWsGogMWvg0m7sr6XhJ6QnaVSTSZenbSm6bzgpiHGoBCZxKpg/5lKG6MQ1ZTBcP11Y
         s0+XMaWzrAGvKEVqMY29al8cAl1TugnJLxf9FQtYMemoND86Z5ml3vTdd1eTxRuaNule
         q3iKwXbX+ksN3v7Pw/QIjUmajQBU8+AmUTDsoX8xcsfEw7udI2OPiXear5EBLHpHJFZ6
         IT7zrHN6QC4RB9T6Ot2pH3tXO1C7AvtiMNl8DwyYmeNyjx0E8udoQyuq6c2hDDGMavQA
         +91A==
X-Received: by 10.68.95.225 with SMTP id dn1mr23799432pbb.126.1407500103753;
        Fri, 08 Aug 2014 05:15:03 -0700 (PDT)
Received: from [127.0.0.1] ([106.202.122.193])
        by mx.google.com with ESMTPSA id g17sm4098678pdk.80.2014.08.08.05.15.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Aug 2014 05:15:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqd2ccku3m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255005>



On 8/8/2014 12:25 AM, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
>> index 21f280c..0d8b99b 100644
>> --- a/Documentation/technical/api-config.txt
>> +++ b/Documentation/technical/api-config.txt
>> @@ -155,6 +155,19 @@ as well as retrieval for the queried variable, including:
>>  	Similar to `git_config_get_string`, but expands `~` or `~user` into
>>  	the user's home directory when found at the beginning of the path.
>>  
>> +`git_die_config(const char *key, const char *err, ...)`::
>> +
>> +	First prints the error message specified by the caller in `err` and then
>> +	dies printing the line number and the file name of the highest priority
>> +	value for the configuration variable `key`.
> 
> Reviewed with a wider context, I notice that this entry alone lacks
> the return type.  I am assuming that this is just an oversight, and
> adding 'void ' in front of the filename to match the next entry is
> simple enough.
> 

Yikes, yes, you are right, it's just an oversight. I will send an amended patch.
