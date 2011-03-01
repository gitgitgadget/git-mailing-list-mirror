From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Tue, 01 Mar 2011 12:00:57 -0800
Message-ID: <7v4o7mehl2.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com> <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com> <7vsjv6evy4.fsf@alter.siamese.dyndns.org> <4D6D0A51.9030701@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:01:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVky-00058a-Tq
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180Ab1CAUBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 15:01:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721Ab1CAUBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 15:01:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF09C38EB;
	Tue,  1 Mar 2011 15:02:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a2n8wBAoFks1afcEsKd3+5oe8fA=; b=jSSnDm
	DR6iQXiaYN1hDYQrEwFq+3DCE2+yp7hRahVKwTuQ9gcBIbIfLXvDUYzp11/FCFg5
	orj0xDHfONUoeYMXIThHqpdLpD5IUa4EYXTW1tL4uOsd41oQrV0Lu+kCKPCh5Cxq
	ojJMJmTE0SDQJyOgNeg2GATFPiutFOOS82VZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q4Of7e3U4xcR0lZN8xiliZRHPCvvSteR
	QapdTDQE+YJTF+rSQjXVpuQxamdsAsaKpQu5tn3s95aI8a+OywQYODWgh6AkmyH/
	6AdSmY4LLtdeyuT2yjClA8E9FqHDqlvun0WzPTCrt//qkhlP/rxQBV4rG5xBjn3i
	ahQ1DRXzAhI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D97538EA;
	Tue,  1 Mar 2011 15:02:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5BB4A38E9; Tue,  1 Mar 2011
 15:02:20 -0500 (EST)
In-Reply-To: <4D6D0A51.9030701@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue\, 01 Mar 2011 16\:01\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3563C80-443E-11E0-A3AC-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168250>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Also, e.g.,
>
> git grep -e frotz "*.c" ":*.h"
>
> will look in all C files in the cwd and and all headers everywhere.

Ah, that is cute.  I don't know if the syntax is acceptable to the general
public, but I do see the beauty in that approach of marking individual
pathspec as "(the rest is) from root".

Nice.
