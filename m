From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-filter-branch: avoid collisions with variables in
 eval'ed commands
Date: Wed, 25 Mar 2009 16:34:53 -0700
Message-ID: <7vskl1w50i.fsf@gitster.siamese.dyndns.org>
References: <1238015581-12801-1-git-send-email-newren@gmail.com>
 <20090325212403.GU8940@machine.or.cz>
 <51419b2c0903251433s75775206x556fc2d65a347d7d@mail.gmail.com>
 <20090325215848.GV8940@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Mar 26 00:36:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmceB-0004iA-MT
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 00:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbZCYXfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 19:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbZCYXfE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 19:35:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbZCYXfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 19:35:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E395D90EA;
	Wed, 25 Mar 2009 19:35:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F285A90E9; Wed,
 25 Mar 2009 19:34:54 -0400 (EDT)
In-Reply-To: <20090325215848.GV8940@machine.or.cz> (Petr Baudis's message of
 "Wed, 25 Mar 2009 22:58:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F17EECC-1995-11DE-96DA-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114691>

Petr Baudis <pasky@suse.cz> writes:

> On Wed, Mar 25, 2009 at 03:33:31PM -0600, Elijah Newren wrote:
>> Hi,
>> 
>> On Wed, Mar 25, 2009 at 3:24 PM, Petr Baudis <pasky@suse.cz> wrote:
>> > On Wed, Mar 25, 2009 at 03:13:01PM -0600, newren@gmail.com wrote:
>> >> From: Elijah Newren <newren@gmail.com>
>> >>
>> >> Avoid using simple variable names like 'i', since user commands are eval'ed
>> >> and may clash with and overwrite our values.
>> >>
>> >> Signed-off-by: Elijah Newren <newren@gmail.com>
>> >
>> > Almost-acked-by: Petr Baudis <pasky@suse.cz>
>> >
>> > But:
>> >
>> >>-i=0
>> >>+git_filter_branch_count=0
>> >
>> > Why branch_count? It counts commits, not branches, doesn't it?
>> 
>> Oh, I was just changing i->git_filter_branch_i, then thought as long
>> as it was long I might as well use a word instead of "i".  Didn't
>> think about the combined meaning.  How about
>> "git_filter_branch_commit_count"?  Maybe a double underscore between
>> the "namespace" and the "variable"?
>
> Oh, I sort of thought it's "git-filter branch count", not
> "git-filter-branch count". I'm dumbed down from all day spent in IKEA
> I guess. :/
>
> I'd personally just use $__git_i, $__git_commit or something, but YMMV.

Heh, I'll drop lmost-a from your earlier message and commit the result.

Thanks.
