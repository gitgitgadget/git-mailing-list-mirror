From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correct singular form in diff summary line for human
 interaction
Date: Tue, 31 Jan 2012 19:04:15 -0800
Message-ID: <7vk4475k5s.fsf@alter.siamese.dyndns.org>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <20120131152028.GA10717@burratino> <7vvcnr92y0.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dd4_Pnvzxww38EfZt8NgRow+qxCReohc45XoNpfJCbYg@mail.gmail.com>
 <20120201015606.GA24482@debian50-32.invisible-island.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= 
	<avarab@gmail.com>, Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, dickey@invisible-island.net
To: dickey@his.com
X-From: git-owner@vger.kernel.org Wed Feb 01 04:04:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsQUi-0002Jj-0K
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 04:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764Ab2BADET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 22:04:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755752Ab2BADES (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 22:04:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FEA16394;
	Tue, 31 Jan 2012 22:04:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4UJFrbZHlag9d+Gkd6djgNYwSZU=; b=FOq6yA
	1Zf1L6jZtJ9hBjGBYY+YSvS3jCbm9COD+k459oeFdn5bUPGtlTuCegv3rNPqxeVx
	hggAFdNKAbkoLuDBpdjJYviN1Ive+zh3lN37ppmjk3VM0j0PmMBqZmDJtf1hG5KT
	ImOBgN3A5WNeZ2CQ5EzfYSNOH0ughvaoCyeEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GJoEjawDvj/6t+gZ0GQSF4/g1QIp4sv4
	AxBlimlcEeDYzuVUxLdFNFMShqivBGRVpjLq/IPyoTrQHMe1UY1oOkkteSfw15aJ
	6aJMJfsFUSAKxoodD92wpgzXwMqSdc5ztZpZQF3svwWeHecYUVOgOQ4/Q3p7MsfT
	pcHtl614Au0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 360A66393;
	Tue, 31 Jan 2012 22:04:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B67D56392; Tue, 31 Jan 2012
 22:04:16 -0500 (EST)
In-Reply-To: <20120201015606.GA24482@debian50-32.invisible-island.net>
 (Thomas Dickey's message of "Tue, 31 Jan 2012 20:56:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D683634-4C81-11E1-BDFA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189497>

Thomas Dickey <dickey@his.com> writes:

> On Wed, Feb 01, 2012 at 08:32:43AM +0700, Nguyen Thai Ngoc Duy wrote:
>> On Wed, Feb 1, 2012 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> >> If there is an environment variable to say "I don't want to see
>> >> variations on strings intended for humans", can it be spelled as
>> >> LC_ALL=C?
>> >
>> >  ...
>
> ... diffstat (google helped find context)

When we show diffstat from "git diff --stat" (or "git apply --stat"), we
currently do not do any singular/plural on the last line of the output
that summarizes the graph, ending up with:

	1 files changed, 1 insertions(+), 0 deletions(-)

when there is a single line insertion to a file and nothing else.

My recollection is that our behaviour originally came from our desire to
be as close as what "diffstat" produces, but that does not seem to be the
case.  I observed that the output from recent versions of "diffstat" is
much more human friendly.  We get these, depending on the input, from
"diffstat" version 1.53:

        1 file changed, 1 insertion(+)
        1 file changed, 1 deletion(-)
	0 files changed
	2 files changed, 3 insertions(+), 1 deletion(-)

Namely, it does singular/plural correctly, and omits unnecessary "0
deletions(-)" and "0 insertions(+)".

I was wondering if you remember what the behaviour of older versions of
"diffstat" was, and if it was changed to be more human friendly over
time. It is very possible that I am misremembering this and "diffstat" has
always done the singular/plural correctly and omitted useless "0 lines".

Somehow it seems hard to get hold of older versions of "diffstat", and I
was hoping that I could get that information straight out of the current
maintainer.

Thanks for responding and sorry for the lack of context of the original
message.
