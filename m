From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] fsck: improve committer/author check
Date: Tue, 02 Aug 2011 10:00:58 -0700
Message-ID: <7vfwljg33p.fsf@alter.siamese.dyndns.org>
References: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
 <1311831844-13123-6-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, SASAKI Suguru <sss.sonik@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 19:01:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoIL5-00072A-KU
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 19:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab1HBRBC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 13:01:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656Ab1HBRBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 13:01:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76B174F12;
	Tue,  2 Aug 2011 13:01:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9rJPYJbSMAUgiz/VkIafEJeMm+w=; b=lR+Nnn
	LjTGa0Q1AlFhfLm3FMCNG8mFCrSTTWNwGxHIl+8tDnMTv9hGFLjXrJGg/nXggyph
	Bsx0+Kop3a6qjiX4IZlxVWsQPE5BgUb1oWc+qioTRwSyTh5mstFRmdnX5D/096HQ
	i3CQ0E70uRFrIKv0wj46D7/OT+bjdQVqrxstE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VGIHiRHXhUMzhuE1c6SbBIrrNmXkkYli
	0/M1yOgG+RqHcrMOZfdBR/mMyBhOJYBtOG1MfTn+Upp9+Pjob+2d4ea/ZOLSRRPx
	KiqBRjQnBJHZlc9gjLs1zc0rzsdqCtuEa7r8dEIhulwv0Kw1agH0/t0VGwm3uIIZ
	oWfSNRcMlVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B2DF4F0F;
	Tue,  2 Aug 2011 13:01:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0074A4F0C; Tue,  2 Aug 2011
 13:00:59 -0400 (EDT)
In-Reply-To: <1311831844-13123-6-git-send-email-divanorama@gmail.com> (Dmitry
 Ivankov's message of "Thu, 28 Jul 2011 11:44:04 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF4478BC-BD28-11E0-8F8E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178483>

Dmitry Ivankov <divanorama@gmail.com> writes:

> Neither name nor email should contain < or >, so split the string with
> these and check they come in that order and < is preceeded with a space.
>
> If < is missing don't say a confusing "missing space", say "bad name" if
>> isn't missing and "missing email" if both < and > are missing.
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> ---

Same comment as 3/5; before starting to talk about how you implemented
your validation, please state what rules you are enforcing.

Thanks.
