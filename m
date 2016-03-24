From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: implemented new mergetool file for ExamDiff
Date: Thu, 24 Mar 2016 08:43:58 -0700
Message-ID: <xmqq60wbc24h.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoulex0b.fsf@gitster.mtv.corp.google.com>
	<1458773745-783-1-git-send-email-jacob.nisnevich@gmail.com>
	<1458773745-783-2-git-send-email-jacob.nisnevich@gmail.com>
	<20160324074404.GA30574@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Nisnevich <jacob.nisnevich@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 16:44:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj7Qf-0007ah-Sh
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 16:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbcCXPoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 11:44:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751359AbcCXPoC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 11:44:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C8AF4A6AA;
	Thu, 24 Mar 2016 11:44:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OjHYHNwOgD5ygZARoRbG86uDfe4=; b=tACk8J
	SSWWAeY1n4Mo6xyuoCWVU3LielNVl2j/HC69nkFQkb0gEkAou/i3e2NWicV0ThJv
	kPglo/d0QuPwOwId5rm82OLRscJXxcA+ul6KJaY1bSz0850vAOjYre9Vz694HPom
	ysGx0Sj/uefaezdufg3vAojKWR2wp6S9qYQRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ul+DRNCxOZziCvmoIkP9/jFH6CWiAiGF
	d93W4/Knito/ORgfb08uFdeq77osjikpWuWvKZ4ID98EZclgck0byiolsN6cD/HL
	DP1v7Y92vGv7hzqLIZKJq0dwtR2SzxJr82e8SUn9gORQ6dvyADEVuFDaIapzbYVS
	LoW1QrEjB2A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EFAD4A6A8;
	Thu, 24 Mar 2016 11:44:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 90E794A6A6;
	Thu, 24 Mar 2016 11:43:59 -0400 (EDT)
In-Reply-To: <20160324074404.GA30574@gmail.com> (David Aguilar's message of
	"Thu, 24 Mar 2016 00:44:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39E22F5E-F1D7-11E5-A95A-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289752>

David Aguilar <davvid@gmail.com> writes:

> We can probably do this without introducing a new file.  One
> possible home for this is with the rest of the "default"
> definitions of the functions in git-mergetool--lib.sh's
> setup_tool() function.
>
> But, that hints that we expect tools to override it.
>
> A better place would be as a normal function inside
> git-mergetool--lib.sh, which more strongly hints that we do not
> expect tools to override mergetool_find_win32_cmd().

Thanks for a clearly described set of rules that people can easily
follow.
