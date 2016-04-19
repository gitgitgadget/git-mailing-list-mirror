From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Tue, 19 Apr 2016 17:40:01 -0400
Organization: Twitter
Message-ID: <1461102001.5540.125.camel@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	 <1460747949-3514-5-git-send-email-dturner@twopensource.com>
	 <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
	 <20160419071403.GA22577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:40:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asdNT-00020U-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 23:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbcDSVkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 17:40:06 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34170 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbcDSVkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 17:40:05 -0400
Received: by mail-qg0-f53.google.com with SMTP id c6so17928491qga.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=6P5Zy513JSqY/LMXvUj3eW4CW1evAMtVXpAEDWSLWu4=;
        b=HFQuIZKp5X7T4dNz07vSJfYr7coAH8AoOAdrtriY/7TRiRsMTzI5vfEdKYtD6nGrED
         3igj7hWy1ALkaVDxWnSbJCX3/6a4uydr2O/ZrJNB4lnw4XGj+cv+6EfKdKAK2X/C8ptS
         FP/ZXbSqRvtof+uDhFrj8P7wRO4XcOC3VFYtDe1L4e0G6nJ0d495/S4wC7lOq0xG4kZs
         CpWkZW9AMTMuFHP3andBLV/8DNGz4ZdzZoEBb3LqaP80asid9mxpzEO+F0bVLiVT//yv
         C37QDNikmOLQqlnDax/HHFr5+sLPlEcz3JwUrPLGZCdUMxib8tNLE4GbqRrxXzSRYWF+
         vpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=6P5Zy513JSqY/LMXvUj3eW4CW1evAMtVXpAEDWSLWu4=;
        b=Trvt4BVS7kG+R+r1OK0zbLnZ94J89Yx/EikBkbN1LFchb0QznMrV9z9eH2KsPuyGbp
         WJftVQ/J0drHeUT4Il+/x6fgR54S72y8EQITXxvImj/Novarkqb92SJbHbnYGNKHJZTa
         f/g+gtzHhyGcPH94VgV+k/Mv3bmAdQj6u4uhyXjcoIpkhlWWOCr9sqNrKsXjoIykG9iU
         CCPABxtNP28VDMqCr5iwirj8F0Zq6pNKfn2o92NGkqAt3TQrOiJNUiSI4YkqWlIuB988
         wEZfAS4HpzZEAiRG0FTWflTDFVZEbqTlsy0W3rFMnYQUXU/ZgnL96lfgM4vVAuXETbeC
         zbHA==
X-Gm-Message-State: AOPr4FWmaq8JOqi1wB5G/grn57Ao7sEl5lsyxqiCO1Zq8qa+D5r8aUI0RIM2Bb9F+4XYkA==
X-Received: by 10.140.43.197 with SMTP id e63mr6740624qga.31.1461102003239;
        Tue, 19 Apr 2016 14:40:03 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l21sm29690491qgd.10.2016.04.19.14.40.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 14:40:02 -0700 (PDT)
In-Reply-To: <20160419071403.GA22577@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291933>

On Tue, 2016-04-19 at 03:14 -0400, Jeff King wrote:
> On Mon, Apr 18, 2016 at 11:45:54AM -0700, Junio C Hamano wrote:
> 
> > David Turner <dturner@twopensource.com> writes:
> > 
> > > Add parameters for a list of refspecs to
> > > transport_get_remote_refs and
> > > get_refs_list.  These parameters are presently unused -- soon, we
> > > will
> > > use them to implement fetches which only learn about a subset of
> > > refs.
> > > 
> > > Signed-off-by: David Turner <dturner@twopensource.com>
> > > ---
> > 
> > What the code tries to do I am more than halfway happy.  It is
> > unfortunate that we cannot do this natively without upgrading the
> > protocol in a fundamental way, but this is a nice way to work it
> > around only for Git-over-HTTP transport without having to break the
> > protocol.
> 
> I dunno, I am a bit negative on bringing new features to Git-over
> -HTTP
> (which is already less efficient than the other protocols!) without
> any
> plan for supporting them in the other protocols.

Interesting -- can you expand on git-over-http being less efficient?
This is the first I'd heard of it.  Is it documented somewhere?

> I thought Stefan's v2 protocol work looked quite good, but it seems
> to
> have stalled. The hardest part of that topic is figuring out the
> upgrade
> path. But for git-over-http, we can solve that in the same way that
> David is passing in the extra refspecs.
> 
> So I'd rather see something like:
> 
>   1. Support for v2 "capabilities only" initial negotiation, followed
>      by ref advertisement.
> 
>   2. Support for refspec-limiting capability.
> 
>   3. HTTP-only option from client to trigger v2 on the server.
> 
> That's still HTTP-specific, but it has a clear path for converging
> with
> the ssh and git protocols eventually, rather than having to support
> magic out-of-band capabilities forever.
> 
> It does require an extra round of HTTP request/response, though.

This seems way more complicated to me, and not necessarily super
-efficient.  That is, it seems like rather a lot of work to add a whole
round of negotiation and a new protocol, when all we really need is one
little tweak.

I do think a fetch v2 protocol is potentially interesting for other
reasons, but I don't know that I have the time to fully implement it.  

I wonder if it would be possible to just add these tweaks to v1, and
save the v2 work for when someone has the time to implement it?
