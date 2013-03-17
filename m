From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make GIT_USE_LOOKUP default?
Date: Sun, 17 Mar 2013 13:13:56 -0700
Message-ID: <7vd2uxrdh7.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 21:14:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHJyO-0007VO-6O
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 21:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab3CQUOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 16:14:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500Ab3CQUN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 16:13:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09873A896;
	Sun, 17 Mar 2013 16:13:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eQXTKzfTpihZXiDPE3+vRHfuXeM=; b=Fpzpm/
	X89NRCAnEuQxSjYL7QM1tZ/tHCU+gR274ObYPMt8FUuPPEVmizizE005T+2wgltk
	igGAOF1x21gWUHRgELpqi7GD/pPwq4g75zcUKk8hBFSy6KjsP4L+jTiuTHQbFacT
	CkHBBb/TbX0Y2GOM8fOqsip1V/tbY0CLGSqmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AEodJXDaY6+wEFKx9bm3fUHGBq3AaYw0
	e2h6wIk12fA5C6m4u+uojGTecDpfJjcwGTKjqm2bs9MXuxJiB1FdxXH0kAteBUNM
	vhJA+psDMApPANiOKJnkCagDVRCt0y4I0A2NIDLFQj3GsWvRpRsWH9LH1uth0YsZ
	IXul2zFkRhc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A27A894;
	Sun, 17 Mar 2013 16:13:58 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C2D6A891; Sun, 17 Mar 2013
 16:13:58 -0400 (EDT)
In-Reply-To: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com> (Duy
 Nguyen's message of "Sun, 17 Mar 2013 20:25:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 338D8DE0-8F3F-11E2-8813-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218372>

Duy Nguyen <pclouds@gmail.com> writes:

> This env comes from jc/sha1-lookup in 2008 (merge commit e9f9d4f), 5
> years ago. I wonder if it's good enough to turn on by default and keep
> improving from there, or is it still experimental?

The algorithm has been used in production in other codepaths like
patch-ids and replace-object, so correctness-wise it should be fine
to turn it on.  I think nobody has bothered to benchmark with and
without the environment to see if it is really worth the complexity.

It may be a good idea to try doing so, now you have noticed it ;-).
