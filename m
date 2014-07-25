From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Fri, 25 Jul 2014 10:09:14 -0700
Message-ID: <xmqqr41974cl.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
	<vpqlhrjqmyw.fsf@anie.imag.fr>
	<xmqqiommadl0.fsf@gitster.dls.corp.google.com>
	<53D15188.2010209@gmail.com> <vpqegxa386m.fsf@anie.imag.fr>
	<xmqqppgu8sxz.fsf@gitster.dls.corp.google.com>
	<53D15EB4.1050303@gmail.com>
	<xmqqlhri8rdb.fsf@gitster.dls.corp.google.com>
	<53D17919.4020702@ramsay1.demon.co.uk> <53D1CBFA.3020107@gmail.com>
	<vpqlhriyll6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 19:09:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAizp-0005xy-6m
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934202AbaGYRJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:09:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58265 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932582AbaGYRJY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:09:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D46962994F;
	Fri, 25 Jul 2014 13:09:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ItXA2mnC0xhUjhe8y0smyTVZ3Kw=; b=TEpV+z
	eLlRkwNo9vqZgOIUNDizPrUJTs7edsBdSe3NWK7awyEeHB8XGgKajh6sALr61QKN
	0Zif6DUZ6/4W6La3Bjii0YGd9ZqmAurmNDzTEFCqrBZERoUMPtTVq2ugTB7AAKdr
	5ldqhJDpebCnC2JDboLRU4VUHmo2pACkRy/V4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YK5Am5WdXDnhze6IREctSOXIus5kzo2M
	9e4ImYR63q4Fc3A6KdOdru7XWfExOvdYLKSP9744mKN205yzKvdv1PfNP7BJxSUN
	l7Q3uR9F51h9/kyGhu3MGqS73+twUClnz+PHx0MmjW3rY2VPIHW/NvcbGfpV+KFR
	7vMseL9zwI0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9A402994E;
	Fri, 25 Jul 2014 13:09:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C75432992B;
	Fri, 25 Jul 2014 13:09:16 -0400 (EDT)
In-Reply-To: <vpqlhriyll6.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	25 Jul 2014 08:54:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 68D5BF44-141E-11E4-83F7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254238>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> On 7/25/2014 2:52 AM, Ramsay Jones wrote:
>>> However, I think it you could create a list of <pointer to hash-table
>>> entry, string-list index> pairs in the config_set and use that to do
>>> the iteration. A bit ugly, but it should work.
>>
>> Thanks for the advice, that is exactly what I am doing.
>
> I'd just replace "list" with "array" and use
> Documentation/technical/api-allocation-growing.txt.
>
> But I can't think of a better way.

Presumably this array will reflect the order the source file told us
about the keys and their values; I wonder if the <filename, lineno>
information we already have can be used (or unified) with it?

Is the "when the last variable in a section disappears, make the
section header go away, with sensible handling of comments around
it" part of this GSoC project?  If so, I suspect that the feature
would also want to know where things appear in the original file, so
this data structure may play a role there, too.
