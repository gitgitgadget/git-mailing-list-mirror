From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/technical/api-hashmap: Remove source highlighting
Date: Mon, 19 May 2014 10:09:12 -0700
Message-ID: <xmqq4n0l3dc7.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.02.1405170707260.44324@all-night-tool.MIT.EDU>
	<20140517152219.GA31912@hudson.localdomain>
	<alpine.DEB.2.02.1405172035160.44324@all-night-tool.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon May 19 19:09:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmR3y-0003mv-8o
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 19:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbaESRJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 13:09:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57184 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754384AbaESRJR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 13:09:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C72B164A8;
	Mon, 19 May 2014 13:09:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S/VU3aCmKiKuQDc8ty6h836D/WI=; b=aROZXh
	jh6lptWbC6/BBYIK2EL7UNucw1mWjjwgD2033TSFK/jsQRvXXxlcYAE1ihsPpR30
	1Havcn1Lrlc1JyiJUWvyD0Qth/kBvQ9onkqAflIXbgZYahOgrfUstXvIFaIPXLqP
	q45LQseg9Hh9waoOPkstsm32ENGKwKaXcLP3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+7ZHqtQ/+fzHB7aEyulOvqoQviKb7Q4
	zG9PtknJSM/NPxbCrliqDLglQWygJ6v4VPMOGKCypALj5iPOghpF0OlgCNRdGhm0
	d+q3K8drfYggQT7si0X50yU0iHRxbVvtAUELzZMdGWdrX+xUslesJ4Yzb0n8+QUy
	Qldyev366FM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22836164A6;
	Mon, 19 May 2014 13:09:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C74C01649D;
	Mon, 19 May 2014 13:09:13 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.02.1405172035160.44324@all-night-tool.MIT.EDU>
	(Anders Kaseorg's message of "Sat, 17 May 2014 20:50:35 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4D5D3448-DF78-11E3-8A92-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249601>

Anders Kaseorg <andersk@MIT.EDU> writes:

> Yes; when I noticed this failure, I asked Jonathan to add source-highlight 
> as a build dependency in Debian (https://bugs.debian.org/745591).  But 
> then Ubuntu forked the packaging to revert this change 
> (https://bugs.launchpad.net/bugs/1316810), because source-highlight in the 
> community-supported universe repository is not allowed to be a build 
> dependency ...

The reasoning and solution Ubuntu has sounds sensible *but* it also
soudns like it is incomplete.  If Ubuntu does not want to use
highlight, it can apply a change like the patch in question as part
of their fork to make the end result consistent and they are failing
to do so.  If the tooling do not use highlight, the source should
not require highlight, either.  It is ultimately their bug.

It however *is* our business, as their upstream, to make it easier
for distros that want to use and distros that do not want to depend
on highlight, and aiming for a solution that relieves Ubuntu or any
other distros from needing to carry one more patch is a good thing.

How bad does the documentation look with the patch applied (I know
how bad it looks without source-highlight installed)?  If it is not
too bad, then it sounds like a sensible solution to drop the
highlight markup unconditionally like the patch that started this
thread does, taking the "common denominator" approach.  You seem to
agree, and I do not object, either.

> But I don’t that would be worth it just to make one page of the API 
> documentation a little more colorful (and it sounds like you agree).
