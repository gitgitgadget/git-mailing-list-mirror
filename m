From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Tue, 10 Sep 2013 08:59:34 -0700
Message-ID: <xmqqy574zmzd.fsf@gitster.dls.corp.google.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
	<xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
	<CAHGBnuNKrtGSoOYS1T0VH=tGvKUW0XKFnWf_WNvZkOriGurgpg@mail.gmail.com>
	<xmqqr4cx1u7u.fsf@gitster.dls.corp.google.com>
	<CAHGBnuN=vpJPXgd78aLohW3Awe+Y+0J7Bxwr4Fmn2NijMK1Z5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 17:59:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJQLv-0004Re-8H
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 17:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab3IJP7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 11:59:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab3IJP7i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 11:59:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0248840165;
	Tue, 10 Sep 2013 15:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2uxU2LPwgt9c24a/5l1zeQDphQs=; b=NwVkv+
	eJ5w/ihS+0nBTnpveEH1Mk9pVn37qq14KdOGWwmp/hJptBy/ovCQpn1zpqNqlENs
	k1XWSbD1sOHYpLQSwvo4LdMzCCAJmMwtzrpYZm1wtgldTmykdo1w9AfZBQQvq7wh
	IwR6fdHkP97+nJj9c5UmZHwIgs7qQty9C+6k8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n4/xWVf/V6H4kOrzvRANZu0JXlajRIAS
	GCpQPtJvOMC9Eo2ADNRP9FOzU7EBPK8Ud9Fxu/m16rq2S3yYPvMj+FzdX9lPvZE9
	s1b9VnIZff5dP88AOyJohyzFV5JSohX3dAJ2PJ/EL4/08Y+hsWpCJcMGkvhjkwKs
	IjIFgSQuDrU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1F5840162;
	Tue, 10 Sep 2013 15:59:37 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF53F4015B;
	Tue, 10 Sep 2013 15:59:36 +0000 (UTC)
In-Reply-To: <CAHGBnuN=vpJPXgd78aLohW3Awe+Y+0J7Bxwr4Fmn2NijMK1Z5g@mail.gmail.com>
	(Sebastian Schuberth's message of "Tue, 10 Sep 2013 10:06:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE18B0B2-1A31-11E3-A527-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234437>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Right, but do we really need DEF_VER *and* version? Couldn't we just
> package official source tarballs in a way that they already contain an
> auto-generated version file?

If you read our Makefile, you will see that we do include the
version file in our official tarball with "make dist".

That however does not help those who use a tarball obtained from
git-archive, perhaps via gitweb running at the distribution site.

Theoretically speaking, you can rip out everything but "version" and
tell those who have been relying on the way other parts of G-V-G
worked to change their workflow to stuff their favorite version
string to that file before building, so in that sense, we do not
*need* DEF_VER and version.  But they have been there for a long
time, and I do not think it gives us a good trade-off between
risking regression and reducing the linecount to change it to remove
one.
