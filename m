From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Rewrite `git_config()` using config-set API
Date: Wed, 23 Jul 2014 14:44:57 -0700
Message-ID: <xmqqiomnda1y.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:45:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA4LX-0001Jn-V8
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933521AbaGWVpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 17:45:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63788 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933437AbaGWVpF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 17:45:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0C4992B428;
	Wed, 23 Jul 2014 17:45:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SONp8BXcXelVNsu8qW8LAcoD0cA=; b=SSPH/7
	VeS91PHqbW1qZqC66af5iQvUhwgMEgWVq1xOpDadX6XbucyJtG0HPQqTHDUrDTOZ
	74V9So51H3kwaISCDg2mr3hoEoLdcc3BIw4K48xPGTdMCd4FTDs2tpnF9+kd+gNa
	RTGMo7vmneqyrX63j22+WKM7s/siLRSZy0R0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pETXNnbebHwOKn5/Px+f5fSN5jJepvpS
	gggt9aZgNgrbg6hRd8Qz6jdS+tDk2WLntbSgy+93EyxAAAmtoqTFEzrd2BH071CZ
	TVn7+K3zLfDlKqV74KwOBjQH2WsC3Ve9uLg0K+yCPLxqh075gCxqTCYzcsQ1N1D6
	jx8rhHm7DEs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3B962B427;
	Wed, 23 Jul 2014 17:45:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B0A462B415;
	Wed, 23 Jul 2014 17:44:58 -0400 (EDT)
In-Reply-To: <1406140978-9472-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 23 Jul 2014 11:42:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 97BF936A-12B2-11E4-87B9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254129>

Tanay Abhra <tanayabh@gmail.com> writes:

> This series builds on the top of 5def4132 (ta/config-set) in pu or topic[1]
> in the mailing list with name "git config cache & special querying API utilizing
> the cache".
>
> This series aims to do these three things,
>
> * Use the config-set API to rewrite git_config().
>
> * Solve any legacy bugs in the previous system while at it.
>
> * To be feature complete compared to the previous git_config() implementation,
>   which I think it is now. (added the line number and file name info just for
>   completeness)

Sounds promising.

Are you done with the original series, or do you still want to fix
the const-ness issue with the string pointer before working on
follow-up topics like this one?
