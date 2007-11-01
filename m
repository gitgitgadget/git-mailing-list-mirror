From: bdowning@lavos.net (Brian Downing)
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 1 Nov 2007 16:41:31 -0500
Message-ID: <20071101214131.GF4099@lavos.net>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:42:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inhne-0004bv-Px
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbXKAVle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbXKAVle
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:41:34 -0400
Received: from mxsf08.insightbb.com ([74.128.0.78]:25315 "EHLO
	mxsf08.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbXKAVld (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:41:33 -0400
X-IronPort-AV: E=Sophos;i="4.21,360,1188792000"; 
   d="scan'208";a="118010329"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf08.insightbb.com with ESMTP; 01 Nov 2007 17:41:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAMrkKUdKhvkY/2dsb2JhbACBW45a
X-IronPort-AV: E=Sophos;i="4.21,360,1188792000"; 
   d="scan'208";a="90817455"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 01 Nov 2007 17:41:31 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 401A7309F21; Thu,  1 Nov 2007 16:41:31 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vmytycykt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63014>

On Wed, Oct 31, 2007 at 10:41:06PM -0700, Junio C Hamano wrote:
> * jc/spht (Tue Oct 2 18:00:27 2007 -0700) 1 commit
>  - git-diff: complain about >=8 consecutive spaces in initial indent
> 
> This is a counterpart of an earlier patch from J. Bruce Fields
> to change "git-apply --whitespace" to make SP{8,} at the
> beginning of line a whitespace error.
> 
> Personally, I am in favor of the stricter check, but I had to
> reject the "git-apply" patch because there was no way to disable
> the additional check without disabling the existing check for
> trailing whitespaces.  We probably would want to revisit that
> one (perhaps with a new option and/or config to selectively
> enable different kinds of whitespace check).

Just to throw in my two cents, I would be strongly opposed to this
going in without some form of configuration to make it work for
spaces-only-indent projects.  I appreciate having whitespace checking,
and I think trailing whitespace and tabs-following-spaces are obviously
bad enough that they should always be flagged.  But flagging leading
spaces makes a legitimate and common coding style yield incredibly
obnoxious-looking diffs.

I don't want to get into another stupid holy war about the superiority
of indent styles (the last one was quite enough, thank you), but there
are real projects out there that have a spaces-only-indent policy and
use Git, and this change as is isn't good for them.

-bcd
