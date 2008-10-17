From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --diff-filter=T does not list x changes
Date: Fri, 17 Oct 2008 16:58:30 -0700
Message-ID: <7vzll2epuh.fsf@gitster.siamese.dyndns.org>
References: <871vyhbsys.fsf@cup.kalibalik.dk>
 <20081016102201.GB20762@sigill.intra.peff.net>
 <7vhc7cq8uq.fsf@gitster.siamese.dyndns.org> <87ej2fvgv9.fsf@kalibalik.dk>
 <7v1vyfoca2.fsf@gitster.siamese.dyndns.org> <87wsg7m2xp.fsf@kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Anders Melchiorsen <anders@kalibalik.dk>
X-From: git-owner@vger.kernel.org Sat Oct 18 01:59:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqzEc-0003Ll-3q
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbYJQX6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755359AbYJQX6p
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:58:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbYJQX6o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:58:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 71BE78B6A6;
	Fri, 17 Oct 2008 19:58:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 73F028B6A4; Fri, 17 Oct 2008 19:58:37 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 87E52A68-9CA7-11DD-A451-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98506>

Anders Melchiorsen <anders@kalibalik.dk> writes:

> ... way to pick out the commits that toggle the x
> bit? That is a problem that I am facing, with no solution shown so far ...

Are you interested in executable-bit only change, or any change that
contains changes to the executable-bit?  If I were looking for the latter,
probably finding "^:100664 100775 " (or the other way around) in log --raw
(or whatchanged) output would be what I would do --- the mode changes are
rare enough in a sane project, so I wouldn't mind having to do such
scripting as needed.

There are other "commit pickers" such as -S<strting> and --diff-filter
that do not absolutely have to exist (iow, they could also be scripted),
but what they pick earned easy shortcuts because the need is very common.
Once you can demonstrate that the need to pick executable-bit changes is
also very common, _and_ if you can come up with a clean solution, we might
add a commit picker that looks for changes in executable-ness in the
future.  I dunno.
