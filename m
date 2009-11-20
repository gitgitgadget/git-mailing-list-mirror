From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t/lib-http.sh: Enable httpd tests by default.
Date: Fri, 20 Nov 2009 12:56:28 -0800
Message-ID: <7vtywovrsz.fsf@alter.siamese.dyndns.org>
References: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com>
 <1258680123-28684-2-git-send-email-tarmigan+git@gmail.com>
 <7vd43d7hdo.fsf@alter.siamese.dyndns.org>
 <905315640911201103w6d1da86duf41a53537672be8e@mail.gmail.com>
 <20091120201116.GA19131@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tarmigan <tarmigan+git@gmail.com>, git@vger.kernel.org,
	peff@peff.net, jaysoffian@gmail.com, spearce@spearce.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBaXB-0004Cs-Oy
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 21:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbZKTU4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 15:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbZKTU4i
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 15:56:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbZKTU4h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 15:56:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 356629E0F4;
	Fri, 20 Nov 2009 15:56:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=B2QrKd7qBoJ6w4306P0w4Cw0q9M=; b=lvV3gE7YBzUyzx8eu7dgooC
	0DJM57U/Q+tA72mtmUQhCQxRPOkiO+zz6EQ07+ocHeDd+zUhrtuV93q8XKHzeZR7
	Bn2e5xKUkqu+4eA8pJqzPZU8oS7KKp/Vc5bwWeEAynVgnewAHJzGubVDDhg6Gvkn
	n0VKhCuL5392qXfuLm/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nuddbWJ+OpEmJ0/nQp/9GzczKjRNsXcnfkW6CVSEjUqkQ0Og8
	/qGMJ02iJfWNLEMb2HoVCKwXradgKMX3pf9eQPxSmUu8JyiCNE+eNaSmaVAR7xCL
	fxKbPDfDwczYvfVNAvwaJFqaotFfFhioRVfW8AR9pPTgJfOcJA6mos6WYI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CDFFA9E0F0;
	Fri, 20 Nov 2009 15:56:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C36D79E0EF; Fri, 20 Nov 2009
 15:56:29 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31EE887A-D617-11DE-9EDD-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133380>

Clemens Buchacher <drizzd@aon.at> writes:

> On Fri, Nov 20, 2009 at 11:03:13AM -0800, Tarmigan wrote:
>
>> Here's a patch (cut-n-paste so it will probably be munged) for
>> discussion of the port-fallback idea.  If httpd cannot bind to 5541,
>> it tries 15541 etc.
>
> I would prefer if we skip the test right away.

Retrying is a different issue, and when tests are enabled I think it is Ok
to retry all you want.

But I don't want to see them enabled unless the user explicitly told us
to.
