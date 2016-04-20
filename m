From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/3] Implements the GIT_TRACE_CURL environment variable
Date: Wed, 20 Apr 2016 11:41:03 -0700
Message-ID: <xmqq4maww2bk.fsf@gitster.mtv.corp.google.com>
References: <20160420162825.62380-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 20:41:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asx3q-0006Wd-4g
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 20:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbcDTSlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 14:41:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751277AbcDTSlG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 14:41:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1394514C2F;
	Wed, 20 Apr 2016 14:41:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sPJUNrJtrtYqjd36WGMyffHi4cM=; b=kOwX6w
	jMGAOLrLfP/3xjXgSyFHAWKTo0q6dewhPnWqzATcsH9oS9e34HgtvZN5qrRbZZKl
	mLwICPG05RjRZBtLnpDpgzzvoPVfvWBkiDJloDteu+bQH9fkrRh04BmX6cIMSHHE
	NxwFgg3WyOLY7uPC3RIOfMRnbxo0Ccw0oeJ2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kDfU+C6T+OOFurAeS6g4saQbKUbRBB/5
	jycDdExJpEgZim9epUVVW5ReyckfWfm0mDFL26PAu/vbY/k+KUmUC4UVo2CzZYgM
	29oKd+CUV9TU1eozYTaSWbpoTVHuc0PFgRSTij4TWk4w9g14V0yk4m0oDaefqQbV
	9NZ+CbmdhGU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09BD614C2E;
	Wed, 20 Apr 2016 14:41:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EBCE14C2D;
	Wed, 20 Apr 2016 14:41:04 -0400 (EDT)
In-Reply-To: <20160420162825.62380-1-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Wed, 20 Apr 2016 16:28:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6FF243DA-0727-11E6-9129-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292054>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Elia Pinto (3):
>   git.txt: document the new GIT_TRACE_CURL environment variable
>   imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
>   http.c: implements the GIT_TRACE_CURL environment variable

I think 2 & 3 need to be swapped; otherwise 2 would refer to
yet-to-be-invented curl_trace() function, and break the build
without 3, no?

Strictly speaking 1 should come at the end for the same reason, as
setting GIT_TRACE_CURL after seeing that commit would not give users
anything new.

Other than that, I didn't find anything blatantly wrong ;-).  Will
nitpick individual patches later but I expect that it would be
sufficient to locally tweak while queuing without rerolling.

Thanks.
