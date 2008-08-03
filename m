From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Sun, 03 Aug 2008 15:16:43 -0700
Message-ID: <7vwsix7nhw.fsf@gitster.siamese.dyndns.org>
References: <20080803025602.GB27465@spearce.org>
 <1217748317-70096-1-git-send-email-spearce@spearce.org>
 <1217748317-70096-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 00:18:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPlts-0007yL-9l
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 00:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757709AbYHCWQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 18:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757662AbYHCWQu
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 18:16:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757430AbYHCWQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 18:16:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF8BF49A5A;
	Sun,  3 Aug 2008 18:16:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5693649A58; Sun,  3 Aug 2008 18:16:45 -0400 (EDT)
In-Reply-To: <1217748317-70096-2-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Sun, 3 Aug 2008 00:25:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DDCF2124-61A9-11DD-9B77-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91281>

I very much like it.

But could you be a bit more explicit than application/x-git-refs magic?  I
suspect very strongly that clueless server operators would advertise the
type on repositories statically hosted there, and would defeat the point
of your patch.

We are not changing update-server-info so if we can find a place we can
use to hide the "magic", it would be a much more robust.

Perhaps "#" comment line in info/refs that is ignored on the reading side
but update-server-info never generates on its own?

Or perhaps sort the output differently from how update-server-info
produces its output, so that older client would not care but the magic
aware client can notice?
