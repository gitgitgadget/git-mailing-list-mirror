From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] -C/--chdir command line option
Date: Sun, 19 Oct 2008 21:55:57 -0700
Message-ID: <7vr66b50gy.fsf@gitster.siamese.dyndns.org>
References: <20081019000227.GA9423@charybdis.dreamhost.com>
 <20081019131745.GA8643@coredump.intra.peff.net>
 <86685067-021C-4DC5-A462-AA6834208BDE@pasternacki.net>
 <20081019141634.GA8997@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maciej Pasternacki <maciej@pasternacki.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 14:35:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrmvK-000125-6E
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 07:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbYJTE4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 00:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbYJTE4L
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 00:56:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53545 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbYJTE4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 00:56:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AB47571308;
	Mon, 20 Oct 2008 00:56:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2E77171306; Mon, 20 Oct 2008 00:56:04 -0400 (EDT)
In-Reply-To: <20081019141634.GA8997@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 19 Oct 2008 10:16:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69515370-9E63-11DD-BF48-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98660>

Jeff King <peff@peff.net> writes:

> On Sun, Oct 19, 2008 at 03:47:04PM +0200, Maciej Pasternacki wrote:
>
>> As for -C being superfluous: --git-dir and --work-tree seem to support  
>> weird usage patterns (like work tree separate from git-dir), but it seems 
>
> Hmm. Yeah, thinking about it more, -C is not really superfluous with
> respect to those options. You don't want to say "here is the work-tree,
> and here is the git-dir". You want to say "find the work-tree and
> git-dir for me using the usual rules, as if I were in this directory."

I think that interpretation of -C, if the option existed, makes sense, but
I do not understand why the tool that drives git refuses to chdir to the
repository for itself in the first place.

The only excuse I remember seeing in the thread was that "make has '-C'
option, so let's have it, because it is similar", which does not justfiy
addition of that option to git at all to me.

With "make", the -C option can be justified as a necessary tool to write a
recursive Makefile that can be sanely and easily processed without
actually executing any commands (iow, imaging implementing "make" that
allows you to write "cd there && $(MAKE)" in the toplevel Makefile and
tells the users what would happen in "there" when run as "make -n").

And even in "make" context, not all implementations have it.  I think it
is only GNU and fairly recent BSDs.
