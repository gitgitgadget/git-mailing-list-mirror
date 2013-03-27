From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Support custom tunnel schemes instead of SSH
 only
Date: Wed, 27 Mar 2013 09:27:40 -0700
Message-ID: <7va9poolj7.fsf@alter.siamese.dyndns.org>
References: <51521216.2050309@gmail.com>
 <20130327043255.GA3667@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wieser <wieser.eric@gmail.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:28:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtCt-0007w2-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab3C0Q1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 12:27:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33532 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab3C0Q1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:27:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F73DAF1E;
	Wed, 27 Mar 2013 12:27:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FlY8ACUJl5IuLKeX5ztG/WFhYPM=; b=OgSSyJ
	8qxS9Fb1pN8rYZu3sPkqTGdYNFmjCrq83+kD27JBAQueZ1qY28y0JJE40ZmY4Fzy
	HFrWt3jkdAsiMVt0lMmfYFeKqJmWhEFPZy5Xvt/nljg/J5ywI/Umm8Qt3nc99XTq
	D4N4J28uFNpH0RSGZdEueE1ZWV6xLsKPWElsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nB2nmUzs+Dj8xlXJcRWPZDnNRCBUu3lU
	NE/eyl2QM2vU0j+kLtf+L1PgOi9eqSvDLhx5bS9D+5ugqWoE4nDx/vL00cvE6oFQ
	oE9dNkP/gwIIuwoHMT0HDRM8v921ByYW1fjVDErDJWqVsMbGRWKoOVUZdugTp8nT
	iLSDCzdvs8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FD42AF1C;
	Wed, 27 Mar 2013 12:27:42 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88774AF19; Wed, 27 Mar 2013
 12:27:41 -0400 (EDT)
In-Reply-To: <20130327043255.GA3667@dcvr.yhbt.net> (Eric Wong's message of
 "Wed, 27 Mar 2013 04:32:55 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F30F93E-96FB-11E2-9259-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219270>

Eric Wong <normalperson@yhbt.net> writes:

> Sebastian Schuberth <sschuberth@gmail.com> wrote:
>> This originates from an msysgit pull request, see:
>> 
>> https://github.com/msysgit/git/pull/58
>> 
>> Signed-off-by: Eric Wieser <wieser.eric@gmail.com>
>> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>
> Thanks, looks obviously correct.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ...
>
> Junio:
>
> The following changes since commit 2bba2f0e6542d541e9f27653d8c9d5fc8d0e679c:
>
>   More topics from the second batch for 1.8.3 (2013-03-26 13:16:11 -0700)
>
> are available in the git repository at:
>
>   git://git.bogomips.org/git-svn.git master
>
> for you to fetch changes up to 3747c015704399dea1aa7ae6569a507e5727e20b:
>
>   git-svn: Support custom tunnel schemes instead of SSH only (2013-03-27 04:28:04 +0000)

Thanks.  Will pull.

By the way, did nobody in the patch chain find the log message
problematic?  It does not give any information other than a URL to
an external site, and if you look at the URL it refers to, it only
says

  "git svn fetch" failed while talking to svn+xyz:// at Git/SVN/Ra.pm line 307

which could easily have been written in the log message itself with
fewer words.
