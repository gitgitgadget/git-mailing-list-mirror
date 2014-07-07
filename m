From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] cache-tree: Create/update cache-tree on checkout
Date: Mon, 07 Jul 2014 11:58:25 -0700
Message-ID: <xmqqmwclc7xq.fsf@gitster.dls.corp.google.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 20:58:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4E7Z-0005IG-C8
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 20:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbaGGS6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 14:58:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50956 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbaGGS6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 14:58:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0D0927BAB;
	Mon,  7 Jul 2014 14:58:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h8yGjG1It906d0th7OY8xF/hdUs=; b=IdK6I7
	oq7qxyRTpeSpUj8Is4FElW5mve9Sz4IDE2dPuLaPMqRRvG8If+udCGjepF09fGNP
	dopBh9vfv1HQxer1OJ3YQFFVIOJhiE0wMFjbk7XYjQ/6OmvEpUek09ymMi8r8Nf0
	f/G4dBRHIsoLk9sMDrvWLweMzVzL3pJqMIQl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J1lF2TGQpelmR72iSGwEevO86LeaQOzU
	/yzO8WxqzBsFToE/mOuOALfE6oT+mr+BnTs1PyIsnDW4mrR22SKTeoX5uPxqsAt4
	GP6v5sbaIeirddn0ISLLL/l4xeAKkCCeZsZmbvCh51AyhFVnKxCgLNx4YTSP/OcU
	GHtcS8+mSAg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D6C8B27BA8;
	Mon,  7 Jul 2014 14:58:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9F1F927BA2;
	Mon,  7 Jul 2014 14:58:13 -0400 (EDT)
In-Reply-To: <1404619619-4774-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Sat, 5 Jul 2014 21:06:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A5A6A31C-0608-11E4-BA45-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252981>

David Turner <dturner@twopensource.com> writes:

> When git checkout checks out a branch, create or update the
> cache-tree so that subsequent operations are faster.
>
> update_main_cache_tree learned a new flag, WRITE_TREE_REPAIR.  When
> WRITE_TREE_REPAIR is set, portions of the cache-tree which do not
> correspond to existing tree objects are invalidated (and portions which
> do are marked as valid).  No new tree objects are created.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---

Looks safe, if a bit wasteful, to me.

Thanks; will queue.
