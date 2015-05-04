From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unexpected behavior when git-adding files in a pre-commit hook then using "git commit -o"
Date: Mon, 04 May 2015 11:03:32 -0700
Message-ID: <xmqqvbg8rzij.fsf@gitster.dls.corp.google.com>
References: <463FC822-916F-4160-A1F2-B4AAEFF3A5B2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C3=ABl?= Fortin <fortinmike@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 20:03:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpKiS-0001LF-8k
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 20:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbbEDSDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2015 14:03:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751409AbbEDSDf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2015 14:03:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 865804B244;
	Mon,  4 May 2015 14:03:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JA0TcXFD70mp
	LdVE7+2H2Yx0qDM=; b=oGAdWCwRy70D3iXjVzmq+gOZYT7YHM88OkMAepvHtbkn
	F0QK7AIujeQU7UiA+g9s/7GqlkgmASunxQWLjAHMgNLG0aJFsLhXfLQSMGkmd++z
	0fFV24+2fYIn7tOSKIJeDUGSOTSJrIIy2JoqkeHybf5Bnpaz/Oc/Ue5xopmNAFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AIiktP
	Fp/Q80YJriQ9paeJT46OawKzwGZsr8iYBabCkmykyGr1w2mFvE9ZVvyOMLrpAc0d
	wEL/8pEVzeeCgd7ao15Ho0+J/9ShQvbbJl1TezQDuzfx+XdychvkNO9boHAYk2xc
	PuX9oSUzR/eCGIZ9dunLE0R56pkObNCiknZFM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EB0A4B243;
	Mon,  4 May 2015 14:03:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB2D44B242;
	Mon,  4 May 2015 14:03:33 -0400 (EDT)
In-Reply-To: <463FC822-916F-4160-A1F2-B4AAEFF3A5B2@gmail.com>
 (=?utf-8?Q?=22Micha=C3=ABl?=
	Fortin"'s message of "Mon, 4 May 2015 08:33:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E11B1A06-F287-11E4-8F8D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268339>

Micha=C3=ABl Fortin <fortinmike@gmail.com> writes:

> I=E2=80=99ve encountered unexpected behavior performing a git add fro=
m a
> pre-commit hook, followed by performing a commit using the =E2=80=9C-=
o=E2=80=9D
> flag,...

As pre-commit is a verification (and rejection) mechanism, not a
mechanism to tweak what is to be commited, it is totally expected
that its behaviour is unspecified when you modify anything in it.

I think I saw a similar confusion posted to the list once in the
past few years.  Perhaps we would need a documentation patch to
clarify this.

Thanks.
