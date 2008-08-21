From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2008, #06; Wed, 20)
Date: Wed, 20 Aug 2008 19:30:54 -0700
Message-ID: <7vy72rkskh.fsf@gitster.siamese.dyndns.org>
References: <7vabf7mcpz.fsf@gitster.siamese.dyndns.org>
 <20080821011811.GA13915@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 04:32:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVzy3-0006aS-65
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 04:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbYHUCbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 22:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYHUCbC
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 22:31:02 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYHUCbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 22:31:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 64B7C58255;
	Wed, 20 Aug 2008 22:30:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CF4C458253; Wed, 20 Aug 2008 22:30:56 -0400 (EDT)
In-Reply-To: <20080821011811.GA13915@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 20 Aug 2008 21:18:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 30CBFB0E-6F29-11DD-9BFF-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93089>

Jeff King <peff@peff.net> writes:

> I really liked this the first time I ran "make -j4 test". However, it
> now cleans up the trash directory automagically after a successful run.
> This bit me today when I added a test that should have failed but
> accidentally passed. I wanted to look at the output, but it was gone.
>
> Probably it's not worth worrying about, since that is certainly the less
> common case, and I can work around it by editing the passing test script
> to provoke failure.

When I add to an existing test, I usually:

 * guess where I want to start the new test;
 * insert an "exit" there to cause failure;
 * run it and inspect the state of the test directory;
 * write the new test just before the "exit";
 * run it until I like the new test;
 * remove the "exit".
