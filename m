From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Tue, 10 May 2016 00:14:18 -0700
Message-ID: <xmqq7ff2s7ud.fsf@gitster.mtv.corp.google.com>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
	<cover.1462774709.git.johannes.schindelin@gmx.de>
	<4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
	<C5C883AD-E684-4D2F-811B-A479DE5E41AB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 09:14:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01sA-0001m6-9X
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 09:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbcEJHOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 03:14:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751055AbcEJHOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 03:14:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AE9314C74;
	Tue, 10 May 2016 03:14:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mO6QbdnTqsxt1SOlCyvX0F02N4o=; b=aSlf5r
	7g6LcCw0dQJrzBPoHSNNGq3SdBj6sCahPQKTcVGuAQESeno5xowFcB4ABHtQQo4w
	Kz2X/EjuU088eWeQEARoEOQhHWeaWZ6j1B8L/9XWkikJbbIPuvmBi/wZJIO47AwX
	20IKeuh5sb2iyw0DwLrVfvzEgLSgN3FS5Yz3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v0SDTk6+Pxc2NzBZ5oZn2L8/meN4m09g
	dai8JT07Zv8tSGeasNZw6FaBY3lMKINg8fHokTvK9hOb/dwN4fXap4VCbysSTau3
	i3xkm4YRaejMkqM4Aga750IdvU458nUA7n10S0DiekfSK6ZD4KqFzWxdasvgh8NV
	zqNe2RWsGKU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 82DE514C73;
	Tue, 10 May 2016 03:14:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0521F14C71;
	Tue, 10 May 2016 03:14:19 -0400 (EDT)
In-Reply-To: <C5C883AD-E684-4D2F-811B-A479DE5E41AB@gmail.com> (Lars
	Schneider's message of "Tue, 10 May 2016 08:37:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D07467C2-167E-11E6-A31E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294109>

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 09 May 2016, at 08:18, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
>> 
>> Lars Schneider noticed that the configuration introduced to test the extra
>> HTTP headers cannot be used with Apache 2.2 (which is still actively
>> maintained, as pointed out by Junio Hamano).
>> 
>> To let the tests pass with Apache 2.2 again, let's substitute the
>> offending <RequireAll> and `expr` by using old school RewriteCond
>> statements.
>
> All Apache 2.2 tests run nicely on Travis CI with Ubuntu and OSX using
> this patch series:
> https://travis-ci.org/larsxschneider/git/builds/128955548
>
> Thanks,
> Lars

Thanks for a report.
