From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 1/6] MinGW: Skip test redirecting to fd 4
Date: Thu, 17 Jul 2014 22:18:00 +0200
Message-ID: <53C82F78.1020805@gmail.com>
References: <20140716092959.GA378@ucw.cz>	<1405611425-10009-1-git-send-email-kasal@ucw.cz>	<1405611425-10009-2-git-send-email-kasal@ucw.cz> <xmqqbnsnq14j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBB566UCPAKGQER56MT6A@googlegroups.com Thu Jul 17 22:18:00 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB566UCPAKGQER56MT6A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB566UCPAKGQER56MT6A@googlegroups.com>)
	id 1X7s7s-0004YU-PT
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 22:18:00 +0200
Received: by mail-wi0-f191.google.com with SMTP id hi2sf335121wib.18
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=1HZXYnLhrvvSfVWeGyxlOL8wfqglsy9Y1G4MCi3AaSU=;
        b=Cd8864XCPyHHxcMOmISIG8tJRfAn/jeU1Y4NVZQ96ijZydOecdC0I8QbuHIOLrFfQD
         2pAcgHLdp/qat9YqwPvMtsBq6i1n1mwPBgC8IQR85W4Kt8R9ELIUsLE57HgDdj2sRPo0
         h3o5CJOKWHtq+IEzqIMmul9fy++9uovb6hFjqLEbnwu95SwRYrxwl6Us8C/ASKjTmjUE
         GLInp3JsxZGJuWkufa/xhtl0ZcSsgezbyM+ozZ3Hqki6XWvR7m6FxFkd9wt551sJBY4E
         H0eyHVUvmlK+uzfANFHbgSvGGetp905JN0XOWLvwjYPuCoq14mbSZfEuD53cCoQWsFm7
         EEUQ==
X-Received: by 10.152.198.170 with SMTP id jd10mr23554lac.20.1405628280375;
        Thu, 17 Jul 2014 13:18:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.178.195 with SMTP id da3ls248593lac.32.gmail; Thu, 17 Jul
 2014 13:17:59 -0700 (PDT)
X-Received: by 10.152.87.226 with SMTP id bb2mr3193536lab.5.1405628279330;
        Thu, 17 Jul 2014 13:17:59 -0700 (PDT)
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com [2a00:1450:400c:c05::22f])
        by gmr-mx.google.com with ESMTPS id cj4si1123095wid.0.2014.07.17.13.17.59
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 13:17:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22f as permitted sender) client-ip=2a00:1450:400c:c05::22f;
Received: by mail-wi0-x22f.google.com with SMTP id ho1so8298913wib.2
        for <msysgit@googlegroups.com>; Thu, 17 Jul 2014 13:17:59 -0700 (PDT)
X-Received: by 10.194.121.65 with SMTP id li1mr11372786wjb.10.1405628279211;
        Thu, 17 Jul 2014 13:17:59 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id nc19sm24634518wic.4.2014.07.17.13.17.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 13:17:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqbnsnq14j.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22f
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253779>

Am 17.07.2014 20:41, schrieb Junio C Hamano:
> Stepan Kasal <kasal@ucw.cz> writes:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> ... because that does not work in MinGW.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>> ---
>>  t/t0081-line-buffer.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
>> index bd83ed3..25dba00 100755
>> --- a/t/t0081-line-buffer.sh
>> +++ b/t/t0081-line-buffer.sh
>> @@ -29,7 +29,7 @@ test_expect_success '0-length read, send along greeting' '
>>  	test_cmp expect actual
>>  '
>>  
>> -test_expect_success 'read from file descriptor' '
>> +test_expect_success NOT_MINGW 'read from file descriptor' '
>>  	rm -f input &&
>>  	echo hello >expect &&
>>  	echo hello >input &&
> 
> Hmm, the point of this test seems to be to exercise buffer_fdinit(),
> instead of buffer_init(), and the file descriptor does not have to
> be "4" for the purpose of the test, no?
> 
> Is what is broken on MinGW redirecting arbitrary file descrptors?

Yes. 0, 1 and 2 work (vie GetStdHandle), but anything else is handled
by the C-runtime. And as MSYS.dll (bash) and MSVCRT.dll (git) do it in
different ways, it doesn't work.

> -	echo copy 6 |
> -	test-line-buffer "&4" 4<input >actual &&
> +	test-line-buffer "&0" <input >actual &&

test-line-buffer already reads commands ("copy 6") from stdin, so stdin cannot
be reused for the data stream, unfortunately.

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
