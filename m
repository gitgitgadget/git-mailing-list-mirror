From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] compat/basename: make basename() conform to POSIX
Date: Mon, 11 Jan 2016 08:01:42 -0800
Message-ID: <xmqqa8ocyujd.fsf@gitster.mtv.corp.google.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
	<cover.1452270051.git.johannes.schindelin@gmx.de>
	<abd20a9fb53d702cb878b8fa767881e7c1ef2148.1452270051.git.johannes.schindelin@gmx.de>
	<xmqqy4bz29mp.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601091553310.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <schindelin@wisc.edu>
X-From: git-owner@vger.kernel.org Mon Jan 11 17:01:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIeuk-0006AU-2p
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 17:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759367AbcAKQBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 11:01:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757704AbcAKQBp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 11:01:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 66BA3376F4;
	Mon, 11 Jan 2016 11:01:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RZfOc6DHW688nQPMGIw74Tss+co=; b=ZpWNid
	m0Ln01I8zcVoneaEPXR1z4hqDPqClUVEy8Bl5nojg/v+XzajsFolWGW+D28fhfUr
	VPVAgd4sZF0ScU/0tkm1i/wXzf/LL8qeS4jPT6HGzoxmuhc8rT5n4PqPAP1sR6gy
	KawH6p6RrRSwboM6WJi/FBaKzDloLTaWjg/T8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gp+YXwk0D7qpZ/JmWEasow5aS6spW+Re
	FOFn2G8ANX64iPWWloKZ9QHUzujQdaZWgRbPFyQB4PSIEfnRtleiL3Rj/ZrENb6T
	fepDoS+GbGL8CYR4rwG4DiA40A1uQWN7XtxXgsZkVIPuQqSUfWRtWKR6sOk+cDdd
	G80Z/3YpycI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5CC55376F3;
	Mon, 11 Jan 2016 11:01:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CC340376F2;
	Mon, 11 Jan 2016 11:01:43 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601091553310.2964@virtualbox> (Johannes
	Schindelin's message of "Sat, 09 Jan 2016 15:53:54 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9C11BC06-B87C-11E5-BBAC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283663>

Johannes Schindelin <schindelin@wisc.edu> writes:

> Hi Junio,
>
> On Fri, 8 Jan 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > According to POSIX, basename("/path/") should return "path", not
>> > "path/". Likewise, basename(NULL) and basename("abc") should both
>> > return ".".
>> 
>> Did you mean basename("abc"), not basename(""), here?  
>
> I don't understand: I wrote basename("abc")... ;-)

Yeah, I read that.  What I didn't read was you wrote 'path' between
slashes in the first example (the MUA was trying to render it as
"path" in italic or something silly like that), and made me
confused: If 'path' has to go to 'path', what's so special about
'abc' to make it go '.'?

Upon second reading I noticed that slashes around the first one, but
forgot to remove the "why 'abc'" comment.
