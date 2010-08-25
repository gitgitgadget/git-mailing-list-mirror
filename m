From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: respect diff.ignoreSubmodules setting
Date: Wed, 25 Aug 2010 13:10:21 -0700
Message-ID: <7vlj7uqwr6.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1008251225200.4020@intel-tinevez-2-302>
 <4C755778.7010306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 25 22:10:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoMJ7-0007b9-Hd
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 22:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab0HYUKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 16:10:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0HYUKd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 16:10:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B3EDD0F59;
	Wed, 25 Aug 2010 16:10:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rveXhxAj/xu+dTFoZd3dKrwgSPY=; b=lKZXSe
	w6CjNH1ym5yIGI5F2tWdWLD6vu7kiTiexhR0ds5Uciv/AX0VbxnsiBmFAN6N3wXZ
	n03ax1ib/tcvRsFVmXoPqzGcMaXDr94S0lBQ83BJaJhWeKhDt8LuHjNYAk1AsOhv
	mUhLHMUGUrCuc8ryO2rYXQKCBct3n+6jWq+ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i7NxgFivNfGdSKap2Xl6lzBja1Jp15v3
	6BPfDv3n1r/jpQfnE3Gh+QY4pmtsEs0pDxLV+D1wDjcU/Gj8ot/oFThQF73cOpGD
	JZrZLy+SUl+54CvNm/girzP/lP8DaiCTsUOM/+JBflD5ciZJO3rmFBDxZAaQHX6Q
	eiDfcu97De8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0396CD0F58;
	Wed, 25 Aug 2010 16:10:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41128D0F55; Wed, 25 Aug
 2010 16:10:23 -0400 (EDT)
In-Reply-To: <4C755778.7010306@web.de> (Jens Lehmann's message of "Wed\, 25
 Aug 2010 19\:48\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD3BE12C-B084-11DF-873D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154466>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 25.08.2010 12:34, schrieb Johannes Schindelin:
>>  ...
>> Let's respect that setting when 'git checkout' reports the uncommitted
>> changes, since it does nothing else than a 'git diff --name-status'.
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Thanks for fixing that!
>
> Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

Makes sense.

I wondered if the new parameter to show_local_changes() should just be of
type (struct checkout_opts *), so that other options given to checkout,
not necessarily related to the diff generation, can influence the output
further if we wanted to, but that kind of change can be done if and when
it becomes necessary.

Thanks.  Perhaps we would want a new test or two in t2013?
