From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 4/5] mingw: reuse tty-version of git_terminal_prompt
Date: Fri, 30 Nov 2012 13:27:16 -0500
Message-ID: <20121130182716.GD7197@sigill.intra.peff.net>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-5-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBB7V4OCQKGQEYQVPBOQ@googlegroups.com Fri Nov 30 19:27:33 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBB7V4OCQKGQEYQVPBOQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-da0-f58.google.com ([209.85.210.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBB7V4OCQKGQEYQVPBOQ@googlegroups.com>)
	id 1TeVJE-0006Kv-Fh
	for gcvm-msysgit@m.gmane.org; Fri, 30 Nov 2012 19:27:32 +0100
Received: by mail-da0-f58.google.com with SMTP id a18sf770794dak.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Nov 2012 10:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=EqkhKouhrB3JDu5ty0CTtuV6kxNBNXet7yKX7lV5i90=;
        b=Ec4lcTHgzM6oGVGtJxITqhx47fibkRJFKzJzutc7jSEsdj6sKdN/QTviLVSzBf+tW0
         y8XWpnyHjhQUnT9Lo7ysg6c/u/mvqxGmB0nHdz09e3Jg4nGMTdTBmjEhzwWL2xB6daCa
         NUKWb/jJlih5XNR8rKVZOJUJo+scaAaDjZlTMtQByNVjxaO9avPkOF02QW6dY8JuNsVA
         qgFuE1wD7xubAaX8goiy2omUfo/v5bgYEELOKCUvoM/BvsbwKoNpKuvHj4u0hU1yVkro
         CebAtwqqwwLEHAeJADsasgHzk7lAD3KoVu683C6OQ3hpguwUyAuCheOicbMhTGCDnUPT
       
Received: by 10.50.193.198 with SMTP id hq6mr2402146igc.10.1354300040647;
        Fri, 30 Nov 2012 10:27:20 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.193.134 with SMTP id ho6ls529igc.23.canary; Fri, 30 Nov
 2012 10:27:18 -0800 (PST)
Received: by 10.42.247.69 with SMTP id mb5mr1752578icb.4.1354300038713;
        Fri, 30 Nov 2012 10:27:18 -0800 (PST)
Received: by 10.42.247.69 with SMTP id mb5mr1752577icb.4.1354300038702;
        Fri, 30 Nov 2012 10:27:18 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id x4si1392730igm.0.2012.11.30.10.27.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Nov 2012 10:27:18 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 5406 invoked by uid 107); 30 Nov 2012 18:28:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 13:28:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 13:27:16 -0500
In-Reply-To: <1352815447-8824-5-git-send-email-kusmabite@gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 75.15.5.89 as permitted sender) smtp.mail=peff@peff.net
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210939>

On Tue, Nov 13, 2012 at 03:04:06PM +0100, Erik Faye-Lund wrote:

> The getpass-implementation we use on Windows isn't at all ideal;
> it works in raw-mode (as opposed to cooked mode), and as a result
> does not deal correcly with deletion, arrow-keys etc.
> 
> Instead, use cooked mode to read a line at the time, allowing the
> C run-time to process the input properly.
> 
> Since we set files to be opened in binary-mode by default on
> Windows, introduce a FORCE_TEXT macro that expands to the "t"
> modifier that forces the terminal to be opened in text-mode so we
> do not have to deal with CRLF issues.

I think this is OK. I had originally envisioned just having a separate
"#ifdef WIN32" and not really sharing code at all with /dev/tty because
I was worried that the conditionals would end up making it hard to read.
This is a little more complex than I would have liked, but I do not see
how the code sharing could be simplified any more than what you have
done, and it is nice to avoid repeating ourselves.

-Peff

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
