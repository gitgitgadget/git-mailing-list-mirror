From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool: check return value from read
Date: Mon, 19 Sep 2011 17:41:07 -0700
Message-ID: <7vboug82qk.fsf@alter.siamese.dyndns.org>
References: <7vaaa09skn.fsf@alter.siamese.dyndns.org>
 <1316475652-35188-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 02:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5oOh-00062F-3R
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 02:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab1ITAlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 20:41:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46371 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab1ITAlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 20:41:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06C195616;
	Mon, 19 Sep 2011 20:41:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WwSbBwPuahDxkHPUo2Nogv4MMIY=; b=rVYc86
	Ogfe20NYA0kUzNC5LBaMi+o8ef6bITum2+rGEbHuVcwSL5RaqzM2otuWGBkFYFhF
	NbC2XBN6+ZZ1jojQDI8m/LV5s0A15qFtttSs7MZeoIdTasLHn1PqrjwSyg4yBUTm
	loP8/W3D90iWxQdbU4jFT8hwaWbPd0F3gkTUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l/Oy2sorEZuOp8mS8sWQgzjN8EXD4tFz
	hQjI1xDvtQA3D/GueeI5JkghBrgbPwp8jLV0Al3U6c8+xa1c4OuQfteH7o3IPr0B
	eAxHV9QFfHpAVJTHFGhuHLt35gP+Ai2idTnaTz+X+2TdDu2py4PxX3rBbCmViKPc
	O1M4XeV/nYM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F295C5615;
	Mon, 19 Sep 2011 20:41:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8669A5611; Mon, 19 Sep 2011
 20:41:08 -0400 (EDT)
In-Reply-To: <1316475652-35188-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon, 19 Sep 2011 19:40:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B12896A-E321-11E0-8019-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181724>

Jay Soffian <jaysoffian@gmail.com> writes:

>> I suspect that it would be more consistent with 6b44577 (mergetool: check
>> return value from read, 2011-07-01), which this patch is a follow-up to,
>> to do:
>>
>> 	read answer || return 1
>>
>> here.
>
> Thanks, sorry I missed that.

Thank _you_ for spotting these unchecked "read"s.  Will queue.
