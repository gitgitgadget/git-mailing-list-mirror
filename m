From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Add post-init hook
Date: Thu, 09 Oct 2008 04:24:29 -0700
Message-ID: <7viqs2ovte.fsf@gitster.siamese.dyndns.org>
References: <1223421033-22340-1-git-send-email-jon.delStrother@bestbefore.tv>
 <20081008015352.GA29313@coredump.intra.peff.net>
 <57518fd10810080116gd876f9bv169f575087baccd7@mail.gmail.com>
 <20081009014146.GA14204@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 09 13:26:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kntel-0003PK-AM
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 13:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758938AbYJILYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 07:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758941AbYJILYm
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 07:24:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758928AbYJILYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 07:24:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 81FBC6C4EB;
	Thu,  9 Oct 2008 07:24:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4C7496C4E5; Thu,  9 Oct 2008 07:24:30 -0400 (EDT)
In-Reply-To: <20081009014146.GA14204@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 8 Oct 2008 21:41:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD1CC540-95F4-11DD-A4E5-9364E785EAEE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97842>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 08, 2008 at 09:16:56AM +0100, Jonathan del Strother wrote:
> ...
>> I want symlinks so I only have to edit my hooks in one place whenever
>> I change them)
>
> This makes a lot of sense to me as a best-practice. I wonder if we
> wouldn't do better to add a core.symlink-templates option?

AFAIR, "git init" copies symlinks in templates as symlinks, so I do not
see why you would even want to have such an option.

Wouldn't it be better if users and installations with such a special
set of templates specified by core.template or --template prepare a
template directory with files and symbolic links of their liking?  If
they want some hooks to point at the latest copy of installation specific
standard hook script, templates/hooks/$that_hook can be a symlink to the
real location, no?
