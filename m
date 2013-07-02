From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 3/7] git-remote-mediawiki: New git bin-wrapper for developement
Date: Tue, 02 Jul 2013 16:04:11 -0700
Message-ID: <7vfvvwimxg.fsf@alter.siamese.dyndns.org>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
	<1372804789-12732-4-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Wed Jul 03 01:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu9cW-0004Sv-TW
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 01:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab3GBXEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 19:04:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727Ab3GBXEU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 19:04:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFCE52D7D3;
	Tue,  2 Jul 2013 23:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kdKlqenCJNcGRAg8YFgY1U9n+pA=; b=B8MP48
	YuA1eUd7ZTl2ggL+LFBdb87xxrMCHEKbVh/QI3lWkFp2Jpo6IeUwu1/7DBmiUaoe
	L4tylyxjMa/oqIMT/7o2hhocZWMaYrYxGPC6hlchofW//6ZHoyZP3Pk2cm8RUcDC
	v5ttyBJ5bWkOC88PZeX3aoaib6ldJeNT411dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TCZympjhrk23enkurGtnS8apklEoN02f
	cRVsX5+7FBDFM/QAOEjL+q0IQo/m+EE89lvrVcmMCrwWWomlF0esxOadqq743u/m
	0Qh9RZeakUheGubLmg+BK5FIuy7tYxuAfuAqDDtw67HideCSBQxzfOBk9aMEP/76
	CLxgBhMTXao=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A379D2D7D2;
	Tue,  2 Jul 2013 23:04:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2019A2D7D1;
	Tue,  2 Jul 2013 23:04:19 +0000 (UTC)
In-Reply-To: <1372804789-12732-4-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Wed, 3 Jul 2013 00:39:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9B837BE-E36B-11E2-890F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229447>

benoit.person@ensimag.fr writes:

> +GIT_ROOT_DIR=../../..
> +GIT_EXEC_PATH=$(cd "$(dirname "$0")" && cd ${GIT_ROOT_DIR} && pwd)
> +
> +GITPERLLIB="$GIT_EXEC_PATH"'/contrib/mw-to-git:'"$GITPERLLIB"

The same comment on ':' applies here.

> +PATH="$GIT_EXEC_PATH"'/contrib/mw-to-git:'"$PATH"

But not to this, as PATH is unlikely to be empty ;-)

> +
> +export GITPERLLIB PATH
> +
> +exec "${GIT_EXEC_PATH}/bin-wrappers/git" "$@"
