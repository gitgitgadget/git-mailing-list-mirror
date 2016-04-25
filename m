From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Mon, 25 Apr 2016 12:44:07 -0400
Organization: Twitter
Message-ID: <1461602647.25914.2.camel@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	 <1460747949-3514-5-git-send-email-dturner@twopensource.com>
	 <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
	 <20160419071403.GA22577@sigill.intra.peff.net>
	 <1461102001.5540.125.camel@twopensource.com>
	 <20160419232243.GF18255@sigill.intra.peff.net>
	 <1461109391.5540.138.camel@twopensource.com>
	 <20160420011740.GA29839@sigill.intra.peff.net>
	 <1461185215.5540.180.camel@twopensource.com>
	 <20160420205726.GA17876@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 18:44:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujcN-00058i-Bi
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbcDYQoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 12:44:11 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33050 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbcDYQoK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:44:10 -0400
Received: by mail-qk0-f181.google.com with SMTP id n63so65023020qkf.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=BDrdcDuSMUaH5f8jOMFibOJS7pDxM2yqS160LuUjxDQ=;
        b=0pdkzkHbzw/d1KAw1ZLNN9TBzz0nZBZUJyGmgA2FxPvBVjhb/FAaQu/zWneGXhz9aT
         +Hcuhh/KPjATFmxSncB9YyMqgvt8qq0I2xPwRHYVaUq/HhtYeOv3g6WLSC1b7EYeR1Zj
         AVsdRNNrQ9iExSwWbtZ4OZif2qMiDtNhuYTQLX6N2Vre7lxgRPL3JcPwZgTY5JylWmlF
         18rWw5GcRm2c8JLCYRHCA9LqKuOvb3Ftcbxtdsp2kYzPFiIT6ABKjTkMj+BflMSwi0iW
         d5aAsDgtK5QpUeoCv4aBjMbZ6WcyuUXR+3YqCv3MP16yXOFbM038fKQiHNf0zhYlxFVD
         TOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=BDrdcDuSMUaH5f8jOMFibOJS7pDxM2yqS160LuUjxDQ=;
        b=L4wk3SD2XqUuihaOcutS8CmmBq0PbgGY3kq4CBpvuFXfrDHBeMKt3G0UovjLhd+rNf
         3KOp7D7YxoNj1nmHuAtqAF9NhS6u8JwDwz+lyT55eSbhCcc8d6RBYNZzlQJapb5CRr3c
         A0sBuOr1UwinbzZrE+sea63VHSOWCkBcMmDo3U9JLiy3OufxGJOlsLvmw8Nf0WlcRPUR
         Fntokdd3ONMLKpk4bNk2iIUeGBUVxyV5SEjQJNwQrGO9h5EHq7DKYL9AUP4igSW8Yreq
         f6dbO/wTdPpeGLhwW1Z7AvpeFQKgWNAP8RKwtdMFlENX1OOJk64ZLVCU0HDaXib041we
         NZgg==
X-Gm-Message-State: AOPr4FUXeOvVhs5xMNUygYPflwPs86HDvuB/sd+d+ms35RmYvp0Qk+4rtw1r1ws0QgoPWQ==
X-Received: by 10.55.107.2 with SMTP id g2mr19458347qkc.165.1461602649254;
        Mon, 25 Apr 2016 09:44:09 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id t81sm7381175qhc.11.2016.04.25.09.44.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2016 09:44:08 -0700 (PDT)
In-Reply-To: <20160420205726.GA17876@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292510>

On Wed, 2016-04-20 at 16:57 -0400, Jeff King wrote:
> On Wed, Apr 20, 2016 at 04:46:55PM -0400, David Turner wrote:
> 
> > As you note, it appears that git-daemon does sort-of have support
> > for
> > extra args -- see parse_host_arg.  So it wouldn't be hard to add
> > something here. Unfortunately, current versions of git die on
> > unknown
> > args.  So this change would not be backwards-compatible.  We could
> > put
> > a decider on it so that clients would only try it when explicitly
> > enabled.  Or we could have clients try it with, and in the event of
> > an
> > error, retry without.  Neither is ideal, but both are possible.
> 
> Right. This ends up being the same difficulty that the v2 protocol
> encountered; how do you figure out what you can speak without
> resorting
> to expensive fallbacks, when do you flip the switch, do you remember
> the
> protocol you used last time with this server, etc.

Right.

[moved]
> > If I read this code correctly, git-over-ssh will pass through
> > arbitrary
> > arguments.  So this should be trivial.
> 
> It does if you are ssh-ing to a real shell-level account on the
> server,
> but if you are using git-shell or some other wrapper to restrict
> clients
> from running arbitrary commands, it will likely reject it.

Oh, I see how I was mis-reading shell.c.  Oops.
[/moved]


> Which isn't to say it's necessarily a bad thing. Maybe the path
> forward
> instead of v2 is to shoe-horn this data into the pre-protocol
> conversation, and go from there. The protocol accepts that "somehow"
> it
> got some extra data from the transport layer, and acts on its
> uniformly.

OK, so it seems like only HTTP (and non-git-shell-git://) allow backwar
ds-compatible optional pre-protocol messages.  So we don't have good
options; we only have bad ones.  We have to decide which particular
kind of badness we're willing to accept, and to what degree we care
about extensibility.  As I see it, the badness options are (in no
particular order):

1. Nothing changes.
2. HTTP grows more extensions; other protocols stagnate.
3. HTTP grows extensions; other protocols get extensions but:
   a. only use them on explicit client configuration or
   b. try/fail/remember per-remote
4. A backwards-incompatible protocol v2 is introduced, which
   hits alternate endpoints (with the same a/b as above).  This is
   different from 3. in that protocol v2 is explicitly designed around
   a capabilities negotiation phase rather than unilateral client-side
   decisions.
5. Think of another way to make fetch performant with many refs, and 	
    defer the extension decision.
