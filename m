From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Thu, 14 Mar 2013 23:35:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info> <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com> <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: kusmabite@gmail.com, git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBGNBRGFAKGQE6DN2GBY@googlegroups.com Thu Mar 14 23:35:34 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBGNBRGFAKGQE6DN2GBY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f187.google.com ([209.85.215.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBGNBRGFAKGQE6DN2GBY@googlegroups.com>)
	id 1UGGkC-0001TN-JD
	for gcvm-msysgit@m.gmane.org; Thu, 14 Mar 2013 23:35:28 +0100
Received: by mail-ea0-f187.google.com with SMTP id o10sf799093eaj.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 15:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:x-authenticated
         :x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:x-y-gmx-trusted
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=p09uEEkKS6DoqH7fBe2hzLIpiS1EHkUnUoLoWKRvSsM=;
        b=k1KWm4hYBcJ45NsRNyxs1OkNPUTp64absiz7sKPkRnC0bniU1F/AnFD8mYImKbRtaM
         Rjunr9wa+BgEDFKKowz/LJbz7uAyw5Xa8B0dXspBM167uFGp4WdyP0CX2tTsCIfqs9dF
         Bykh+Kh/sLRyBPIicoYo2frZ8x1E0bJF54Vs6Drnt6HoYMDyn/AL/XMXcOUrSxziCpaS
         ZSCNl/7wy6pxJ4qQvaduiheNIQQqohoL/2iNbnPyalsUR/Ib/1KjqNT3AYLXKoL53dK4
      
X-Received: by 10.180.183.66 with SMTP id ek2mr540383wic.8.1363300506093;
        Thu, 14 Mar 2013 15:35:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.13.74 with SMTP id ew10ls174179wid.52.gmail; Thu, 14 Mar
 2013 15:35:04 -0700 (PDT)
X-Received: by 10.14.184.9 with SMTP id r9mr5726362eem.7.1363300504689;
        Thu, 14 Mar 2013 15:35:04 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTP id 47si1060340eeh.1.2013.03.14.15.35.04;
        Thu, 14 Mar 2013 15:35:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from mailout-de.gmx.net ([10.1.76.12]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MZANm-1U1ukO2DsK-00L0mM for
 <msysgit@googlegroups.com>; Thu, 14 Mar 2013 23:35:04 +0100
Received: (qmail invoked by alias); 14 Mar 2013 22:35:04 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp012) with SMTP; 14 Mar 2013 23:35:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19O6KI1V8NOKPcdPyMHs3yJSQ8WqklEpk7Ng6VNma
	GWE4uIwGsUi44g
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218178>

Hi Junio,

On Thu, 14 Mar 2013, Junio C Hamano wrote:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
> >> I wonder whether we want to have something like this instead:
> >>
> >>         flags = CURL_GLOBAL_ALL;
> >>         if (prefixcmp(url, "https:"))
> >>                 flags &= ^CURL_GLOBAL_SSL;
> >>         curl_global_init(flags);
> >>
> >> I do see that CURL_GLOBAL_ALL is #define'd as CURL_GLOBAL_WIN32 |
> >> CURL_GLOBAL_SSL in curl.h, but that might change in the future, no?
> >
> > Good suggestion. But perhaps we'd want to use CURL_GLOBAL_DEFAULT
> > instead?
> 
> That as a follow-up suggestion may be fine but if you go that route,
> you would need to explicitly flip SSL on when you know it is going
> to an SSL destination.
> 
> The way to determine SSL-ness has to be rock solid and that is much
> more important than ALL vs DEFAULT.  Is prefixcmp(url, "https://")
> the right way to do so?  Do we use this codepath only for HTTPS, or
> does anybody use other protocol cURL supports over SSL with this,
> too?

Apparently, ftps is also handled by cURL and most likely requires SSL.

How about optimizing for the common case and instead of prefixcmp(url,
"https:")) ask for !prefixcmp(url, "http:")?

Ciao,
Dscho

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
For more options, visit https://groups.google.com/groups/opt_out.
