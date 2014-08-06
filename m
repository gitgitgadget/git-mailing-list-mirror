From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subtree with submodule inside?
Date: Wed, 06 Aug 2014 16:32:54 -0700
Message-ID: <xmqqr40tkxcp.fsf@gitster.dls.corp.google.com>
References: <CAHd499CaCeHYGZSQeY8MRVnnjXBTgDy=OUqBYqNd1e5GiKre_A@mail.gmail.com>
	<xmqqk36lmrpl.fsf@gitster.dls.corp.google.com>
	<CAHd499AmY+EYXAK8h_oYiOn-amnNrE1+a7qsQ4x7bCOVsJDxcw@mail.gmail.com>
	<53E28CAB.4040800@web.de> <20140806220832.GA12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 01:36:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFAkz-0004CO-8w
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 01:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbaHFXg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 19:36:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51512 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963AbaHFXg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 19:36:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB9B530123;
	Wed,  6 Aug 2014 19:36:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NmWN17Y5WzlxEZ78nCzJ8fFuqUE=; b=oKl+I4
	sbn2AJh6Yry9Q+TewFQ5nyQ8bEYap8A++RUBSYPgTQ0wyCdglLu0tqlea5hhUq5p
	GMdGT0ijOZuyF+g0tZ407HuJB3ffzRBE6B6PxGtmifVneEzjjbujv52lHzF4emIO
	ePq7b00So0qRIZ9cMECKf7mAFiroASzOmEZSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BYzjNk0ZTFx/Gg6EUuSkbC2q+0w69hEM
	2J5b54SFe7zEUke3T0CFFCMwLJ0xUxVU1V3vdMFYoYq3C5xYM/XbYsrLNcWM12Vb
	tfu38J9n8kILM7DKcQMpXfZRzKMDFqLJIZ/QLP3wAl7TvM3BiuNE/Rh/Zy0LpJcW
	k4nRA/nzJaA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D1DD330122;
	Wed,  6 Aug 2014 19:36:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BC04830052;
	Wed,  6 Aug 2014 19:32:55 -0400 (EDT)
In-Reply-To: <20140806220832.GA12427@google.com> (Jonathan Nieder's message of
	"Wed, 6 Aug 2014 15:08:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE26E5EE-1DC1-11E4-92C7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254915>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  2. Submodules aware of their superproject and of the parent's branches.
>     In other words, submodules would act as thought under refs/ they
>     had a symlink
>
> 	parent -> ../../../refs
>
>     So you could do
>
> 	git checkout --recurse-submodules master
>
> 	cd path/to/submodule
> 	git checkout parent/heads/next
>
>     This would avoid danger from "git gc" in submodules and would
>     get rid of most of the motivation for named branches in the
>     submodule, I'd think.

Are you assuming that they share their object stores?
