From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sat, 04 Aug 2007 17:09:13 +0200
Message-ID: <85odhnfiau.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz> <85tzrfh3yg.fsf@lola.goethe.zz>
	<8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
	<85k5sbh129.fsf@lola.goethe.zz>
	<8c5c35580708040703w44781498t7396588a3f8c81c8@mail.gmail.com>
	<854pjfgzit.fsf@lola.goethe.zz> <85y7grfkbe.fsf@lola.goethe.zz>
	<8c5c35580708040735l54d1b9c7i40cd80d7d11e2961@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 17:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHLFn-0005Cf-IK
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 17:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899AbXHDPJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 11:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756957AbXHDPJR
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 11:09:17 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:33473 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753193AbXHDPJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 11:09:16 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 3C2F84C94C;
	Sat,  4 Aug 2007 17:09:15 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 2A4CC212FAF;
	Sat,  4 Aug 2007 17:09:15 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 058E42BB11D;
	Sat,  4 Aug 2007 17:09:14 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D00B21C4F932; Sat,  4 Aug 2007 17:09:13 +0200 (CEST)
In-Reply-To: <8c5c35580708040735l54d1b9c7i40cd80d7d11e2961@mail.gmail.com> (Lars Hjemli's message of "Sat\, 4 Aug 2007 16\:35\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54863>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 8/4/07, David Kastrup <dak@gnu.org> wrote:
>> Can we get merge conflicts
>> with a remote tracking branch, too?  Namely when the remote branch
>> messed with its history, rebased/reverted stuff?
>
> No, since the "fetch" line in .git/config is prefixed by '+', which
> gets translated to the '-f' option for 'git-fetch'.
>
> And this was probably the primary reason for refs/remotes/* in the
> first place: you have a namespace in which there is no chance for
> 'git-fetch' to overwrite local changes (ancient git had no such
> namespace).

Ok, so a remote tracking branch is a forcefully merged branch, so we
put it into a separate category where we won't get tempted to have a
branch head which will get overwritten.

This whole "remote tracking" appears to be more a matter of _policy_
rather than inherent design.  It would appear that local and remote
tracking branches have no fundamental differences, they just get
different defaults which make it less likely for the first to lose
local changes, and less likely for the second to miss remote changes
(in particular where those involve messing up the history).

But it would be easy to create chimeras when working outside of the
porcelain, right?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
