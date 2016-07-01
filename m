Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6F342018A
	for <e@80x24.org>; Fri,  1 Jul 2016 20:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbcGAUGv (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 16:06:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752812AbcGAUGu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 16:06:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7721227B32;
	Fri,  1 Jul 2016 16:06:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WcaSdqvz1BxJak9Bd2h1RlrsFl0=; b=mNJKeY
	a75/rTVF40EAlHZBLsULfA7wf1KuOrD7qebbbCsGSDal3uhhEEClZnQ9ERtUCWpF
	nbhWBXo1KjZ1OO/Nu3h9h23iV/QEf1dRqlNGjnCAteNz6orDV4owVM2C9/NBMBEF
	doM6cu+6o/txW5YqCpiONkd79yfRJnT3AHuEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HZwOEV2ODpN4vuCgKERAJuizAK/CSUOf
	UFKIUa/XQM0BfXDIITBFwpdr+A/QUkbVYJlqbMTYzP6VYkiilFkQz240/RuTd+J/
	kug+1Z1Qo+DbxqPSpbByIOfrKXdnCliOvXf41TdV7ov6c+kYk47/wGy9MEEv9Gu5
	MdmEESgc99A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DDEC27B31;
	Fri,  1 Jul 2016 16:06:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E71B927B30;
	Fri,  1 Jul 2016 16:06:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/12] nd/icase updates
References: <20160623162907.23295-1-pclouds@gmail.com>
	<20160625052238.13615-1-pclouds@gmail.com>
	<xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BU0fDVR54hMpA6qVknj+QxWR9Z-i1gRgpaJ6hp+SB2xQ@mail.gmail.com>
	<xmqqvb0pxjfi.fsf@gitster.mtv.corp.google.com>
	<xmqqk2h5xi3q.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 01 Jul 2016 13:06:45 -0700
In-Reply-To: <xmqqk2h5xi3q.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 01 Jul 2016 12:40:09 -0700")
Message-ID: <xmqqbn2hxgve.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5772E264-3FC7-11E6-8FD8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> The rest looks good (after your comment fixup). I see you already have
>>> all the changes in your SQUASH??? commit. Do you want me to resend or
>>> you will just squash this in locally?
>>
>> Squashing in would need to redo this into a few relevant commits,
>> so it won't be "just squash this in locally" I am afraid, but let me
>> try.
>
> Ok, there was a miniscule conflicts but otherwise the squashed
> material was all coming from a single step in the original, so
> I did so myself.  Let's start merging the result to 'next' ;-)
>
> Thanks.

IOW, this on top of the fixup we discussed.

 sideband.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sideband.c b/sideband.c
index afa0136..2782df8 100644
--- a/sideband.c
+++ b/sideband.c
@@ -62,10 +62,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 			 *
 			 * The output is accumulated in a buffer and
 			 * each line is printed to stderr using
-			 * fwrite(3).  This is a "best effort"
-			 * approach to support inter-process atomicity
-			 * (single fwrite(3) call is likely to end up
-			 * in single atomic write() system calls).
+			 * write(2) to ensure inter-process atomicity.
 			 */
 			while ((brk = strpbrk(b, "\n\r"))) {
 				int linelen = brk - b;
@@ -78,7 +75,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 				} else {
 					strbuf_addf(&outbuf, "%c", *brk);
 				}
-				fwrite(outbuf.buf, 1, outbuf.len, stderr);
+				xwrite(2, outbuf.buf, outbuf.len);
 				strbuf_reset(&outbuf);
 
 				b = brk + 1;
@@ -101,7 +98,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	if (outbuf.len) {
 		strbuf_addf(&outbuf, "\n");
-		fwrite(outbuf.buf, 1, outbuf.len, stderr);
+		xwrite(2, outbuf.buf, outbuf.len);
 	}
 	strbuf_release(&outbuf);
 	return retval;
