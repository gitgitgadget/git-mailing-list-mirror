From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Fri, 16 Jan 2015 10:38:38 -0800
Message-ID: <1CCD6775-7A2E-4AC4-813B-6027C0D67336@gmail.com>
References: <54B6C897.5030405@web.de> <20150114211712.GE1155@peff.net> <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com> <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com> <20150115222719.GA19021@peff.net> <xmqqa91j6537.fsf@gitster.dls.corp.google.com> <20150115235752.GB25120@peff.net> <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com> <20150116013256.GA25894@peff.net> <BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com> <20150116033445.GA29572@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=UTF-8; format=flowed; delsp=yes
Cc: Junio C Hamano <gitster@pobox.com>,
 msysgit@googlegroups.com,
 =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
 Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCA2HLOB7YGRBMVV4WSQKGQEAISDRRY@googlegroups.com Fri Jan 16 19:38:45 2015
Return-path: <msysgit+bncBCA2HLOB7YGRBMVV4WSQKGQEAISDRRY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f191.google.com ([209.85.160.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCA2HLOB7YGRBMVV4WSQKGQEAISDRRY@googlegroups.com>)
	id 1YCBn9-0001cI-PD
	for gcvm-msysgit@m.gmane.org; Fri, 16 Jan 2015 19:38:43 +0100
Received: by mail-yk0-f191.google.com with SMTP id 9sf2975292ykp.8
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 Jan 2015 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :mime-version:date:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=hOUa1MBCxYRYM06RxYR1a1mDYTy6XdDwHeW5mUo4TJs=;
        b=KLD14j0Gf2PuKzm55wGOhDM4VwNWX954nw+lAKtGGeQ5UwrZfReTfcAanRusBAQu/A
         2XrXh1V0oHjAs8ZQ91koA94EiWiLHeV1rEchxHCiisaaUCdeEUgaU0CeFLy3gTsi/ZmR
         wQinMxUpaCs8xB1YExl9CiE+ULkdBhVWCUUuCPzjal8rjsXso6MgmQ32FColu85dq2qt
         CWyXN+ARdmJTFpq8tsIfb3sXsxr/sx9oqs87w6Hlt2JOc/UeDRsvUlnQKmwEuV8F8Tps
         vQNpLy2MAIavps/fmYkplIjpMxMjTtbsYJ2T9fjiB1viYMb6q5iWeEL0fcSj3PmZ8OOa
         ehnQ==
X-Received: by 10.182.236.74 with SMTP id us10mr13374obc.32.1421433522811;
        Fri, 16 Jan 2015 10:38:42 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.20.44 with SMTP id k12ls724183obe.1.gmail; Fri, 16 Jan
 2015 10:38:42 -0800 (PST)
X-Received: by 10.182.165.132 with SMTP id yy4mr13318087obb.20.1421433522396;
        Fri, 16 Jan 2015 10:38:42 -0800 (PST)
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com. [2607:f8b0:400e:c02::229])
        by gmr-mx.google.com with ESMTPS id v6si555180pdo.2.2015.01.16.10.38.42
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 10:38:42 -0800 (PST)
Received-SPF: pass (google.com: domain of mackyle@gmail.com designates 2607:f8b0:400e:c02::229 as permitted sender) client-ip=2607:f8b0:400e:c02::229;
Received: by mail-pd0-f169.google.com with SMTP id z10so24203774pdj.0
        for <msysgit@googlegroups.com>; Fri, 16 Jan 2015 10:38:42 -0800 (PST)
X-Received: by 10.70.118.168 with SMTP id kn8mr24614789pdb.133.1421433522228;
        Fri, 16 Jan 2015 10:38:42 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kl7sm4738123pdb.10.2015.01.16.10.38.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 10:38:41 -0800 (PST)
In-Reply-To: <20150116033445.GA29572@peff.net>
X-Mauler: Craptastic (2.936)
X-Original-Sender: mackyle@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of mackyle@gmail.com designates 2607:f8b0:400e:c02::229
 as permitted sender) smtp.mail=mackyle@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262558>

On Jan 15, 2015, at 19:34, Jeff King wrote:

> On Thu, Jan 15, 2015 at 07:27:34PM -0800, Kyle J. McKay wrote:
>
>> "id -u" works for me in MSYS and cygwin (each appears to have it's  
>> own
>> id.exe).
>
> That's comforting. MSYS was the one I was most worried about. What UID
> do they report? I.e., do they correctly tell us if we are root (or
> more accurately, if we are not root)?

It's funny, really.  The MSYS version gives a different answer than  
the cygwin version although both are non-zero.  The MSYS perl gives  
the same answer as the MSYS id and the cygwin perl gives the same  
answer as the cygwin id.

I'm not even sure what it would mean to "be root" on one of those  
systems.

The closest I can think of would be to run as the "SYSTEM" user.  And  
that's not nearly as simple as just "sudo -s". [1].

I haven't tested that.  I will try to remember to give that a try next  
time I'm feeling the need for some frustration. ;)

-Kyle

[1] http://cygwin.com/ml/cygwin/2010-04/msg00651.html

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
