From: Junio C Hamano <gitster@pobox.com>
Subject: Re: confused about remote branch management
Date: Wed, 23 Jul 2014 14:41:19 -0700
Message-ID: <xmqqmwbzda80.fsf@gitster.dls.corp.google.com>
References: <1406083743.29001.139.camel@localhost>
	<53CF66D4.7060201@gmail.com> <1406143336.29001.185.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Ross Boylan <ross@biostat.ucsf.edu>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:41:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA4I0-0006GG-NY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933491AbaGWVl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 17:41:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56141 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933386AbaGWVl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 17:41:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A2952B305;
	Wed, 23 Jul 2014 17:41:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2bUGLvdfif554ZLCR961peur1vg=; b=UskD8r
	CfPJCSGy6iDEAmT5+mBcoDloAAtZFKFw5YdxdaH/z/wtHhYs7+g74LqRIxq+IIEP
	sOG4+RJ5hrQ5qFX6PUX2Uuq0EfzR9/5mOVU91s51NIglFx5yjJ+UpWmNOwiCvBou
	tOH37grx/akuu5/WCwYvVYbSFhJfTRflgig5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cJr3owCqQ+dAk0TZ/SD68xe5XxW8BzcN
	ZRUHDSqtsRFrW38kqDeTRpIo5ZP+Fck0aNEvEdzh7BcMCl0SG1jGArWmEkGffrFS
	PNyjYf5CEHWWW+SzNBvAhjBRdzfnEr7qBnns00RAvhxNXeDVcTweQcBHobCOOJFR
	JtOP2LVIg4E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F6752B304;
	Wed, 23 Jul 2014 17:41:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 447032B2F6;
	Wed, 23 Jul 2014 17:41:21 -0400 (EDT)
In-Reply-To: <1406143336.29001.185.camel@localhost> (Ross Boylan's message of
	"Wed, 23 Jul 2014 12:22:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 162495A8-12B2-11E4-9EB7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254128>

Ross Boylan <ross@biostat.ucsf.edu> writes:

> I still don't know what I need to do to update origin/master in my local
> repo.
>
> Regarding Kevin's suggestion, I just tried "git fetch origin master".

I think Kevin's suggestion was 'To older git, "git fetch origin
master" tells it to fetch master without updating origin/master, so
it is understandable that your origin/master was not molested'.

Either

	git fetch origin master:refs/remotes/origin/master

or if you want to be more explicit and unambiguous:

	git fetch origin refs/heads/master:refs/remotes/origin/master

should work on all versions of git.
