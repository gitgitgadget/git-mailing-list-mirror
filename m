From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] path.c: implement xdg_config_home()
Date: Tue, 14 Apr 2015 15:30:43 -0700
Message-ID: <xmqqd2361gx8.fsf@gitster.dls.corp.google.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
	<e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
	<xmqqzj6a1m3c.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaO_1QMMTY0ni9k3hrkrt_PhqRDRzXkhZEiYuJ0EsE9Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 00:30:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi9M3-0006h8-29
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 00:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbbDNWar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 18:30:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753787AbbDNWap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 18:30:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEC0349286;
	Tue, 14 Apr 2015 18:30:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UOZTi3MAiwBESjC3GHah2p+l+hM=; b=ENic29
	SDCtIVvOD93IibMd/xghgUct3KYPAaOUyeFQulOLRSvMPcH/93ix6p474n5Bap5U
	Vnd29ezF013QGsHAHghzE7Swd/IRUOMbdK/GFQ/uvWq5/GKeqRmmHVWu4Uym/sEy
	9H3MnLa/KJf2KT7CTts8bB5ocKiHBy95bcW3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QPkVTVgRvf2Acd04izFnNs6KS8MjMBmH
	fQyPuTwbRokE1T9PKoneIdktrRa0iadwSygVsUI0J9vS8zKYUy1SXQE/rTJwPTZN
	RFLZYBbOhZJtAuP4dBv+MO3+Xj72qzIVug/s+I5PAeNEkeyBZJ5p9XMx4rIctV7E
	0tvcZLXdtjE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6E7149285;
	Tue, 14 Apr 2015 18:30:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48CC949284;
	Tue, 14 Apr 2015 18:30:44 -0400 (EDT)
In-Reply-To: <CAGZ79kaO_1QMMTY0ni9k3hrkrt_PhqRDRzXkhZEiYuJ0EsE9Tw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 14 Apr 2015 15:28:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3B5CD8E-E2F5-11E4-A688-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267172>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Apr 14, 2015 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> It is OK to omit the name in the extern declaration here.
>
> It is OK, but I think this is bad practice.

Take a special note on the word "here", meaning "in this particular
case."  It is perfectly fine when the meaning of the parameter is
clear from its type.

I was assuming that our developers have common sense to disambiguate
ambiguous cases, of course ;-)
