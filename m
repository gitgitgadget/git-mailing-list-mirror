From: Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: Re: [PATCH] rebase: ignore failures from "gc --auto"
Date: Wed, 13 Jan 2016 16:40:11 -0300
Message-ID: <20160113194011.GD20764@sdfg.com.ar>
References: <20160113184718.GA5647@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:12:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJRlx-0005vr-PK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 21:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbcAMUL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 15:11:57 -0500
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:50058 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbcAMUL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 15:11:56 -0500
X-Greylist: delayed 1898 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2016 15:11:56 EST
Received: from 87-198-58-88.ptr.magnet.ie ([87.198.58.88] helo=sdfg.com.ar)
	by alerce.vps.bitfolk.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <rodrigo@sdfg.com.ar>)
	id 1aJRHN-0006Xl-L2; Wed, 13 Jan 2016 16:40:25 -0300
Content-Disposition: inline
In-Reply-To: <20160113184718.GA5647@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283980>

On Wed, Jan 13, 2016 at 01:47:18PM -0500, Jeff King wrote:
> After rebasing, we call "gc --auto" to clean up if we
> created a lot of loose objects. However, we do so inside an
> &&-chain. If "gc --auto" fails (e.g., because a previous
> background gc blocked us by leaving "gc.log" in place),
> then:
> 
>   1. We will fail to clean up the state directory, leaving
>      the user stuck in the rebase forever (even "git am
>      --abort" doesn't work, because it calls "gc --auto"!).

Just curious, but do you mean "git rebase --abort" ?




Thanks,
Rodrigo
