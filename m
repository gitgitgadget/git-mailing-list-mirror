From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: [PATCH v4] Expand ~ and ~user in core.excludesfile, commit.template
Date: Fri, 29 Aug 2008 15:34:41 -0700
Message-ID: <quack.20080829T1534.lthd4jr30xq@roar.cs.berkeley.edu>
References: <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
	<20080824220854.GA27299@coredump.intra.peff.net>
	<7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
	<20080824231343.GC27619@coredump.intra.peff.net>
	<7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
	<quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
	<20080827002506.GB7347@coredump.intra.peff.net>
	<quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu>
	<7vy72jrr00.fsf@gitster.siamese.dyndns.org>
	<quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
	<20080829032630.GA7024@coredump.intra.peff.net>
	<7vod3ca2ey.fsf@gitster.siamese.dyndns.org>
	<quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu>
	<7vsksn4xdo.fsf@gitster.siamese.dyndns.org>
	<quack.20080829T1201.lthsksnir1u@roar.cs.berkeley.edu>
	<7vk5dz4o3t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 00:36:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZCZU-0002Mn-2R
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 00:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbYH2Wem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 18:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756847AbYH2Wem
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 18:34:42 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:52524 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756636AbYH2Wel (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 18:34:41 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 0E3983458E; Fri, 29 Aug 2008 15:34:41 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <7vk5dz4o3t.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 29 Aug 2008 12\:28\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94336>

>>>>> On 2008-08-29 12:28 PDT, Junio C Hamano writes:

    Junio>  [3/3] Update the sole caller of user_path() to use
    Junio>  expand_user_path().

Actually I just looked closer at enter_repo() and it's not quite
as simple as your proposed patch, because enter_repo() wants to
concatenate suffixes like ".git".  So either the malloced string
would have to be copied to the static buffer again, or return a
strbuf, or take an argument for allocating extra chars.

Wow, I'd forgotten how much work it is to do string manipulation
in C.
