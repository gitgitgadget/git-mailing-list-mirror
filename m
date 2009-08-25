From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] make the new block-sha1 the default
Date: Mon, 24 Aug 2009 23:50:22 -0700
Message-ID: <7vprakpett.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0908242249420.6044@xanadu.home>
 <20090825041859.GA10033@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 08:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfprq-0007Cg-7N
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 08:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbZHYGum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 02:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbZHYGum
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 02:50:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbZHYGul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 02:50:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B03EE366FF;
	Tue, 25 Aug 2009 02:50:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nIrLmqN85JgUlHByJB4FqYv+QMQ=; b=DCmhPo
	POyvz1HOVXYnKTEoBAFNk1023KwiJWHvKZSSnW+xHh0n3L6Vb5TX+xaMVS86zgHZ
	Gw3sIlGb89vA+i89a0VbB1ashImDMPwJgk40GXvhhBsc2/FkV6qGf3w0sYAnvnDz
	vUjOM3QNnNOvV529yK9Ai7X47KKBtmJtRLYes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U4zMKt+dXNwPAJ78QyYBCCJ2eRlZRtCa
	/A1ntDKxllSodRKX0Q2Yv7OIkn+4sumlosr0ycV7sfmGgGKEJLG8ID8BGxQhe/Ab
	eMwqeJJmCP0qZxZwxNPOA9rAr89JCLKDaQ5fwssOeasvCgUXlxiuURtJ7o88YADE
	KXflY5pfgGA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 898CD366FB;
	Tue, 25 Aug 2009 02:50:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B62D5366F6; Tue, 25 Aug 2009
 02:50:24 -0400 (EDT)
In-Reply-To: <20090825041859.GA10033@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 25 Aug 2009 00\:18\:59 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 93A3EA6A-9143-11DE-BA9A-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127011>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 24, 2009 at 11:04:37PM -0400, Nicolas Pitre wrote:
>
>> ... and remove support for linking against the openssl SHA1 code.
>> 
>> The block-sha1 implementation is not significantly worse and sometimes 
>> even faster than the openssl SHA1 implementation.  This allows for
>
> Is there a reason not to leave the option of linking against openssl?

I think it is a valid question.  Why remove the _option_?

I would certainly understand it if you made BLK_SHA1 the _default_, though.
