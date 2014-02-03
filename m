From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Running "make rpm" fails on a CentOS 6.3 machine
Date: Mon, 03 Feb 2014 10:08:04 -0800
Message-ID: <xmqqmwi8f4sb.fsf@gitster.dls.corp.google.com>
References: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
	<20140130181643.GG27577@google.com>
	<20140130185104.GV3241@zaya.teonanacatl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Erez Zilber <erezzi.list@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 19:08:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WANwR-0000Dw-VW
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 19:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbaBCSIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 13:08:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbaBCSIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 13:08:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFDFD6945C;
	Mon,  3 Feb 2014 13:08:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DmebY/IJG5LECViKYM+8Aa8Bi3A=; b=G/mC0B
	566OMyPn0aLu3jo/GOZH1QZFAqzx2e8OSFN1Zk0iOcloIflpYcn/a0FHipqO17VA
	c3y9SxLfR32vVsISAOd9jP1osaBgP/0n+XxSA+0SvQjNYJXy8yYFy9qEEUDu3m85
	XYWekGswpwG3dZgoRD/rO3n2iRGPHXe2FMYgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yIofTDCXyy+yLUFz9EFTJQunAXqca2uk
	4GYx5EesVyIQZ1xbzHDYkp3PS3PrBl5JTHwn7o4eX8Fd3g9rAquIPoSG4KTwaiED
	kD49Z/SsKBX+30IeRdN14Aqdp5ea8LUthyha/XOzAbSUHeEHBfNYIO6gXhJIQlYT
	lM3Z+20aC38=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A10656945B;
	Mon,  3 Feb 2014 13:08:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3177769456;
	Mon,  3 Feb 2014 13:08:09 -0500 (EST)
In-Reply-To: <20140130185104.GV3241@zaya.teonanacatl.net> (Todd Zullinger's
	message of "Thu, 30 Jan 2014 13:51:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 233EA420-8CFE-11E3-824A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241444>

Todd Zullinger <tmz@pobox.com> writes:

> I know the Fedora/EPEL spec file and what's in git.git have grown
> apart a good bit, unfortunately.  That's the cost of having a spec
> file that is meant to work across a very wide array of RPM-based
> systems, I guess.  The Fedora/EPEL spec file is fairly specific to the
> Fedora/EPEL build tools (mock is the primary build tool).

Hmph.

Once it gets to the point where our "spec" file is so out of sync
with anybody's RPM based distribution in the real world, I suspect
that removing and not shipping it in tree might be more helpful to
the users.  Or at least have a set of pointers, one for each major
RPM based distribution, where to obtain spec file more tailored for
their platform, at the beginning of it, or something.

Have we already reached that point?  Does anybody still use it?
