From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 08/12] fast-import: MinGW does not have
 getppid().  So do not print it.
Date: Wed, 2 Jul 2008 16:22:02 +0200
Message-ID: <A1D7E098-B5FD-42F6-8EAD-8AACF0B8D764@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <7vzlp0bq2l.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org, msysgit@googlegroups.com, Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <junio@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 16:23:12 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE3Ei-0002rW-79
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 16:23:08 +0200
Received: by wr-out-0708.google.com with SMTP id b72so97910wra.6
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=XJJsoMwR+YL5tV5SUX4hwm2G2zzqEQCRJhIYesr4iEM=;
        b=x0G5cK/pzyQs86aqScUNbWyf9kodbksUUi0kStbsy/0PHyLvXGPUDFo/ANFpaIi+2E
         U+U5tU8O5Dm14uRgrUiAl2gAUNIalReLHufFx8vMKn+qjBs5RXcCC+tVqMrliBA1+ryT
         82g9zUTTzAwYKV2MY4eiGJ49Ec/6uLroLiXNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=Y4xwEnuL+d5/jI+Uug4O7p7UdkG0DXKADE+1IEjh+0xDW85eDoYjcoUq5y1mUe1gUy
         BHNVTKV6l1mZVgYxj+Und8ETGgjn8qZIdeQ9rUJS29ryPrRA7BiD6n0FfexkHhSPIDtE
         +uLCewStJWolIBNRoeuIQsWvlQkHHmLmyyzw8=
Received: by 10.100.144.18 with SMTP id r18mr31542and.26.1215008527082;
        Wed, 02 Jul 2008 07:22:07 -0700 (PDT)
Received: by 10.106.239.31 with SMTP id m31gr2566prh.0;
	Wed, 02 Jul 2008 07:22:06 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.111.1 with SMTP id j1mr4586172wac.0.1215008526179; Wed, 02 Jul 2008 07:22:06 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 22si8189950yxr.2.2008.07.02.07.22.05; Wed, 02 Jul 2008 07:22:06 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m62ELw3r002180; Wed, 2 Jul 2008 16:22:03 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db94382.pool.einsundeins.de [77.185.67.130]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m62ELv1C024038 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Wed, 2 Jul 2008 16:21:58 +0200 (MEST)
In-Reply-To: <7vzlp0bq2l.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87141>



On Jul 2, 2008, at 11:20 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> diff --git a/fast-import.c b/fast-import.c
>> index e72b286..271b93c 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -391,7 +391,9 @@ static void write_crash_report(const char *err)
>>
>> 	fprintf(rpt, "fast-import crash report:\n");
>> 	fprintf(rpt, "    fast-import process: %d\n", getpid());
>> +#ifndef __MINGW32__
>> 	fprintf(rpt, "    parent process     : %d\n", getppid());
>> +#endif
>> 	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_LOCAL));
>> 	fputc('\n', rpt);
>>
>> --  
>> 1.5.6.1.255.g32571
>
> It does not matter too much for this part that writes crash report,  
> but
> keeping the file format the same across platforms will make it  
> easier for
> tools to read output, so as a general principle, I think this is a
> suboptimal solution to the issue.  How about throwing something like  
> this
> in MinGW specific header files?
>
>        #define getppid() 0

Hannes added something similar to the compat layer, so this commit
is no longer needed.  I'll remove it from the series and revert it
in 4msysgit.

	Steffen
