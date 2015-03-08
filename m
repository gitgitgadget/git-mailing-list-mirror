From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Sun, 08 Mar 2015 00:06:49 -0800
Message-ID: <xmqqtwxvsyjq.fsf@gitster.dls.corp.google.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>
	<xmqqzj7takks.fsf@gitster.dls.corp.google.com>
	<54F6D3B0.60600@gmail.com>
	<xmqqfv9k8rcs.fsf@gitster.dls.corp.google.com>
	<54F95F25.9090300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, tboegi@web.de,
	sunshine@sunshineco.com, charles@hashpling.org,
	Johannes.Schindelin@gmx.de
To: Anton Trunov <anton.a.trunov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 09:07:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUWEr-0000Zg-PX
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 09:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbbCHIHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 04:07:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751368AbbCHIG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 04:06:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 797E2379DD;
	Sun,  8 Mar 2015 04:06:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S5nsH0i5MrHykX8R//2TJO4qBBU=; b=a63yJe
	b9EgLcAgretSerjFv9qwb3FoNsI/9OzWrmfqyz0eXNZlG4z5xroSET8XkJRB3bOt
	QOaLmg/s0YQaqPX8dQwcn1gCdRYn/+BHLPXaN+8vdsqDXtaPnlQRyThBmvNdzvaL
	KnUejZ+schFMKwOthR8QezewvmqqDXO7yPFGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CDH86xRVWCruJloEt1sAxm+b0SwncfEN
	HiIwfZwzmsrbJg9ADXQUJCY96UWRwkJwq/vJC5anNVf332OnAcSF8OsE6E6lIfWz
	zSdi6GWbUsBdnsH4dfy2tRHb7nJhS1sX5xAUYk4HxgDTbH70waiTp1tNsa4Kik+5
	JE1tcB+XHnw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F713379DB;
	Sun,  8 Mar 2015 04:06:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB58C379DA;
	Sun,  8 Mar 2015 04:06:50 -0400 (EDT)
In-Reply-To: <54F95F25.9090300@gmail.com> (Anton Trunov's message of "Fri, 06
	Mar 2015 11:02:45 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1359B7A2-C56A-11E4-B514-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265044>

Anton Trunov <anton.a.trunov@gmail.com> writes:

> On 04/03/15 23:01, Junio C Hamano wrote:
>
> My apologies for pushing this topic, but what would you recommend?
> Should we treat both sides line-wise or should we correct the documentation?

My gut feeling is that the change to swap which side is examined
first would end up to be a patch to rob Peter to pay Paul, and a
line-by-line approach might end up paying too expensive a runtime
cost in practice (and it should not really matter which side's
whitespace the end result matches, because the user says "I do not
care about whitespace changes", so paying that cost is not something
we would want to do).  So it may be that the best course of action
may be documentation updates.

But I haven't had a chance to think about it through yet to form a
definite opinion.

Thanks.
