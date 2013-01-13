From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #05; Fri, 11)
Date: Sun, 13 Jan 2013 15:02:15 -0800
Message-ID: <7vobgsheko.fsf@alter.siamese.dyndns.org>
References: <7vip739su3.fsf@alter.siamese.dyndns.org>
 <CACsJy8CRbkLAD7LtoE_6FA_zW4YTW6Nb0mJU3ejqbu5URTrU1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 00:02:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuWZc-0006Wr-8Y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 00:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab3AMXCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 18:02:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755620Ab3AMXCS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 18:02:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16DF4C7EC;
	Sun, 13 Jan 2013 18:02:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iy+qDjUTZYiPTrZZZXo9G4XLHx0=; b=WnZ1Vv
	6inRzmIvy/dFOdYnk5z+R1/iIOJMBM6mfVZWHV3MlpWFLdHz9X8e5TD2Jj/Xo0Pe
	+lBdgGwuSOe+NjM/dH805oQCsd1/dk3kbR3YqFSRBFyaIh/goFqpkd/ZnTVzT1eH
	m9TLIVTLjGkf3YLeOEBZhjZetO60IbFQS5I9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ALQFYdJGsDSuQEQgeB8O49gKMq89SeOn
	/xPl2AMrXEV1TzYPTY7OUDgNxxd9FIv3l/tPMRcfJbnpg1zuTXkrSqzXTpc12I/z
	o/fl7mt5FALEd3ePLvvG9TDbS3ziGZ347/T3P0M1MwE7zu7tBqT69Q28omqcz/6T
	jxqUQSw1Jmk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B482C7EB;
	Sun, 13 Jan 2013 18:02:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6737DC7E9; Sun, 13 Jan 2013
 18:02:17 -0500 (EST)
In-Reply-To: <CACsJy8CRbkLAD7LtoE_6FA_zW4YTW6Nb0mJU3ejqbu5URTrU1Q@mail.gmail.com> (Duy
 Nguyen's message of "Sat, 12 Jan 2013 23:25:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46F32C32-5DD5-11E2-98CC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213406>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jan 12, 2013 at 6:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/parse-pathspec (2013-01-11) 20 commits
>>
>>  Uses the parsed pathspec structure in more places where we used to
>>  use the raw "array of strings" pathspec.
>>
>>  Unfortunately, this conflicts a couple of topics in flight. I tried
>>  to be careful while resolving conflicts, though.
>
> parse_pathspec has not picked up init_pathspec changes from
> jk/pathspec-literal and nd/pathspec-wildcard (already in master) so
> --literal-pathspecs is probably broken in 'pu' after a lot of
> init_pathspec -> parse_pathspec conversion.

I guess it may be a better way forward to hold the series off, and
instead help polishing the other topics that are depended on so that
they can graduate sooner, given multiple topics in flight wants to
touch pathspecs (either change the way they are handled, or adds new
places that use them).
