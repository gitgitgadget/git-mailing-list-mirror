From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 12:47:17 -0700
Message-ID: <7vei60p86y.fsf@alter.siamese.dyndns.org>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com>
 <7vwrjssbfk.fsf@alter.siamese.dyndns.org> <4D877FAD.9000807@viscovery.net>
 <4D879516.3060204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:47:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1l4o-0007vF-1E
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab1CUTrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 15:47:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab1CUTr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 15:47:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 50AC34329;
	Mon, 21 Mar 2011 15:49:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nKEpjILmekx/tJ4J5fu/Cfr8qbg=; b=OqbxQW
	+fAw40r5JMI1CZAFz3eTZV8Rye4hKZ2TsGqBCC/Z6vu+132iQptbZidDah9e64e1
	fmbAG+zy/wDnJK+ZpOZHIkXZJOOchLA77b9etaeJNXAQNBNENFoP62EfRTAxKFkp
	AW780tpIMKdI9DRE57RMO7R2+uu3wfPGmyziw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZwUfBJ4Mu8rk7QQtBibHdVisMo4aLd7Z
	cc3iBf9fr5FI/Ivt9ll5EH7OQka65pUDgQm2TgzU9kpO0s/73fXKCmj+WISq+4wp
	gLOv885Fc2qQY8+OvDqn1CNehTj0ac2WRiE7aQzDeQfXdhEcRQSIliU0eqeeXi+9
	1ZKN2EOOdHg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 204F54328;
	Mon, 21 Mar 2011 15:49:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B98AF4327; Mon, 21 Mar 2011
 15:48:58 -0400 (EDT)
In-Reply-To: <4D879516.3060204@gmail.com> (Piotr Krukowiecki's message of
 "Mon, 21 Mar 2011 19:12:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4676F3E8-53F4-11E0-BD0D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169651>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> I think I even suspected this might have something to do with the merge
> conflict and tried to make git-diff show me exact change between working
> tree and index/HEAD (ignoring the merge).

Doesn't "git diff HEAD" show the difference between HEAD and working tree
without the higher stages for the path getting in the way?

The difference between the index and the working tree is "git diff" which
is condensed.  I think you can force it to uncondense it by giving "-c"
option, but I haven't tried (didn't find a need/use for it for a long
time).
