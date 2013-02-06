From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] connect.c: Tell *PLink to always use ssh protocol
Date: Wed, 6 Feb 2013 18:22:14 -0500
Message-ID: <20130206232214.GN27507@sigill.intra.peff.net>
References: <5112D219.3020604@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org, gitster@pobox.com
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: msysgit+bncBDO2DJFKTEFBBLGLZOEAKGQEAEATDJI@googlegroups.com Thu Feb 07 00:22:47 2013
Return-path: <msysgit+bncBDO2DJFKTEFBBLGLZOEAKGQEAEATDJI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f190.google.com ([209.85.213.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBLGLZOEAKGQEAEATDJI@googlegroups.com>)
	id 1U3EK8-0000fO-3Y
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2013 00:22:40 +0100
Received: by mail-ye0-f190.google.com with SMTP id l14sf712615yen.27
        for <gcvm-msysgit@m.gmane.org>; Wed, 06 Feb 2013 15:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf:date:from
         :to:cc:subject:message-id:references:mime-version:in-reply-to
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=z1muD5HD4lC1G46nOhkbeLzETYLiGp5jE0HsyonvZXw=;
        b=HzsMligGyrUa1EgJDQpR5UGXAk27/eBB2fRF7YyCoAw15MOYl40vF2wx67H9r0RDS9
         3J/9yVMGIJEPB11Zx62wmxZW119cp4uRHlEHSWdz5m8L7+w8Jl66p6jSmU9B9eEsNWrf
         t4x3TL5RsG62rqd6L1UlAuKPNa7xOr6RliOk1VO5fZY6HSJy8qZ8pk/a+JjRNdzhmhMn
         VUpc/mqpY8RV92mY6kkRdb0isv6r92ElrGJJ3AN8G5foeYJjYkzI3G81NOOlaRbvTqXb
         1LKOT9Pn3Cr768WIn84XhcZ09cfdo/PI 
X-Received: by 10.50.187.133 with SMTP id fs5mr623750igc.12.1360192940678;
        Wed, 06 Feb 2013 15:22:20 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.36.168 with SMTP id r8ls2958525igj.40.canary; Wed, 06 Feb
 2013 15:22:19 -0800 (PST)
X-Received: by 10.42.123.66 with SMTP id q2mr22117286icr.15.1360192939865;
        Wed, 06 Feb 2013 15:22:19 -0800 (PST)
X-Received: by 10.42.123.66 with SMTP id q2mr22117284icr.15.1360192939854;
        Wed, 06 Feb 2013 15:22:19 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id ut11si326724igb.3.2013.02.06.15.22.19
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 15:22:19 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 12087 invoked by uid 107); 6 Feb 2013 23:23:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 18:23:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 18:22:14 -0500
In-Reply-To: <5112D219.3020604@tu-clausthal.de>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted
 sender) smtp.mail=peff@peff.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215664>

On Wed, Feb 06, 2013 at 10:58:49PM +0100, Sven Strickroth wrote:

> Default values for *plink can be set using PuTTY. If a user makes
> telnet the default in PuTTY this breaks ssh clones in git.
> 
> Since git clones of the type user@host:path use ssh, tell *plink
> to use ssh and override PuTTY defaults for the protocol to use.
> 
> Signed-off-by: Sven Strickroth <email@cs-ware.de>

Makes sense to me, though I'd expect to see this cc'd to the msysgit
list (which I'm doing on this response) for comment from people who
might be more familiar with the area.

Quoted patch follows.

-Peff

> ---
>  connect.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/connect.c b/connect.c
> index 49e56ba..d337b6f 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -625,6 +625,8 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
>  		if (!ssh) ssh = "ssh";
>  
>  		*arg++ = ssh;
> +		if (putty)
> +			*arg++ = "-ssh";
>  		if (putty && !strcasestr(ssh, "tortoiseplink"))
>  			*arg++ = "-batch";
>  		if (port) {
> -- 
> Best regards,
>  Sven Strickroth
>  PGP key id F5A9D4C4 @ any key-server

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
