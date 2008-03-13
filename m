From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: proper pack time stamping with
 --max-pack-size
Date: Thu, 13 Mar 2008 13:59:11 -0700
Message-ID: <7vzlt2wdb4.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0803131440590.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 22:00:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZuWz-0001gU-2m
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 22:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbYCMU70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 16:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbYCMU7Z
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 16:59:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbYCMU7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 16:59:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C9F211043;
	Thu, 13 Mar 2008 16:59:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4793E1042; Thu, 13 Mar 2008 16:59:20 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803131440590.2947@xanadu.home> (Nicolas
 Pitre's message of "Thu, 13 Mar 2008 14:59:29 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77137>

Nicolas Pitre <nico@cam.org> writes:

> Runtime pack access is done in the pack file mtime order since recent 
> packs are more likely to contain frequently used objects than old packs.
> However the --max-pack-size option can produce multiple packs with mtime 
> in the reversed order as newer objects are always written first.
>
> Let's modify mtime of later pack files (when any) so they appear older 
> than preceding ones when a repack creates multiple packs.

It is a very good companion to f7c22cc (always start looking up objects in
the last used pack first, May 30, 2007) after 10 months ;-)
