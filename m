From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 29/48] merge-recursive: When we detect we can skip an
 update, actually skip it
Date: Mon, 18 Jul 2011 16:39:57 -0700
Message-ID: <7voc0rb1ki.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-30-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:40:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixPx-0003MY-ST
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab1GRXkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:40:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab1GRXj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:39:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11EE041F6;
	Mon, 18 Jul 2011 19:39:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=3l92cOuJnB2CRJZAma8QsOqFQTs=; b=nRibHDTt+f0jOomTSCdg
	W7fX+2zGdKMhS7yGMoiWMS8AnpFdLaDmvmqWc7N87Y8juWOTEaVPMu5kWSxY8sww
	NWWoA0bIFUXMtqVj6mj1FhrBFQ9AZ+3Xaui9EWAX5Nnu2Bdv6NpXNVWh1OnvdncU
	UUdsLdx9qNZ8gQR3Zm+uvX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BcM/l9ad72TFUFTCfEsKXxt5YQrCD+jSyF55z6xWcV8CVT
	Y6XGj3b1GGRMTivzmnFYzdo9otQqXwgbA8RakGifQm3svW7aKGlVGP9rrf3nPLqz
	6MBKQnlLFlb/EwFE2IHYh9dJMZNCh50gKG8e256Uh1v4n7Go47Pi8t0CQQ7Vk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0786D41F5;
	Mon, 18 Jul 2011 19:39:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AB8941F4; Mon, 18 Jul 2011
 19:39:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F87586A-B197-11E0-ABAA-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177425>

Elijah Newren <newren@gmail.com> writes:

> ...  The reason this change works is due to the changes of the
> last few patches to (a) record_df_conflict_files instead of just unlinking
> them early, (b) allowing make_room_for_path() to remove D/F entries, and
> (c) the splitting of update_stages_and_entry() to have its functionality
> called at different points.

Nice.
