From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Mon, 13 Oct 2014 13:41:31 -0700
Message-ID: <xmqqtx371z44.fsf@gitster.dls.corp.google.com>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 22:41:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdmQz-0003WC-Gu
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 22:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbaJMUld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 16:41:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750755AbaJMUld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 16:41:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B9558154AF;
	Mon, 13 Oct 2014 16:41:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uDqFMSgLrN86DBQAVwbL4yMJk1g=; b=j6kRR1
	a6N+X4Ffc8ziJYMb8qSdkWBDAz8dZo6r3jzYGWoPyrR1weGDyjTHhYTZYm7NDy0o
	4PpdlnYLISFM7NsqPDHeWGv9jHbLc87sWvCKS87UwJd9myHwBQV/52L+8gBkZ/Y+
	lbRrrCPS9ahdVpr8NjtB8WlZnpgaajCGMzXVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CZum2fI35d1DZIzR40PRnGMEBTV/u0p8
	rH64Vtjt44hZZz45I/UodXIRZuAo5B1iYgooSQOJxvORXnjDybEPoYjJDVC+qYBD
	EAvzQIpNy+DHy99M445P3gibDX0GNDvZJRz7s9jM/x7PUM8AUvV1PIySYyl3xZRE
	5rU5I3uYh1Q=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B176B154AE;
	Mon, 13 Oct 2014 16:41:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39698154AD;
	Mon, 13 Oct 2014 16:41:32 -0400 (EDT)
In-Reply-To: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sat, 11 Oct 2014 23:37:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 50C6CA30-5319-11E4-B669-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series is designed to implement the changes necessary to build Git
> using Asciidoctor instead of AsciiDoc.
>
> The first two patches are bug fixes.  Asciidoctor is stricter about
> title underline lengths (± 1 character instead of 2) and requires
> matching delimiter lengths[0].  They're needed regardless of whether the
> other two patches are accepted because git-scm.com uses Asciidoctor to
> render the documentation, so we might as well render it correctly.
>
> Even with these patches, Asciidoctor warns about everyday.txt and
> user-manual.txt.  I'm not sending patches for these right now because
> I've seen recent series including those and don't want to cause a
> merge conflict.

Sounds good.

> The second two patches implement some basic support for building with
> Asciidoctor.  The first of these moves some items into variables due to
> some differences between the AsciiDoc and Asciidoctor command lines.
> The user can then override these values when invoking make.
>
> The final patch adds support for the linkgit macro.  Asciidoctor uses
> Ruby extensions to implement macro support, unlike AsciiDoc, which uses
> a configuration file.

What I do not understand is that 3/4 lets you drop inclusion of
asciidoc.conf which contains a lot more than just linkgit:
definition.

For now I'll queue only the first two, which unquestionably take us
in the right direction.

Thanks.
