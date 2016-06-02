From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix prune/gc problem with multiple worktrees
Date: Thu, 02 Jun 2016 10:44:55 -0700
Message-ID: <xmqqy46ntrhk.fsf@gitster.mtv.corp.google.com>
References: <574D382A.8030809@kdbg.org>
	<20160601104519.16563-1-pclouds@gmail.com>
	<xmqqshwwzyee.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DjKo-HcyG6sKhhvx8vtySn6VTTP-E6vX2uKNEJgjouZg@mail.gmail.com>
	<575017FF.1020901@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 02 19:45:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8WgD-0003P2-32
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 19:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970AbcFBRpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 13:45:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751963AbcFBRpE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 13:45:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1BEE210A5;
	Thu,  2 Jun 2016 13:44:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FT9hvxOelCP51c9KSHMg7btD98o=; b=dVGf+B
	hfttYAqS9MrvnLCkWOoOaPcQseVhipDlFixDVHh7n3vqREj1uzymRtXcs5uoJeNu
	4ylrj3IOTr3bbRZ+PW59ERfDtP53DIMGSoC/ztKnNzcdEXxG/DhPP0vGdR6rEf+q
	umt/C3Y5F5nozVacbw+xCAr0bZh4DOi5QUJoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pAUmHsvKdWSZrPJx9cnr4XGf+2nQVJ3Z
	PHI8nVnm/MSQD8bYv1/as6G9i76z2QN5gS767wnl1A2BzgOpN5yFJhykro7cuW8o
	/FCgnmJo7pQnqcT8SFKCxcpDWwyn3CBJj4CRNSMSm7Dl28eBQv+/t17tyuT7hYX9
	wQyVtGv0UF4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AE5F210A4;
	Thu,  2 Jun 2016 13:44:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21045210A2;
	Thu,  2 Jun 2016 13:44:57 -0400 (EDT)
In-Reply-To: <575017FF.1020901@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 2 Jun 2016 13:26:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8AB3BDE-28E9-11E6-A8F0-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296219>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Fixing reachability via the index and detached HEADs feels relatively
> important.
> ...

I agree with the order of importance above.  But "relatively" is a
very good keyword.  Just like bisection refs, what is in the index
and the commit detached HEAD points at are expected to be tentative.
As a part of still-experimental feature, I'd rather see our
bandwidth spent on fixing it the right way first time, instead of
piling on an unproven quick-fix as a band aid, having to rip it off
and fixing it properly later.

> It's hard for me to predict when the ref-iterator stuff will be merged.
> It is a big change, but so far the feedback seems pretty good. I can
> tell you that pushing it and ref-stores forward is high on my priority list.

Thanks.
