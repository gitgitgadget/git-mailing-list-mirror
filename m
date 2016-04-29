From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Fri, 29 Apr 2016 11:20:20 -0700
Message-ID: <xmqq37q4z38b.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461942126-16296-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Fri Apr 29 20:20:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awD1h-0007PE-0I
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 20:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbcD2SUZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 14:20:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750714AbcD2SUY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 14:20:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 308A517E9F;
	Fri, 29 Apr 2016 14:20:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z0vNlKsTFaTQ
	UVSmbiA/tsnmo1g=; b=FxjW7tD5D/bSxwYvbb0eZOKMSswrqyCMQFiszvIOi8zP
	Qe7ITYf0M37HqYAeubXRYk+ZmxIVAayEdk3dh9+bQa/0AMHiPQa4G2QwI4uI3UwC
	+3qIGgG00N+Vi+oRvoqkpYkL5u7BvmYc2USnpDJStgYB9t+nAP/y3D8noVzYTBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pKUh9N
	AL49kXwGhsAxRVK2cHz3ctg/NhW6371r3Igz6Y1+dvyhi8L573kqQ491N+p6hRF+
	nsUIy6o0NexMjUrznS3R43/u5B62SYRjwK/n5fRh3ql3nhoa1Ewgq88KzSChATFO
	U5O2d9cIv9J7T8SKMqtCOBqmPmz/VD+RLLwrE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 29B8117E9D;
	Fri, 29 Apr 2016 14:20:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C05617E9B;
	Fri, 29 Apr 2016 14:20:22 -0400 (EDT)
In-Reply-To: <1461942126-16296-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 29 Apr 2016 17:02:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 097239D2-0E37-11E6-B801-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293039>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> We define the working tree file is clean if either:
>
>   * the result of running convert_to_git() on the working tree
>     contents matches what is in the index (because that would mean
>     doing another "git add" on the path is a no-op); OR
>
>   * the result of running convert_to_working_tree() on the content
>     in the index matches what is in the working tree (because that
>     would mean doing another "git checkout -f" on the path is a
>     no-op).
>
> Add an extra check in ce_compare_data() in read_cache.c.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Thanks, will re-queue.
