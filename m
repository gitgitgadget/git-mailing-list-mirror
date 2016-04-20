From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Wed, 20 Apr 2016 16:46:55 -0400
Organization: Twitter
Message-ID: <1461185215.5540.180.camel@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	 <1460747949-3514-5-git-send-email-dturner@twopensource.com>
	 <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
	 <20160419071403.GA22577@sigill.intra.peff.net>
	 <1461102001.5540.125.camel@twopensource.com>
	 <20160419232243.GF18255@sigill.intra.peff.net>
	 <1461109391.5540.138.camel@twopensource.com>
	 <20160420011740.GA29839@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 22:47:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asz1b-0003wu-6i
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 22:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbcDTUq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 16:46:59 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33277 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbcDTUq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 16:46:58 -0400
Received: by mail-qk0-f179.google.com with SMTP id n63so18533864qkf.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=TmuDkEYs99L7qyfcyaVZDiQXKLXdsTwupb3n9EnqLxo=;
        b=o8TqZDaUDziKI7W3EmJXkqcM+Q9wYT6u650zFzbMPL2Qw/SJZ8K5ywp64cbcMLW9lt
         iHJvvmjKxsdWSYKzfcfupvvcLCx5GTZMz5OUHB5lqLQ4vAWPtihDk2/yB7NUa9+eoqRB
         MrP/mc0kIuHkPf2j9kO92TxeH/Zoopj8sNFE5cg/GOPWCINEoQ5HTyvdKAp6NKlf5D4M
         jN1eBQ1zZySz8WZQpu7jh4c393+axNlRRdZsiJAzdcQlDGY3SZreUYJ1I9eSIex8h2RN
         YGt+Kb9LgVsIK14tOjMIa2jOIxvwTFoYysuO47ouzv3FU7CijQEcTi2BYpqv2noyAAt/
         5YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=TmuDkEYs99L7qyfcyaVZDiQXKLXdsTwupb3n9EnqLxo=;
        b=aF3JvLLud27sEe6txZ0vYv2WtA1A1T3E0U+Ba7VVrr0MK8U3aFB5PkMJABnzESjeJH
         OPGd6Qsh+0gDb97bbx9aoyOj4GXV6cAfRhla/HVmXE+vwxc9rp96kAaoaY4eyVc8iLTT
         iQstZQCtmK3uNyk5VzeYDzsMOMBdL5UtIBAjr5tpofw9ldNynRZGkbKLPG9nw9e0sRe4
         yGuqgDUDavGO/L5zApIm2V3HgF9gCKx6VJhzV39zFezbu9UuYjURi2VT/yIyJYY4LPB/
         57PlgR75WNsuxNsdMGveX9WBXl/5iFFXiaBy1P8T13VL/k1ekzB9X/RK/NEzuIEu+cUq
         Zn5A==
X-Gm-Message-State: AOPr4FVE5mxX6Blx1D+HyRw76j1dz+tsirkdsQ8SM/zOjOdmZ1fMXGi9HFaINkBSNGNMjA==
X-Received: by 10.55.71.195 with SMTP id u186mr14413513qka.38.1461185217508;
        Wed, 20 Apr 2016 13:46:57 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p129sm31844516qhp.44.2016.04.20.13.46.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 13:46:56 -0700 (PDT)
In-Reply-To: <20160420011740.GA29839@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292075>

On Tue, 2016-04-19 at 21:17 -0400, Jeff King wrote:
> On Tue, Apr 19, 2016 at 07:43:11PM -0400, David Turner wrote:
> 
> > On Tue, 2016-04-19 at 19:22 -0400, Jeff King wrote:
> > > You can find previous discussion on the list, but I think the
> > > options
> > > basically are:
> > > 
> > >   1. Something like v2, where the client gets a chance to speak
> > > before
> > >      the advertisement.
> > > 
> > >   2. Some out-of-band way of getting values from the client to
> > > the
> > >      server (so maybe extra command-line arguments for git-over
> > > -ssh,
> > > and
> > >      maybe shoving something after the "\0" for git-daemon, and
> > > of
> > >      course extra parameters for HTTP).
> > > 
> > >   3. The client saying "stop spewing refs at me, I want to give
> > > you a
> > >      ref filter" asynchronously, and accepting a little spew at
> > > the
> > >      beginning of each conversation. That obviously only works
> > > for
> > > the
> > >      full-duplex transports, so you'd probably fall back to (2)
> > > for
> > >      http.
> > 
> > OK, so (2) seems like what I'm doing -- it just happens that I only
> > implemented it for one protocol.
> 
> Right. And I don't mind that approach _if_ we can figure out a way to
> do
> it for all protocols. But I think there are some complications with
> the
> other ones, which means that HTTP will have the ability to grow
> features
> the other protocols do not.

As you note, it appears that git-daemon does sort-of have support for
extra args -- see parse_host_arg.  So it wouldn't be hard to add
something here. Unfortunately, current versions of git die on unknown
args.  So this change would not be backwards-compatible.  We could put
a decider on it so that clients would only try it when explicitly
enabled.  Or we could have clients try it with, and in the event of an
error, retry without.  Neither is ideal, but both are possible.

If I read this code correctly, git-over-ssh will pass through arbitrary
arguments.  So this should be trivial.
