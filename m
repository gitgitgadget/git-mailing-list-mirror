From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Tue, 14 Oct 2014 10:08:19 -0700
Message-ID: <xmqqsiiqziik.fsf@gitster.dls.corp.google.com>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
	<20141014095119.GC16686@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 14 19:08:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe5aF-0002Zc-FN
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 19:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbaJNRIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 13:08:23 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754214AbaJNRIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 13:08:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D25761476F;
	Tue, 14 Oct 2014 13:08:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hafejsci7NiZKcw8o1hvIJsiiZo=; b=rACCVO
	GgOo6zU8peKcat2gEg8oY5QZRJasWG3jxjHUgIzs2M+yN61TgmUlHutE45LyLMXR
	kjv3KSZ2zhSDQX3GuIUnDnSJaYq4zM9vKz3ZMnYfLSAM5KjFsgFLCYB0Mpnsl3oK
	lan7hw6q2CnTzDWq9znisisplBN3bbAga/wQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D0/6NMJSogQhQWsPr4WRMUS0JEvblPpV
	FYhXM1ghoWFy8qOaSsMeT4Yyu8L0zIk8BgheY9zySu4yhnDKZNJtjltcv4OhDvHd
	5lELwfA2AYuibNgUmWRl/NAyAKG3FznOfCLIFsYI/SIefZlwRnG4AYHFznhPlUKp
	ZcNUVXZnUVo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C939F1476E;
	Tue, 14 Oct 2014 13:08:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 479671476D;
	Tue, 14 Oct 2014 13:08:21 -0400 (EDT)
In-Reply-To: <20141014095119.GC16686@peff.net> (Jeff King's message of "Tue,
	14 Oct 2014 05:51:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B331A18A-53C4-11E4-A93D-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Oct 11, 2014 at 11:37:32PM +0000, brian m. carlson wrote:
>
> Specifically I'm not excited about getting into a state where we have to
> maintain both an asciidoc.conf file _and_ ruby extensions for
> asciidoctor. I don't mind if somebody wants to step up and keep the
> asciidoctor bits in sync with the asciidoc.conf, but I feel like one of
> them needs to be considered the "master".

My so-far-unstated inclination, since seeing the patch to fix the
unbalanced example block separators from Brian (which was outside
and before this four-patch series), has been to keep our Makefile in
Documentation/ aware only of AsciiDoc while maintaining *.txt files
in a state so that AsciiDoctor could also be used to process them,
if people want to futz with their copies of Documentation/Makefile.

I do not mind to have the machinery to run AsciiDoctor too much in
my tree.  It may make it easier for those who use it to spot places
in *.txt that need (in)compatibility workarounds between the two
formatters than keeping it outside.

But somebody needs to maintain that machinery and that will not be
me.

Thanks.
