From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git.pm: localise $? in command_close_bidi_pipe()
Date: Mon, 04 Aug 2008 23:12:01 -0700
Message-ID: <7v7iawxa6m.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com>
 <20080804075313.21325.28396.stgit@localhost>
 <7vtze12oij.fsf@gitster.siamese.dyndns.org>
 <20080804082117.GI10151@machine.or.cz>
 <7vhca12n2l.fsf@gitster.siamese.dyndns.org>
 <20080804113827.GA1239@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 08:13:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQFnD-0004LY-KB
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 08:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYHEGMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 02:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbYHEGMJ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 02:12:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYHEGMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 02:12:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D5E94BC0E;
	Tue,  5 Aug 2008 02:12:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9862B4BC0D; Tue,  5 Aug 2008 02:12:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E8DD03C-62B5-11DD-A5BB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91429>

Abhijit Menon-Sen <ams@toroid.org> writes:

> With my patch, however, Git::DESTROY calls the two _close functions
> during global destruction, which in turn call command_close_bidi_pipe,
> which calls waitpid with sensible arguments this time, which alters $?,
> thus altering the exit status of the dcommit itself to 0. Oops.

Thanks.
