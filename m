From: Johannes Sixt <j6t@kdbg.org>
Subject: Topic sk/mingw-unicode-spawn-args breaks tests
Date: Thu, 10 Jul 2014 22:05:50 +0200
Message-ID: <53BEF21E.9090007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>, Git Mailing List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCJYV6HBKQIKHZH3TUCRUBD4TZPGU@googlegroups.com Thu Jul 10 22:06:00 2014
Return-path: <msysgit+bncBCJYV6HBKQIKHZH3TUCRUBD4TZPGU@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIKHZH3TUCRUBD4TZPGU@googlegroups.com>)
	id 1X5KbO-00075z-RG
	for gcvm-msysgit@m.gmane.org; Thu, 10 Jul 2014 22:05:58 +0200
Received: by mail-wi0-f191.google.com with SMTP id q5sf27923wiv.28
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Jul 2014 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=I3TupdgTxpeNxnOD5ftlnL25D3Z0SbIusAVw8voeSAY=;
        b=hY5mlf+7oW8P7QfDLMdUUVqEjJtudW85YPP4zerT8qAUZoGRWDV+VaSfWpZRTb9Yj/
         bp0F5zmPbWrR22z3DCfhEpUPazGuLeF7tbrR5IY68kZWaKjhOsP41BCd+Ft9GxLQu1Nk
         dOtwGDuy+i1LQSg9bd1KbB/JvDeGHjWIOm0Hw8xUGBIz6PDbEIdKyPdsF4HjRpBpSmui
         JpW8OtvC6LQc0qATwkfc78HasT3ea0lFaFA0odQJP8vakpr56Ju5239LQ52yDOI0KqQh
         a9XLhKozlyIa+U5hL6ByJjzKhiLXpF66SO21b4nHHCWoB5TMWWDN6qn9ob3KHZ8Y058T
         yJSg==
X-Received: by 10.152.116.17 with SMTP id js17mr5342lab.41.1405022755610;
        Thu, 10 Jul 2014 13:05:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.203.200 with SMTP id ks8ls45501lac.105.gmail; Thu, 10 Jul
 2014 13:05:54 -0700 (PDT)
X-Received: by 10.112.42.229 with SMTP id r5mr42605lbl.23.1405022754621;
        Thu, 10 Jul 2014 13:05:54 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp.bon.at. [213.33.87.14])
        by gmr-mx.google.com with ESMTPS id gg16si644415wic.2.2014.07.10.13.05.53
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jul 2014 13:05:53 -0700 (PDT)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.14;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C6D1B130067;
	Thu, 10 Jul 2014 22:05:51 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1B7C919F364;
	Thu, 10 Jul 2014 22:05:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253204>

It looks like I totally missed the topic sk/mingw-unicode-spawn-args.
Now it's in master, and it breaks lots of test cases for me:

t0050-filesystem
t0110-urlmatch-normalization
t4014-format-patch
t4041-diff-submodule-option
t4120-apply-popt
t4201-shortlog
t4205-log-pretty-formats
t4209-log-pickaxe
t4210-log-i18n
(I killed the test run here)

Am I doing something wrong? Does the topic depend on a particular
version of MSYS (or DLL)?

-- Hannes

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
