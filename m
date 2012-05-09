From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/19] tests: add tests for the bash prompt functions in
 the completion script
Date: Wed, 09 May 2012 11:36:25 -0700
Message-ID: <7vvck5ryl2.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 20:36:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSBkX-0004In-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 20:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab2EISg3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 14:36:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753414Ab2EISg2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 14:36:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D58CE78E4;
	Wed,  9 May 2012 14:36:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Rji6qiSMESv/
	MMc14fYZJ4Ab/Ak=; b=cYJvRO83+XWFg7aj+0Jep+QKFaKXoZzUd9BgW2ZhLNMq
	Z8Gp2z3W+RolvjBOsk5xlEvQmOI5ox+ngc6UwwR/xGeaD4OkrHs/wFqQRwTzIFB8
	Bystk8HVMy/QsK0Cv3Ox+e32EGPuETNTjQ30QDV0MzuZxVekfHbd/KALCPxaMyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UBMvR6
	2eyv1n5D8zVgdZDYwcQ+99bZ454Q3fX/DI353/mzB4M20SXTp6L2hWCgsqf6oHvo
	hdkdP585uiYP7Rp6GwFMFBo/RKc7E182iTdLfIx0emftxxN4MzTYJdmljFAiUl6U
	acsfrlGN1JjNbx4dzwyO2eJSKhKgOaBLmu2KY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD4A478E2;
	Wed,  9 May 2012 14:36:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A13C78E1; Wed,  9 May 2012
 14:36:27 -0400 (EDT)
In-Reply-To: <1336524290-30023-3-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 9 May 2012 02:44:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E31EE9E6-9A05-11E1-AB06-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197488>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> The tests cover the discovery of the '.git' directory in the __gitdir=
()
> function in different scenarios, and the prompt itself, i.e. branch
> name, detached heads, operations (rebase, merge, cherry-pick, bisect)=
,
> and status indicators (dirty, stash, untracked files; but not the
> upstream status).
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Looks like a quite comprehensive tests around GIT_PS1_$MANY_DIFFERENT_S=
TYLES
(except that GIT_PS1_SHOWUPSTREAM seems to be missing); very nice.

> +	echo 1 > file &&

When you are going to re-roll to add the missing SHOWUPSTREAM test, in
addition to J6t's $PWD vs $(pwd) vs $TRASH_DIRECTORY fix, please fix th=
ese
redirections to match the coding styles (i.e. "cmd >file" and "cmd <fil=
e",
with SP before and without SP after redirection operators).
