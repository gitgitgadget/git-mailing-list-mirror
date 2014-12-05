From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] prompt: respect GIT_TERMINAL_PROMPT to disable terminal prompts
Date: Fri, 05 Dec 2014 09:37:22 -0800
Message-ID: <xmqqk326q9pp.fsf@gitster.dls.corp.google.com>
References: <20141204034206.GA1493@peff.net> <20141204035228.GB21492@peff.net>
	<xmqqy4qntgs6.fsf@gitster.dls.corp.google.com>
	<20141204210149.GB19953@peff.net>
	<xmqqbnnjrtfi.fsf@gitster.dls.corp.google.com>
	<20141205091049.GB32112@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 18:37:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwwou-0000Nf-Ky
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 18:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbaLERh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 12:37:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751848AbaLERh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 12:37:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96F752086E;
	Fri,  5 Dec 2014 12:37:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=98PEaLl9oYhO4bNMsWEak2nQngo=; b=dEjEir
	WglXF3esYcPa649TxZ7NeSPoZu9ekkuiipiHe1twG1kuFtQPIIePcsGds/ot2pkj
	ditCNOUlXymKAGZ0XYtNSnvlQ+OGe1OOP7Syz8/eAGY/GLbOLRqXIXyQu6cvIUyb
	5n0GTio0pOUfc2JtceodaeynwhNfmAFmup9aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M45JccPmNFxHzdAjawWhAg1vLgRmvy7Y
	rk5QzKHH3B0Wc9n77r0KoJ7A7mLJcWp57KRWjHMnwZTZXdbz3X6GpmUY9JDveJHN
	R7gqxSOyyyBKbBEfYFUo+DNpmZDAwyKjCTD1Bd1gNxRvwfcmKNXkV4AFo0slGQxv
	B0Q1oAKDGeM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C6102086D;
	Fri,  5 Dec 2014 12:37:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E89E62086A;
	Fri,  5 Dec 2014 12:37:23 -0500 (EST)
In-Reply-To: <20141205091049.GB32112@peff.net> (Jeff King's message of "Fri, 5
	Dec 2014 04:10:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F61C71A-7CA5-11E4-9693-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260876>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 04, 2014 at 01:33:53PM -0800, Junio C Hamano wrote:
>
>> Of course, from _our_ point of view, that somebody is not us.  We do
>> not have direct control, certainly from this codepath.

Belated typofix - s/from /not &/.

>
> Right, but in theory we can provoke gpg to do what we want when we spawn
> it. However, having had zero luck in convincing it to stop asking me for
> a passphrase recently in another thread, I do not know what magic
> command line option is required. :(
>
> I think it would be OK to merge the git handling of GIT_TERMINAL_PROMPT
> (i.e., the patch I sent), and somebody who runs into the issue with gpg
> and can figure out how to tame it can scratch their own itch later. I
> hate leaving things half-implemented or inconsistent, but I also don't
> know how to make gpg do what we want. And doing a partial solution
> seems better to me than holding the credential.c half hostage.

Oh, no question about that.  You are making things better by
advancing one step at a time.

Queued and will be moving to 'next' shortly.
