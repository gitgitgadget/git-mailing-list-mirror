From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 0/3] Win32: nanosecond-precision file times
Date: Fri, 13 Feb 2015 02:59:37 +0100
Message-ID: <54DD5A89.5080502@gmail.com>
References: <54DBEAA5.6000205@gmail.com>	<xmqqbnkysygl.fsf@gitster.dls.corp.google.com>	<54DD2FDA.7030604@gmail.com> <xmqqsieaog4a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBB5V6WTAKGQEYD644KY@googlegroups.com Fri Feb 13 02:59:38 2015
Return-path: <msysgit+bncBCH3XYXLXQDBBB5V6WTAKGQEYD644KY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBB5V6WTAKGQEYD644KY@googlegroups.com>)
	id 1YM5Xd-0004S4-ER
	for gcvm-msysgit@m.gmane.org; Fri, 13 Feb 2015 02:59:37 +0100
Received: by lamq1 with SMTP id q1sf3327186lam.8
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 17:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=DNXacHZQV+9xXk8zdLe6z7R8MBtrvCTXGb8+UMYOhUc=;
        b=CS67dCHGR2MMr7rpqsP4cwxz8sZ8LOiOV//a7191Q0/xrX8Df1LtjgDB8aN3RIcqR8
         3s6ki3e4gx//YoGjZaHmdtp0ems+l08vCqtAnkLEPQhR93fNnr+Ae5Mq7ZhhebD4soH1
         jWxIzdokaZtcsCMvpsOiXQgC6xSA+kkg8gEhq2f3XTlCmLQ8+AF19EOuS/w5wu+yxaVa
         6/MHTmvj6QscgURlxGNPuk+fK36gQbtdm3H5qeiApBS9jkzEFNbuoSF4Mj1Mx3utpOf1
         XTRWDsyTI0J95uN8Nwsp8cS9kVXvUxze/Tb9r1av8Ftc72Jns1qR2Gg3/Cc/lOpepC9m
         doNA==
X-Received: by 10.152.22.198 with SMTP id g6mr102815laf.16.1423792777018;
        Thu, 12 Feb 2015 17:59:37 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.116.14 with SMTP id js14ls273976lab.69.gmail; Thu, 12 Feb
 2015 17:59:35 -0800 (PST)
X-Received: by 10.152.10.65 with SMTP id g1mr990670lab.5.1423792775109;
        Thu, 12 Feb 2015 17:59:35 -0800 (PST)
Received: from mail-wg0-x22d.google.com (mail-wg0-x22d.google.com. [2a00:1450:400c:c00::22d])
        by gmr-mx.google.com with ESMTPS id o6si663710wia.1.2015.02.12.17.59.35
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 17:59:35 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22d as permitted sender) client-ip=2a00:1450:400c:c00::22d;
Received: by mail-wg0-f45.google.com with SMTP id k14so10787380wgh.4
        for <msysgit@googlegroups.com>; Thu, 12 Feb 2015 17:59:35 -0800 (PST)
X-Received: by 10.194.237.34 with SMTP id uz2mr12871283wjc.157.1423792774989;
        Thu, 12 Feb 2015 17:59:34 -0800 (PST)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id lu13sm4816426wic.10.2015.02.12.17.59.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 17:59:34 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqsieaog4a.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22d
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263794>

Am 13.02.2015 um 00:38 schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> This is more about copying 'old' things around, which usually also
>> copies mtime on Windows. E.g.:
>>
>>   # create two files with slightly different mtime
>>   for i in {1..10}; do (echo "v1" >> test); done &&
>>   for i in {1..10}; do (echo "v2" >> test2); done
>>   # wait a bit so that '.git/index' is always newer than 'test' / 'test2'
>>   sleep 1
>>   git add test
>>   git commit -m v1
>>   # copy test2 over test (similar to 'cp -p', but native 'copy' also
>>   # copies mtime nanoseconds)
>>   cmd //c "copy /y test2 test"
>>   git add test
>>   git commit -m v2
>>
>> Without these patches, git does not detect the change, and the second
>> git add / git commit are noops.
> 
> We do have sec/nsec fields in cache_time structure, so I have
> nothing against updating the msysGit port to fill that value.
> 
> I was and am just reacting to the fact that this is sold as if it
> "fixes" something.

Sorry, that must have been a misunderstanding. This series does
NOT fix the problem with VSS2Git, nor any other tool that abuses
mtime for the author's birthday or whatever.

The issue that two files may accidentally have the same size and
mtime was just brought up in this discussion.

> It doesn't fundamentally change the fact that
> mtime that does not follow the semantics Dscho mentioned in his
> earlier message does not work well with Git.
> 
> Having said that, even with such a patch, as long as the system is
> sufficiently fast, test and test2 will have nonoseconds identical
> timestamp and you would have the same issue, no?
> 

Right. Where "sufficiently fast" would mean opening and closing a
file ten times in less than 100ns...on Windows... ;-)

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
