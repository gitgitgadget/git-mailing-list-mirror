From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] transport-helper: ask the helper to set the same options for import as for fetch
Date: Fri, 13 Feb 2015 11:36:24 -0800
Message-ID: <xmqqwq3lmwnb.fsf@gitster.dls.corp.google.com>
References: <xmqqlhk2ri1j.fsf@gitster.dls.corp.google.com>
	<1423805086-807-1-git-send-email-mh@glandium.org>
	<1423805086-807-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 20:36:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMM2V-0003EI-96
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 20:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbbBMTg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 14:36:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751263AbbBMTg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 14:36:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D875923B3C;
	Fri, 13 Feb 2015 14:36:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jCrV1PtJaFzuG5WA0nsGIpDDaNE=; b=pc/Ljz
	lL2QKBwrP5QpIZmovi6Da5NCO/0kWWaqsXqNiYGD170+T8uhlQQp4KGCDZwGEDoQ
	MxMlJTgdJ0XJIp4ET1NXbj7LcpJSTH9bKmu6ROs8jzBojYfr/b50GJA3Hfcc4m6R
	MaJgAuUgGfW4J9gIk/EAN+rIkWq6axRn4wA9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MyyYyE+7bQWnMP9qfJzMo9H5l13Hp2X0
	AXfJI6IPhEnhHB5qj/TIGjhKKRCA8WSJBCO0snkkGhSzh56ryVwb59G4K1Xz5Fev
	7sYAcbIZV2xA/yEh2L5EosOaea4MTTD+b111mCbBQKLk9GxRIP8pUXFS7PeRmyb4
	r9eM0Yi7+nw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CECD723B39;
	Fri, 13 Feb 2015 14:36:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 529DD23B38;
	Fri, 13 Feb 2015 14:36:25 -0500 (EST)
In-Reply-To: <1423805086-807-2-git-send-email-mh@glandium.org> (Mike Hommey's
	message of "Fri, 13 Feb 2015 14:24:46 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98E4DF56-B3B7-11E4-A273-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263825>

Mike Hommey <mh@glandium.org> writes:

> A remote helper is currently only told about the 'check-connectivity',
> 'cloning', and 'update-shallow' options when it supports the 'fetch'
> command, but not when it supports 'import' instead.

Sounds sensible.

Does the same issue exist for export vs push or do they happen to be
coded to pass similar enough set of options already by copied and
pasted code?
