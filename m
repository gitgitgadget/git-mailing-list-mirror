From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 5 Jun 2014 06:10:43 +0700
Message-ID: <CACsJy8Bz_cvF-AQyVKF7yqu9PArH7cV2Va_t=-bM-DGtGu8tpA@mail.gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com>
 <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com>
 <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
 <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com>
 <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info>
 <20140604154503.GB22681@camelia.ucw.cz> <alpine.DEB.1.00.1406041749590.14982@s15462909.onlinehome-server.info>
 <20140604161625.GB23226@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Erik Faye-Lund <kusmabite@gmail.com>, 
	GIT Mailing-list <git@vger.kernel.org>, Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBC2ZN5PHQUMBBEOPX2OAKGQESGIPAOI@googlegroups.com Thu Jun 05 01:12:41 2014
Return-path: <msysgit+bncBC2ZN5PHQUMBBEOPX2OAKGQESGIPAOI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f64.google.com ([209.85.216.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBEOPX2OAKGQESGIPAOI@googlegroups.com>)
	id 1WsKKx-0000bn-7F
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 01:11:15 +0200
Received: by mail-qa0-f64.google.com with SMTP id i13sf32983qae.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 16:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=TgD6hgvkazsx/UZiZbUZpc0zdH7Tvds3HYJKUs0Uk9I=;
        b=abZWraLlOs2p21JWXPqFH45h5MwqW+j72IBaumfmw7gRjFiz7e3OIAgrF/2dVlIsng
         ty5nzRMqmH1l0RQ2iUqOvzQ93kClNyFPk/FdaS5Apn8E9TsXWyc89DkI/wxBjT3dpLdG
         mGtc6fIh716v2/mBZ1smcRoF4qgbRUCOwC6CRGThKXu5eT86xVk86KCKosGoSVPkD8/u
         LhQohRGEN2VaW+ZHA6E8YMG12awvTTspG5ec7T2ojkPAOXNR7q8JmwjD6E6kclXVFEEb
         1JMK9ixXRQZsTpwSzj50CH5W+wo4vXC5lQ/XZUgV/T1EkDtAVkfLYUj10cSf34lrpbL3
         NNEQ==
X-Received: by 10.50.66.129 with SMTP id f1mr35533igt.13.1401923474453;
        Wed, 04 Jun 2014 16:11:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.253.74 with SMTP id zy10ls870880igc.26.canary; Wed, 04 Jun
 2014 16:11:13 -0700 (PDT)
X-Received: by 10.68.180.132 with SMTP id do4mr21426200pbc.4.1401923473670;
        Wed, 04 Jun 2014 16:11:13 -0700 (PDT)
Received: from mail-qg0-x22e.google.com (mail-qg0-x22e.google.com [2607:f8b0:400d:c04::22e])
        by gmr-mx.google.com with ESMTPS id l6si19657qco.2.2014.06.04.16.11.13
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 16:11:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c04::22e as permitted sender) client-ip=2607:f8b0:400d:c04::22e;
Received: by mail-qg0-f46.google.com with SMTP id q108so333232qgd.19
        for <msysgit@googlegroups.com>; Wed, 04 Jun 2014 16:11:13 -0700 (PDT)
X-Received: by 10.224.160.202 with SMTP id o10mr78366438qax.8.1401923473515;
 Wed, 04 Jun 2014 16:11:13 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 4 Jun 2014 16:10:43 -0700 (PDT)
In-Reply-To: <20140604161625.GB23226@camelia.ucw.cz>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c04::22e
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250799>

On Wed, Jun 4, 2014 at 11:16 PM, Stepan Kasal <kasal@ucw.cz> wrote:
> Hi dscho,
>
> your arguments seem really strong.  (Especially the four years of
> battle testing, with the memories of constant problems with HOME before.)
>
> I hope they are strong enough to convince Junio to accept this patch;
> that would help.

I think you should include the problems Dscho described in the commit
message too.
-- 
Duy

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
