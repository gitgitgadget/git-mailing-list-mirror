From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] Add an option to git-format-patch to record base tree info
Date: Thu, 31 Mar 2016 10:45:02 -0700
Message-ID: <xmqqpouao82p.fsf@gitster.mtv.corp.google.com>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:45:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algek-0001NZ-JN
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005AbcCaRpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:45:08 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756821AbcCaRpG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:45:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C731852272;
	Thu, 31 Mar 2016 13:45:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EexHl8ifXsZ01xWy7a4gGZK6yvk=; b=Ydmc2E
	4DBEVerQOW/xpFR2IhDReq7u2gOIwrFxm5zJlnC5KfTsC55T3iRjJAp646Pf53zE
	Vy7M7OlYpaQlwTeO/R/CiXFayxEMxzNimHBpekqISiz8TyQWGKppn2czqYuvEBRr
	qB/djint/q2vf9HBF3K3orvjemKP9q5iAes10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l7DuLpsKEfhT1UBKh8RN6chJmR/Y0QTE
	JEsWVueQCPdn6GhjMc6PuAPdYM7V0ep/r6h3RkM5WAScKhUFGJoBPRjFG5WmElsP
	kMYJVFKlaykehcWvhjagkMG3J9pqiso0YgAj89GQQIjGB/UJ6SM6DBsDZDSXx1LM
	039qVjoR8Rk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD6DA52271;
	Thu, 31 Mar 2016 13:45:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1B3315226E;
	Thu, 31 Mar 2016 13:45:04 -0400 (EDT)
In-Reply-To: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Thu, 31 Mar 2016 09:46:12 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4CD02C88-F768-11E5-9B16-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290431>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> V3 mainly improves the implementation according to Junio's comments,
> Changes vs v2 include:
>
>  - Remove the unnecessary output line "** base-commit-info **".
>  
>  - Improve the traverse logic to handle not only linear topology, but more
>    general cases, it will start revision walk by setting the starting points
>    of the traversal to all elements in the rev list[], and skip the ones in 
>    list[], only grab the patch-ids of prerequisite patches.

This looks much more sensible than the previous ones.  I sent a few
comments on remaining issues separately.


Thanks.
