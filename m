From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-bisect: use dash-less form on git bisect log
Date: Sun, 13 Jul 2008 14:26:57 -0700
Message-ID: <7vk5fpqxum.fsf@gitster.siamese.dyndns.org>
References: <1215792089-27201-1-git-send-email-vmiklos@frugalware.org>
 <200807130819.24206.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 23:28:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI971-0001Yt-5K
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 23:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373AbYGMV1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 17:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756173AbYGMV1G
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 17:27:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971AbYGMV1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 17:27:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 83D152AA5D;
	Sun, 13 Jul 2008 17:27:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 45DA12AA5C; Sun, 13 Jul 2008 17:26:59 -0400 (EDT)
In-Reply-To: <200807130819.24206.chriscool@tuxfamily.org> (Christian Couder's
 message of "Sun, 13 Jul 2008 08:19:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 70452EF6-5122-11DD-95A1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88339>

Christian Couder <chriscool@tuxfamily.org> writes:

> Your patch looks good. But there is also the problem that new bisect logs 
> will not be understood by old git. So I wonder if a patch to only read the 
> new log should be first commited to the "maint" branch.

I do not think it is worth it.  If we are making something long lived like
rerere cache backward incompatible, the approach would be sensible, but
bisect log is about a single session and once you reached the breakage you
would not reuse it.  Besides, the bisect log is designed to be executable
shell script so you can always copy it out, edit it if needed and feed
that to shell.
