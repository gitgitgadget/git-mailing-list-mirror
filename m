From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: fix #patchNN anchors when path_info is
 enabled
Date: Thu, 17 Mar 2011 13:55:17 -0700
Message-ID: <7v8vwd31sa.fsf@alter.siamese.dyndns.org>
References: <3ef1af6874437043a4451bfbcae59b2b@localhost>
 <m3hbb258pw.fsf@localhost.localdomain>
 <7v62rh4ml1.fsf@alter.siamese.dyndns.org>
 <201103172020.05055.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 21:55:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0KEH-00053s-Ll
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 21:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab1CQUza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 16:55:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab1CQUz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 16:55:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A244433C;
	Thu, 17 Mar 2011 16:57:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G1OevaiK1iynsZuP0RZUelI+Mj4=; b=AJ+n5t
	xRu/gNkkyqg9/ODOkYpkjJiNiitMibrLF7KxJA5Xeoe+hmTynbgpSrDq1nALWZlB
	xaB10HXT4qlUj4x0A1xJGbX2QNqmdfbI5YQkefpdzqr6f1hNS6/UnW6tSy3butIX
	xP0ZjoHepjGUxltCEmwuPQULoNz0O4v8NhSW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uPFyGiGcxMwCktt89104NATyStps7xxx
	xJlOKCLyo6AseQKyj4OKp26oAx1MHwu4+Cl7/PvY+pVDQTJkob/TC6prQZSP1c48
	157Wx7J3xXN98/cc1Xjf3/5jld4cN06TQZ02c9zodoLFEFcfLKOfxz+Ouke6+1Id
	Hu+1oScD6JY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EE85433B;
	Thu, 17 Mar 2011 16:56:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BAECF4338; Thu, 17 Mar 2011
 16:56:53 -0400 (EDT)
In-Reply-To: <201103172020.05055.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu, 17 Mar 2011 20:19:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19AA5404-50D9-11E0-9B04-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169277>

Jakub Narebski <jnareb@gmail.com> writes:

>>> or even make it so 'href(-anchor=>"ANCHOR")' implies '-replay => 1'.
>> 
>> I don't see why "or even" is an improvement, given the following
>> implementation.
>
> Well, 
>
>   -href => href(-anchor=>"patch$patchno")
>
> is closer in spirit to
>
>   -href => "#patch$patchno"
>
> that is currently used, and does not work with path_info.

I questioned "implies '-replay => 1'" part, not the use of href(...) part.
