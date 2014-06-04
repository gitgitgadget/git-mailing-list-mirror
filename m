From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 16:53:50 +0200
Organization: <)><
Message-ID: <20140604145350.GA22681@camelia.ucw.cz>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBAPGXSOAKGQE5KQUXWI@googlegroups.com Wed Jun 04 16:53:58 2014
Return-path: <msysgit+bncBCU63DXMWULRBAPGXSOAKGQE5KQUXWI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBAPGXSOAKGQE5KQUXWI@googlegroups.com>)
	id 1WsCZf-0004Rr-SI
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 16:53:55 +0200
Received: by mail-wi0-f192.google.com with SMTP id z2sf110697wiv.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=LRr0Qr9L3Sz/kbHrvjEd9LKIY8Jaf4YSJ1TtCvKPPTI=;
        b=DrGi17ccrJVqDPnTMeCbTFOFGTHDME98pKtgd3BiTgKkS8uJXbry5EmbDHjdlYIVwP
         AHr8qW/GSB80dikEu3Oe9GiJzgoz3GbU9fGNitq/kDLD1EfWp/V2Ns1Q2apFqthNXwH1
         Gf0FJlMe58L0FSu/F2Q+SCTFk2spH6QIlhEyG39Onmci6YlsZTilSKrgZjTIlIOomvdq
         a8KvsC7v0BaTfX5zWWWqp/UGZUHmZYPwuQb4gOtiTit3maXi4DfKyzm5+67JkbrmZT47
         0m1tw/AFZb8mZ4hnyQ5krfjOmCFc4je+MXtfpdaJBGPCxOzK5+LD0R779UsNp6ig+9sh
         V1Rw==
X-Received: by 10.152.120.37 with SMTP id kz5mr13458lab.30.1401893634382;
        Wed, 04 Jun 2014 07:53:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.5.200 with SMTP id u8ls522033lau.33.gmail; Wed, 04 Jun
 2014 07:53:53 -0700 (PDT)
X-Received: by 10.112.89.10 with SMTP id bk10mr5086833lbb.5.1401893633413;
        Wed, 04 Jun 2014 07:53:53 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id xk11si585778wib.0.2014.06.04.07.53.52
        for <msysgit@googlegroups.com>;
        Wed, 04 Jun 2014 07:53:52 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 15A711C009E;
	Wed,  4 Jun 2014 16:53:51 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s54EroNj022873;
	Wed, 4 Jun 2014 16:53:50 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s54EroWJ022872;
	Wed, 4 Jun 2014 16:53:50 +0200
In-Reply-To: <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250733>

Hello,

On Wed, Jun 04, 2014 at 08:47:58PM +0700, Duy Nguyen wrote:
> setenv("HOME") if it's missing instead? MinGW port already replaces
> main(). Extra initialization should not be a problem.

well, I would be afraid to modify the environment for subprocesses.
It could hit back in certain situations, like with git filter-branch.

We could replace getenv() with a wrapper though.
But I don't think it's worth it.

> I feel
> "getenv("HOME")" a tiny bit more familiar than get_home_directory(),
> but that's really weak argument as the number of call sites has not
> increased in 4 years.

Actually, the patch had to be updated when msysgit modifications were
rebased.  But yes, the number of call sites has not icreased: it was
called in four places back than, and it is called at three places
now.  There is only one that is in common, though.

Stepan

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
