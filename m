From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/5] Fix parsing of @{-1}@{1}
Date: Sat, 17 Jan 2009 12:02:33 -0800
Message-ID: <7vsknh66qu.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-2-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-4-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-5-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-6-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901171907530.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 17 21:04:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOHOq-0004JA-Pu
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 21:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbZAQUCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 15:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbZAQUCp
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 15:02:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbZAQUCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 15:02:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A6B21BB59;
	Sat, 17 Jan 2009 15:02:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 27DDB1B6A9; Sat,
 17 Jan 2009 15:02:34 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901171907530.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 17 Jan 2009 19:08:12 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD3C8512-E4D1-11DD-8806-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106100>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> To do that, Git no longer looks forward for the '@{' corresponding to the
> closing '}' but backward, and dwim_ref() as well as dwim_log() learnt
> about the @{-<N>} notation.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	The modifications of dwim_ref() and dwim_log() are probably
> 	more important than the issue I tried to fix...

Good, so we can say things like:

	git log -g @{-1}
        git show-branch -g @{-1}

with this?

By the way, I noticed that without these patch series we show something
when "git rev-parse --verify @{-1}" is asked for.  What is it trying to
show?
