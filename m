From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge --abort deletes unstaged files
Date: Mon, 15 Sep 2014 12:25:25 -0700
Message-ID: <xmqq61go65zu.fsf@gitster.dls.corp.google.com>
References: <04af01cfd0fb$d077e200$7167a600$@webkr.de>
	<87k354x0qt.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?QW5kcsOpIEjDpG5zZWw=?= <andre@webkr.de>,
	<git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:25:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbu1-00084c-U5
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 21:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbaIOTZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2014 15:25:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50767 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754187AbaIOTZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2014 15:25:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 100A53A477;
	Mon, 15 Sep 2014 15:25:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nffLWtYPiXtF
	ksSb3+WpDDqbvd8=; b=ojlXuKhUU6w3eM+wUlQMrYkkZMXRXTaPxlbguNkpln0O
	hF2+6EqBPzG7wAHNaRNSibSohzOvOBI71fY3e74MJ47XfvFjSmEqezBvVyii44XL
	kXC3xk5FIJHbLh9gD1zZzbZngWBPf7XpyJw/MF6MWIgIOp0akX7cP6Az95HCEws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fEVXYD
	KEOHQnvIjMufas2mVYOGStUYjc/VxkkfymQSvBhjKjCM15BkKK3cwhyQN/EkhTqs
	57g6DjoI8gZ4FkBb1OAT7k+SNLXA4uUNpN+ceSSZWFhICAQ4dP19jVOVw5S830ix
	B7mTO42hZQ/Ck4YsWpb4p7VOj+pvsQVOxDwks=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA2A43A474;
	Mon, 15 Sep 2014 15:25:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 151B83A46D;
	Mon, 15 Sep 2014 15:25:27 -0400 (EDT)
In-Reply-To: <87k354x0qt.fsf@igel.home> (Andreas Schwab's message of "Mon, 15
	Sep 2014 19:16:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0C2B360C-3D0E-11E4-9649-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257076>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Andr=C3=A9 H=C3=A4nsel <andre@webkr.de> writes:
>
>> I ran git merge to merge a branch. There were some conflicted files.
>> Although they were automatically resolved by git rerere, I still had=
 to add
>> them.
>
> If you want them to be added automatically, set rerere.autoupdate=3Dt=
rue.

I would have to caution against doing so without thinking, though.
In other words, it is OK if you are Andreas who knows what he is
doing, but it is not a very good advice to give to random newbies.

"rerere" will apply whatever matching previous resolution, which may
hopefully be the correct resolution this time too, but it is a good
habit to get into to double check if such a merely textual side-port
of previous resolution is really applicable to the current conflict.
