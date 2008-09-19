From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: warn against merging in a dirty tree
Date: Fri, 19 Sep 2008 13:28:15 -0700
Message-ID: <7vljxnswww.fsf@gitster.siamese.dyndns.org>
References: <200809160048.31443.trast@student.ethz.ch>
 <1221518994-26111-1-git-send-email-trast@student.ethz.ch>
 <1221518994-26111-2-git-send-email-trast@student.ethz.ch>
 <7vtzch7z7u.fsf@gitster.siamese.dyndns.org>
 <32541b130809151653w27d7876fp35e0967d597ae2a9@mail.gmail.com>
 <alpine.LFD.1.10.0809180804100.3337@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 19 22:29:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgmbf-00063F-3X
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 22:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbYISU21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 16:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbYISU21
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 16:28:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbYISU20 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 16:28:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A4F66371F;
	Fri, 19 Sep 2008 16:28:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 797A56371C; Fri, 19 Sep 2008 16:28:18 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82BB0FBE-8689-11DD-8513-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96311>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, it's actually kind of sad that we don't expose a real 
> capability that the git plumbing does have. Namely
>
> 	git read-tree -u -m HEAD ORIG_HEAD

I do not think this is quite enough.  "read-tree --reset -u" is probably
closer, but it may discard the entries added (and got conflicted) by the
merge before actually updating the working tree (the right thing there
would be to remove them).
