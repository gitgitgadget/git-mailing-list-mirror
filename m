From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: unify boolean feature subroutines
Date: Wed, 17 Dec 2008 00:20:27 -0800
Message-ID: <7vabavp60k.fsf@gitster.siamese.dyndns.org>
References: <7vabawu1ao.fsf@gitster.siamese.dyndns.org>
 <1229408179-7655-1-git-send-email-kraai@ftbfs.org>
 <7vmyewqypk.fsf@gitster.siamese.dyndns.org> <20081216142357.GF4529@ftbfs.org>
 <20081217081028.GA3640@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Dec 17 09:22:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCrfQ-0003h6-2M
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbYLQIUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 03:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbYLQIUh
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:20:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYLQIUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 03:20:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1FA91A75A;
	Wed, 17 Dec 2008 03:20:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F37D51A758; Wed,
 17 Dec 2008 03:20:29 -0500 (EST)
In-Reply-To: <20081217081028.GA3640@machine.or.cz> (Petr Baudis's message of
 "Wed, 17 Dec 2008 09:10:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 947A5E92-CC13-11DD-AA66-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103315>

Petr Baudis <pasky@suse.cz> writes:

> Hi,
>
> On Tue, Dec 16, 2008 at 06:23:57AM -0800, Matt Kraai wrote:
>> On Tue, Dec 16, 2008 at 01:03:03AM -0800, Junio C Hamano wrote:
>> > But a change to the function signature of feature subroutines is not
>> > something I'd like to apply while other series that want to add new
>> > features are still cooking.  How about doing these two patches as the
>> > first thing that goes to 'next' after 1.6.1, and then force other series
>> > rebase on top of your change?  Alternatively, we could make you wait until
>> > other series do settle in 'next' and then apply your change rebased on
>> > them, but I think that is probably less optimal.
>> 
>> OK, I'll resubmit the patches on top of 'next' once 1.6.1 is
>> released.  Thanks for your help,
>
> is it worth keeping them separate? Just a single patch makes more sense
> to me, the interface is much nicer in the latter than in the former. :-)

I agree.

It should come *first* before other topics that are not in 'master/next'
and change the function signature of feature subs of only existing (read:
in 'master') ones.  This will force gb/gitweb-patch (and anybody else's
patch that haven't been submitted, waiting during the -rc period) to be
rebased on top of the updated interface, but that's life.
