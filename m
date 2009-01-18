From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] checkout: don't crash on file checkout before
 running post-checkout hook
Date: Sat, 17 Jan 2009 17:56:51 -0800
Message-ID: <7vd4el2x7g.fsf@gitster.siamese.dyndns.org>
References: <20090116172521.GD28177@leksak.fem-net>
 <1232133002-21725-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 02:59:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOMvq-00063K-T0
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 02:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343AbZARB5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 20:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757265AbZARB5J
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 20:57:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757274AbZARB5I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 20:57:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 74F281CBED;
	Sat, 17 Jan 2009 20:57:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 242091CBDA; Sat,
 17 Jan 2009 20:56:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4F0974C0-E503-11DD-B4DE-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106131>

All looked good to me except one thing; you need to initialize argv to
NULL as ALLOC_GROW() calls xrealloc on it in the last one.

Will queue with an amend.
