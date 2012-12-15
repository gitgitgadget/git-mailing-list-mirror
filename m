From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Make lock local to fetch_pack
Date: Sat, 15 Dec 2012 10:40:44 -0800
Message-ID: <7vtxrnrwer.fsf@alter.siamese.dyndns.org>
References: <1355510300-31541-1-git-send-email-kraai@ftbfs.org>
 <1355510300-31541-2-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:41:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjwfe-0002Sa-Dq
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab2LOSkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:40:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab2LOSkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:40:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2D5CA12F;
	Sat, 15 Dec 2012 13:40:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=65FFpS//pyhZdOP5PMM2VMT+zr0=; b=Yjn/UG
	dR+u3eG17VXWDCfdMDw+Ai+6nfaMohO+DvcFx9RrZlePj8b95JSVlq0MYZCHwDmy
	boULPi3O7X1WtXQ0qTUCtg84FIVPUD/E4RufeTCYTOgpJhv/sS770MXMpWJSY/Ba
	k0xlpoJpFFMXVG0rK9iLm88/KdzQv9dvhhJN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EmMgVQLgzdYwEZpSWcOX61MXCoRCwv00
	5SLaJVYo4Ngrz+yjRiaMhlDHcu+H1f7wtInTiSj7W6JN3gE4P+sEFfveL1fgm2xC
	s/6E5waLHnT1/KJ0ngFz+EIl3nagV+BG4v7qYOEj7k0jBfVUrTr56ikWkiHuSv67
	HRt5Rott3Tc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B05D8A12E;
	Sat, 15 Dec 2012 13:40:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 286BCA12B; Sat, 15 Dec 2012
 13:40:46 -0500 (EST)
In-Reply-To: <1355510300-31541-2-git-send-email-kraai@ftbfs.org> (Matt
 Kraai's message of "Fri, 14 Dec 2012 10:38:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0409E1A-46E6-11E2-AFE4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211557>

Matt Kraai <kraai@ftbfs.org> writes:

> From: Matt Kraai <matt.kraai@amo.abbott.com>
>
> lock is only used by fetch_pack, so move it into that function.
>
> Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
> ---
>  fetch-pack.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Eh, did you base your patch on something older than 2d4177c (Make
fetch-pack a builtin with an internal API, 2007-09-10)???
