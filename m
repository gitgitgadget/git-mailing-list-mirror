From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Wed, 14 May 2014 20:35:27 +0200
Organization: <)><
Message-ID: <20140514183527.GA5422@camelia.ucw.cz>
References: <20140514155010.GA4592@camelia.ucw.cz> <xmqq7g5okztp.fsf@gitster.dls.corp.google.com> <20140514182654.GA9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, GIT Mailing-list <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBCU63DXMWULRB4POZ2NQKGQEL3E66HY@googlegroups.com Wed May 14 20:35:33 2014
Return-path: <msysgit+bncBCU63DXMWULRB4POZ2NQKGQEL3E66HY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB4POZ2NQKGQEL3E66HY@googlegroups.com>)
	id 1Wke1a-0003jB-3V
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 20:35:30 +0200
Received: by mail-wg0-f57.google.com with SMTP id l18sf226693wgh.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=VF9jhvy7Y+TibKRHhtoRODzAe4rnmK/ov3dG3sDvLtA=;
        b=fi5Wb/gbGIqlQ1yvgpWefZN77MPFMdSM2UuzldsBVQ95HXySt8n/cXcdrohgeJah7O
         j7aFZ53KiPwXvHgCutMx+ANRCXQtupdJEiQmEARUuAReSxu4eYUiZIz3jpciLkb366hH
         WcL9/EPpiGfELzwuiyhGquq+W+DuhFqArh2RuskDPA/SbvzMxMOl4XOoF/FXexdNu/7u
         Mq3IMROV+Dsbue2ut3U+xQUjenWFPMo3XEVoIjjL8vT2ZTuaVz6+FHXxQs3B4NFImLEn
         vMual3DmEhH6FF1NXRRXEz5GP6O+Zjlt4fKkxV4GhL6VIXUiH/Ket/J9VmtOzW5Ns3XI
         8wpQ==
X-Received: by 10.152.6.168 with SMTP id c8mr31121laa.27.1400092529736;
        Wed, 14 May 2014 11:35:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.30.73 with SMTP id q9ls20855lah.23.gmail; Wed, 14 May 2014
 11:35:28 -0700 (PDT)
X-Received: by 10.112.168.198 with SMTP id zy6mr448777lbb.15.1400092528795;
        Wed, 14 May 2014 11:35:28 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id u49si896336eeo.1.2014.05.14.11.35.28
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 11:35:28 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 8970F1C00BE;
	Wed, 14 May 2014 20:35:28 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4EIZSij005443;
	Wed, 14 May 2014 20:35:28 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4EIZRKJ005442;
	Wed, 14 May 2014 20:35:27 +0200
In-Reply-To: <20140514182654.GA9218@google.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248933>

Hello,

On Wed, May 14, 2014 at 11:26:54AM -0700, Jonathan Nieder wrote:
> But as is, it's an improvement, so (except that "-i" should be
> replaced by "-I") it seems like a good change.

indeed, "-I" would match the semantics of git-grep -i .

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
