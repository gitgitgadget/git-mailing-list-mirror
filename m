From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: support NNTP
Date: Thu, 25 Apr 2013 09:54:40 -0700
Message-ID: <7vppxi4kkv.fsf@alter.siamese.dyndns.org>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
	<7vobd5l277.fsf@alter.siamese.dyndns.org> <87txmw75bb.fsf@samsung.com>
	<7vip3bgax9.fsf@alter.siamese.dyndns.org> <87sj2fhzdx.fsf@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: l.stelmach@samsung.com (=?utf-8?Q?=C5=81ukasz?= Stelmach)
X-From: git-owner@vger.kernel.org Thu Apr 25 18:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVPRX-0000xg-DH
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 18:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312Ab3DYQyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 12:54:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756288Ab3DYQym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 12:54:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63DD619B11;
	Thu, 25 Apr 2013 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=i1pJ1sEGqeyp
	rTvQ7mJFfB1C5hc=; b=nk+NHCQ4TYJoBzQo3ZiGCfhVL/6DZb+my82wMOYtUMYq
	onKQPHVafmK+/GohoLHkH5as0TTXWmcmYov5Lp13i+8tkxUhOKO2BHhyEw0SdlV4
	ZCOw/pZZ4bzvUaFE1FeoSVa85K9sXzoQ+K/RhTclwq8k31WenrvN2foiafxgUgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pCaiVG
	4eq1g6fu8zY6Cn2zJ0jl7OhQXsNaso20dUTw3jwljjta+aGOaLipl16XDMRVRQov
	bhA+bczkvjzYPBfDs8wgXJBs7tk0g9Zngh2TcJdnwlqgb+cwUhcwZvYg1+xBKPwk
	YUFQlOywEzTNQRXbTII/OwJrfgiGMLsJ74OMw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58B8D19B10;
	Thu, 25 Apr 2013 16:54:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C51D019B0F;
	Thu, 25 Apr 2013 16:54:41 +0000 (UTC)
In-Reply-To: <87sj2fhzdx.fsf@samsung.com> (=?utf-8?Q?=22=C5=81ukasz?=
 Stelmach"'s message of
	"Thu, 25 Apr 2013 08:56:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2EA02AE-ADC8-11E2-8BE1-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222395>

l.stelmach@samsung.com (=C5=81ukasz Stelmach) writes:

> OK, I see. Good point. Where would you recommend me to put these modu=
les
> and how to name them? I mean I don't want to make to much mess here (=
;

I would not recommend you to do any of the above now.  As I said, the
open-coded if/elsif cascade version you posted is fine as a starting
point.  I'd prefer to see it made work correctly as advertised first
with documentation updates and tests.

A Perl guru might want to come and refactor the result once the code
solidifies, but that should be left as a separate series.
