From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] migrate api-strbuf.txt into strbuf.h
Date: Thu, 12 Feb 2015 15:01:18 -0800
Message-ID: <xmqqh9uqpwe9.fsf@gitster.dls.corp.google.com>
References: <20150116090225.GA30797@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 00:01:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM2lD-00062L-1B
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 00:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbbBLXBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 18:01:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752081AbbBLXBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 18:01:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73CDC37E28;
	Thu, 12 Feb 2015 18:01:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WPPtVEAn20cY2bzTbsAQ0zy3ruA=; b=F0tWDc
	15Xc/WENTE4CMob5/N6OYcDM2W+kJKT3vPTFEznMnPr6T2R0Pzv1pN/67JPuWUGr
	MGCP0A7juzSugLlcYry6Ga08MPbzOkohf1TAscGpfzbLMu6dLlc9JQtyppPsjpaV
	PZBatxmXArj71lMrRRopXdhfR5ADewplv8Im0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oUAI8e+1VqyznwqJd/vrRES5NYt7FfTX
	Lm3qzpA0xRnAKxnMIl/6e0cHlQGKsXzD/HQb4tczF+VZPX+Fucd8t3YcQS1FTyS5
	Z4vflsJX7aq/5oCrnYlSzWaLkuZLpTAmjRV4w+v7GQ0dApMfxBRuum/0DCf92DSI
	fV8tlVbNmAM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69EED37E27;
	Thu, 12 Feb 2015 18:01:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDB1537E21;
	Thu, 12 Feb 2015 18:01:19 -0500 (EST)
In-Reply-To: <20150116090225.GA30797@peff.net> (Jeff King's message of "Fri,
	16 Jan 2015 04:02:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E9E50AE-B30B-11E4-9592-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263782>

Jeff King <peff@peff.net> writes:

> This is a re-roll of this series:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/260922/focus=261374
>
> from early December to move the strbuf documentation into the header
> file.
>
> And of course the elephant in the room is the other dozen or more
> api-*.txt files. I'd propose to do this strbuf.h series (and possible
> follow-ons mentioned above) and stop there for a bit. That will let us
> form a more coherent opinion on whether we like this system in practice,
> how it ages as functions are changed and added, etc. That might affect
> how or if we end up converting other files.
>
> It does leave us in an inconsistent state (some documentation is in
> Documentation/technical, and some is in the headers), but I think that
> is largely where we're at today. IMHO this is a strict improvement
> because at least the logical chunk of "strbuf" is now in a single place.

Is there a general concensus on the direction?

I am inclined to merge this to 'next', if there is a general
understanding that we will try to make the headers _the_ single
source of truth of the API by (1) not adding to api-*.txt without
describing new things in the headers and (2) moving things from
api-*.txt to corresponding headers when clarifying, fixing or
updating the API.
