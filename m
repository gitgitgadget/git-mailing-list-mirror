From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] status -s: obey color.status
Date: Mon, 07 Dec 2009 09:33:27 +0100
Message-ID: <4B1CBDD7.2070906@drmicha.warpmail.net>
References: <cover.1260025135.git.git@drmicha.warpmail.net> <2b987524f57a0ac04e219f82e20e806741ce4eca.1260025135.git.git@drmicha.warpmail.net> <20091207051715.GA17521@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 09:34:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHZ3R-0005P9-FL
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 09:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933557AbZLGIei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 03:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759054AbZLGIeh
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 03:34:37 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36736 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759039AbZLGIeg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 03:34:36 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E90C4C562C;
	Mon,  7 Dec 2009 03:34:42 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 07 Dec 2009 03:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lKC4XgwADJPDcRPkxmpo5ejnYlw=; b=kVgcXxOM4o2XvRn06qgWw5upV9T5b2QNxCDlCoVYjL8uJo02jJTL8LtMUas6fqi9CJRBfvTMXkpGxvRbkXAAcYwLJgofSmM6HV9lMIH4UJl7VtKcPuCVC4oN+yEGIljhd0156/3irE0CYFU6EWzusCpK1g9hFfxIXz+5B0VIfEY=
X-Sasl-enc: mRzcFIwvzdC6o/vwg0og93ficSTjytgU5TPv8UEpfXf7 1260174882
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4C4EE35301;
	Mon,  7 Dec 2009 03:34:42 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091204 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <20091207051715.GA17521@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134724>

Jeff King venit, vidit, dixit 07.12.2009 06:17:
> On Sat, Dec 05, 2009 at 04:04:38PM +0100, Michael J Gruber wrote:
> 
>> Make the short version of status obey the color.status boolean. We color
>> the status letters only, because they carry the state information and are
>> potentially colored differently, such as for a file with staged changes
>> as well as changes in the worktree against the index.
> 
> This seems to also turn on color for --porcelain in some cases, because
> git_status_config unconditionally sets s->use_color if you are using
> color.status instead of color.ui. I think we are probably best just
> explicitly disabling options for the "porcelain" format rather than
> trying to come up with some trickery to make sure they never get set.
> Like:

Thanks. I let myself get fooled by the apparent option handling within
the switch statement (which is OK for relativePaths) (and some
subconscious link between null_termination and porcelain, which goes one
way only).

I guess this shows (again) that one needs tests for everything... If I
get around to I'll amend t$(relevantoneicantrecallrightnow) with tests
for long and short status with color and porcelain with the various options.

Michael
