From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Wed, 15 Oct 2014 10:43:33 -0700
Message-ID: <xmqqsiipw7ne.fsf@gitster.dls.corp.google.com>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
	<20141014095119.GC16686@peff.net>
	<xmqqsiiqziik.fsf@gitster.dls.corp.google.com>
	<20141015011754.GA131351@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 19:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeSc5-0004QT-Px
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 19:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbaJORnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 13:43:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751279AbaJORng (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 13:43:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8455814FA4;
	Wed, 15 Oct 2014 13:43:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eEolL4f0UpmBWBShmBAGvib5c6g=; b=w+UA2N
	EuvhZSjrS9Uvs+w5CpvJEjutugorU4Zc/AjcN5QB5cFSMwkCxD7YoyXysFMLrbnj
	xH4EZfcwbck2CfFMZ4Wm/GSKSXY6SgxYVzIwoxLBjEOdYYgbuCNL4NH3IWi5oHeN
	Ep0me3+kxgDuDAnfDwtcEHTEte0lkAtcTOkcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WHs3CoZNQAwm5bBXAyRKv+Iqdt+OfwGn
	TbKzjMRGWk08/9xGTjNavMb9Oz5siHxaqcpkk3NLziZshpzL+S91sBulpCcadycM
	ZZWg9GUa/CiAv+mTawETkDWedqO+5aBS14piQqX8n7McpN+Ut6SN0izgmGT4N2Sw
	bo6oAaiKQ+k=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AA2314FA3;
	Wed, 15 Oct 2014 13:43:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED72014FA0;
	Wed, 15 Oct 2014 13:43:34 -0400 (EDT)
In-Reply-To: <20141015011754.GA131351@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 15 Oct 2014 01:17:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C975D06E-5492-11E4-AAF5-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Tue, Oct 14, 2014 at 10:08:19AM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Sat, Oct 11, 2014 at 11:37:32PM +0000, brian m. carlson wrote:
>> >
>> > Specifically I'm not excited about getting into a state where we have to
>> > maintain both an asciidoc.conf file _and_ ruby extensions for
>> > asciidoctor. I don't mind if somebody wants to step up and keep the
>> > asciidoctor bits in sync with the asciidoc.conf, but I feel like one of
>> > them needs to be considered the "master".
>> 
>> I do not mind to have the machinery to run AsciiDoctor too much in
>> my tree.  It may make it easier for those who use it to spot places
>> in *.txt that need (in)compatibility workarounds between the two
>> formatters than keeping it outside.
>
> Alternately, I'm happy to be responsible for maintaining the
> extensions.rb file.

Let's see how well the patches 3 and 4 work for other people with
AsciiDoctor and then decide to go in that direction.

I do not forsee that changes to allow our *.txt to be used with
AsciiDoctor interfere with what GitHub folks do with their own
documentation toolchain, but I am not sure how the AsciiDoctor
specific alternative build infrastructure we would eventually ship
would interact with them---maybe they are not affected at all, or
maybe they can even take advantage of it.

Thanks.
