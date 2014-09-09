From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty-format: add append line-feed format specifier
Date: Tue, 09 Sep 2014 12:37:48 -0700
Message-ID: <xmqqegvkk2k3.fsf@gitster.dls.corp.google.com>
References: <540F426E.6080908@exec64.co.uk>
	<xmqqmwa8k3lg.fsf@gitster.dls.corp.google.com>
	<540F554C.5010301@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 09 21:38:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRREm-0006V1-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 21:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbaIIThx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 15:37:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62447 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaIIThv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 15:37:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 041C338349;
	Tue,  9 Sep 2014 15:37:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SMwQDQX+HEaTFkD7WwdUNhwm1rI=; b=w3yJjh
	a2BJC4TfD1ecD74w64XWZnD4iWEMk6ri83MzzJouVazumD9o770IlKRZMBWdbh8a
	c8OyZ9os2D57RYXDrIEx/MAAUCr/WmZpVpLLQrS1vBsVlv0UzT85BU++YuJsGG+r
	a2fvnfSpQ/qwR2DSFgxrkICT9J15Nk9RZMLjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YU5mcPx8ZzEbo+ncvoy/+Oa66sSYwB0j
	dorhHV7tPLjfBLcq0YChmEhcUumofR46hG2LH5Cjcf5Whsb/6kilha3yCn6d9aGy
	+QVMiVxxiETMJ/zIAKqZbN4yoRIWlsCS/XZVzablVAzmizDyHiZqnSDGmNwB+9JS
	/ZB0AnSf0Ck=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF3D038348;
	Tue,  9 Sep 2014 15:37:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 72FFE38347;
	Tue,  9 Sep 2014 15:37:50 -0400 (EDT)
In-Reply-To: <540F554C.5010301@exec64.co.uk> (Harry Jeffery's message of "Tue,
	09 Sep 2014 20:30:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C8C8607E-3858-11E4-AF4E-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256707>

Harry Jeffery <harry@exec64.co.uk> writes:

> On 09/09/14 20:15, Junio C Hamano wrote:
>> Is this different from "%n%-d"?
>>
>
> Yes. "%n%-d" will place the newline before the expansion, not after.

Maybe "%[-+ ]" needs to be rethought, instead of making things worse
by turning it into "%[-_+ ]", as the next person who comes would
want to add space after the expansion and would need to find yet
another letter like you did with '_'.
