From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header dependencies
Date: Tue, 26 Aug 2014 09:54:19 -0700
Message-ID: <xmqqiolfjio4.fsf@gitster.dls.corp.google.com>
References: <20140822042716.GE27992@peff.net>
	<20140822043303.GB18192@peff.net> <20140825194641.GS20185@google.com>
	<20140825200042.GJ30953@peff.net> <20140825204516.GT20185@google.com>
	<xmqqppfol1sx.fsf@gitster.dls.corp.google.com>
	<20140825212705.GU20185@google.com>
	<xmqq4mx0kyrx.fsf@gitster.dls.corp.google.com>
	<20140826123427.GD29180@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 18:54:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMK0y-00077i-5D
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 18:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbaHZQyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 12:54:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57418 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbaHZQya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 12:54:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD1A532834;
	Tue, 26 Aug 2014 12:54:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WDcy/s8nL9zLiLEKtpKfmq8OeY8=; b=QXLmYZ
	4jmrIN/OAm5VeLP+gcZIIKn54zGEo127MVCmwCQ5CCcloM3JHTri7DsQngfTkOhN
	5q8AjFGMQFwZMt3lm1BcBs2dZtnOTkVcRG8v3CkGiGL3ZiSts7DjY0d/3RUd2FEK
	pSoOIW4O59R3xiF1RqBd7GTKNKGRFOlbBBlYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GVY6FAtAQ5VTEF3mQ+6hORk+zEfHfzKO
	SkymFo+GlnLImlhU1EyuBkhj0x+Mg5UArpVmM9dA+PXyz5S+k6qcaIjN0dAqU0Zo
	JWzdJuqHzVX3JMJhfcGnxiMOww0FULPcy4Nz22CJxERqHSgpQhF22s/IatIMCEwW
	xoLdJUHQcsY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C351032833;
	Tue, 26 Aug 2014 12:54:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A18483282E;
	Tue, 26 Aug 2014 12:54:21 -0400 (EDT)
In-Reply-To: <20140826123427.GD29180@peff.net> (Jeff King's message of "Tue,
	26 Aug 2014 08:34:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A07EAE92-2D41-11E4-8B78-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255918>

Jeff King <peff@peff.net> writes:

>> Actually as you are not excluding CVS, RCS, etc., and using ??* as
>> the starting point will exclude .git, .hg, etc. at the top, I think
>> we can shorten it even further and say
>> 
>> 	find ??* -name Documentation -prune -o -name \*.h
>> 
>> or something.
>
> I had originally considered starting with "find *", but I was worried
> about shell globbing overflowing command-line limits here. "echo *" on a
> built tree is about 12K.

OK.  What I queued is still your original which is the most
conservative among various "fun" alternatives we have seen so far on
this thread, so we should be good ;-)

Thanks.
