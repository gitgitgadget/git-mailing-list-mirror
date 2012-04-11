From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] gc: do not explode objects which will be immediately
 pruned
Date: Wed, 11 Apr 2012 11:31:37 -0700
Message-ID: <7v398aktme.fsf@alter.siamese.dyndns.org>
References: <20120407103008.GA11242@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204101623010.16314@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 20:31:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2KY-0001ev-NF
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760799Ab2DKSbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 14:31:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695Ab2DKSbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 14:31:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEB417F31;
	Wed, 11 Apr 2012 14:31:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MVPEFEbg5XLz8q9INfVCFGpe3UM=; b=bNzNfK
	0CD7hgvoVcUnL0dHAoOnb2H1mMZkmVM9K2JdWoqCUN6GPJAy/WY/FgFQ1uf/5RWB
	EdMYnpCHyc3AAVyqvkQL+KoEjxbNKfwQ/RYLDaV87xhVSlQP7v5/PFLPFOsXF4gw
	C8RN52YCsi1LtP2x0S1aNtVQmC3nh6q1wveOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pt8K322bS+cnNPOSGix6mp3XnqCft74I
	BWWW0h6qlRmB8Utfne2OAz2dy7nTzaiaurh97tEKV1rv9SOLZS54QZAcHYugl87l
	iklodfcPBRIYkJRqooAwMBnlkJbH87euixsr3Kg6u+5FjuWpccZi48irKTvMjomM
	ZTtdPSD1pGs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A672A7F30;
	Wed, 11 Apr 2012 14:31:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E35A7F2F; Wed, 11 Apr 2012
 14:31:39 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.02.1204101623010.16314@xanadu.home> (Nicolas
 Pitre's message of "Tue, 10 Apr 2012 16:24:17 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93D336CE-8404-11E1-9874-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195233>

Nicolas Pitre <nico@fluxnic.net> writes:

>> ...
>> This patch teaches pack-objects to receive the expiration
>> information and avoid writing these objects out. It also
>> teaches "git gc" to pass the value of gc.pruneexpire to
>> repack (which in turn learns to pass it along to
>> pack-objects) so that this optimization happens
>> automatically during "git gc" and "git gc --auto".
>> 
>> Signed-off-by: Jeff King <peff@peff.net>
>
> Looks fine to me.
>
> Acked-by: Nicolas Pitre <nico@fluxnic.net>

Thanks, both.
