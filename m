From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GTP/0.1 terminology 101: commit reels and references
Date: Mon, 28 Jul 2008 00:24:12 -0700
Message-ID: <7vk5f6tqsj.fsf@gitster.siamese.dyndns.org>
References: <488D42B6.4030701@gmail.com> <1217228570.6750.24.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Roys <roysjosh@gmail.com>, gittorrent@lists.utsl.gen.nz,
	git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Jul 28 09:25:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNN6j-0006g1-TW
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 09:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbYG1HYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 03:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbYG1HYZ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 03:24:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbYG1HYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 03:24:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8817246E20;
	Mon, 28 Jul 2008 03:24:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E8CB546E1D; Mon, 28 Jul 2008 03:24:14 -0400 (EDT)
In-Reply-To: <1217228570.6750.24.camel@maia.lan> (Sam Vilain's message of
 "Mon, 28 Jul 2008 19:02:50 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31FB8E74-5C76-11DD-BFD3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90426>

Sam Vilain <sam@vilain.net> writes:

>>   Commit reels can also, and generally do, include the objects required
>>  for a specific commit.
>
> Yes.  The only times where they wouldn't contain all the objects
> required for the commits within the reel, is when those objects happened
> to be contained by a previous reel.

What do you mean by "previous" reel?  It is not quite defined in your
message but perhaps defined elsewhere?

How is this different from a bundle?  Does a reel, unlike a bundle,
contain the full tree for the bottom commits? 

> This is one of the design decisions which I think may be a mistake; a
> less expensive to calculate definition of a reel would be *all* objects
> between the starting and ending Reference objects.

Do you mean all such objects and nothing else?  That would imply that a
reel is quite similar to a bundle (but neither rev-list --objects-edge
nor bundle guarantees that the result is minimal).
