From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] t0000: verify that real_path() works correctly with
 absolute paths
Date: Sat, 08 Sep 2012 22:27:42 -0700
Message-ID: <7vvcfnsr3l.fsf@alter.siamese.dyndns.org>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <1346746470-23127-6-git-send-email-mhagger@alum.mit.edu>
 <7v627q21hl.fsf@alter.siamese.dyndns.org> <504C1B8A.3000406@alum.mit.edu>
 <7vfw6ru7de.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 09 07:28:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAa4T-0003GY-RY
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 07:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab2IIF1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 01:27:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53973 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521Ab2IIF1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 01:27:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA8BC445D;
	Sun,  9 Sep 2012 01:27:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KE/mp7dgxUjDmijh7nzMjAm8ztk=; b=YnP3bz
	Ky9TFf06TJ1FsT/FSSmFndmOOgO9tNogKfJqf3XsGtqhQCgu0d7IhDLnQcZNZWXL
	S7McPinoNDWLtHL3KbJIxl6V/dd5xeplOa9+jig1SNMk/Na89+hdXqWNf6yNIkHk
	dfgoQrXFLO87rZTlKC1DL96Y1pkvWvuO1k08I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z+AJRF8R9+2ryZi4TeXfHgLgWfNpuWwv
	UiKekBwAFh9TABx0me/q4+SNUVH6D7ejoVIH5jwSQFShKucTxqqLIoNqL4fkIYgu
	ZRc1r4czFv4qikN4mcNEOwxhOVqcolXgSeWWPooeHKxDUxqPl74nRLxHG7lk6LTw
	Nov4rMbdFRU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B81C3445C;
	Sun,  9 Sep 2012 01:27:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36345445B; Sun,  9 Sep 2012
 01:27:44 -0400 (EDT)
In-Reply-To: <7vfw6ru7de.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 08 Sep 2012 21:50:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1522A614-FA3F-11E1-A921-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205045>

Junio C Hamano <gitster@pobox.com> writes:

> (4) if it only runs once at the very beginning of the test and sets
> a variable that is named prominently clear what it means and lives
> throughout the test, then we do not even have to say "hopefully" and
> appear lazy and loose to the readers of the test who wonders what
> happens when the path does exist; doing so will help reducing the
> noise on the mailing list in the future.

Having said that, I really do not deeply care either way.  If you
are rerollilng the series for other changes, I wouldn't shed tears
even if I do not see any change to this part.
