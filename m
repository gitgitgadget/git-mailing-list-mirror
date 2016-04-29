From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Fri, 29 Apr 2016 19:05:44 -0400
Organization: Twitter
Message-ID: <1461971144.4123.38.camel@twopensource.com>
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
	 <1461602647.25914.2.camel@twopensource.com>
	 <CAGZ79kYc+uMCJq5tTHujp1YYG5OcNSPiyWuGvVzipuBcwtLNYA@mail.gmail.com>
	 <CAGZ79kYGi9bhRfGype7te4cGkxvnKww269kYoykB+76HNnTarg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:05:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHTs-0004Yh-GV
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbcD2XFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:05:48 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34381 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbcD2XFr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:05:47 -0400
Received: by mail-qg0-f50.google.com with SMTP id 90so33320510qgz.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rjq0Ht5cQdPUCeiiTx3dk1FBXRHuh2jT8Dy/7NRMerQ=;
        b=oQ9c7gSJXFiB/iPuL7XUY38QRzngiYvbRzT32eheNvq9uwYLsv42HsVmOzAN8+GctO
         ONI3HBgl0gaW2GYqmDujsqX1K5j8mEQRy/6u/IezEBCiHl6Ns+rBrTx4i2gpqDPI+nE5
         TKWkKNwjnUCqieYAuPhTY3PA3Cq44m31hFpG5r6ZceLVmvb+i5tynx+I8rzbSnEQ2c3z
         iTS2QBclRxuCGuZJMhsvxUz1b1JBdoJh0WMs79GhScARwMKebq3tN36PFoz8ZUgK65uw
         BMuuKzqMynIZfRipk2gdF7RFl/3650NodSgPAg5d1ZEHhUSQPs63aO16eecbKlcPQAPV
         g3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rjq0Ht5cQdPUCeiiTx3dk1FBXRHuh2jT8Dy/7NRMerQ=;
        b=LdIzGbQ9jWyARSr+zkJRnBUxnjxroBrMGRjpCZC3hXgp6YhuMrYk45TZ8A29oWAIB5
         tSWxsTJdgJn941VYBnLfxsz3UH9eQMlu88cRu3mbSA2h6yqyw50l4Sje+Xypuo+nlHaR
         SAxep0tC3tMxr8UctRbkskQTCj2mRq5dGVAv1EvKxmzzHkGsSFgdNCQ0lqSBRxx3rUiN
         bE4InVgCXkW+xyBIGpkyMgXAbAGbInian6skrqE8m5gPN6rGVMEGbeIqKXdUqoXcVwdM
         Uqqic/BvobEXeUr5P1mfD/vTP3NlcR9Zo0Eel1suwfDrxNGJCLki5euxLT1u3InvNj8v
         3AQQ==
X-Gm-Message-State: AOPr4FVuwxj1GRINvVC8zY4fUYzoiyVbXTl+rVkT4VwC88NSy1EfvxItjae1BTd8+dkCJA==
X-Received: by 10.140.28.135 with SMTP id 7mr21578612qgz.72.1461971146699;
        Fri, 29 Apr 2016 16:05:46 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id d145sm5141995qhc.31.2016.04.29.16.05.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 16:05:45 -0700 (PDT)
In-Reply-To: <CAGZ79kYGi9bhRfGype7te4cGkxvnKww269kYoykB+76HNnTarg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293066>

