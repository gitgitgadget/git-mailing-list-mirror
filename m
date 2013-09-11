From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Wed, 11 Sep 2013 11:45:06 -0700
Message-ID: <xmqqvc27rydp.fsf@gitster.dls.corp.google.com>
References: <cover.1378840318.git.john@keeping.me.uk>
	<c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
	<52300838.5040703@kdbg.org> <20130911082042.GR2582@serenity.lan>
	<CACsJy8BgEM3eEDo8wOgkqYTL1fkh9azZNqbogxBubp9g5KRNbQ@mail.gmail.com>
	<xmqqwqmnthfh.fsf@gitster.dls.corp.google.com>
	<20130911172705.GV2582@serenity.lan>
	<xmqq8uz3tece.fsf@gitster.dls.corp.google.com>
	<20130911182233.GW2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJpPu-0007jY-El
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591Ab3IKSp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:45:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40530 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989Ab3IKSpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:45:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB3D141C34;
	Wed, 11 Sep 2013 18:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wFyWWvVxdZouCeeDUkSSFpwWqCk=; b=uPQoEQ
	lsdUh3ityoU80nOqJOllMWo0qIuOsNFlJFciRJ7MQ/est2tRkI/OcYeJsghApjrj
	gOgEDdM5r/b80zM2NBLTrJOkxPC7mMdAmiq2SyVNHmoTyOvuVrlcu5StjaAqHYOq
	qVIuxgr/oTkI3rVrRqi4YUiEKbge2T2hMRAf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FYtGuRYOTet8JxutA894r1UParBLpn6n
	G4MxC0AB2dQnW+FCINmORd1zDDHWO9GK8Ni8G3fsWV56DFVEExhPLlcwJTZodOiy
	zlpHo4mT++92NvKLiT9MJo9HYgaDzHInKT2U99Vf8gbffFMg4GbfYQe7V5XRg0mb
	ULEfYsPRizE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9436C41C17;
	Wed, 11 Sep 2013 18:45:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4A1441BEB;
	Wed, 11 Sep 2013 18:45:10 +0000 (UTC)
In-Reply-To: <20130911182233.GW2582@serenity.lan> (John Keeping's message of
	"Wed, 11 Sep 2013 19:22:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4B95512A-1B12-11E3-8F5B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234597>

John Keeping <john@keeping.me.uk> writes:

> However, I think we do do a read_cache when using "reset --soft" since
> we go through builtin/reset.c::die_if_unmerged_cache() which dies if
> read_cache fails.  So I don't think we are losing anything by moving
> this check earlier.

Thanks.
