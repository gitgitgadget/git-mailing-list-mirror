From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Tue, 03 Mar 2015 11:47:22 -0800
Message-ID: <xmqqd24pc185.fsf@gitster.dls.corp.google.com>
References: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
	<xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
	<CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
	<CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
	<xmqqioekawmb.fsf@gitster.dls.corp.google.com>
	<20150302092136.GA30278@lanh> <20150303103351.GA4922@lanh>
	<xmqqk2yy80mq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:47:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSsn0-0004xV-5m
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 20:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375AbbCCTr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 14:47:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756099AbbCCTr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 14:47:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C84933BDB8;
	Tue,  3 Mar 2015 14:47:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F+LHhLGjVfP0o/cmHbJ+i/cAJMg=; b=eK80Cp
	cWbDsMlCUQrB/JDI+3DgaJqfQwtzxYgwoG0yZxCyZAWjJEuOE6fXQeNToHToHlxX
	J4KkVBw8qvOuR24xAVO51cgDmzkYVgisDoch0aXdD/+LrWBL9xlJrzoLG2YY6Tue
	fOjSMMqB9vT1Y862jgYWCh2rJRQmHwIwalEeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fkctY7dxQEXMAxyCNHHuuW1Anhvo4UPe
	fsfKX5JBTFDPCXsWNNaa2YiP0PGbznYkWfD9PtEWeiC02LiO2TcDrggDNJj0JqvF
	EQztVDKQKSfNo82Eh9a3TsVJRbk4Q2FYsXe1OJP4FUWqzvAjyrTZoKcZo+yLl+iC
	M0zJrRvmkII=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C08E63BDB6;
	Tue,  3 Mar 2015 14:47:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F24F3BDB5;
	Tue,  3 Mar 2015 14:47:25 -0500 (EST)
In-Reply-To: <xmqqk2yy80mq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 03 Mar 2015 09:13:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DA2A7E4-C1DE-11E4-82FB-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264677>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Junio pointed out in private that I didn't address the packet length
>> limit (64k). I thought I could get away with a new capability
>> (i.e. not worry about it now) but I finally admit that was a bad
>> hack. So perhaps this on top.
>
> No, I didn't ;-) but I tend to agree that "perhaps 4GB huge packet?"
> is a bad idea.
> ...

I realize that I responded with "No, I did not complain about X, I
had trouble about Y and here is why" and talked mostly about Y
without talking much about X.  So let's touch X a bit.

As to the packet length, I think it is a good idea to give us an
escape hatch to bust 64k limit.  Refs may not be the reason to do
so, but as I said, we cannot forsee the future needs.

Having X behind us, now back to Y, and then I'll remind us of Z ;-)
[*1*]

> My recollection is that the consensus from the last time we
> discussed protocol revamping was to list one capability per packet
> ...

And the above is "the right thing" from the protocol point of view.
The only reason the current protocol says "capabilities go on a
single line separated by SP" is because the hole we found to add to
the protocol was to piggyback after the ref advertisement lines, and
there was no guarantee that we have more than one ref advertised, so
we needed to be able to stuff everything on a single line.

Stepping back and thinking about what a "packet" in pkt-line
protocol is, we realize that it is the smallest logical unit of
transferring information.  The state of a single ref in a series of
ref advertisement.  The fact that receiving end has all the history
leading up to a single commit.  The request to obtain all history
leading up to a single commit.

That is why I say that one-cap-per-packet is the right thing.

These individual logical units are grouped into a larger logical
unit by (1) being at a specific point in the protocol exchange, (2)
being adjacent to each other and (3) terminated by a "flush
packet".  Examples:

 - A bunch of individual ref states that is at the beginning of the
   upload-pack to fetch-pack commniucation that ends with a flush
   constitutes a ref advertisement.  

 - A series of "want" packets at the beginning of the fetch-pack to
   upload-pack communiucation that ends with a flush constitutes a
   fetch request.

Another thing I didn't find in the updated documentation was a
proposal to define what a "flush" exactly means.  

In my above writing, it should be clear that a "flush" is merely
"the end of a group".  It does not mean (and it never meant, until
smart HTTP) "I am finished talking, now it is your turn."  If a
requestor needs to give two groups of items before the responder can
process the request, we would want to be able to say "A1, A2, ...,
now I am done with As; B1, B2, B3, ..., now I am done with Bs; this
concludes my request, and it is your turn to process and respond to
me".  But you cannot easily do so without affecting smart HTTP, as
it is written in such a way that it assumes "flush" is "I am done,
it is your turn".

I am perfectly OK if v2 redefined "flush" to mean "I am done, it is
yoru turn."  But then the protocol should have another way to allow
packets into larger groups.  A sequence of packets "begin A", "A1",
"A2", ..., "end", "begin B", "B1", "B2", "B3", "end", "flush" may be
a way to do so, and if we continue to rely on the order of packets
to help determine the semantics (aka "being at a specific point in
the protocol exchange" above), we may even be able to omit "begin A"
and "begin B" packets (i.e. the "end" is the new "end of a logical
group", which is what "flush" originally was).


[Footnote]

 *1* For those who haven't been following the discussion:

     X: maximum packet length being 64kB might be problematic.

     Y: requiring capability advertisement and request in a single
        packet is wrong.

     Z: the meaning of "flush" needs to be clarified.
