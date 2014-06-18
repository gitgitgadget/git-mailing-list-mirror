From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v5 10/11] trace: add trace_performance facility
 to debug performance issues
Date: Wed, 18 Jun 2014 17:14:42 +0200
Message-ID: <53A1ACE2.30406@gmail.com>
References: <53980B83.9050409@gmail.com> <53980CD8.5090801@gmail.com> <xmqqsin3mpfe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBY6ZQ2OQKGQE6OWJH7Q@googlegroups.com Wed Jun 18 17:14:44 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBY6ZQ2OQKGQE6OWJH7Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f185.google.com ([74.125.82.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBY6ZQ2OQKGQE6OWJH7Q@googlegroups.com>)
	id 1WxHZU-00005D-2q
	for gcvm-msysgit@m.gmane.org; Wed, 18 Jun 2014 17:14:44 +0200
Received: by mail-we0-f185.google.com with SMTP id t60sf121850wes.12
        for <gcvm-msysgit@m.gmane.org>; Wed, 18 Jun 2014 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Nf8H+xiLYTSYZkJ0w1sdpVeBFCM6jtSHrrB80Ikihn0=;
        b=vmj4q30xyUuZdzhF8zB/uvG+8l7o+nMBfkAnnmQ40pOc+PtMmYSr8lmxWBTpEZLEsZ
         p2AS48UunyMoTQ7bPCUbD79V5+YhWe+jx1ckzll/frqbN2VUdrU9/eWvW3OHiU2fcgdw
         ESd/dkBvrJJ2V7Y3fhs/pkI9mvkWf3Upxyjpheaq7zUCP2oJi0yokLdE+L20U7OM/a+E
         MHjBH07ceYgkQ6Kt3FJ8VZIFxSFIS5gsL9w7xfno+i0eQJg1QRPMR1aG1IY1a/JhbHrF
         AbXtFktXsygapK1JfmWyML/hR/zhZdKS4g18ZDBQ1v14f4xYReHSVKaThqdxEs62Y60d
         Z17Q==
X-Received: by 10.152.205.1 with SMTP id lc1mr21942lac.29.1403104483774;
        Wed, 18 Jun 2014 08:14:43 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.115.134 with SMTP id jo6ls34776lab.62.gmail; Wed, 18 Jun
 2014 08:14:42 -0700 (PDT)
X-Received: by 10.112.140.170 with SMTP id rh10mr308830lbb.7.1403104482712;
        Wed, 18 Jun 2014 08:14:42 -0700 (PDT)
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com [2a00:1450:400c:c05::236])
        by gmr-mx.google.com with ESMTPS id mx7si813031wic.1.2014.06.18.08.14.42
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 08:14:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::236 as permitted sender) client-ip=2a00:1450:400c:c05::236;
Received: by mail-wi0-f182.google.com with SMTP id bs8so1337242wib.9
        for <msysgit@googlegroups.com>; Wed, 18 Jun 2014 08:14:42 -0700 (PDT)
X-Received: by 10.194.223.67 with SMTP id qs3mr14801721wjc.66.1403104482614;
        Wed, 18 Jun 2014 08:14:42 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id q46sm5840902eem.1.2014.06.18.08.14.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 08:14:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqsin3mpfe.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::236
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251987>

Am 17.06.2014 19:11, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Simple use case (measure one code section):
>>
>>   uint64_t start = getnanotime();
>>   /* code section to measure */
>>   trace_performance_since(start, "foobar");
>>
>> Medium use case (measure consecutive code sections):
>>
>>   uint64_t start = getnanotime();
>>   /* first code section to measure */
>>   start = trace_performance_since(start, "first foobar");
>>   /* second code section to measure */
>>   trace_performance_since(start, "second foobar");
>>
>> Complex use case (measure repetitive code sections):
>>
>>   uint64_t t = 0;
>>   for (;;) {
>>     /* ignore */
>>     t -= getnanotime();
>>     /* code section to measure */
>>     t += getnanotime();
>>     /* ignore */
>>   }
>>   trace_performance(t, "frotz");
> 
> Hmph.  Even though trace_performance() makes an extra call to
> getnanotime() in order to return, examples do not use the returned
> value?  The second example is a good illustration why it makes sense
> for trace_performance_since(), though.
> 

Right, it makes no sense for trace_performance(), and for
trace_performance_since() only if followed by another 'measured' code
section. In that special case, I think it wouldn't hurt if you had to
write:

  uint64_t start = getnanotime();
  /* first code section to measure */
  trace_performance_since(start, "first foobar");

  start = getnanotime();
  /* second code section to measure */
  trace_performance_since(start, "second foobar");

So I guess I'll drop the return value (and the second example, which
is then redundant to the first).

>> +static void trace_performance_vfl(const char *file, int line,
>> +				      uint64_t nanos, const char *format,
>> +				      va_list ap)
>> +{
> 
> Just being curious, but what does "v" stand for?
> 

trace_performance_vfl(, va_list)
vs.
trace_performance_fl(, ...)

Will change to trace_performance_vprintf_fl()

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
