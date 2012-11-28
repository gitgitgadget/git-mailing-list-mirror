From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 0/4] git-submodule add: Add --local-branch option
 (summary)
Date: Wed, 28 Nov 2012 11:53:34 -0500
Message-ID: <20121128165334.GA20483@odin.tremily.us>
References: <20121128063107.GA7189@book.hvoigt.net>
 <20121128024205.GG15213@odin.tremily.us>
 <20121109162919.GA922@book.hvoigt.net> <20121128130903.GB15786@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:54:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdktx-0002YD-5T
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 17:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab2K1QyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 11:54:04 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:37289 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab2K1Qx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 11:53:58 -0500
Received: from odin.tremily.us ([unknown] [72.68.95.13])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME700IZEIXBON60@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Nov 2012 10:53:35 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id D405C6E1825; Wed,
 28 Nov 2012 11:53:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354121614; bh=uZsSgubt9mTdjyc9/rWC8nUWRRgtoMlaVxGZ0cM6OdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IneyS8HQdjOH7vHZa8NvBfdNdi0D8Yqf3zyPA6VA0SuucMahUf2nHQFCKgYXkP06V
 44ZjqHxVWHx527IDa25KvLfQ4X3kFt8/FluW4TWdF0u3XRaefhrD+RsUzWTysIKiBJ
 gSspZixhXMJM1ZUKY4YTr0VQB1S/JOmAVmse+Wqc=
Content-disposition: inline
In-reply-to: <20121128130903.GB15786@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210740>

On Wed, Nov 28, 2012 at 08:09:03AM -0500, W. Trevor King wrote:
> * A new 'submodule pull' for tracking the submodule's remote, which is
>   pulling --ff-only origin/$branch into a whatever state the submodule
>   is currently in.  If any changes were made to submodule $shas,
>   optionally commit them with a shortlog-generated commit message.

I thought of a better idea on the train.  How about adding `--remote`
to `submodule update` that overrides the gitlinked SHA-1 with the
SHA-1 for origin/$branch?  All of the other checkout/merge/rebase
functionality is untouched.  The only thing that changes is where we
look for the update.  I'm working up the patch now, and will submit v5
shortly.

-- 
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
