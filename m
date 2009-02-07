From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: add --no-fetch parameter to update command
Date: Sat, 07 Feb 2009 00:44:39 -0800
Message-ID: <7vbptey6tk.fsf@gitster.siamese.dyndns.org>
References: <1233872312-17781-1-git-send-email-git@fabian-franz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hjemli@gmail.com
To: Fabian Franz <git@fabian-franz.de>
X-From: git-owner@vger.kernel.org Sat Feb 07 09:46:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVipV-0001TE-27
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 09:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbZBGIor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 03:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZBGIoq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 03:44:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbZBGIoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 03:44:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ABD652A9CA;
	Sat,  7 Feb 2009 03:44:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AEB542A9BE; Sat, 
 7 Feb 2009 03:44:40 -0500 (EST)
In-Reply-To: <1233872312-17781-1-git-send-email-git@fabian-franz.de> (Fabian
 Franz's message of "Thu, 5 Feb 2009 20:18:32 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9188C698-F4F3-11DD-8EB8-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108832>

Fabian Franz <git@fabian-franz.de> writes:

> git submodule update --no-fetch makes it possible to use git submodule
> update in complete offline mode by not fetching new revisions.
>
> This does make sense in the following setup:
>
> * There is an unstable and a stable branch in the super/master repository.
> * The submodules might be at different revisions in the branches.
> * You are at some place without internet connection ;)
>
> With this patch it is now possible to change branches and update
> the submodules to be at the recorded revision without online access.

How is this better than "cd submodule/path && git checkout whatever"?

> Another advantage is that with -N the update operation is faster,
> because fetch is checking for new updates even if there was no
> fetch/pull on the super/master repository since the last update.

Do we know this is common enough to deserve a shortopt -N?

The logic of the patch itself looks sane to me.
