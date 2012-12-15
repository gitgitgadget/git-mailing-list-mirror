From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: add --index-file command-line option.
Date: Sat, 15 Dec 2012 11:36:33 -0800
Message-ID: <7vliczrttq.fsf@alter.siamese.dyndns.org>
References: <1355484219-7517-1-git-send-email-manlio.perillo@gmail.com>
 <7vpq2btcqp.fsf@alter.siamese.dyndns.org> <50CCC73B.3070802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjxXZ-0001sy-Sw
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 20:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab2LOTgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 14:36:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52408 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab2LOTgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 14:36:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7A178C18;
	Sat, 15 Dec 2012 14:36:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zD39SiKdZs9326EG8Xc1Wv7HTDA=; b=vKpRJH
	pVBbnxgQlR4lqmDU3BFnRlv5Im6x7L2mROfgTgJvQmDDIpl0sBlpEjp79GedA+JA
	lzh95x1DylA3iojlGb12SOUJZ5DUVK6WwW2E0tXHbgrI99Tesg75Ue9QQGDnatYZ
	APE4yAPe6WtvrqNoo5DugMbhfadcpkb0A/sZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bw3+c75UG8rIeLfdLzx58wZ9vO+52f48
	oOTix/0mACOLbSQvXZ3/WDOgPua73xe8fsZ8XzwjvuI9Sze6ucd9nshBtpH78f5f
	Hc1rJCoejhTKwPP7PiNzYJs6WSMJ+gdT8lJ2fu5h9LTwLCT6uhdbDvSpu0Z3sB0y
	QbO8dyPHHYc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D468F8C17;
	Sat, 15 Dec 2012 14:36:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E2BD8C0C; Sat, 15 Dec 2012
 14:36:35 -0500 (EST)
In-Reply-To: <50CCC73B.3070802@gmail.com> (Manlio Perillo's message of "Sat,
 15 Dec 2012 19:53:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC811714-46EE-11E2-9EB1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211566>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> Il 15/12/2012 19:02, Junio C Hamano ha scritto:
>> Manlio Perillo <manlio.perillo@gmail.com> writes:
>> 
>>> Unlike other environment variables (e.g. GIT_WORK_TREE,
>>> GIT_NAMESPACE), it was not possible to set the GIT_INDEX_FILE
>>> environment variable using the command line.
>> 
>> Is this necessary?  I'd prefer to see a better reason than "just
>> because others have it".
>
> A long running program will be able to tell git to use an alternate
> index file, without having to modify its own environment,...

Hrm, isn't that the single-shot environment export syntax

	GIT_INDEX_FILE=foo git blah

is for?  Is there a real-world need for this?
