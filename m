From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/9] fetch doc: add a section on configured remote-tracking branches
Date: Wed, 04 Jun 2014 15:17:35 -0700
Message-ID: <xmqqfvjktj40.fsf@gitster.dls.corp.google.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
	<1401833792-2486-9-git-send-email-gitster@pobox.com>
	<538F3359.2050601@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Thu Jun 05 00:17:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsJVB-0000jO-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 00:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbaFDWRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 18:17:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53587 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbaFDWRk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 18:17:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15D2B1C849;
	Wed,  4 Jun 2014 18:17:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LWUTv9VqJ0M7e6PSUO9S0dDi//k=; b=aii9vY
	araVxvFGPl8CcMhs94SklUJf5gsk939pFLErKvOLx5eQ8wr8ZNSieWZmwK4+v1sH
	sCrYvlnwjyCLjOBWBryuWK8DxXDthzWbtjq7soxC2KNcK2lVWDL2SZkvTpZvtBdC
	ZlPbh9DrwNq/dACFl5MF082PyJUUW+1ptPXxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fZPwT8H6hOuCNPvTdPVQjUyDLhfAl4Qw
	TsT4bnHjxUPwLM0IWjKh8++h+gBbP/8rlk22ao739UjnXKaHp29CtTwSvUT1jnE+
	Mh1hZhpxBlidsX8hJUkw5leELunxxCCptSlrwh9bdhdPTscMq6NgbzRjZAp9APXK
	ZamxUGNFF0g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CA181C848;
	Wed,  4 Jun 2014 18:17:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6AB011C846;
	Wed,  4 Jun 2014 18:17:36 -0400 (EDT)
In-Reply-To: <538F3359.2050601@xiplink.com> (Marc Branchaud's message of "Wed,
	04 Jun 2014 10:55:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 08653140-EC36-11E3-84D3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250797>

Marc Branchaud <mbranchaud@xiplink.com> writes:

[jc: omitted good suggestions I'll use in amending]

>> +  the refspecs to be used to fetch.  The example above will fetch
>
> /to be used//

I have a problem with that change, actually, because you do not
"fetch" refspec from anywhere.  A refspec is what is used to
determine what histories to fetch (i.e. left-hand side of it before
the colon) and which local refs to update with what is fetched
(i.e. right-hand side of it after the colon), and this description
of the traditional behaviour is meant to highlight the difference
from the second usage, which is relatively new since f2690487
(fetch: opportunistically update tracking refs, 2013-05-11),
i.e. how the variable is *not* used as a refspec when the command
line already has one.

Perhaps

    ... `remote.<repository>.fetch` values are used as the refspecs,
    i.e. they specify what refs to fetch and what local refs to
    update.

or something?
