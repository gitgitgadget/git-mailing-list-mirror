From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recovering from a bad object
Date: Sun, 22 May 2011 19:09:01 -0700
Message-ID: <7vtycmw4le.fsf@alter.siamese.dyndns.org>
References: <BANLkTindTWzeTFKYA3if4HYG3mj+NZX8oQ@mail.gmail.com>
 <7vy61ywjpa.fsf@alter.siamese.dyndns.org>
 <BANLkTinPOYH_pJsFkbQHCb_H5GhyTn+xhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "jonsmirl\@gmail.com" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 04:09:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOKa9-0007JV-Ly
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 04:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab1EWCJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 22:09:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab1EWCJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 22:09:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B97B553A;
	Sun, 22 May 2011 22:11:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7wVbEfm8hXmUO5w6pF+H8Ju+KwY=; b=V7UnOw
	IVfH2+67ie03cpKwq7X9zPoIYk+wtKbE51xFvTf/E9gNIob0rncWlnEGAzVgg5MS
	jcFw2BK+7n2eWT9Hg4dcqSUONmEcik8AZrC7AZy5dGNJGeUY7QIFF+xLX+kEz/av
	dzwDy4SSqmUcID+0igwn/jRTzaq0Ecggc7wPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sty3codE5G6lbMux8ZalF8k5LUvrabiW
	lit8ZlZ7b8A86ugqpT2R/Sb6xFX0L+30zbjpHbYoxtqjcciCK7kDJngYew5OhGhN
	zQEsr5pwMRLzgADpo3wBdtJ9ScGTrYb6HndGuqShSmzHetesKctAkGKPH7vAHDQQ
	UqiI4RafxpU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED1195538;
	Sun, 22 May 2011 22:11:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 248C45537; Sun, 22 May 2011
 22:11:10 -0400 (EDT)
In-Reply-To: <BANLkTinPOYH_pJsFkbQHCb_H5GhyTn+xhg@mail.gmail.com>
 (jonsmirl@gmail.com's message of "Sun, 22 May 2011 18:31:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF53AF4C-84E1-11E0-A0E5-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174218>

"jonsmirl@gmail.com" <jonsmirl@gmail.com> writes:

> Looks like the corrupt object is ok in the object store.

Yeah, that is exactly what I meant by the paragraph that begins with "But
seeing that your repack succeeded,...".

> I checked out about 20 of the dangling objects. They all start off with...
> ...
> That's stgit leaving all those dangling references.

I don't think there is anything to worry about dangling objects (there is
no such thing as "dangling references"--you may see "missing objects" that
ought to exist because some other object that is reachable from one of
your references points at it, which deserves your worries, but dangling
objects are garbage and nothing to be worried about).
