From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto merge bug
Date: Tue, 05 Mar 2013 10:47:11 -0800
Message-ID: <7va9qhu1jk.fsf@alter.siamese.dyndns.org>
References: <CAOFaZ+5F1BcWNU=AkcnS53bQt1VfAfsFjp9EvRCL=7kYiU1ejg@mail.gmail.com>
 <20130305090326.GC13552@sigill.intra.peff.net>
 <7vtxopvoky.fsf@alter.siamese.dyndns.org>
 <20130305175904.GC9379@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Krmpotic <david.krmpotic@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 05 19:47:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCwtu-0002kU-DA
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 19:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab3CESrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 13:47:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758039Ab3CESrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 13:47:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 502D4A80C;
	Tue,  5 Mar 2013 13:47:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ngQXyzVxGWHLvEfPZKaKbS8X50=; b=CdDwp6
	E6hwYWGZqkxgfofrVhmknn5YNcnnbdQtjPVLnDW9AcSuPzRXQLbkHr8lowfs/sLL
	FysVOKhP7LpDhjTsF4LUl8UTcFurFcZ5fvgAAYIPvbNZuObTKMxnmPBwlP2blhle
	zU4G8AGasAQ2N3RR1c2cWi7cV9bVMDIxgLbRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AtWwz81i1cT7B0+luoG/dxH6G7KW98mO
	v4PHo1ms58T5x7yOMLuMftNCCrX0ONsTjkXm4+q/etFt1r1k2fGsTkF/xZh1rKJU
	aEO29/WU8OKoEptC9Ce9G6kYSZu2L4vUIxGL7/MtHUYK8o9UnQ7XL/VRcLkmPSAr
	9rxSKH9QK/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43B8AA80A;
	Tue,  5 Mar 2013 13:47:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8E26A807; Tue,  5 Mar 2013
 13:47:12 -0500 (EST)
In-Reply-To: <20130305175904.GC9379@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Mar 2013 12:59:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17BA00EA-85C5-11E2-ACE5-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217474>

Jeff King <peff@peff.net> writes:

> I'm also not sure how useful those really are in practice. I have not
> used "union" myself ever. And in the example that started this thread, I
> find the use of "union" slightly dubious.

Yeah, I do not think anybody sane used "union" outside toy examples.
IIRC, it was originally done as a "if you want a GIGO, here it is,
go hang yourself." response to "I am too lazy to resolve conflicts
myself, Git should let me take both sides blindly."
