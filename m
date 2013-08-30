From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] replace: forbid replacing an object with one of a different type
Date: Fri, 30 Aug 2013 09:52:55 -0700
Message-ID: <xmqqa9jz15p4.fsf@gitster.dls.corp.google.com>
References: <xmqqa9k1a9wq.fsf@gitster.dls.corp.google.com>
	<20130829.082936.1893875995125817253.chriscool@tuxfamily.org>
	<xmqqli3k7abw.fsf@gitster.dls.corp.google.com>
	<20130830.074124.1031903859178992049.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trast@inf.ethz.ch, git@vger.kernel.org, philipoakley@iee.org,
	j6t@kdbg.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Aug 30 18:53:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFRwX-0002nS-C5
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 18:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802Ab3H3QxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 12:53:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49890 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756457Ab3H3Qw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 12:52:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5374A3CFC7;
	Fri, 30 Aug 2013 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r5vs87tFecduI7slcZy3T0k+Gfw=; b=ftp3Pe
	Ih5uCy7VEFJ89Pg4//bRi6unF0h7u3aRbyijZeypB5rdYb8t3gRvwMmymNTH/rC8
	5aFtGbLDxV6Lxe76Qirat/3j42IXpSRRGY4fNGuvvCvhMU6kzRQA9jKkk+iIrTIa
	ByGyDpchQjMm7zw1R3xA38OCq1gbzYBHZnyZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dRQ0FcxdluD3g+Szi6yG8GOVoWU941rZ
	woqYkPV8eoHYE+XuL/1mHD+CDaRBsUhtqFF1RfbYEZeYw5fCzuv4ziIG9DKStm/i
	YSaD+8Q2Eokxe5tC9R+16WQKnupUAAHKiwJIbyDINPhu5C1wNfmeFCJLXhOhtHLP
	bHfaCzJtAJU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 472423CFC6;
	Fri, 30 Aug 2013 16:52:59 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 670893CFC4;
	Fri, 30 Aug 2013 16:52:58 +0000 (UTC)
In-Reply-To: <20130830.074124.1031903859178992049.chriscool@tuxfamily.org>
	(Christian Couder's message of "Fri, 30 Aug 2013 07:41:24 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9FC2A4C8-1194-11E3-8EB4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233443>

Christian Couder <chriscool@tuxfamily.org> writes:

> There is already a --force option, but I can add a --force-type in a
> another patch.

Oh, that was not what I meant.  As long as existing --force override
this check, that should be sufficient and more preferrable than yet
another kind of "force".

Thanks.
