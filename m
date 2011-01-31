From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 14:17:19 -0800
Message-ID: <7vpqrc4t1s.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jan 31 23:18:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk24V-00034H-5d
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 23:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693Ab1AaWRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 17:17:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab1AaWRb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 17:17:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87D974CAA;
	Mon, 31 Jan 2011 17:18:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zmsB0HHnjJhxbAs02l+DU/VQPs0=; b=WhBfFb
	fnWvW2NUu0CpFBmfQ2+j2KF5n/BKjnooQZFQBHEakMKOJDW5l/NgMAMmO1SVNZmM
	H7ufevmKisnXpp20t3mS+GfqZueJuHaPFl0W2RaEkMJKftx4+W74Hg7Nv8n5jaau
	7v/n2lj+88XQlCfZ4NIWVOQCmzlXmAsx8YTHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HFmYZAWQhOqb3sDiqZhGuKg9kN80WIN7
	eFkQNM5iWeSdE3aDoj5bpA/4L1l3TCavml6UplGP6Fg8nPZXXVZoRkS2ZPWYivd1
	n8ETZPUA6WaTcpl+VCzuZkeUMBQN4TqK2W45tNRt2MdwmxwzCs+yhunDIXcLUXIY
	7RjUFzYRAek=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 563C24CA6;
	Mon, 31 Jan 2011 17:18:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1FEA14CA5; Mon, 31 Jan 2011
 17:18:13 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1101311621150.8580@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 31 Jan 2011 16\:28\:49 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01627FD0-2D88-11E0-BBCD-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165762>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Mon, 31 Jan 2011, Jeff King wrote:
>
>> Besides being just one more directory to go up and down, it does make 
>> history browsing more annoying. As much as I love git's "don't record 
>> renames" philosophy, our handling of renames on the viewing side is 
>> often annoying. I already get annoyed sometimes following stuff across 
>> the s!builtin-!builtin/! change. This would be like that but more so.
>
> So... we do suck at something?  So why not take this opportunity to 
> shake yourself out of this easy comfort and improve Git as a result on 
> both front?  :-)
>
>> Or maybe it is a good thing for that reason, as we will eat our own
>> rename dogfood. :)
>
> Exactly!  And maybe we'll make Git even more useful in the process.

This part I _could_ actually buy; even though I do not think moving files
without much reason is a good project hygine, it does happen in real life,
and we would want to keep things smooth for real people.

>> > 5) Rename t/ to testsuite/ so this doesn't look like some garbage 
>> >    leftover.

I am not sure about this "t/" vs "testsuite/".

>> Ugh, more typing. :P
>
> Come on!  You sound like an old fart now!  ;-)

If we make the top-level directory lean enough, we probably can tab
complete after typing just "cd t" to go to testsuite/ or tests/ or
whatever you come up with, so "more typing" is not a huge issue to me
personally.

I however think the directory name "t/" is not our invention but what we
took from somebody else (perhaps Perl?), and I suspect some people expect
to find tests under there since we have had them there for a long time.
