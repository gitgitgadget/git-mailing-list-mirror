From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: update help text
Date: Thu, 31 Mar 2011 14:44:15 -0700
Message-ID: <7v39m3j780.fsf@alter.siamese.dyndns.org>
References: <1301404805-12095-1-git-send-email-pclouds@gmail.com>
 <20110329210457.GA14031@elie>
 <AANLkTiknvWE9Fe3u88Jbis4Cgxd5ubqaR6MzYOJZ-AtM@mail.gmail.com>
 <20110331184246.GA19264@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 23:44:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5PfU-0002Te-8l
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 23:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758829Ab1CaVof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 17:44:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab1CaVoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 17:44:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E86D4FBA;
	Thu, 31 Mar 2011 17:46:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c3+FibAF7rvh+vi/DkD2e+XuzwI=; b=etnmUp
	G6jIdX5nihAgbfzLGL76sP4vb/IuX95Oemv0VPxOJ+buHvONFH84i7VTIzhDO+mZ
	/OKs3V3MKxu6p7go6ZaI6mNSBkQMkxJnmcLK3LirYh8Hrv6xO9oI0wWfo2/gl1bh
	T4mlO5ZQoZu2D8e8J2YllJvPXWka8Y2SqabaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f6xZ5ijPJf93JTSGlz0rtljV+h4uoyT8
	GgnZvO5NvLOwDSSM/YGt9OiEzQdfX0J2EroNr5x7sKDjZ1LK/F+h79gE44e9ns0g
	Azeg4KfkoAbNvpr3MPjkTQa9lQuvHwCbtbgw/VtvHq+Cf/uXCGbRKd6NWZQrAJK+
	4J6d7iZOQxo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D57A4FB7;
	Thu, 31 Mar 2011 17:46:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 64E6F4FB1; Thu, 31 Mar 2011
 17:46:06 -0400 (EDT)
In-Reply-To: <20110331184246.GA19264@elie> (Jonathan Nieder's message of
 "Thu, 31 Mar 2011 13:42:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DB3672E-5BE0-11E0-BC8A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170532>

Jonathan Nieder <jrnieder@gmail.com> writes:

> [1] Detailed semantics: for each path listed by "git diff --name-only
> HEAD <commit>":
>
>  * if the worktree, index, and HEAD match, make the index and worktree
>    match <commit>.
>
>  * otherwise, if it is "not easy" to keep local changes, error out.
>    We are not going to do a three-way merge.  That is,
>
>    - if the index matches neither HEAD nor <commit>, error out;
>    - if the index matches HEAD but not the worktree, error out.
>
>  * otherwise, it is "easy", so keep local changes.
>
>    - if the index already matches <commit>, leave the index and
>      worktree alone.
>    - if the index and worktree match HEAD, make them match the
>      <commit> instead.

The latter item in the last "otherwise" is the same as the first "if all
match, move to the one from the named commit", isn't it?
