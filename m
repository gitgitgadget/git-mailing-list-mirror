From: Junio C Hamano <gitster@pobox.com>
Subject: [Bug?] rebase-i marking the last entry for edit gives a barf?
Date: Sun, 28 Mar 2010 10:39:07 -0700
Message-ID: <7vd3yo2vno.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Mar 28 19:39:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvwSF-00057G-MG
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 19:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab0C1RjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 13:39:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0C1RjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 13:39:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FCFCA6EEF;
	Sun, 28 Mar 2010 13:39:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Xi+W
	t+IisS2sfktw9faDeSFBDKc=; b=lnMEiMrFwwaPX9tMkjqyGccr3nKIaMMwqVlS
	ZDPayvbxbOEB7rrFutH60ZBRT8Gz3qUxR1KbDP6ODZ5LPJ0ircPlaGzvNNmyabu1
	xdAwqTFK/3BaeQSZ3PBXl/1A1amD/VgGLwQ384kWwWgDr5fPbxDWvL7OLnSfiHnf
	F8NQO6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	cwL0DS6QMu5O/ga1DvMhlp6eEZ5PhNOVIxXq13G77FOJ/c0INgKBMjxmURsjF5dp
	uoeQx3bZPI31/rcDXmM6TRkSqHK11YNvMZI3It1QUh4tRd7ovHiDBsIoV44xpXqT
	ldhTdvdX16pWu+qlnNg/E9TWZtAf/RqXA0fYy5s5JMg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E653A6EEE;
	Sun, 28 Mar 2010 13:39:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2422A6EED; Sun, 28 Mar
 2010 13:39:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1BCC32A-3A90-11DF-8554-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143407>

I am getting this:

/home/junio/g/Debian-5.0.4-x86_64/git-next/libexec/git-core/git-rebase--interactive: line 565: /git/.git/rebase-merge/rewritten-list: No such file or directory
Successfully rebased and updated refs/heads/nd/setup.

This was after marking both commits in a two-patch series for "edit" in
rebase -i, running "commit --amend; rebase --continue; commit --amend";
saying "rebase --continue" at this point gave this error.
