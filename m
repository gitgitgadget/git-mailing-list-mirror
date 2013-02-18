From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 08/10] remote-curl: pass buffer straight to
 get_remote_heads
Date: Mon, 18 Feb 2013 02:47:18 -0800
Message-ID: <20130218104718.GG7049@elie.Belkin>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092905.GH5096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:47:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7OGC-0000yZ-7J
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab3BRKrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:47:24 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:53590 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab3BRKrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:47:24 -0500
Received: by mail-da0-f48.google.com with SMTP id v40so2396147dad.35
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 02:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iqXOoSDTu+eoI2sd2t0ByHUAX9zwut0deCcsIJ24cbc=;
        b=gS7p6kZ6NO6cxqF4K+vXZJ/kPAvsp9cTr9VXJWbsotsR8MPpBYDKVoV/SJZDI6ZeRK
         TM2thh1y5Wo3QSdpGBocaUgEnDDKOBcsh3z6smWJJjVBEwmXQUBqOjwWhuDd69k2s+5u
         FVOCMfpHskqNuZdjwf4oajw2MWeVB55/rR8SaprXYMZQrRhjv827JbXghUBav0OYo8wD
         e7BVqKuX93kUwJfQ8a3bWF8pSKnabuLFB+heDlvEqZIq5Zd/Qq+iv0VG2J5miSH5pk19
         sKR201vQ8MqmhDTdkxtR1eA0tbuUPiVJRTd3Wedcbjqn0YRyz3cLPv5M1SohTEJ1MTCT
         z+Xg==
X-Received: by 10.66.4.165 with SMTP id l5mr34611667pal.53.1361184443562;
        Mon, 18 Feb 2013 02:47:23 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id bi2sm103410585pab.18.2013.02.18.02.47.21
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 02:47:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218092905.GH5096@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216473>

Jeff King wrote:

> I don't know that this code was hurting anything, but it has always
> struck me as ugly and a possible source of error. And now it's gone.

Heh.  Belongs in the commit message, presumably.

I don't think the async procedure was very harmful, but it's nice to
avoid the cost of a new thread and some copying.

>  remote-curl.c | 26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)

Nice.  The patch looks sane.
