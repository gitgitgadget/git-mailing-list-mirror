From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git diff colorization idea
Date: Thu, 22 Jan 2009 22:45:14 -0800
Message-ID: <7vfxja34hx.fsf@gitster.siamese.dyndns.org>
References: <53497057-1ADE-4300-9F35-B218959606FE@wincent.com>
 <7vhc3q6evi.fsf@gitster.siamese.dyndns.org>
 <5034E8A9-2B17-4368-8EDF-5FEE61BB2BAD@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 07:46:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQFoY-0000Dz-Pk
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 07:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbZAWGpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 01:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbZAWGpU
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 01:45:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbZAWGpT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 01:45:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A86991D077;
	Fri, 23 Jan 2009 01:45:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D4FCA1D056; Fri,
 23 Jan 2009 01:45:15 -0500 (EST)
In-Reply-To: <5034E8A9-2B17-4368-8EDF-5FEE61BB2BAD@wincent.com> (Wincent
 Colaiuta's message of "Fri, 23 Jan 2009 07:16:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6610352C-E919-11DD-9F48-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106844>

Wincent Colaiuta <win@wincent.com> writes:

>>> Any feedback or suggestions before I get in too deep?
>>
>> I personally find your "prposal" picture too loud to my eye.
>
> Yes, mine too. I wouldn't actually use those colors in practice.  
> (Doubly so because the "removed" color looks like the "whitespace  
> error" color.)

I did not mean that your choice of colors is loud.  Not at all.  What I
meant was the use of color _everywhere_ makes it too loud, and also the
use of _larger number of_ colors makes it too loud..  In other words, you
are painting the output more than what the current output does, and that
made me find it too loud, no matter what the choice of colors are.

You might have misunderstood my illustration, but what I meant to suggest
was to leave most of the characters on both - and + lines in monochrome
(or whatever the "normal" is), and paint _only_ the words that are
different.  The outcome would become _less_ colorful than the current
"whole -/+ lines are painted" output, but "only different words are
coloured; the words that are unmodified are left uncoloured, without
distracting the eyes."  Much less louder than even the current one, yet
giving more information.

As -/+ has a marker value, I think colouring them may be Ok, too.  That
would make something like this:

  | {
  |<red>-</red>    <gray>local subcommands="add rm show prune<gray> <red>update</red>"
  |<green>+</green>    local subcommands="add <green>rename</green> rm show prune"
  |     if ...
