From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH ld/maint-diff-quiet-w] Windows: redirect
 fopen("/dev/null") to fopen("nul")
Date: Thu, 25 Feb 2010 09:03:15 -0800
Message-ID: <7vtyt59rjg.fsf@alter.siamese.dyndns.org>
References: <4B86399E.3090508@viscovery.net> <20100225162032.GA3527@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Thu Feb 25 18:03:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkh7a-0002V4-FG
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 18:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807Ab0BYRDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 12:03:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186Ab0BYRDY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 12:03:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 662659D01E;
	Thu, 25 Feb 2010 12:03:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qTqBv80IAhRyadBJzUooxOSywxg=; b=ClCeRG
	W8AOzN4N8ooKra35qRsO8MahKL/0YJykyRTA24tFeVgv5ZbCTeDye1iKhFL01yDm
	27kYJyPE/tdhwj25g0ZbPPK0zh2//hBSwkyFEO8S8O65Vr0j41wT8Aw4ca45sD/S
	Ukdr6bLEOV5oQ9fqv6ZhRNnLgIbyErXhUArGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cz3SAP1iOYeBuSNuq0/ubmgwL8LzynNX
	+RD0GqpPkcxOWUCYPk3SHeEKN4NtqUGuwEfg/C4XRuWNc28h/7KJk07VgEPlROoU
	BINiuYP60H95vNRRFK6px9lS5Q84XRGgkO3ickzgOOaBbSo3TdHKy7yRUegKMPc4
	BStxwPZbgpk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 331EB9D01B;
	Thu, 25 Feb 2010 12:03:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C0559D01A; Thu, 25 Feb
 2010 12:03:16 -0500 (EST)
In-Reply-To: <20100225162032.GA3527@cthulhu> (Larry D'Anna's message of
 "Thu\, 25 Feb 2010 11\:20\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACC4CB68-222F-11DF-8E6F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141055>

Larry D'Anna <larry@elder-gods.org> writes:

> * Johannes Sixt (j.sixt@viscovery.net) [100225 03:49]:
>> From: Johannes Sixt <j6t@kdbg.org>
>> 
>> An instance of fopen("/dev/null",...) was added to the code base. On
>> Windows, we have to use "nul" instead. This implements a compatibility
>> wrapper of fopen() that checks for this particular condition.
>
> Doesn't store_updated_refs do this too?

I think there is no problem, as the patch covers that case, too.
