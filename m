From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv2 1/2] am: add gitk patch format
Date: Fri, 05 Sep 2014 11:29:01 -0700
Message-ID: <xmqq8ulxrkeq.fsf@gitster.dls.corp.google.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-2-git-send-email-judge.packham@gmail.com>
	<xmqq38c8waub.fsf@gitster.dls.corp.google.com>
	<CAFOYHZCcAwHwRy50kE8=rRwEOtrXovNkkKSQo2Gwcfvbve1Qwg@mail.gmail.com>
	<xmqqiol3uwr5.fsf@gitster.dls.corp.google.com>
	<CAFOYHZC5pWadJiqY=F3gP4DKcNzhogfWH76jAcez5AjW7FJrVQ@mail.gmail.com>
	<CAPc5daWip1dQ5Or6hzmdjoBUStusvs-jK0ODNuzAotNfM5BLbQ@mail.gmail.com>
	<CAFOYHZDfpZPvuE_BZQHajc65fZNKoyqvFf+UZyf0LyLwrooqzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 20:29:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPyFz-0002VC-2k
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 20:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbaIES3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 14:29:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52364 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbaIES3F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 14:29:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA36236E5D;
	Fri,  5 Sep 2014 14:29:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ctfs0li8FjhRTrTSs6BZ4P8UtYQ=; b=L5hMfh
	0dmebIyoEL3qCbKfAWkgzMJFKZA45aNke7xSIs4BqrP213EEY0g0soZUg0w00+BG
	GKeaCJZaULOAb3VWhS7JnapMCsqAb3GKQCDJgqgcncKGlRfYOoiAP1VFThGTH+Et
	U1hlXe8exrRbmkXUi3E315Oi71zkRUKk00XkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m9z3sTfDXqR4Xx16c6Vi1G7whz7teaNu
	X6/IvPGnSY/u8w1A2r7zs4VQgtzXj64etDiWe9JLCCOe1CeLzvh7u5o4A82MmPuX
	SEKk6Nxm51NvA2ineG2Sov+AFV4194WkcPVtKLSmkLwip1o3ZDgN9ioCdFHjARRq
	m0jnKS8ECQk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1AB436E5C;
	Fri,  5 Sep 2014 14:29:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 64E9336E5B;
	Fri,  5 Sep 2014 14:29:03 -0400 (EDT)
In-Reply-To: <CAFOYHZDfpZPvuE_BZQHajc65fZNKoyqvFf+UZyf0LyLwrooqzA@mail.gmail.com>
	(Chris Packham's message of "Fri, 5 Sep 2014 13:23:17 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8335FBC4-352A-11E4-815A-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256512>

Chris Packham <judge.packham@gmail.com> writes:

> So teaching git mailinfo to do s/^    // (either when asked to or
> using some heuristic) would be a better approach? I also think we
> should accept "Author:" as an acceptable fallback if "From:" is not
> present.

Not as "a fallback" in the sense that "Author:" should not be
treated any specially when "am" (which stands for "apply mail") is
operating on the patches in e-mails.  Whatever wants to convert the
output from "log --pretty" as if it came from "log --pretty=email"
would certainly need to flip "Author:" to "From:" (what should
happen when it sees "From:" in the input, though???), and whatgver
wannts to pick metainfo from "log --pretty" output like mailinfo
does for "log --pretty=email" output would certainly need to pick
the authorship from "Author:" (without paying any attention to
"From:" if one exists).
