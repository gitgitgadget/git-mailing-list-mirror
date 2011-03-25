From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HOME must be set before calling git-init when creating
 test repositories
Date: Fri, 25 Mar 2011 13:49:37 -0700
Message-ID: <7vsjub53j2.fsf@alter.siamese.dyndns.org>
References: <20110325200528.GA7302@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 21:50:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3DxT-0007DR-9g
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 21:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab1CYUtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 16:49:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836Ab1CYUts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 16:49:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 416163D70;
	Fri, 25 Mar 2011 16:51:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FidVIudyOpXvtAMlwpwxXe0AyUc=; b=E5ZUTt
	XuRvmoSH41iWBiLge9zUhRwKMp9zQJGf6Ogb69Xf9NbsS4dEekeOHQNiSgbb/k/C
	EySdGHExF/G0BvRlWQNLtCk9KD1JP3SA8sTrGUyKkglGbeR3c2JO9qGpmPQcaPR4
	FmEuwk6mVUOko/5Pfb2gww+lbOKDJcOj6bFVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CidDBf7pyWr876Bs5gzDlWLbOiQLKlDh
	55hVGE8lkgjxV1kQL62gAJE8PY1434mCqiHqh824Mo8NK/F+yJYdwgu5N3HZq/uy
	RL9slYwYo7PBmes9btsrcphbqBaECvvFsBcj5IXaYQBe/Q1X31qeV/KxRy7lJB1W
	NKjWEMArAzI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1DB423D6F;
	Fri, 25 Mar 2011 16:51:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB6F63D6D; Fri, 25 Mar 2011
 16:51:22 -0400 (EDT)
In-Reply-To: <20110325200528.GA7302@blimp.localdomain> (Alex Riesen's message
 of "Fri, 25 Mar 2011 21:05:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6848F5E-5721-11E0-A16B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170017>

Alex Riesen <raa.lkml@gmail.com> writes:

> Otherwise the created test repositories will be affected by users ~/.gitconfig.
> For example, setting core.logAllrefupdates in users config will make all
> calls to "git config --unset core.logAllrefupdates" fail which will break
> the first test which uses the statement and expects it to succeed.

Doesn't this change the location of HOME used during the test as well?
