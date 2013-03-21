From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] drop some obsolete "x = x" compiler warning hacks
Date: Thu, 21 Mar 2013 13:47:09 -0700
Message-ID: <20130321204709.GL29311@google.com>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321111028.GC18819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 21:47:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UImOt-00018Y-R8
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 21:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab3CUUrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 16:47:17 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:38863 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab3CUUrO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 16:47:14 -0400
Received: by mail-pd0-f177.google.com with SMTP id y14so1236533pdi.8
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 13:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VgNce2WohdJCVIddHtJAk2QvDHUcQCoWvZl1/3HZb9s=;
        b=x8xZwo3f/fqD6NzSwEyGqdy9TjARr9cKoWqoHm7ttSKb/3isjBDDx1I8CsbBO1bx9l
         ZOpUgphU1eOnWjcH1uoajZ4sz8wCnRMsvvoW/BiZ0wwqtmgDnR5zP10o43pDB/SnVjVi
         9ChED4p5eKx/IEHEBZTjU9NMl11DHJH/LX9DXlwHKwMXtmn6c7dUcqlJSUQKyI114SwD
         IaV0tNZUa2PacTI2PEitwgJ5m87QpRMmNkEgsNSD4nGT9GLDBxuCDqueIOVSl7P6VCpL
         rNut9offHoJAA+tP6tg8XRTnyFBUU5vEh8p4CjFzggG536GkMiON7g6RItGQWPJwpQNi
         DsCQ==
X-Received: by 10.67.14.105 with SMTP id ff9mr17136010pad.101.1363898833650;
        Thu, 21 Mar 2013 13:47:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id in5sm7264996pbc.20.2013.03.21.13.47.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 13:47:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130321111028.GC18819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218759>

Jeff King wrote:

> And 4.3 was old enough for me to say "I do not care if you can run with
> -Wall -Werror or not", let alone 4.2.

Changes like this can only reveal bugs (in git or optimizers) that
were hidden before, without regressing actual runtime behavior, so for
what it's worth I like them.

I think perhaps we should encourage people to use
-Wno-error=uninitialized, in addition to cleaning up our code where
reasonably recent optimizers reveal it to be confusing.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