On Tue, 2016-04-26 at 20:59 -0700, Stefan Beller wrote:
> On Mon, Apr 25, 2016 at 3:10 PM, Stefan Beller <sbeller@google.com>
> wrote:
> > On Mon, Apr 25, 2016 at 9:44 AM, David Turner <
> > dturner@twopensource.com> wrote:
> > > On Wed, 2016-04-20 at 16:57 -0400, Jeff King wrote:
> > > > On Wed, Apr 20, 2016 at 04:46:55PM -0400, David Turner wrote:
> > > > 
> > > > > As you note, it appears that git-daemon does sort-of have
> > > > > support
> > > > > for
> > > > > extra args -- see parse_host_arg.  So it wouldn't be hard to
> > > > > add
> > > > > something here. Unfortunately, current versions of git die on
> > > > > unknown
> > > > > args.  So this change would not be backwards-compatible.  We
> > > > > could
> > > > > put
> > > > > a decider on it so that clients would only try it when
> > > > > explicitly
> > > > > enabled.  Or we could have clients try it with, and in the
> > > > > event of
> > > > > an
> > > > > error, retry without.  Neither is ideal, but both are
> > > > > possible.
> > > > 
> > > > Right. This ends up being the same difficulty that the v2
> > > > protocol
> > > > encountered; how do you figure out what you can speak without
> > > > resorting
> > > > to expensive fallbacks, when do you flip the switch, do you
> > > > remember
> > > > the
> > > > protocol you used last time with this server, etc.
> > > 
> > > Right.
> > > 
> > > [moved]
> > > > > If I read this code correctly, git-over-ssh will pass through
> > > > > arbitrary
> > > > > arguments.  So this should be trivial.
> > > > 
> > > > It does if you are ssh-ing to a real shell-level account on the
> > > > server,
> > > > but if you are using git-shell or some other wrapper to
> > > > restrict
> > > > clients
> > > > from running arbitrary commands, it will likely reject it.
> > > 
> > > Oh, I see how I was mis-reading shell.c.  Oops.
> > > [/moved]
> > > 
> > > 
> > > > Which isn't to say it's necessarily a bad thing. Maybe the path
> > > > forward
> > > > instead of v2 is to shoe-horn this data into the pre-protocol
> > > > conversation, and go from there. The protocol accepts that
> > > > "somehow"
> > > > it
> > > > got some extra data from the transport layer, and acts on its
> > > > uniformly.
> > > 
> > > OK, so it seems like only HTTP (and non-git-shell-git://) allow
> > > backwar
> > > ds-compatible optional pre-protocol messages.  So we don't have
> > > good
> > > options; we only have bad ones.  We have to decide which
> > > particular
> > > kind of badness we're willing to accept, and to what degree we
> > > care
> > > about extensibility.  As I see it, the badness options are (in no
> > > particular order):
> > > 
> > > 1. Nothing changes.
> > > 2. HTTP grows more extensions; other protocols stagnate.
> > > 3. HTTP grows extensions; other protocols get extensions but:
> > >    a. only use them on explicit client configuration or
> > >    b. try/fail/remember per-remote
> > > 4. A backwards-incompatible protocol v2 is introduced, which
> > >    hits alternate endpoints (with the same a/b as above).  This
> > > is
> > >    different from 3. in that protocol v2 is explicitly designed
> > > around
> > >    a capabilities negotiation phase rather than unilateral client
> > > -side
> > >    decisions.
> > > 5. Think of another way to make fetch performant with many refs,
> > > and
> > >     defer the extension decision.
> > 
> > I'd prefer 2,3,4 over 1,5.
> > 
> > Speaking about 2,3,4:
> > 
> > Maybe we can do a mix of 2 and 4:
> > 
> >    1) HTTP grows more extensions; other protocols stagnate for now.
> >    2) Come up with a backwards-incompatible protocol v2, foccussed
> > on
> >        capabilities negotiation phase, hitting alternative end
> > points
> >        (non http only, or rather a subset of protocols only)
> >     3) if HTTP sees the benefits of the native protocol v2, we may
> > switch
> >         HTTP, too
> > 
> > (in time order of execution. Each point is decoupled from the
> > others and may
> > be done by different people at different times.)
> > 
> 
> Today I rebased protocol-v2[1] and it was fewer conflicts than
> expected.
> I am surprised by myself that there is even a test case for v2
> already,
> so I think it is more progressed that I had in mind. Maybe we can do
> 1)
> for now and hope that the non http catches up eventually?
> 
> 
> [1] https://github.com/stefanbeller/git/tree/protocol-v2


Do you plan to send these patches to the mailing list?  What's the next
step here?
