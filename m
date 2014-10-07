From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously set variables
Date: Tue, 07 Oct 2014 09:44:29 -0700
Message-ID: <xmqq1tqjkexe.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<xmqqvbo2meg5.fsf@gitster.dls.corp.google.com>
	<5433CBC3.5010202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 18:44:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbXsL-0003EF-0U
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 18:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbaJGQod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Oct 2014 12:44:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63426 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751300AbaJGQoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2014 12:44:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 946F114319;
	Tue,  7 Oct 2014 12:44:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rMlcL9lxHFFb
	UwuEap+acG3242Q=; b=yQt0JpO/hrqjXNGJOlgbcf6S4mt5zKlEF5Lt4/jvORl/
	zQYHcpY3gdaTF4Ni2yMWxEY+LNxtwy+MMoVuPzvCyaQIblXPsNLX1PACelpZODEh
	T7PleQZKrX7t+DEsb4cM108lTXcPdU7BDroSd4cLwh3dwDWx4FrP0AS0erN1Eo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h0aMID
	ArslUvOaF3kByX80w4hDJ6EMPmoELpwSp0BozQNFRZozeo/JGS6F4MEvwu5i6iUE
	IhHtkRzKUCU1MbUR8frKnheXw52kdF0tKgQJobeoQTjqzjg37o08AuSM/sJP4OJG
	rF6xe7l6Q4kuVL783zY4Cx0lyXNo1QuXZ5/P4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AB9B14317;
	Tue,  7 Oct 2014 12:44:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3A5114315;
	Tue,  7 Oct 2014 12:44:30 -0400 (EDT)
In-Reply-To: <5433CBC3.5010202@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Tue,
	07 Oct 2014 13:17:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 35D20852-4E41-11E4-BA17-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257931>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>>   - "[config] safe =3D section.variable" will list variables that ca=
n
>>     be included with the config.safeInclude mechanism.  Any variable
>>     that is not marked as config.safe that appears in the file
>>     included by the config.safeInclude mechanism will be ignored.
>
> Why user must know which variables are safe, why it cannot be left to
> Git to know which configuration variables can call external scripts?

That's a fallback to let them take responsibility for variables we
do not mark as "safe"; and having that fallback mechanism lets us
keep the set of variables we by default mark as safe to the absolute
minimum.
