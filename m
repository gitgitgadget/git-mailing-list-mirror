From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Use SUDO_UID to guess committer identity
Date: Sat, 07 Jun 2008 14:05:13 -0700
Message-ID: <7v63slnegm.fsf@gitster.siamese.dyndns.org>
References: <20080607071130.GZ12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 23:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K55cb-0005dJ-5L
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 23:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYFGVFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbYFGVFV
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 17:05:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbYFGVFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 17:05:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A0062E28;
	Sat,  7 Jun 2008 17:05:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D1E2D2E27; Sat,  7 Jun 2008 17:05:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6EDBDCC2-34D5-11DD-8FE4-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84227>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> When invoking Git commands though sudo against a bare repository
> with reflogs enabled we should attempt to record the actual user's
> information in the reflog, not the identity of the user sudo entered.
>
> For example when executing:
>
> 	sudo -u gitadm git --git-dir=/srv/git.git branch -f pu master
>
> We want record information about the caller of sudo, not gitadm.

If you are using something esoteric like pseudo, isn't it too much to ask
to also use existing GIT_COMMITTER_NAME, or are there reasons why it is
not sufficient?
