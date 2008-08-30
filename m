From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git gui: use apply --unidiff-zero when staging hunks
 without context
Date: Sat, 30 Aug 2008 10:53:15 -0700
Message-ID: <7vhc92ie44.fsf@gitster.siamese.dyndns.org>
References: <20080830164527.GA25370@localhost>
 <20080830165600.GB25370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Aug 30 19:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZUet-0006NE-9s
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 19:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbYH3RxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 13:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYH3RxX
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 13:53:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbYH3RxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 13:53:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 282E75AE0C;
	Sat, 30 Aug 2008 13:53:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 961445AE0B; Sat, 30 Aug 2008 13:53:18 -0400 (EDT)
In-Reply-To: <20080830165600.GB25370@localhost> (Clemens Buchacher's message
 of "Sat, 30 Aug 2008 18:56:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 895D92E2-76BC-11DD-BADD-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94395>

Clemens Buchacher <drizzd@aon.at> writes:

> echo a > victim
> git add victim
> echo b >> victim
> git diff -U0 | git apply --cached --unidiff-zero
> git diff

I think "diff -U0" there would say "@@ -1,0 +2 @@", iow "add this one line
after the first line", and "apply" has an off-by-one in this case.
