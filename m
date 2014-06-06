From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH v2] Add a Windows-specific fallback to getenv("HOME");
Date: Fri, 6 Jun 2014 10:03:12 +0200
Organization: <)><
Message-ID: <20140606080312.GA1303@camelia.ucw.cz>
References: <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com> <20140605080317.GA28029@camelia.ucw.cz> <53903B22.70507@gmail.com> <CABPQNSYtxLyWkRGOyst7VOpw-_=rQvKF_VsbDB7Y0-K=d9rvkQ@mail.gmail.com> <5390E4B6.60206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, GIT Mailing-list <git@vger.kernel.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBQXLYWOAKGQEO2D36JQ@googlegroups.com Fri Jun 06 10:03:16 2014
Return-path: <msysgit+bncBCU63DXMWULRBQXLYWOAKGQEO2D36JQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f61.google.com ([74.125.82.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBQXLYWOAKGQEO2D36JQ@googlegroups.com>)
	id 1Wsp7L-0007ir-Qa
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 10:03:15 +0200
Received: by mail-wg0-f61.google.com with SMTP id m15sf241653wgh.26
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=OMxYSTJ4lzY/OkPQPlVL9sGJeVepOduVYab0iTDBCdI=;
        b=Q7h7xeNRdovVfa5s8ikvUn3DHiE0+Hi1pZHBdRq3e09a7tlp2MwEOgqyf1TPaBfFA0
         30LWxkxOs6N/sc73EaYxRDYl9umaB6RyJkmAYjgg0nZC28ECmYgI+HIAVluLusPgeudz
         /WwDoI6HZgdzWZKnaMnK8X6noj1ZMrZd0CEJ+r2zJaSnMbdHLPh/0RRPuY3CMdDFcMEu
         ik5Z199SZBCqXzLfIeeGs1xDZFW93S2sIuRYo0qxKbXPv5n88eqpUmwwUH9M+dvaOTB4
         UnADA/NLUN1m2moHuV8t+Oi+fuGZIolv/Cb/YC8NXrYN6ziwwFkzvTw03f7ux6NMhK6X
         mi9Q==
X-Received: by 10.152.23.165 with SMTP id n5mr47878laf.5.1402041795540;
        Fri, 06 Jun 2014 01:03:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.22.67 with SMTP id b3ls115517laf.1.gmail; Fri, 06 Jun 2014
 01:03:14 -0700 (PDT)
X-Received: by 10.112.40.1 with SMTP id t1mr1008464lbk.19.1402041794330;
        Fri, 06 Jun 2014 01:03:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id m20si496963wij.1.2014.06.06.01.03.14
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 01:03:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 05C831C009B;
	Fri,  6 Jun 2014 10:03:14 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s5683Dc1001400;
	Fri, 6 Jun 2014 10:03:13 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s5683CmZ001399;
	Fri, 6 Jun 2014 10:03:12 +0200
In-Reply-To: <5390E4B6.60206@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250892>

Hi,

On Thu, Jun 05, 2014 at 11:44:22PM +0200, Karsten Blees wrote:
> I think the most time-preserving option is to send it upstream as
> unchanged as possible (probably with the bugfix-patches squashed).

I plan to submit one by one or in a small series.
Agreed about the squashes, I have several of them prepared, thanks to
your hints.

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
