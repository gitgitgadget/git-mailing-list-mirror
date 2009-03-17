From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disable post-checkout test on Cygwin
Date: Tue, 17 Mar 2009 09:52:09 -0700
Message-ID: <7vprggqeh2.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, layer <layer@known.net>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:53:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjcY0-0001mK-8R
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbZCQQwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbZCQQwT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:52:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbZCQQwS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:52:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 22B687C1A;
	Tue, 17 Mar 2009 12:52:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4E5697C19; Tue,
 17 Mar 2009 12:52:11 -0400 (EDT)
In-Reply-To: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com>
 (Alex Riesen's message of "Tue, 17 Mar 2009 17:26:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F873A0E2-1313-11DE-ACD2-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113504>

Alex Riesen <raa.lkml@gmail.com> writes:

> It is broken because of the tricks we have to play with
> lstat to get the bearable perfomance out of the call.
> Sadly, it disables access to Cygwin's executable attribute,
> which Windows filesystems do not have at all.

Hmm, perhaps when checking hooks to see if they are executable, Cygwin
port should avoid using the "tricks"?  Compared to paths inside the
worktree the number of hooks is a lot smaller, no?
