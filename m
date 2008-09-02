From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack count on repo.or.cz
Date: Mon, 01 Sep 2008 18:47:36 -0700
Message-ID: <7vod37s4hz.fsf@gitster.siamese.dyndns.org>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org>
 <20080902000037.GA11869@coredump.intra.peff.net>
 <20080902010410.GI10360@machine.or.cz>
 <20080902011433.GA12682@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 03:48:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaL0j-0006x8-B5
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 03:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbYIBBro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 21:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbYIBBro
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 21:47:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbYIBBrn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 21:47:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 513E35E9B1;
	Mon,  1 Sep 2008 21:47:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 90CCE5E9AF; Mon,  1 Sep 2008 21:47:38 -0400 (EDT)
In-Reply-To: <20080902011433.GA12682@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 1 Sep 2008 21:14:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21C621D6-7891-11DD-ACC3-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94639>

Jeff King <peff@peff.net> writes:

> Though an even simpler solution, since you control all of the repos, is
> to just temporarily add references from the "parent" of the fork to
> every ref of every forked child. Then do the repack in the parent, which
> should then contain all of the objects for all of the children, delete
> the temporary references, and prune in the children (who should see most
> of their objects now in the parent).

Hmm, I am slightly worried about doing so might defeat the whole point of
making the sample repository a separate one from git.git hosted there.

The reason it is not a branch in git.git is because I did not want to
contaminate the official git.git repository with commit objects in tree
objects (aka gitlinks); it would deny access to clients older than 1.5.2.
