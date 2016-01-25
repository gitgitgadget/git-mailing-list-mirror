From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/2] Port `git submodule init` from shell to C
Date: Mon, 25 Jan 2016 14:46:55 -0800
Message-ID: <xmqqtwm1e0ps.fsf@gitster.mtv.corp.google.com>
References: <xmqqoacdtfh3.fsf@gitster.mtv.corp.google.com>
	<1453505536-14895-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j6t@kdbg.org, sunshine@sunshineco.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 23:47:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNpuY-0008ON-Bp
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 23:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbcAYWq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 17:46:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932370AbcAYWq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 17:46:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4461A3F84B;
	Mon, 25 Jan 2016 17:46:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IISr4oK7C4MRZiZNhIIOxBh1vi8=; b=Oov2M5
	NwbHmoBv1H7VRdJOSJeiLagAwlfY5bK6wreyc0r1Y372nZiKwxVH3lUjaXu5kTrg
	Oo8reaQh9lAj4Rc0Y95GaC4pp/cv4RYvJA4E+FQrYhNiUdD0rZuJ+15PjWAGRCoB
	vlwllt+7U4CVSTDsiPRed0Uub1Qx6dbMYZT1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LJOp3WgJWhPvklH/LKLzyLAaj1IVeGO/
	of5l/iyNmDQLbxsjaZS2131mtlRZ8738BUYjYDojw3t28g/yRvFx1W3xIzRNZY/C
	iZa7NnjZ8/aqBaGAtkjEwXzKo9CB4IXPv+Cvtbt/+KWDnbjjY3G/Vw6vwGEfAMra
	O3ckjANApnI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CA553F84A;
	Mon, 25 Jan 2016 17:46:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A631E3F848;
	Mon, 25 Jan 2016 17:46:56 -0500 (EST)
In-Reply-To: <1453505536-14895-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 22 Jan 2016 15:32:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8979C432-C3B5-11E5-A673-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284765>

Stefan Beller <sbeller@google.com> writes:

> This applies on top of sb/submodule-parallel-update, replacing
> sb/submodule-init.
>
> Fixes:
>
>  * a more faithful conversion by staying on stdout (We switch to stderr later
>    in another series)
>  * use the existing find_last_dir_sep instead of reinventing the wheel.
>
> Stefan Beller (2):
>   submodule: port resolve_relative_url from shell to C
>   submodule: port init from shell to C

Thanks, will replace.
