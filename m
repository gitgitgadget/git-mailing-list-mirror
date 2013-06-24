From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 06/16] git-clean: refactor git-clean into two phases
Date: Mon, 24 Jun 2013 12:22:15 -0700
Message-ID: <7v4ncn8gbc.fsf@alter.siamese.dyndns.org>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<37345475f7166717c7e3cbfab7e179605dafabdd.1372087065.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 21:22:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrCLH-0005gw-2P
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab3FXTWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 15:22:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46530 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054Ab3FXTWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 15:22:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02A2A2B93D;
	Mon, 24 Jun 2013 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8327EchwJ/144/Mz+T4HCt6MWmA=; b=bt+KmY
	G5Ml/VZY9shHwgjD4KsDK3s2nhAZMwVKvfP2H6tuHXBRFt424GDxTj9C39KXlzsF
	1DViJHm/lLNxz/K2qjoz6E7GRC7QDbiaLisPrVJwdEDSGe09zM0eHbtpjB4okaOn
	N6JNevJ5x/MeCHMgMV8dDTyzk0dpxNMqh3vN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K9TdL4kFrqv52wxpyEEZpJoSIU6fuFyy
	/BSp3zgsKVcTe3N3Sc7akwMufpf7joHzoXP1rcUD/WNdT8iOZdjeAEcE/dwU5Wdx
	bna6qsLw5n4mTOUkugPwHSnB2lMf50tIpBJZEQmLxUD9xTiVkUedwpa5hZB5lNJb
	LPGitpg0wmU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB7892B93B;
	Mon, 24 Jun 2013 19:22:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D1992B937;
	Mon, 24 Jun 2013 19:22:17 +0000 (UTC)
In-Reply-To: <37345475f7166717c7e3cbfab7e179605dafabdd.1372087065.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Mon, 24 Jun 2013 23:21:30 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62126CD2-DD03-11E2-AF40-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228903>

Jiang Xin <worldhello.net@gmail.com> writes:

> Before introducing interactive git-clean, refactor git-clean operations
> into two phases:
>
>  * hold cleaning items in del_list,
>  * and remove them in a separate loop at the end.
>
> We will introduce interactive git-clean between the two phases. The
> interactive git-clean will show what would be done and must confirm
> before do real cleaning.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Looks sensible.
