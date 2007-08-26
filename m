From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-daemon on NSLU2
Date: Sun, 26 Aug 2007 14:22:12 -0700
Message-ID: <7vtzqmng8r.fsf@gitster.siamese.dyndns.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	<alpine.LFD.0.999.0708241618070.16727@xanadu.home>
	<9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
	<alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org>
	<9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com>
	<20070826093331.GC30474@coredump.intra.peff.net>
	<9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com>
	<alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org>
	<9e4733910708261106u3fecde67m8045ddba3aa57650@mail.gmail.com>
	<alpine.LFD.0.999.0708261118260.25853@woody.linux-foundation.org>
	<9e4733910708261200m5e4c3019g490ffc29b171ef08@mail.gmail.com>
	<alpine.LFD.0.999.0708261318140.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Jeff King <peff@peff.net>,
	jnareb@gmail.com, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 26 23:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPPZP-0004L2-4Q
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 23:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbXHZVWY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 17:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbXHZVWY
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 17:22:24 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:57618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbXHZVWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 17:22:23 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 274EC1272BD;
	Sun, 26 Aug 2007 17:22:36 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708261318140.25853@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 26 Aug 2007 13:19:31 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56734>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> I'm not buying the security argument. If you want something kept hidden 
>> get it out of the public db. If I know the sha of the hidden object 
>> can't I just add a head for it and git-deamon will happily send it and 
>> the chain up to it to me?
>
> That's a particularly idiotic statement.
>
> If you know the SHA1, there can *by*definition* not be any hidden objects. 
> The SHA1 depends on the object chain.

I think what we have is even stronger --- upload-pack does not
allow asking for an arbitrary commit.  The requesting fetch-pack
side needs to pick from what are offerred, and upload-pack makes
sure of that.
