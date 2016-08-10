Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127561FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935152AbcHJTi0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:38:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34195 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934947AbcHJTiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:38:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so11544177wma.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:38:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vMVzNxNdheW9QRZTXjLoDl6TCgJ94TI/caf48lfKh9Y=;
        b=mS+I1yPys5pJG/BTTSiv2ffkDqW56ZlFyDsMBD9Ki+Ne6T/5GNUXKrR6zo2O2Lf9Q9
         UCyIgVbjqFnHNH8DNkYPqv3NM/uAcrQbtAFpXvfaCZl9NMg+sV8hA2ERDxr9Nb/tOFfL
         BsQ1FoxRVJDT5REaCXcbT/n0nSwOJQ+e5Sx9oSrbRhJK/UaDBvXnlXkKpkdOkZQvAUsj
         JyNmVxebSot62qQbAnhcXVXkOIcu/1nXECB/iiss6fLIu2x1RDetlOWx0zsD/MHi/R0B
         DsuAoBSZ5H48Hb0O1h78HgMkPsoiArmml09BUGKCOBF9oBAUI81OMYyDrgSJvMuUNNaP
         2+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vMVzNxNdheW9QRZTXjLoDl6TCgJ94TI/caf48lfKh9Y=;
        b=QCHrCJ/zW+IjSbr/Hjr8ErHIEz6u+CZyH2KPJKGaiZrmjfuZJD2zPbvjWQNHKSiKiz
         e5jDX4X0l3YWAskrIIT9U0WgMFp4JUvoOdbpliVymcT4/HO8+BUHhdu1olZdrKPsXu9v
         tcHdX+WgTJDf68pCZCS6s8+qJlWMHyLmh/rn8xMcvh+2n6RkzfHx0mMvRe9wPcQvlZyg
         KqXpByeaGkieBLRWUc/WvrTDfD8yj+bOahoupmViLPzS+y89+Ojnm253hkvs57DDH1/F
         pykTHsgCtB93dwXEnOTADP6QQCjT/s8eSbO4kWH1bBekK4s/PznytSprQK1NigbzkeWu
         ZuUw==
X-Gm-Message-State: AEkoouuZ1VWj7BH0s8V6imXKRixl1HPWj1f93KuQ4AbnhPdFtxdz+/mH97k9mewh/1rIcw==
X-Received: by 10.28.126.75 with SMTP id z72mr3181314wmc.74.1470835767534;
        Wed, 10 Aug 2016 06:29:27 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8421128wma.18.2016.08.10.06.29.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:29:27 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 03/15] pkt-line: add `gentle` parameter to format_packet()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160810131541.ovpvgwdxjibae5gy@sigill.intra.peff.net>
Date:	Wed, 10 Aug 2016 15:29:26 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Content-Transfer-Encoding: 7bit
Message-Id: <F4D9C42A-5B7F-47B4-B334-704D5F6210F5@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-4-larsxschneider@gmail.com> <20160810131541.ovpvgwdxjibae5gy@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 15:15, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Aug 10, 2016 at 03:03:59PM +0200, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> format_packet() dies if the caller wants to format a packet larger than
>> LARGE_PACKET_MAX. Certain callers might prefer an error response instead.
> 
> I am not sure I agree here. Certainly I see the usefulness of gently
> handling a failure to write(). But if you are passing in too-large
> buffers, isn't that a bug in the program?
> 
> How would you recover, except by splitting up the content? That might
> not be possible depending on how you are using the pkt-lines. And even
> if it is, wouldn't it be simpler to split it up before sending it to
> format_packet()?

Good argument. I agree - this patch should be dropped.

Thanks,
Lars
