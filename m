From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Sun, 01 Nov 2015 10:31:44 -0800
Message-ID: <xmqqlhahh8q7.fsf@gitster.mtv.corp.google.com>
References: <CA+izobsBmYHHepYka795K2VnVLYBmN2tFqEyzSweMoS9gvuRVw@mail.gmail.com>
	<1446243122-21464-1-git-send-email-apahlevan@ieee.org>
	<xmqqa8r0j8tu.fsf@gitster.mtv.corp.google.com>
	<CA+izobuGFGhho9X6xGdXMskay3UH6-FuzriNA7=mkveFjo0SBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: Atousa Duprat <atousa.p@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 19:31:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsxPy-0006RI-TS
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 19:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbbKASbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 13:31:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752408AbbKASbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 13:31:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 48DBF274EC;
	Sun,  1 Nov 2015 13:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=INHVakq266KueWmTQRf3NtR0+Eo=; b=J5wOYG
	2tI88lwVuSyMFLISfpE6P8fwjHBOIcf2gFchGCanOOc+LyE4ncEFEdMOEPij5qQj
	BFVN7sBGT2bJIkyESCpbI8bVLdPgDcWdMwD9cUSCVodNfuV6z73AghxLraP/tNbf
	CR+6sShp9yVs8GPhjFRzKKWhKrgJaxcreT66E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CCJ60MDJTzs4q9jpczemF0p/vBra0kV5
	5wOYPw9nAGMitU2BFzSxt1oLe8o5XEoWkRE9RTcSQYB3ktZE1cjwqi+gGoeCWHhE
	zvBtqrcfTxCrsEez1Ivm+D4MwTx99vw028ZjDS3wyWsYfEWNjXrTOabjv2O5P4hh
	fLa0rINnWgQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41A09274EB;
	Sun,  1 Nov 2015 13:31:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AE09F274EA;
	Sun,  1 Nov 2015 13:31:45 -0500 (EST)
In-Reply-To: <CA+izobuGFGhho9X6xGdXMskay3UH6-FuzriNA7=mkveFjo0SBA@mail.gmail.com>
	(Atousa Duprat's message of "Sat, 31 Oct 2015 23:41:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CE464FC2-80C6-11E5-9B4C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280649>

Atousa Duprat <atousa.p@gmail.com> writes:

> Indeed, the declaration needs a const void *; but I need to advance by
> a specific number of bytes in each iteration of the loop.  Hence the
> cast.

Ah, of course you are right.  Silly me.

Thanks.
