From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Thu, 15 May 2014 19:44:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1405151943310.14982@s15462909.onlinehome-server.info>
References: <20140514155010.GA4592@camelia.ucw.cz> <xmqq7g5okztp.fsf@gitster.dls.corp.google.com> <20140514182654.GA9218@google.com> <xmqqvbt8jjlg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Stepan Kasal <kasal@ucw.cz>, 
    GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRB27Z2ONQKGQE6VJP3FQ@googlegroups.com Thu May 15 19:44:13 2014
Return-path: <msysgit+bncBCZPH74Q5YNRB27Z2ONQKGQE6VJP3FQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB27Z2ONQKGQE6VJP3FQ@googlegroups.com>)
	id 1WkzhU-0005b7-Hr
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 19:44:12 +0200
Received: by mail-la0-f55.google.com with SMTP id el20sf139510lab.10
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=r4GY7C09cHTQlOtphe15jwk15cT3NQMG8nLcb8xZ8tw=;
        b=BSdUExYhVhWq/9WfBbls2sPZC7X6tB+eF1gwww9Tkzr307WWvte+eOX+Vwt5EA2znF
         fFL+aWa7W+jlRJX+S+WXIa71zxlVEjP3UVdb/uR1Vj1Lv3ePiP9EYFUwDc8ggeSeqKDT
         cP7c2K5QQNVetWv14A8sebTsWZnZCi9pSxdLb9w7Bcur/s+2xxzcTOH2DRoYRPAPXy/F
         ls2VfsL6e2t+VC4JQYPuRSqJ2tsMCId/OeCy2C86llV6Yfysm0OVKzeeB/NrCEIPjTNz
         gDyObrjN/i+vHgyz0SEQC7rwhOs5dQb9reHB9TSiU6mofAP6Rn2+Pg/7nKRZ1LIAFAXx
         EmIg==
X-Received: by 10.180.99.197 with SMTP id es5mr113538wib.9.1400175852049;
        Thu, 15 May 2014 10:44:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.76.238 with SMTP id n14ls1322703wiw.11.canary; Thu, 15 May
 2014 10:44:10 -0700 (PDT)
X-Received: by 10.180.206.33 with SMTP id ll1mr3684293wic.5.1400175850846;
        Thu, 15 May 2014 10:44:10 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id u49si1906786eeo.1.2014.05.15.10.44.10
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 May 2014 10:44:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LeSOH-1X8AMe0xBd-00qD6k;
 Thu, 15 May 2014 19:44:09 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqvbt8jjlg.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:tDGSbmZZPaUjmNPKAcGJFemhaPT+SiE3dfBeWo3VzMZrSnQijtB
 gFCn6XlCnlbM6JQcOVqrUom8b4xesYuWJQxliAC0cAHSJBMVWaa6fL8v7OX15WvCgb2scOs
 ksq9RQUTwn3WHZATgFpf739ty3kd95ZuKNsMhhyJfTd1u23gA06Ep1qtnJUsZUiGGgDLsen
 fIcpODTuKkuQv/YnufgYQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249169>

Hi Junio,

On Wed, 14 May 2014, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >>> +		if (opt.ignore_case && !strcmp("less", pager))
> >>> +			string_list_append(&path_list, "-i");
> >>
> >> I have a feeling that this goes against the recent trend of not
> >> mucking with the expectation of the users on their pagers, if I
> >> recall correctly the arguments for dropping S from the default given
> >> to an unconfigured LESS environment variable.
> >
> > It's just missing an explanation.
> > ...
> > (That's -I, not -i, because it ought to work even when the pattern
> > contains capital letters.)
> 
> Spot on.  The change, especially with "-I", makes sense.

Except that it was not tested with -I. If you change it that way and it
stops working on Windows, it's useless to me.

Ciao,
Johannes

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
