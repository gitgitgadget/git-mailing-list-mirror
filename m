From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fast forward a branch from another
Date: Thu, 12 May 2011 09:06:02 -0700
Message-ID: <7vsjsjdhud.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=PtkDp8PNdMNi3hTwHPjFg+Jtftw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 18:06:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKYP2-0003yx-Un
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 18:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757964Ab1ELQGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 12:06:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757951Ab1ELQGK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 12:06:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E5F7E492D;
	Thu, 12 May 2011 12:08:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rG0JzdsFYrhRKZIfx7AtL0cK7Jw=; b=mpN6Hd
	EeHDE7EOTuOZM7o5uiFaEyhetwYQbWO98fSqtx8xBf5axXMwPm8GaZANweAf9RJd
	DXcxfhknAeMvycGNM4GP+1xbxijOIEs2lkaMeD8ZVQenqHT0/Dy+qcBexJsKKMMh
	9mbwC4ykUuLZFf5GaRdNt3AewT2XmPIHzDzk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hl8eDgOMAV0uGV+c1bJi96muO467s+rP
	xe3gcuHuFGJNpcgHAyH86tcWPE7xISSyBMnH0eH+tDF6rh7ic9UvDP/C0Xd0O6wY
	bxiVASS2TbstXu1IjdwbfFSUXfFavY6rWNi2hqN1TnOnVLsgJz5BeuhsL3gG33CT
	mHy655folgQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C421F492C;
	Thu, 12 May 2011 12:08:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F0FC14929; Thu, 12 May 2011
 12:08:09 -0400 (EDT)
In-Reply-To: <BANLkTi=PtkDp8PNdMNi3hTwHPjFg+Jtftw@mail.gmail.com> (Eric
 Frederich's message of "Thu, 12 May 2011 10:40:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 098B3052-7CB2-11E0-8F6D-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173479>

Eric Frederich <eric.frederich@gmail.com> writes:

> Often times I get into a situation where I have a "development" branch
> that gets ahead of say a "stable" branch.
> When I am ready to call the development branch stable this is what I do.
>
> $ git checkout stable
> $ git merge development
> $ git checkout development

Instead of switching to "stable", while still on the development, you
could do

	$ git push . HEAD:stable

which would succeed only when you are purely ahead of stable (otherwise it
will fail as you are not forcing).
