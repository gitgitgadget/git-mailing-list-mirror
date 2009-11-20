From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t/lib-http.sh: Enable httpd tests by default.
Date: Fri, 20 Nov 2009 12:54:09 -0800
Message-ID: <7v6394x6ha.fsf@alter.siamese.dyndns.org>
References: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com>
 <1258680123-28684-2-git-send-email-tarmigan+git@gmail.com>
 <7vd43d7hdo.fsf@alter.siamese.dyndns.org>
 <905315640911201103w6d1da86duf41a53537672be8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jaysoffian@gmail.com,
	drizzd@aon.at, spearce@spearce.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:55:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBaVx-0003Xv-Q2
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 21:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbZKTUy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 15:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755875AbZKTUyY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 15:54:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858AbZKTUyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 15:54:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD12A9E0C1;
	Fri, 20 Nov 2009 15:54:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ecejyhmc9ED069xgewxmV3tVMlM=; b=O8c5rm
	lZX5hnWyqJB/ZLVPCSzSlwPUGpmJe9XnDDDKvXSFwxQjhyC301VgPmsUuNzJwgq0
	Jdll2+Cx5fQytu7OOnc5iZMyFD41FnrEh5nVZWvnJKrR3ZRYJ2qK260GEqIphKQH
	G935N72i45EPjeE3bVqAg8IDK8vNSWBf1qhYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FlnZH/uHYLd5PVCr4G+dMMoQLGSNdj/9
	5ZQLi8jkIjVuUWmBKS/hfVpguEshR8yZNt8j2QVwY2x6kIB0xAC7IHEB2tFQ4H6W
	kpG3c9u+PeHSo9WrAI+4SiL7RvofPGib+ptL3bkrakf4imyStwkc/Q/MkK8yibVs
	4Bbbh6dGNtI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F35C9E0BF;
	Fri, 20 Nov 2009 15:54:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6D2159E0B1; Fri, 20 Nov 2009
 15:54:11 -0500 (EST)
In-Reply-To: <905315640911201103w6d1da86duf41a53537672be8e@mail.gmail.com>
 (Tarmigan's message of "Fri\, 20 Nov 2009 11\:03\:13 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DF7C1B5C-D616-11DE-9EDD-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133378>

Tarmigan <tarmigan+git@gmail.com> writes:

> On Fri, Nov 20, 2009 at 12:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Tarmigan <tarmigan+git@gmail.com> writes:
>>
>>> With smart http, git over http is likely to become much more common.
>>> To increase testing of smart http, enable the http tests by default.
>>
>> Sorry, but no test that listens to network ports should be enabled by
>> default; otherwise it will break automated, unattended tests people have
>> already set up randomly, depending on when the port happens to be
>> available for use by the tests.
>
> Is this the only concern or are there security or other issues as well?

I thought security was too obvious to mention.
