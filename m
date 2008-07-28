From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Sun, 27 Jul 2008 23:18:51 -0700
Message-ID: <7vej5ev8dw.fsf@gitster.siamese.dyndns.org>
References: <20080727053324.b54fe48e.chriscool@tuxfamily.org>
 <7vabg43pcp.fsf@gitster.siamese.dyndns.org>
 <200807280810.20922.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 08:20:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNM5S-0007ZA-Hu
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbYG1GTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 02:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbYG1GTB
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:19:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbYG1GTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 02:19:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C093469B5;
	Mon, 28 Jul 2008 02:18:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 68DE9469B4; Mon, 28 Jul 2008 02:18:53 -0400 (EDT)
In-Reply-To: <200807280810.20922.chriscool@tuxfamily.org> (Christian Couder's
 message of "Mon, 28 Jul 2008 08:10:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10064ABA-5C6D-11DD-9A7A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90416>

Christian Couder <chriscool@tuxfamily.org> writes:

> Yeah, but what is quite confusing I think is that a merge base seems to be 
> defined as "an as good as possible _common_ ancestor" but in this case, the 
> result of "git merge-base A B C" is not an ancestor of C (even with --all 
> option). So perhaps we need a better definition.

See my other message.  "git merge-base A B C" is not the best common
ancestors across A B and C.  It is the best common ancestors between A and
a commit that is a merge between B and C.

By defining/explaining it that way, you can avoid the "Huh, are you
talking about OR or AND" question you would inevitably get when you say
"Common ancestor of A and B or A and C".  Also in "git merge-base A B C",
A is fundamentally different from any other commit; a commit being (or not
being) common between A and B (or A and C) is what we care about a lot,
but a commit being (or not being) common between B and C does not matter
in this computation.
