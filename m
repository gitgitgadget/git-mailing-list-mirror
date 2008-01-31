From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] filter-branch: only print usage information when no arguments supplied
Date: Wed, 30 Jan 2008 17:34:55 -0800
Message-ID: <7v3asehj5s.fsf@gitster.siamese.dyndns.org>
References: <47A109A7.1070502@nrlssc.navy.mil>
	<47A112C5.8010903@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 31 02:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKOLG-0001qV-Ov
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 02:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbYAaBfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 20:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754691AbYAaBfS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 20:35:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbYAaBfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 20:35:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 48CA2231C;
	Wed, 30 Jan 2008 20:35:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1292231A;
	Wed, 30 Jan 2008 20:35:11 -0500 (EST)
In-Reply-To: <47A112C5.8010903@nrlssc.navy.mil> (Brandon Casey's message of
	"Wed, 30 Jan 2008 18:13:57 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72087>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Testing for whether command line arguments were supplied was being
> performed during option parsing. This had the side effect of
> printing usage information when a more appropriate error message
> would have been printed had the script been allowed to continue.
>
> Now this:
>
> 	git filter-branch
>
> will print usage information.
>
> And these:
>
> 	git filter-branch -d /tmp/work-dir
> 	git filter-branch <non-existant-revision>
> 	git filter-branch --
> 	git filter-branch -- <non-existant-revision>
>
> will print a message informing the user that filter-branch did
> not know which reference to rewrite. Without this patch the
> one with '-d' would also print usage information.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
>
> I prefer my original patch since I think it is consistent
> with the git interface.

I'd refrain from commenting on if it is consistent or not with
"the git interface".

But I would say I prefer your original better than this one.
Will apply.
