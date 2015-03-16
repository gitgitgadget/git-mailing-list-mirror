From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] log: forbid log --graph --no-walk
Date: Mon, 16 Mar 2015 12:08:21 -0700
Message-ID: <xmqq7fugrc9m.fsf@gitster.dls.corp.google.com>
References: <5504D5A2.2070405@norn.io>
	<CABwkPcpdpsVUFa_GSr=qYazYQDBr_ygQTctFXmYQf2ZsRt5bpA@mail.gmail.com>
	<5504DF62.4050104@norn.io>
	<CABwkPcpRG0d23OCuoktRdXt9nyA3RtmxGkqkoQ-wApzZvtfYDQ@mail.gmail.com>
	<55072856.5090308@norn.io>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dongcan Jiang <dongcan.jiang@gmail.com>,
	Git List <git@vger.kernel.org>, me@ikke.info,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>
To: Manos Pitsidianakis <epilys@norn.io>
X-From: git-owner@vger.kernel.org Mon Mar 16 20:08:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXaNO-0006M7-31
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 20:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933716AbbCPTI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 15:08:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932634AbbCPTI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 15:08:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E6974001E;
	Mon, 16 Mar 2015 15:08:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xu6zf2au+jxJRUqhA2KaUe2RBes=; b=S0pZpt
	X2NiRKfbwLYZyB8OGWld/E2LZK2LaFkGjuvcOqL7Gy0XhPROxH59wtm6dL9mvWOh
	y5TaMHtMlQfxD6RVOYiu1cYjRRvUdicbBVdZqSbXcOG2BUXJQF0lxJNUAhCJkhUg
	8WXVgZfiP49baGXFqOHZsl8uvZd+TfXzv2FkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OpGKWI4SqlufEAh9mywn05fYFuYgoOCs
	H/aJuuQH7y3JB8bG7gXmeMrQcCk/06kiD3R8KKbr/gf0F5d+xawaFILVVzEfLsjD
	0ibByNMMlylbcKL/bMd+1R5tlzt/P6+WohHbtYoSksjEsR09sXmMwxBgIG97E94X
	ChzXzDQy4cg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 95BCD4001C;
	Mon, 16 Mar 2015 15:08:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1733740012;
	Mon, 16 Mar 2015 15:08:22 -0400 (EDT)
In-Reply-To: <55072856.5090308@norn.io> (Manos Pitsidianakis's message of
	"Mon, 16 Mar 2015 21:00:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D07393A2-CC0F-11E4-8161-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265588>

Manos Pitsidianakis <epilys@norn.io> writes:

> On 03/15/2015 03:39 AM, Dongcan Jiang wrote:
>> Because "revs->no_walk" gets set when it comes to "git show".
>
> So basically rewriting t4052-stat-output.sh to exclude git show --graph
> cases (or similar) is not enough. If rewriting git-show code is what is
> needed, is that in the scope of a microproject?

Perhaps 13b25381 (revision: forbid combining --graph and --no-walk,
2015-03-11) that is queued on 'pu' would be a good answer to this
question?
