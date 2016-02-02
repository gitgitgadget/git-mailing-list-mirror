From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -g bizarre behaviour
Date: Tue, 02 Feb 2016 12:42:20 -0800
Message-ID: <xmqqa8nisv2r.fsf@gitster.mtv.corp.google.com>
References: <1454241144.2822.7.camel@kaarsemaker.net>
	<xmqqegcwt32j.fsf@gitster.mtv.corp.google.com>
	<1454401738.32711.7.camel@kaarsemaker.net>
	<xmqqsi1asyai.fsf@gitster.mtv.corp.google.com>
	<1454444532.2713.1.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:42:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQhmU-0001jl-CA
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 21:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934125AbcBBUm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 15:42:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934122AbcBBUmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 15:42:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9DFAA404E2;
	Tue,  2 Feb 2016 15:42:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GT28yK6Uwgu0/sYm33pGPqjAdgc=; b=WPg20V
	D1/ykM8UpvbTvlbUQU5RBcDNIdBhEIJF5bXNxOmngjbiCJuUBIFAbX+TtMrfcxcQ
	pRQ09qkAC/9meO64dBpMPy3b5ipIHJYpfMHuArea/b62Td+TAb2IQR5X1L4XXM/5
	Mkzs/EuDw3VIWx+79VZxiNainRXEmMJzSQRg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bG1BOh4uK25bgyEtrKEr6cHI6pdtuhSX
	IwyFMkvSasY4IPdMoclXzRqQ/OI1nkb1cCL/AtsuX0qAkH3Ecl0sub6NIEiUYIE7
	sI/e5SiM799KW+5NsfjBNBsJOUFaMtstLG+8i4YqkKNvau/pTLvTqutT8JY/Av1i
	0im5O1FcdXw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 967F8404E1;
	Tue,  2 Feb 2016 15:42:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 178C6404DF;
	Tue,  2 Feb 2016 15:42:22 -0500 (EST)
In-Reply-To: <1454444532.2713.1.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Tue, 02 Feb 2016 21:22:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 758A33EC-C9ED-11E5-8B66-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285305>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

>> > $ git (log -g|reflog) v2.7.0
>> > From the bizarre behaviour above to a silent noop.
>
> As I demonstrated in the text that you cut: that is not true.
> git log -g v2.7.0 and git reflog v2.7.0 are *not* silent, but buggy. I
> would like to make them silent.

Ah, sorry, I totally misread your "bizarre".  Yes, "log -g" that
walks the history not the reflog is "bizarre" and wrong, which we
already agreed in the previous exchange.  A fixed behaviour that
walks only the reflog entries should become a "silent noop".
