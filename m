From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow bulk import to be packed
Date: Wed, 05 Sep 2007 18:36:01 -0700
Message-ID: <7vlkbkfuda.fsf@gitster.siamese.dyndns.org>
References: <7vps0wfv8g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 03:36:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT6I3-0001bg-JT
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 03:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335AbXIFBgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 21:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757326AbXIFBgK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 21:36:10 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756097AbXIFBgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 21:36:09 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DA60C12E53D;
	Wed,  5 Sep 2007 21:36:26 -0400 (EDT)
In-Reply-To: <7vps0wfv8g.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 05 Sep 2007 18:17:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57796>

Junio C Hamano <gitster@pobox.com> writes:

> This will use fast-import as a backend to dump blobs resulting
> from a huge initial import into a packfile.

This needs major work to be usable.

Although fast-import knows object name of each blob, being a
quick-and-dirty patch, git-add does not ask for it and still
computes the blob names by itself.  The only thing this
proof-of-concept patch buys is that the resulting object
database is packed, and does not get loose objects.
