From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool--lib: refactor {diff,merge}_cmd logic
Date: Mon, 17 Jun 2013 13:13:16 -0700
Message-ID: <7vtxkwbin7.fsf@alter.siamese.dyndns.org>
References: <828585499e535649d14ef0ecd0f53403aefb10c2.1371405056.git.john@keeping.me.uk>
	<CAJDDKr5ewcYgtZn-oCQ5b=rGix5EALRdiSaNMatOwtP75e0h3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 22:13:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uofnn-0006UL-Kd
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 22:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab3FQUNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 16:13:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46265 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588Ab3FQUNS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 16:13:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38756281B5;
	Mon, 17 Jun 2013 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VDmHrEJLxQNGTqFyZV20mu8Rjj8=; b=scItck
	69qVzqX/FEXjiG72Q5TG1KVDyB+euZv8k5C87+02NLe4aSgvYvlGu1VRzdNIqvKb
	vgqhRkZAeQ/PSAi7NTNcgnHGTJaTkRsSbdxEYzV3mlmos/5DsLt7tGZ4vr/3t6H8
	2HsJi2c2WBqje2whqvJZIPukcxcDuW8GyvgCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lAM3MbPdQItImUbafIKtqmdhPx3l76Nu
	vkBd3BAEjuOsZeGtwowEPR/YFvd8jvc/HcAGkFEnSe15Hi/Ek9F6HlTlwx2J8B2m
	zPjv2NGrx4SqHftjm/BebqYSmZHWASDo/mP61EJTAYFrdQIGNyJzfoeXtT6TOsNE
	r25m0mCq6rI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C104281B4;
	Mon, 17 Jun 2013 20:13:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97AFB281AA;
	Mon, 17 Jun 2013 20:13:17 +0000 (UTC)
In-Reply-To: <CAJDDKr5ewcYgtZn-oCQ5b=rGix5EALRdiSaNMatOwtP75e0h3g@mail.gmail.com>
	(David Aguilar's message of "Sun, 16 Jun 2013 22:31:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 593030BE-D78A-11E2-BE1B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228109>

David Aguilar <davvid@gmail.com> writes:

> On Sun, Jun 16, 2013 at 10:51 AM, John Keeping <john@keeping.me.uk> wrote:
>> Instead of needing a wrapper to call the diff/merge command, simply
>> provide the diff_cmd and merge_cmd functions for user-specified tools in
>> the same way as we do for built-in tools.
>>
>> Signed-off-by: John Keeping <john@keeping.me.uk>
>> ---
>
> This is a nice cleanup.
>
> Acked-by: David Aguilar <davvid@gmail.com>

Thanks, both.
