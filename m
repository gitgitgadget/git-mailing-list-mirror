From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Mon, 09 Apr 2012 12:58:13 -0700
Message-ID: <7vpqbgvfsa.fsf@alter.siamese.dyndns.org>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
 <20120408050140.GA5862@sigill.intra.peff.net>
 <20120408103002.GA3177@burratino>
 <20120408110642.GB21217@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 21:58:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHKjW-0002Hp-Jq
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 21:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab2DIT6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 15:58:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab2DIT6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 15:58:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAFA76D22;
	Mon,  9 Apr 2012 15:58:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vjeKPu2Z1mClpVNx5ULlCIKo2L0=; b=fT0OsP
	YvAxe756uJ24shM2n7POpb7sNrz3YGO9D8EWnYBkAvWA80Il4G2ChwV3KBoFWRCz
	yTNXFZDX62tMofhceEzOHa1GktQEGbEpcjnNSIX2QKaGxegGsgw5aAhdTQlEXoba
	7pUp1QsRyNob03cNBenkHpGqt+6KqiqUeb3BU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQLvFC43n8xAJ5zC5wcpdBovlt0v8CpH
	mCwIo2PxGXjCZZjqRxAnlx+YV+OIJATk/A93JiiXFbKpuBG5cu+hDPSAFkSyrT1o
	lJQ/ZcNmvGDBv5wU31HbJoqBGYjLC2OmQizhdPo+tE1+0bNTKp8iaon8auZyQcxw
	y5YQ1Mw7zYU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E265A6D21;
	Mon,  9 Apr 2012 15:58:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 516356D1F; Mon,  9 Apr 2012
 15:58:15 -0400 (EDT)
In-Reply-To: <20120408110642.GB21217@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 8 Apr 2012 07:06:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 581AA270-827E-11E1-A465-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195034>

Jeff King <peff@peff.net> writes:

> On Sun, Apr 08, 2012 at 05:30:02AM -0500, Jonathan Nieder wrote:
>
>> > This test fails for me. The problem is that I have other git-f* programs
>> > in my PATH
>> [...]
>> Is there some reason we care about the exact list of completions for
>> "git f"?
>> [...]
>> Maybe it would make sense to check a few representative items.
>> 
>> 	# builtin
>> 	grep "^fetch\$" out &&
>
> I think your approach (to stop worrying about stopping pollution from
> the environment, and start being more specific in what the tests care
> about) is much saner than the snippet I posted.

I have to agree with that; it might give unexpeceted results if the user
has a $HOME/bin/git-update-index or something, though.
