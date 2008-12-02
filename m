From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Mon, 01 Dec 2008 18:29:28 -0800
Message-ID: <7vtz9npawn.fsf@gitster.siamese.dyndns.org>
References: <20081107220730.GA15942@coredump.intra.peff.net>
 <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
 <20081108142756.GC17100@coredump.intra.peff.net>
 <ee2a733e0812011822r4cef6a44ra68d6e84f9e30a90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	git@vger.kernel.org, "Sam Vilain" <sam@vilain.net>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 02 03:31:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7L39-0004oQ-EJ
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbYLBCaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYLBCaV
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:30:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbYLBCaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:30:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8267583D47;
	Mon,  1 Dec 2008 21:30:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2B2E883D39; Mon,
  1 Dec 2008 21:29:29 -0500 (EST)
In-Reply-To: <ee2a733e0812011822r4cef6a44ra68d6e84f9e30a90@mail.gmail.com>
 (Leo Razoumov's message of "Mon, 1 Dec 2008 21:22:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27C98260-C019-11DD-86C5-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102107>

"Leo Razoumov" <slonik.az@gmail.com> writes:

> On 11/8/08, Jeff King <peff@peff.net> wrote:
>> On Fri, Nov 07, 2008 at 03:16:53PM -0800, Junio C Hamano wrote:
>>
>>  > > The FAQ even says "don't do this until you know what you are doing." So
>>  > > the safety valve is configurable, so that those who know what they are
>>  > > doing can switch it off.
>>  >
>>  > "We are breaking your existing working setup but you can add a new
>>  > configuration to unbreak it" should not be done lightly.  I think as the
>>  > end result it is a reasonable thing to aim for for this particular
>>  > feature, but we do need a transition plan patch in between that introduces
>>  > a step that warns but not forbids.  We can ship 1.6.1 with it and then
>>  > switch the default to forbid in 1.6.3, for example.
>>
>>
>> Yeah, I was kind of hoping we could assume that anybody relying on this
>>  behavior was somewhat insane, and wouldn't be too upset when it broke.
>
> I do not think that having a work-flow different from yours deserves a
> "somewhat insane" label. But let us consider the consequences of
> banning push into a (current branch) non-bare repo. To propagate
> changes to such a non-bare repo there are two remaining alternatives
> neither of which is fully satisfactory:
>
> (1) Switch target's current branch to something else (prevent a
> conflict) before pushing and then restore it back after the push
>
> (2) Use git-fetch from the target.

(3) set the config in the target repository to allow such a push
    regardless of the git version.

Remember, I am in the third camp in this topic myself.
