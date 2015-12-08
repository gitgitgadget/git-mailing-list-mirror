From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: add an option to suppress commit hash
Date: Tue, 08 Dec 2015 10:18:28 -0800
Message-ID: <xmqqa8pkls7f.fsf@gitster.mtv.corp.google.com>
References: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
	<1449440196-991107-3-git-send-email-sandals@crustytoothpaste.net>
	<xmqqr3iym4rg.fsf@gitster.mtv.corp.google.com>
	<20151208010227.GC990758@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 19:18:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6MqX-0004EM-Ju
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 19:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbbLHSSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 13:18:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751245AbbLHSSg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 13:18:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91DAA31213;
	Tue,  8 Dec 2015 13:18:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dEA/nM3RLJTog8awD1Uh8ShyZVU=; b=YrnRFG
	4qT7kClYhuc19IIUmBCxNP4dnvCLfepTP2d8xvl6/Pz6dDx0c4rYj97ZTi9ohh+h
	1UCKDHbw5A+S8cnsLtkka0gpvz6hi8NyJ+KaV6Nt7hft/7JVc9R0qi3BxfPACbdS
	2DMQOC6R+dIpf5Gnfc9CBYV8JgnQ0jdNm0bLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XN1s88JliRY6QK6pbcthIeTRPBbQZPuC
	raeQBq/z9shRM/3eQlx6CcRlA+JvxY4Guz81G0ku/YAoNy/8s64WrNYenm5OUjOk
	klrYQfh3vNcPxblfWPtz99FWy/7wMiVosHBWumclmNM6RlFqoLO1nOwn81wo3NzN
	KP6C1+vhbdY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8684A31212;
	Tue,  8 Dec 2015 13:18:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 012ED31211;
	Tue,  8 Dec 2015 13:18:29 -0500 (EST)
In-Reply-To: <20151208010227.GC990758@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 8 Dec 2015 01:02:27 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1547D6E2-9DD8-11E5-857A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282170>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> Don't test "any number of '0'"; test 40 '0's.  This is because the
>> line format was designed to be usable by things like /etc/magic to
>> detect format-patch output, and we want to notice if/when we break
>> that aspect of our output format.
>
> My idea was to future-proof it against changes in the hash function,
> although that's in the distant future.

Making sure that the test fails when somebody accidentally lengthens
(or fails to truncate to 40-hex, when you start using a longer hash)
the displayed name there is a good future-proofing.

Thanks.
