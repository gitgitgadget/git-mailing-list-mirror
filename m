From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/11] builtin/pack-objects.c: change check_pbase_path() to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 11:03:19 -0800
Message-ID: <xmqqfvn3ukjs.fsf@gitster.dls.corp.google.com>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
	<53105995.3010001@yandex.ru>
	<CACsJy8C2h13JFqh=CKvR=3TByHkxWCNR-XhK-WxA+DOE3GmvAQ@mail.gmail.com>
	<CACsJy8AmQeVb-i6Sn0BH-_ikEXPHTdtKnQRyzChX1WfD9Lj4Jw@mail.gmail.com>
	<53109B19.8070103@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 28 20:03:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJSiY-0003hL-8V
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 20:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbaB1TD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 14:03:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbaB1TDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 14:03:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D10586FE50;
	Fri, 28 Feb 2014 14:03:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UEAT7b540W6xk5qb6nNyax1eQCI=; b=rbrb0m
	i+jm3MB9KZdaIGoxAZro3o/+ND5+euMSbZysGiHI+mR8F0PGN3r/XbVYfjxOUBG/
	h1HX1jVXyfyYdyTLrGp3M4Nd+GQjT7x+rSEfAs7F8GDh8d2QCSDE6QHV9sMQ4LNU
	FBk5r3S+UGhZlXwKaPa5qFJmf8+E0jdM5DOog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cgdjd3Tuv80hjGybxSKaM0WLr4ZETOdv
	Q2/9yhCQjKNZktA27KNcNm3G6ZKRyguHtY3HnuM9RVOMoWknGYsnJ/18F8e6va1k
	23r9LRX/h+yJotbvRktoD2Iak8hlbOJGvsLDBQrr8rI8ugxsBigh0/8Tar2B0ar5
	dvqW/nfIrig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0CB56FE4D;
	Fri, 28 Feb 2014 14:03:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3BB06FE4A;
	Fri, 28 Feb 2014 14:03:22 -0500 (EST)
In-Reply-To: <53109B19.8070103@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 28 Feb 2014 15:20:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FEA111AA-A0AA-11E3-B648-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243004>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> So my vote is that the patches are OK the way Dmitry wrote them (mind, I
> have only read through 05/11 so far).

Seconded ;-)

By the way, I do not like these long subjects.  "change" is a
redundant word when one sends a patch---as all patches are about
changing something.

	Subject: builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()

would be a lot more appropriate for "git shortlog" consumption.
