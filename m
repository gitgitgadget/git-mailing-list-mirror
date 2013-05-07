From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Enable minimal stat checking
Date: Mon, 06 May 2013 21:54:46 -0700
Message-ID: <7va9o7o0dl.fsf@alter.siamese.dyndns.org>
References: <7v4niblhr6.fsf@alter.siamese.dyndns.org>
	<1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
	<20130506232242.GA27393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 07 06:54:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZvR-000053-TG
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760718Ab3EGEyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:54:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57581 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759321Ab3EGEyt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:54:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D77D616ABA;
	Tue,  7 May 2013 04:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FPu73qjq4dWH3mWXKwl0f/IgwOw=; b=Ag8839
	qCRMErmmI1KWpWGu5tRjXN52gwfvwTJlubtIrCMXXlA5Wh67Bc7Zw8QmgXE2B5Zu
	KaL4LPFpUoG31o65fb5ykV5PqCswj4+mbCcpS00oX8I6Bd9qvAsjwTEMcZXcX99O
	GmLPSIMI6g5ytt6JXpsXih/hMzx4e3cvfE5Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BTImurAaEsvcNJQgizuJaUpXKanL59Rb
	UYNIi1/bF9CC7aAK9O/9uokNMWHyWe/IFIyRhQ/pVUtqf9jqw0n0O3HItsPYJndj
	m2VbmQpN86cCAuBDKVajhVPj37W/WCyaAp7EGPMgNfieLZmWkIQEshbAOQdSlBh3
	Lw7yvaX1X2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB6716AB9;
	Tue,  7 May 2013 04:54:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DD5516AB8;
	Tue,  7 May 2013 04:54:48 +0000 (UTC)
In-Reply-To: <20130506232242.GA27393@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 May 2013 19:22:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E8C51BC-B6D2-11E2-A049-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223550>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 22, 2013 at 08:49:22AM +0100, Robin Rosenberg wrote:
>
>> Specifically the fields uid, gid, ctime, ino and dev are set to zero
>> by JGit. Other implementations, eg. Git in cygwin are allegedly also
>> somewhat incompatible with Git For Windows and on *nix platforms
>> the resolution of the timestamps may differ.
>
> This is an old commit, but I noticed a bug today...
>
>> This change introduces a core.checkstat config option where the
>> [...]
>> +core.checkstat::
>> [...]
>> +	if (!strcmp(var, "core.statinfo")) {
>
> One of these is not like the others. I didn't prepare a patch, though,
> because I wasn't sure which it was supposed to be. A documentation bug
> or a code bug? :)

I'd say checkstat reads much better than statinfo.
