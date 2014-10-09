From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 01/14] MINGW: compat/mingw.h: do not attempt to
 redefine lseek on mingw-w64
Date: Thu, 9 Oct 2014 03:01:34 +0200
Message-ID: <CABPQNSZXLSfvAOYfER2KYHedityyA+OEo4C5sfu-8K1KkL1R7g@mail.gmail.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-2-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBDR53PPJ7YHRBFV526QQKGQEUSN7M7I@googlegroups.com Thu Oct 09 03:02:18 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBFV526QQKGQEUSN7M7I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qg0-f55.google.com ([209.85.192.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBFV526QQKGQEUSN7M7I@googlegroups.com>)
	id 1Xc27U-0007UZ-BC
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 03:02:16 +0200
Received: by mail-qg0-f55.google.com with SMTP id q108sf45949qgd.20
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 18:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=gqJHKNXogR6pkYfco2Ad1KldAou9+CmjspGV6ccTTso=;
        b=c5G52NKwDDo1W3dsM9RkiU6/fgTnnh2DEGkbkxoY6JUr2Z3YRAmk1AG/6wyUaZWZp5
         XuGznJboAnCj1uWfcQZEIE8K0sPrGbpcktzvUF1AoWvoQ5HkId3Na81BRhH3WjfJa/fy
         Ep9nsJfq7OhKthPGTW1Q1CZTVpi9st5NbRnX0Ar22qWbD/Vho+I3GPUW9Sb0Clb9jX6n
         PqI3jhlVVfPyDXPrO0uEB/Dc5V0MRYfRj1kyV7mn9P7gnmdx3HMB8UGs6O9ZX4fqQUyu
         rGpiwJHveZ+9nxPUymUnGWqQjveTr18HNK9QPt3VDbHREreJb1LaR4ZIoP7Fu0NtBuTG
         Uoaw==
X-Received: by 10.50.142.104 with SMTP id rv8mr371643igb.11.1412816535589;
        Wed, 08 Oct 2014 18:02:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.51.16.66 with SMTP id fu2ls4154594igd.0.canary; Wed, 08 Oct
 2014 18:02:14 -0700 (PDT)
X-Received: by 10.50.138.167 with SMTP id qr7mr1296477igb.6.1412816534653;
        Wed, 08 Oct 2014 18:02:14 -0700 (PDT)
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com [2607:f8b0:4001:c05::231])
        by gmr-mx.google.com with ESMTPS id nt9si299483igb.1.2014.10.08.18.02.14
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 18:02:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::231 as permitted sender) client-ip=2607:f8b0:4001:c05::231;
Received: by mail-ig0-x231.google.com with SMTP id a13so1154793igq.16
        for <msysgit@googlegroups.com>; Wed, 08 Oct 2014 18:02:14 -0700 (PDT)
X-Received: by 10.42.180.5 with SMTP id bs5mr2164919icb.70.1412816534558; Wed,
 08 Oct 2014 18:02:14 -0700 (PDT)
Received: by 10.64.123.5 with HTTP; Wed, 8 Oct 2014 18:01:34 -0700 (PDT)
In-Reply-To: <1412791267-13356-2-git-send-email-marat@slonopotamus.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::231
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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

On Wed, Oct 8, 2014 at 8:00 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> Unlike MinGW, MinGW-W64 has lseek already properly defined in io.h.
>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> Acked-by: Eric Faye-Lund <kusmabite@gmail.com>

I spell my name with a K, "Erik Faye-Lund".

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
