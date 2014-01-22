From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work -> relnotes
Date: Tue, 21 Jan 2014 16:40:28 -0800
Message-ID: <xmqqbnz4svb7.fsf@gitster.dls.corp.google.com>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
	<xmqqppo090m7.fsf@gitster.dls.corp.google.com>
	<52CFACBB.7000805@atlas-elektronik.com>
	<F11CD558C63947F9B4AA75501D2F9F62@PhilipOakley>
	<52D91B0E.6080000@atlas-elektronik.com>
	<BA4E87FA92ED4E8FB2C00F013BD7B3FF@PhilipOakley>
	<xmqqob34synq.fsf@gitster.dls.corp.google.com>
	<2D10AF8E0C024CC5A817528582FDE07D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	"GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jan 22 01:40:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5lsG-00053J-H7
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 01:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbaAVAkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 19:40:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbaAVAkg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 19:40:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2662465111;
	Tue, 21 Jan 2014 19:40:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+a8cX6i07xpMux4Wa061TwnOeqo=; b=RmeKJV
	dBFGf6tV2SlwOMv63taSn9ixvgg7XKBYk5DcLUpCvMDt/t3KUhZP4vtKcRvNX04z
	4sNFJzcy1LxTd/982/BOmxHTZn5g4gwCIFQx9fPPp4g86nCEd/ZIFma5jnI4tImB
	yAKEHKl2PLopHNrFe6n5/eG9X+Rab4kbFXLVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vxr3ZBJU1CNaVqu6g4/yta7z/+VnzmOd
	jHunb1FuIIQeeK9/yg1vBWT5q9zJ1SbIH1iyRId7l/a1vxAkbBNeQT7K/BaBQ2ZM
	t0rKRlLFHEbQRfUhhJwTC3OJ4M9LTJ6AfaJe4IsLdpHt9rx5rU/kxk3gezuzRLrW
	DFiTKpc98ds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1807765110;
	Tue, 21 Jan 2014 19:40:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 137AB6510F;
	Tue, 21 Jan 2014 19:40:31 -0500 (EST)
In-Reply-To: <2D10AF8E0C024CC5A817528582FDE07D@PhilipOakley> (Philip Oakley's
	message of "Wed, 22 Jan 2014 00:22:19 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CC85638A-82FD-11E3-85C3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240810>

"Philip Oakley" <philipoakley@iee.org> writes:

> I already have a local patch that creates a stalenote.txt file, and
> includes that in a "release-notes(7)" man page, but it still leaves
> the actual release notes in a separate plain text file, linked from
> the man page, rather than being right at hand, which is what I think
> readers would expect.

Sorry, but I still do not get it.  If you have a script that reads
git.txt and extracts its stale-notes section to generate the source
to be processed into release-notes(7), why can't that script also
include the contents of the latest release notes inline into its
output?

My release notes are _not_ written to be compatible with/processable
by AsciiDoc (they are meant to be mere plain text)---perhaps you are
wondering if that would make it harder to maintain your script that
produces release-notes.txt?

Confused...

>
> My other question would be to ask how you normally manage the up-issue
> of the stalenotes, and when you would normally create that section in
> git(1) as I didn't see any ifdef::stalenotes[] being defined anywhere
> else.

I'm not sure if I am understanding the question right (up-issue?),
but it used to be that the preformatted and web-reachable manual
pages at k.org were processed with stalenotes defined (which by the
way was disabled with adaa3caf "Meta/dodoc.sh: adjust to the new
layout, 2011-11-15" on the todo branch), and 26cfcfbf "Add release
notes to the distribution., 2007-02-13" used that facility to
prepare something like this:

    docs/git.html
        /git-cat-file.html
        ...
    docs/vX.Y.Z/git.html
    docs/vX.Y.Z/git-cat-file.html
                ...

where the "latest" one lived immediately underneath docs/*, while
older ones were in versioned subdirectories.
