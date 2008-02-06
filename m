From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prune: heed --expire for stale packs, add a test
Date: Tue, 05 Feb 2008 21:15:49 -0800
Message-ID: <7v7ihi64xm.fsf@gitster.siamese.dyndns.org>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
	<alpine.LFD.1.00.0802051357420.2732@xanadu.home>
	<alpine.LSU.1.00.0802052005200.8543@racer.site>
	<alpine.LFD.1.00.0802051512370.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Steven Tweed <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 06:17:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMceV-0001hl-DE
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 06:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbYBFFQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 00:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbYBFFQP
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 00:16:15 -0500
Received: from rune.pobox.com ([208.210.124.79]:52758 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbYBFFQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 00:16:14 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 00F361921B4;
	Wed,  6 Feb 2008 00:16:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BE3AA190493;
	Wed,  6 Feb 2008 00:16:27 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802051512370.2732@xanadu.home> (Nicolas Pitre's
	message of "Tue, 05 Feb 2008 15:13:27 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72754>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 5 Feb 2008, Johannes Schindelin wrote:
>
>> Follow the same logic as for loose objects when removing stale packs: they
>> might be in use (for example when fetching, or repacking in a cron job),
>> so give the user a chance to say (via --expire) what is considered too
>> young an age to die for stale packs.
>> 
>> Also add a simple test to verify that the stale packs are actually
>> expired.
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Acked-by: Nicolas Pitre <nico@cam.org>
>
> Nicolas

They are not "stale packs", but temporary files that wanted to
become pack but did not succeed.  Perhaps "stale temporary
packs"?

Shouldn't we do something similar to objects/pack/pack-*.temp
files and objects/??/*.temp that http walker leaves?
