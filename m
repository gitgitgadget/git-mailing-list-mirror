From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "Already up-to-date!" merge isn't a no-op?
Date: Wed, 06 Mar 2013 14:08:12 -0800
Message-ID: <7v38w8p4fn.fsf@alter.siamese.dyndns.org>
References: <1826064298.2151517.1362605175796.JavaMail.root@genarts.com>
 <142915274.2151729.1362606487755.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 23:08:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDMVt-0000fG-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 23:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655Ab3CFWIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 17:08:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335Ab3CFWIP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 17:08:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDEABAD63;
	Wed,  6 Mar 2013 17:08:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HoPs/8oei/fhjqAwLuixC9a3O9k=; b=YMT44B
	GIC7/KW4r9DDyITcooQxPUhLCQdigRAjHRcse8ToYsEWXCUr2qRFAQCzpJqRQn6H
	BLDvNLQ2gedUPD3LcdUggQb52WZ7jalIHP8sSPW9WeaDJBiaMT8lxcNv/8zwMGws
	SU4FjNc1CfamI46GJ9SI8Ig19P04pdg+Ix484=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XDepbhoVkaOmt512BSlzrN4ifbWY2pzt
	EWJRiuriCtHjao5x49BYNFPMSAiJEIOi8qHDdCaFPenEiRoZAX6iLfmwG50sapLf
	8op8U8F95AScPPmNE7dgCX7vMf7JOvHgzA0O9oG21SQG8IcMaobM7bIlxJkVi5cu
	4x4aGTAEAC0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2929AD62;
	Wed,  6 Mar 2013 17:08:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 433FEAD60; Wed,  6 Mar 2013
 17:08:14 -0500 (EST)
In-Reply-To: <142915274.2151729.1362606487755.JavaMail.root@genarts.com>
 (Stephen Bash's message of "Wed, 6 Mar 2013 16:48:07 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 575D3B00-86AA-11E2-BF30-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217558>

Stephen Bash <bash@genarts.com> writes:

> So what is the actual meaning of "Already up-to-date!"?  Is it
> based on the tree, the reachable commits, or something more
> complicated?

The resulting tree of the merge happened to be the same as the
original tree (i.e. "git diff HEAD^ HEAD" is empty).

This happens quite often and is perfectly normal.  After merging
topics that has been cooking in 'next' to 'master', merging the
resulting 'master' to 'next' is likely to result in that situation,
unless 'master' has gained some other changes, such as updating the
draft release notes with a commit on it, or applying an obvious and
trivial fix before cooking it in 'next'.
