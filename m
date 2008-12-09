From: Junio C Hamano <gitster@pobox.com>
Subject: Re: get upstream branch
Date: Mon, 08 Dec 2008 22:43:02 -0800
Message-ID: <7v8wqp6e89.fsf@gitster.siamese.dyndns.org>
References: <3ab397d0812082052j6a45d05dr1c863aa260826f4@mail.gmail.com>
 <7vljup6hdf.fsf@gitster.siamese.dyndns.org>
 <20081209055629.GB2972@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Whiteside <jeff.m.whiteside@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 07:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9wKf-0008ND-Qh
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 07:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYLIGnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 01:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYLIGnL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 01:43:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbYLIGnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 01:43:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 31B3618737;
	Tue,  9 Dec 2008 01:43:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C127318736; Tue, 
 9 Dec 2008 01:43:04 -0500 (EST)
In-Reply-To: <20081209055629.GB2972@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 9 Dec 2008 00:56:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A44B5770-C5BC-11DD-AA52-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102602>

Jeff King <peff@peff.net> writes:

> In one of my scripts I do something like this (actually this is not
> straight from my script, as the operation there is "find all pairs of
> local/remote branches" and this is "find the current upstream"):
>
>   ref=`git symbolic-ref HEAD`
>   head=${ref#refs/heads/}
>   remote=`git config branch.$head.remote`
>   branch=`git config branch.$head.merge`
>   echo refs/remote/$remote/${branch#refs/heads/}
>
> And obviously this is missing error checking for the detached HEAD
> (symbolic-ref should fail) and no tracking branch ($remote and/or $branch
> will be empty) cases.

Yeah, add any nonstandard layout to that set of things that are missing,
but in practice it should not matter.
