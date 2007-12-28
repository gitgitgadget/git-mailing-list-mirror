From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull: warn if only fetching tags with the -t switch
Date: Thu, 27 Dec 2007 23:19:00 -0800
Message-ID: <7vodcbe17f.fsf@gitster.siamese.dyndns.org>
References: <20071221124400.20725.qmail@db93e79e204cd8.315fe32.mid.smarden.org>
	<7v8x3oatvi.fsf@gitster.siamese.dyndns.org>
	<20071227093016.18337.qmail@e6d9fb481b7087.315fe32.mid.smarden.org>
	<7vwsr0ifqi.fsf@gitster.siamese.dyndns.org>
	<20071227144618.32373.qmail@5b51609f839e87.315fe32.mid.smarden.org>
	<7vve6je349.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 08:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J89VL-0002aA-2w
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 08:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbXL1HTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 02:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbXL1HTL
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 02:19:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbXL1HTK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 02:19:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 04657BD21;
	Fri, 28 Dec 2007 02:19:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 577E7BD20;
	Fri, 28 Dec 2007 02:19:04 -0500 (EST)
In-Reply-To: <7vve6je349.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 27 Dec 2007 22:37:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69277>

Junio C Hamano <gitster@pobox.com> writes:

> It appears that the explicit case also needs documentation.

But with two "oops-correction"s.

> The refs fetched are:
>
>  + Having --tags on the command line is the same as replacing
>    remote.$remote.fetch with refs/tags/*:refs/tags/* in the
>    configuration.
>
>  + If refspecs are explicitly given from the command line, they
>    will be the ones that are fetched, and remotes.$remote.fetch
>    is consulted unless they come from the above --tags.

s/is consulted/is ignored/;

>  * Otherwise, remotes.$remote.fetch (and its equivalent in
>    .git/remotes/$remote) are the ones that are fetched.
>
>  * In addition, if branch.$current_branch.merge is specified but
>    is not covered by the above, it also is fetched.

s/if /if no explicit refspecs are given and /;
