From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 16 Dec 2011 09:01:57 -0800
Message-ID: <7v7h1wjvqy.fsf@alter.siamese.dyndns.org>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <4EEB4F13.2010402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 18:02:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbbAe-00061w-C9
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 18:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759885Ab1LPRCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 12:02:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab1LPRB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 12:01:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDA517531;
	Fri, 16 Dec 2011 12:01:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5uoZ2/UFwOmfLM9aWdgUmBac/c=; b=Y4Bqau
	5KPclmTMf78brPSI3Gp5bKPnMxRxCtTLFERK51PamFa9yMM+Zpk7iqvYWlcKbBaH
	EU0ciJm1cZlxTgNyrVVLzI0z2GSbhANOSRSGFmTeaghNAk+k5NCOVNw01NiW0GwP
	ZbSgx3Gki5yjXV1HiE0awrfBsiFWtBMe+9I3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FT/jb2iBq3Szf6Xz2EcKvOnYGp6oCnzM
	1JZbg9BJD/6C8k5xEb5rgLwTsnYRh8i/zPmbGuM9LBa0TMHZ/k44axT3GghgE9Bb
	bazPcm3ZXooCH36IjBmBz4F8YCgN0deMYbLDpxeLrCxji+zyEcOgwhryUk2v3OHM
	zGPhtK6KE4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D35B57530;
	Fri, 16 Dec 2011 12:01:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69F42752E; Fri, 16 Dec 2011
 12:01:58 -0500 (EST)
In-Reply-To: <4EEB4F13.2010402@viscovery.net> (Johannes Sixt's message of
 "Fri, 16 Dec 2011 15:00:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA46735C-2807-11E1-95C8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187287>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 12/16/2011 12:00, schrieb Jeff King:
>>  static const char *builtin_attr[] = {
> ...
>> +	"*.c diff=cpp",
>> +	"*.cc diff=cpp",
>> +	"*.cxx diff=cpp",
>> +	"*.cpp diff=cpp",
>> +	"*.h diff=cpp",
>> +	"*.hpp diff=cpp",
>
> Please don't do this. It would be a serious regression for C++ coders, and
> some C coders as well. The built-in hunk header patterns are severly
> broken and don't work well with C++ code.

I do not often do C++, but I tend to agree wrt C.
