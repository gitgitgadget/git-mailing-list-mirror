From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 05 Sep 2013 16:45:39 -0700
Message-ID: <xmqqzjrqest8.fsf@gitster.dls.corp.google.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
	<BC4EB62C5077409384A225ECD96D04E1@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John Keeping" <john@keeping.me.uk>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	"Git List" <git@vger.kernel.org>, "Andreas Krey" <a.krey@gmx.de>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Sep 06 01:45:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHjFD-0004PJ-3z
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 01:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722Ab3IEXpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 19:45:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56978 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096Ab3IEXpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 19:45:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4B263F6F1;
	Thu,  5 Sep 2013 23:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IUy79aoV/g+CXjEQys3ood4QuqU=; b=yc3r6sRYZZhhmBFa3lJi
	5E7QXPs1QmnUlkEzGU7tmnX4ky67LIxUVAM6eDCU8A6uVjYRMnNXVn+nHtalXYE9
	OmsZgt+1bw9NITlC9DZg/Rok08zzeC80xUY+II3VWi3OkN7+Z6q904Jp97NDZgDa
	b2oDRYcYkH2aBXqOKgZudJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=GZoHjUAT04lAO1W0e4P3F3Qg+ffbvoK9RvbKeXV1QADSka
	SOMTlpyHEiv8ZIfrWmS3pVAm4XkO+rD7NiHEB0+cjHYSbenrhq4x0RJOFwk6PM34
	odTAzh8AczOdZkT6IoLVhGG1HI5c3sT1CSRlzx+5R0HjUtmKibXdrJdJuD7Mg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9F433F6EE;
	Thu,  5 Sep 2013 23:45:41 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 518943F6E6;
	Thu,  5 Sep 2013 23:45:41 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4614138A-1685-11E3-AF80-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234006>

"Philip Oakley" <philipoakley@iee.org> writes:

> It's not clear to me that a single default that uses a merge or
> rebase, without a 'stop if' criteria would be of any help in my
> situation.
>
> My thoughts are that the options on a fetch-pull are for the branch to
> be:
> * Overwritte (--force) (i.e. a conflict scenario)
> * Stop if not-ff (conflict scenario, this patch series)
> * rebase existing onto tracked [not a conflict in terms of initiation]
> * merge existing into tracked [not a conflict in terms of initiation]
> * fast-forward (bring tracked onto existing) [desired]

In short, it sounds to me like that the answer to my question is
"what I do depends too much on what I did on my other machine that
is not even directly connected to this matchine, so there is no way
to formulate it as a concrete workflow---I need to inspect what I
get from the central repository and decide the next step anyway, so
I just want 'git pull' not to do anything".

Among the things that were suggested so far (the 'pull' update that
has been cooking in the 'next' branch, Felipe's tightening to apply
the same logic to 'git pull $there $that' as well as 'git pull', and
being able to set "pull.rebase = fail" and renaming the variable to
something like "pull.integrate = fail"), only the last one seems to
be the solution to your particular case.  The other two would not
help such an ad-hoc (non)workflow very much either way.

Am I reading you correctly?  If so, I sent out the first (or zeroth)
step to add something like that separately.
