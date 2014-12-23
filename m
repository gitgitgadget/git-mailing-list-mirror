From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 09:56:06 -0800
Message-ID: <xmqqwq5i2qtl.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
	<xmqq38878gao.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
	<xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
	<xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
	<xmqqmw6e499u.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
	<xmqqa92e47ap.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231829020.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Tgu-00010s-G8
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbaLWR4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 12:56:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754452AbaLWR4I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 12:56:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA8132814F;
	Tue, 23 Dec 2014 12:56:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PbQRr7RDXyVSsP8MAiWpfal4crk=; b=t4+xtQ
	FKKwSSuUVEP9za6qVtZ1ZsBxNL8tJ7Y6QdFactOVBVpwPE4Ar/6UWb5n5/el8BUM
	LpOWQTydRa9Wz948vuo4UfwMn6uVFIlDNcofX9/8Tw77S69qN7R9A4o6NtDevEKu
	2nQ7i11GZDTPxf5EJv05J6eUp+UUdsrkXj5pU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AlmDgCL6oc6TJtFy1ixmUD2Hstl0PSKX
	3t60HvWv7AxeVh3qyIYVg2MFNKHIBAkyuKLGHLdgyN6K6p3P35EevQIRf8m9Rhbj
	TInTE/RO8lhn+nI6Jf+srgtISEw5vAdYENjEdLMSTfZP+GFW1PdBy3iQcuoVyHXd
	QquoycoV7zA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C172C2814E;
	Tue, 23 Dec 2014 12:56:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B0082814A;
	Tue, 23 Dec 2014 12:56:07 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412231829020.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 23 Dec 2014 18:41:38 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F862F8E6-8ACC-11E4-ADF5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261750>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, so just to clarify: you want me to
>
> - split the parser into
>
> 	- a parser that accepts only camelCased variable names when they
> 	  come from the config (for use in fsck and receive-pack), and

OK.

> 	- another parser that rejects camelCased variable names and only
> 	  accepts lower-case-dashed, intended for command-line parsing
> 	  in fsck, index-pack and unpack-objects, and
>
> - consequently have a converter from the camelCased variable names we
>   receive from the config in receive-pack so we can pass lower-case-dashed
>   settings to index-pack and unpack-objects.

I am not sure about the latter two.  This needs a design discussion
what the command line options should be.

I think the command line should be like this:

	git cmd --warn=missingTags,missingAuthor

in the first place, i.e. "we may invent tokens to denote new kinds
of errors as we improve fsck", not with "we may add options for new
kinds of errors", i.e. the command line should not look like this:

	git cmd --missing-tags=warn --missing-author=warn

And from that point of view, I see no reason to support the dashed
variant anywhere in the code, neither in the config parser or in the
command line parser.
