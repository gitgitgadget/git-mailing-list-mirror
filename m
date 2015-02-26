From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Thu, 26 Feb 2015 12:13:44 -0800
Message-ID: <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	<xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:13:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR4oh-0000Nd-Ku
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 21:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbbBZUNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 15:13:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753689AbbBZUNr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 15:13:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 866BC3B38F;
	Thu, 26 Feb 2015 15:13:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mRvBZMiY7qWzUQ6FMEiVaSSl7lY=; b=wEkDdS
	rzIhJHzLf0Hv5Kgubv/p7B4UeZIZrtvixqWM5prnnM7YMjldl8paqMk8oCThRkCq
	+fABaECKGoszWJksKK32Ahil8PKnDS2DeXaq7fGiEi7mJvglhTSTakgCefFxfX/4
	1e3IAho3JoHL4ieQnMXHGQoGb9r1SmqTmR6oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ExrUzE+pa7cwclnHXt4yVphDlElTmOH8
	x5v1G7BGSO5yEum9e4aTTHTcDZ4QepvY4mLWtjQ6KvmBIdMPgC39Zha1hAD8r4w7
	AGowupTJ27A/M96S815MSCVRrKWjikqpPHFti2MTOeQ/kLbr/GkrTkbxkuNBQUzj
	60fJCtgoRB0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DC663B38D;
	Thu, 26 Feb 2015 15:13:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE8533B378;
	Thu, 26 Feb 2015 15:13:45 -0500 (EST)
In-Reply-To: <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 26 Feb 2015 17:15:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7B66CC0-BDF3-11E4-B27F-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264455>

Duy Nguyen <pclouds@gmail.com> writes:

> Step 1 then should be identifying these wrongdoings and assumptions.
>
> We can really go wild with these capabilities. The only thing that
> can't be changed is perhaps sending the first ref. I don't know
> whether we can accept a dummy first ref... After that point, you can
> turn the protocol upside down because both client and server know what
> it would be.

Yes, exactly.  To up/down/side-grade from v1 is technically
possible, but being technically possible is different from being
sensible.  The capability-based sidegrade does not solve the problem
when the problem to be solved is that the server side needs to spend
a lot of cycles and the network needs to carry megabytes of data
before capability exchange happens.  Yes, the newer server and the
newer client can notice that the counterparty is new and start
talking in new protocol (which may or may not benefit from already
knowing the result of ref advertisement), but by the time that
happens, the resource has already been spent and wasted.

I do not think v1 can be fixed by "send one ref with capability,
newer client may respond immediately so we can stop enumerating
remaining refs and older one will get stuck so we can have a timeout
to see if the connection is from the newer one, and send the rest
for the older client", because anything that involves such a timeout
would not reliably work over WAN.

> You realize you're advertising v2 as a new capability, right? Instead
> of defining v2 feature set then advertise v2, people could simply add
> new features directly. I don't see v2 (at least with these patches)
> adds any value.

I agree with the value assessment of these patches 98%, but these
bits can be taken as the "we have v2 server availble for you on the
side, by the way" hint you mentioned in the older thread, I think.

> And we already does that, except that we don't state what version (as
> a number) exactly, but what feature that version supports. The focus
> should be the new protocol at daemon.c and maybe remote-curl.c where
> we do know the current protocol is not flexible enough.

The "first" thing the client tells the server is what service it
requests.  A request over git:// protocol is read by "git daemon" to
choose which service to run, and it is read directly by the login
shell if it comes over ssh:// protocol.

There is nothing that prevents us from defining that service to be a
generic "git service", not "upload-pack", "archive", "receive-pack".
And the early protocol exchange, once "git service" is spawned, with
the client can be "what real services does the server end support?"
capability list responded with "wow, you are new enough to support
the 'trickle-pack' service---please connect me to it" request.
