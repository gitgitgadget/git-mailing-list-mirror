From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH 2/5] fix "git add --ignore-errors" to ignore pathspec errors
Date: Thu, 13 Aug 2009 15:42:23 -0500
Message-ID: <200908131542.23971.luke@dashjr.org>
References: <200908121726.52121.luke-jr@utopios.org> <1250133624-2272-2-git-send-email-luke-jr+git@utopios.org> <7vr5vfa4ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luke Dashjr <luke-jr+git@utopios.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbhEk-0001hW-OE
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 22:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209AbZHMUtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 16:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbZHMUtG
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 16:49:06 -0400
Received: from unused ([66.216.20.21]:47942 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756200AbZHMUtE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 16:49:04 -0400
Received: from tsuruki.localnet (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	(Authenticated sender: luke-jr)
	by zinan.dashjr.org (Postfix) with ESMTPSA id 5D656B9DB47;
	Thu, 13 Aug 2009 20:42:26 +0000 (UTC)
User-Agent: KMail/1.12.0 (Linux/2.6.27-gentoo-r7; KDE/4.3.0; x86_64; ; )
In-Reply-To: <7vr5vfa4ha.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125872>

On Thursday 13 August 2009 02:38:57 pm Junio C Hamano wrote:
> Luke Dashjr <luke-jr+git@utopios.org> writes:
> > Unmatched files are errors, and should be ignored with the rest of them.
>
> Why is this a "fix"?
>
> I would understand if it were "Make --ignore-errors imply --ignore-unmatch
> unconditionally".  But then I do not think I would necessarily agree it is
> a good change.
>
> The user may know that some files in the work tree are unreadable and
> cannot be indexed (hence he gives --ignore-errors) but he still may want
> to catch a typo on the command line.
>
> I do not think it is wise to make --ignore-errors imply --ignore-unmatch
> unconditionally like this patch does without any escape hatch.

Are unmatched files not errors? Perhaps the old flag should be renamed to
--ignore-read-errors and a new --ignore-errors that implies both added. Or 
maybe just a documentation change to preserve compatibility with anything that 
might assume that...
