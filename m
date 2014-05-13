From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] wincred: avoid overwriting configured variables
Date: Tue, 13 May 2014 08:18:26 -0500
Message-ID: <CAMP44s2p0t9cBg=rOdY74MKOYzekCoCj8K20F8ARjQ0RQmJygg@mail.gmail.com>
References: <20140430064610.GA22094@camelia.ucw.cz>
	<CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com>
	<20140430112724.GA22929@camelia.ucw.cz>
	<CABPQNSafKXDLyBj5OYW-PPWdxfxQtC23vKQsQ-_Pa1empU=n8g@mail.gmail.com>
	<20140513055953.GA28182@camelia.ucw.cz>
	<20140513060144.GC28182@camelia.ucw.cz>
	<CABPQNSYU5haMzdy2cDn=KF2+j_aFK19Ju+x+LTeex6JqWJMncQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>, 
	Pat Thoyts <patthoyts@users.sourceforge.net>, msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBDBJVMGGZYNBBI5XZCNQKGQESDA22JA@googlegroups.com Tue May 13 15:18:29 2014
Return-path: <msysgit+bncBDBJVMGGZYNBBI5XZCNQKGQESDA22JA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f190.google.com ([209.85.128.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBBI5XZCNQKGQESDA22JA@googlegroups.com>)
	id 1WkCbE-0001Se-N5
	for gcvm-msysgit@m.gmane.org; Tue, 13 May 2014 15:18:28 +0200
Received: by mail-ve0-f190.google.com with SMTP id jz11sf77872veb.27
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 May 2014 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=Dcf2VzOw+Y5tR9P8DY6P7wQz4MTedrz5Lr6KpH96yUg=;
        b=dXQe9oyBYkNydS7FMHjwXl5I4l+rX+1ZvZfI3aHYbfoo88wTpyjxBcaVf1nkpB0Kd0
         2h6dBUQqV5M7ODrqsc/nlIXYJclJAJ/04Iq6VPypbwZqdoMu9X1HHQRs3KsOaNCEXyOd
         V6bCmK/7kRvSBkY/Mhs7NlurETNRJYqGH0lgwgHeeKBbRHk6QbzUj7BkoCKxBq5mC3XT
         0lBkGBBJ3Hdd+ZsQ8VDIvz8Gi4O9cjpDDnlIrYxvjMSnZUAVgra8/L0l1j7fY0tu4u5I
         8Jkhylbw4moFDQEaYGNoorlEuXd1QdNoVhagocNXxCUISZd3YcDcNqZUOUG5RQxLzwEf
         BrXQ==
X-Received: by 10.140.97.119 with SMTP id l110mr13685qge.21.1399987107941;
        Tue, 13 May 2014 06:18:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.104.49 with SMTP id z46ls880507qge.50.gmail; Tue, 13 May
 2014 06:18:27 -0700 (PDT)
X-Received: by 10.236.141.11 with SMTP id f11mr6628992yhj.54.1399987107289;
        Tue, 13 May 2014 06:18:27 -0700 (PDT)
Received: from mail-qg0-x22d.google.com (mail-qg0-x22d.google.com [2607:f8b0:400d:c04::22d])
        by gmr-mx.google.com with ESMTPS id k3si2281553qcn.2.2014.05.13.06.18.27
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 06:18:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 2607:f8b0:400d:c04::22d as permitted sender) client-ip=2607:f8b0:400d:c04::22d;
Received: by mail-qg0-f45.google.com with SMTP id z60so351104qgd.32
        for <msysgit@googlegroups.com>; Tue, 13 May 2014 06:18:27 -0700 (PDT)
X-Received: by 10.229.125.130 with SMTP id y2mr13996525qcr.22.1399987107193;
 Tue, 13 May 2014 06:18:27 -0700 (PDT)
Received: by 10.140.19.242 with HTTP; Tue, 13 May 2014 06:18:26 -0700 (PDT)
In-Reply-To: <CABPQNSYU5haMzdy2cDn=KF2+j_aFK19Ju+x+LTeex6JqWJMncQ@mail.gmail.com>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras@gmail.com designates
 2607:f8b0:400d:c04::22d as permitted sender) smtp.mail=felipe.contreras@gmail.com;
       dkim=pass header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248780>

On Tue, May 13, 2014 at 1:34 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Tue, May 13, 2014 at 8:01 AM, Stepan Kasal <kasal@ucw.cz> wrote:
>> From: Pat Thoyts <patthoyts@users.sourceforge.net>
>> Date: Wed, 24 Oct 2012 00:15:29 +0100
>>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>> ---
>>  contrib/credential/wincred/Makefile | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
>> index 39fa5e0..e64cd9a 100644
>> --- a/contrib/credential/wincred/Makefile
>> +++ b/contrib/credential/wincred/Makefile
>> @@ -1,9 +1,5 @@
>>  all: git-credential-wincred.exe
>>
>> -CC = gcc
>> -RM = rm -f
>> -CFLAGS = -O2 -Wall
>> -
>
> Would it be better to set these if not already set, i.e:
>
> -CC = gcc
> -RM = rm -f
> -CFLAGS = -O2 -Wall
> +CC ?= gcc
> +RM ?= rm -f
> +CFLAGS ?= -O2 -Wall
>
> instead?

Set by whom? If it's by the environment you should be running 'make -e'.

-- 
Felipe Contreras

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
