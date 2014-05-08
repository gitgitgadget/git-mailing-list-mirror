From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] Windows: Always normalize paths to Windows-style
Date: Thu, 8 May 2014 12:11:15 +0200
Organization: <)><
Message-ID: <20140508101115.GC4511@camelia.ucw.cz>
References: <20140428083931.GA10257@camelia.ucw.cz> <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com> <20140428113815.GA10559@camelia.ucw.cz> <20140428114224.GA11186@camelia.ucw.cz> <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com> <20140428142931.GA12056@camelia.ucw.cz> <20140507184444.GB4013@sandbox-ub> <xmqqmwet8gre.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>, GIT Mailing-list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCU63DXMWULRBRVQVWNQKGQEHKSCLSI@googlegroups.com Thu May 08 12:11:21 2014
Return-path: <msysgit+bncBCU63DXMWULRBRVQVWNQKGQEHKSCLSI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f62.google.com ([74.125.82.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBRVQVWNQKGQEHKSCLSI@googlegroups.com>)
	id 1WiLIN-0007vh-60
	for gcvm-msysgit@m.gmane.org; Thu, 08 May 2014 12:11:19 +0200
Received: by mail-wg0-f62.google.com with SMTP id n12sf231082wgh.17
        for <gcvm-msysgit@m.gmane.org>; Thu, 08 May 2014 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=KWp2nhVl6pMxnvqfZ6Jz9b1fUDyF1reeKkOLIdVxjrE=;
        b=d5r6yhkgXF26yjCRXDusUBN13HA1Occ5OiGsyo4IoAfZ2BXRWYN7L9qWfzrxXhEc8E
         /fdk5RIEUOAu5mG/lrXkZZLhSmqH/MXEO3Zw1CNNySr8HOjIfgVl/oX18T+yXGLZwpBl
         15N0xq19uwyuPIAv3pZwliRvIvEAlMrzqhNYW4pLvIVq98mu+YvjvieOXq8w/CDIB9Ke
         iRWGtgXs+eUzRPLBkyysOywxSZFXf7xlk037lYszS3nfz58jVwF6aN+Aoy5RNJzwqabV
         IQCBcmdIF84CZljYc3hLTnoO3w3MOfKGNqldvSRhr+oCZldJU91Nw6uHJ4t91ECQk5GW
         2C9Q==
X-Received: by 10.180.198.239 with SMTP id jf15mr28964wic.12.1399543878923;
        Thu, 08 May 2014 03:11:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.95.161 with SMTP id dl1ls132426wib.0.gmail; Thu, 08 May
 2014 03:11:17 -0700 (PDT)
X-Received: by 10.180.211.102 with SMTP id nb6mr359005wic.1.1399543877538;
        Thu, 08 May 2014 03:11:17 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id m49si385142eeu.0.2014.05.08.03.11.17
        for <msysgit@googlegroups.com>;
        Thu, 08 May 2014 03:11:17 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 450CB1C00F1;
	Thu,  8 May 2014 12:11:17 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s48ABGb0004622;
	Thu, 8 May 2014 12:11:16 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s48ABFdB004621;
	Thu, 8 May 2014 12:11:15 +0200
In-Reply-To: <xmqqmwet8gre.fsf@gitster.dls.corp.google.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248416>

Hello,

On Wed, May 07, 2014 at 01:40:05PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > On Mon, Apr 28, 2014 at 04:29:31PM +0200, Stepan Kasal wrote:
> >> this is another patch that lives in msysGit for a long time.
> >> Originally, it had two parts:
> >> (Cf https://github.com/msysgit/git/commit/64a8a03 )
> >> 
> >> 1) adding alias pwd='pwd -W' to git-sh-setup.sh
> >>    This one went upstream, though as a shell function.
> >> 
> >> 2) revert of commit 4dce7d9b by Johannes Sixt <j6t@kdbg.org>
> >> This mingw-specific commit was created less than 3 weeks before
> >> it was reverted.  And it stayed reverted for two years.
> >> 
> >> Could you please either accept this patch, or revert 4dce7d9b ?
> >> (Both alternatives are exactly the same.)
> >
> > Sorry for the late reply.  To me reverting (or omitting at the next
> > rebasing merge) this patch sound fine, as it seems to be superseeded by
> > the upstream change.
> >
> > As I can see thats already done on master, so it seems to be all good.

Thank you, Junio, for asking.
(I'm afraid my previous mail was unclear.)

> Are you guys talking about be39048a (git-sh-setup.sh: Add an pwd()
> function for MinGW, 2012-04-17) which has been in since v1.7.11?

This one is ok, keep it.  (msysGit has been using an alias instead of
function for several years, but msysGit/master was synced recently.)

> The change introduced by 4dce7d9b (submodules: fix ambiguous
> absolute paths under Windows, 2012-03-04) still exists, but your
> "reverting this patch sound fine" confuses me.

This one was accepted to git, but was reverted in msysGit almost
immediately by 64a8a03.  Things stayed that way for 2 years.
So it seems no one has ever actually used this code.
Consequently, I propose to revert 4dce7d9b from git.

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
