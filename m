From: Junio C Hamano <gitster@pobox.com>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Sun, 22 Jun 2008 03:01:07 -0700
Message-ID: <7vtzfln5zw.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr>
 <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com>
 <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0806212343560.18093@fbirervta.pbzchgretzou.qr>
 <alpine.LNX.1.10.0806221107540.15126@fbirervta.pbzchgretzou.qr>
 <7vtzflolis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vegard Nossum <vegard.nossum@gmail.com>,
	Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Bart Trojanowski <bart@jukie.net>
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sun Jun 22 12:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAMOr-0000ki-Ow
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 12:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbYFVKB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 06:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbYFVKBZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 06:01:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYFVKBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 06:01:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 416DBA9B3;
	Sun, 22 Jun 2008 06:01:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7657AA9B2; Sun, 22 Jun 2008 06:01:12 -0400 (EDT)
In-Reply-To: <7vtzflolis.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 22 Jun 2008 02:40:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2919CC76-4042-11DD-9D15-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85763>

Junio C Hamano <gitster@pobox.com> writes:

> Jan Engelhardt <jengelh@medozas.de> writes:
>
>> I am aware that this is a less / xterm issue, but I wanted to let
>> you know.
>
> Do you mean "me" by "let you know"?  Well, I have already been aware of
> it, thanks.

Having said all that, I have to say I am regretting to have accepted that
patch to enable pager on status, not because it bothers me personally (it
doesn't primarily because I practically never run git-status because I
consider the command useless and living almost always in Emacs helps), but
because in principle changing anything that existing users are used to is
bad.

Jeff had a patch to allow boolean configuration variable "pager.<command>"
to override the built-in pager settings during 1.5.6 cycle, and I think it
was a reasonable approach to take.  People who want to page output from
git-status can then set "pager.status = true" in their configuration (and
then we can revert c8af1de (make git-status use a pager, 2008-04-23)).
Alternatively we could keep the current status-quo for the default, and
people can say "pager.status = false" in their configuration.
