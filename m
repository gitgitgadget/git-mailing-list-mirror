From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Allow missing objects during packing
Date: Mon, 11 Aug 2008 15:39:47 -0700
Message-ID: <7vk5enuqfg.fsf@gitster.siamese.dyndns.org>
References: <20080811182839.GJ26363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 00:40:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSg4Q-0006JK-IN
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 00:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbYHKWjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 18:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbYHKWjz
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 18:39:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbYHKWjy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 18:39:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C20615CA67;
	Mon, 11 Aug 2008 18:39:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 35F655CA65; Mon, 11 Aug 2008 18:39:49 -0400 (EDT)
In-Reply-To: <20080811182839.GJ26363@spearce.org> (Shawn O. Pearce's message
 of "Mon, 11 Aug 2008 11:28:39 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69EE2770-67F6-11DD-B3F8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92014>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> ... It seems pretty harmless to allow an object we
> aren't going to transmit but that we want to use as a delta base
> in a thin pack to be missing.  At worst we just get a little bit
> more data transfer.

If the check is only about a thin delta base that is not going to be
transmit, I'd agree.  But I do not see how you are distinguishing that
case and the case where an object you are actually sending is missing (in
which case we would want to error out, wouldn't we?)
