From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack.indexversion config option now defaults to 2
Date: Tue, 24 Jun 2008 23:06:36 -0700
Message-ID: <7viqvy59qr.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806250025130.2979@xanadu.home>
 <alpine.LFD.1.10.0806242130450.22069@hp.linux-foundation.org>
 <7vd4m66rfp.fsf@gitster.siamese.dyndns.org>
 <20080625055605.GD28563@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 08:07:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBOAR-0004HX-Kv
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 08:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbYFYGGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 02:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYFYGGq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 02:06:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbYFYGGq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 02:06:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C50FF176FC;
	Wed, 25 Jun 2008 02:06:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 12AAB176FB; Wed, 25 Jun 2008 02:06:38 -0400 (EDT)
In-Reply-To: <20080625055605.GD28563@glandium.org> (Mike Hommey's message of
 "Wed, 25 Jun 2008 07:56:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2B60730-427C-11DD-B22F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86239>

Mike Hommey <mh@glandium.org> writes:

> Wouldn't it be a good idea to add a warning in git update-server-info
> when it detects pack.indexVersion is not 1, too ?

Can you describe how that warning will help whom in the bigger picture?

The way as I understand everybody runs "git update-server-info" is:

 * "git push" pushes into a publishing repository, then
 * "post-receive" (or "post-update") hook triggers "update-server-info".

If you spit out a warning from update-server-info, it will be shown to the
pusher over sideband, but this will not necessarily help the pusher, who
may or may not have shell access to the repository.
