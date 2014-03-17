From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using "-" for "previous branch" failing with rebase
Date: Sun, 16 Mar 2014 23:37:30 -0700
Message-ID: <7vppll2uvp.fsf@alter.siamese.dyndns.org>
References: <20140315152924.26c3294e@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 07:36:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPR9v-000086-Ff
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 07:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbaCQGgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 02:36:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbaCQGgW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 02:36:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13CA46B6CE;
	Mon, 17 Mar 2014 02:36:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c68Nt3JWQUlIV4q5eiMRf2sTgog=; b=dyYxte
	7Uzz524rfWAthUzf02TkjwEmNEcM9aewae/uJ/EyLkmWqZJKC79MZbUhL1OK+vka
	imp8gShxRMRyzWSbZfSK2ZymlHPBIvUfLC7dHesg06LacM9P+UsAzM1qPS+DseL0
	E7OBwRLOVFZj4bhBCZddQQKTxi5omxt/qUzh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T0nhIJybPGLAAQ2kndqwSmX+TuEGbQ94
	N0zI82nM+maOSR5MXpk//uETaGJGRbSFyHm1sVi4LYgsvRfVhXFKTewLllNH44l0
	UYZpnwKz5BauruWMemXn/NO60OP0Opw/Hdkf9aOpTgz03xG9lpRemSoIaGbNj8i4
	dvpKFezu+Vc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EED7A6B6CB;
	Mon, 17 Mar 2014 02:36:21 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CE7F6B6CA;
	Mon, 17 Mar 2014 02:36:21 -0400 (EDT)
In-Reply-To: <20140315152924.26c3294e@bigbox.christie.dr> (Tim Chase's message
	of "Sat, 15 Mar 2014 15:29:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 73ECD0AC-AD9E-11E3-AB4C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244222>

Tim Chase <git@tim.thechases.com> writes:

> Is this just an interface inconsistency or is there a some technical
> reason this doesn't work (or, has it been addressed/fixed, and just
> not pulled into Debian Stable's 1.7.10.4 version of git)?

It is merely that nobody thought "rebase" would benefit from such a
short-hand, I think.

    Teach more commands that operate on branch names about "-"
    shorthand for "the branch we were previously on", like we did
    for "git merge -" sometime after we introduced "git checkout -"

has been sitting in my "leftover bits" list at

    http://git-blame.blogspot.com/p/leftover-bits.html

for quite some time.  Hint, hint...
