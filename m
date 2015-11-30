From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Mon, 30 Nov 2015 11:05:42 -0800
Message-ID: <xmqq610j8fzt.fsf@gitster.mtv.corp.google.com>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
	<CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
	<CACsJy8DhAfu7J=WpPAp8HYGLuFQC5+DZyZj6Hs6vruEJEeVKig@mail.gmail.com>
	<CAP8UFD2V3nbY2-abW6cGDtB2PR9Q+sN+d0RgTVJORCPg6TPMcQ@mail.gmail.com>
	<CACsJy8CNRbvsDY+ucFZGcO4+tE9Ud_QNr1k4D=+utawSCrc+Sg@mail.gmail.com>
	<CACBZZX4jJ_b-5sbor6YibXGASeOa0gx8nEBiv8=54yoHfWL8Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:05:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3Tln-0003Cy-1K
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbbK3TFr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2015 14:05:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751771AbbK3TFq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2015 14:05:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D06F2ED3A;
	Mon, 30 Nov 2015 14:05:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FGyk6dZL8+TJ
	Wof1CfAn3sYcbsM=; b=oIB5oECTUFQBK4J3Eudy5lPwD3Px5kksDWRYibDJPgMd
	s4VF5LflZi7SCSYhCBOBlSCfUu750ygf9+D90USh7zulEx0A272g8vNKDFKC6srP
	KMJRTOHI9P4jEzWw0QBOqw+kjfZZHUIsMOoEaSzK2L9mi2en+DN/vKZnTv1JNV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MneVUY
	DxVlN40nw2D99hZuAoaM6syaCUoSu5BVyAVZvbKA0dHNngudHsRFY/BkD0VboXFo
	1VhopH6QDW8uGNjW6JYPF6JN/h2b45Cm1FtFEswyQo+d9Gb17oUq/+7rD6Tl0pos
	pdT3ojXQX6ApoyHJFKMsZUPTDqIRo1OuerSDk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 528752ED37;
	Mon, 30 Nov 2015 14:05:45 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B35DC2ED34;
	Mon, 30 Nov 2015 14:05:44 -0500 (EST)
In-Reply-To: <CACBZZX4jJ_b-5sbor6YibXGASeOa0gx8nEBiv8=54yoHfWL8Fw@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 27 Nov
 2015 02:35:46
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B9B848E-9795-11E5-AE94-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281812>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Maybe I'm missing some really common breakage with st_mtime on some
> system, but having a feature the user explicitly enables turn itself
> off and doing FS-testing that takes 10 seconds when it's enabled seem=
s
> like the wrong default to me.
>
> We don't do it with core.fileMode, core.ignorecase or core.trustctime
> or core.symlinks. Do we really need to be treating this differently?

I share the exact thought.  I was looking the other way when
untracked-cache was done originally ;-), and I would also want to
know the answers to the above questions.

Thanks.
