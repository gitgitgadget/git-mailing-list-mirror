From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status / git diff -C not detecting file copy
Date: Wed, 03 Dec 2014 08:03:18 -0800
Message-ID: <xmqq61dslnzt.fsf@gitster.dls.corp.google.com>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
	<CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
	<CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
	<CAGyf7-F9twCEUY-LN=xEf4=gfNW8oLEHJmTjHRQ2MncHZ2emZQ@mail.gmail.com>
	<20141202065550.GB1948@peff.net>
	<CAGyf7-EHBqZn5LCTYuA+07GSNOF0vVdszL6oTUKwY1ETRDKEwA@mail.gmail.com>
	<20141202215013.GB25338@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bryan Turner <bturner@atlassian.com>,
	Pol Online <info@pol-online.net>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 17:03:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwCOj-0007ia-ET
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 17:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbaLCQDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 11:03:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751173AbaLCQDU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 11:03:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2121422621;
	Wed,  3 Dec 2014 11:03:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pxKfrNd/jwV61jVKAA+GHk3ijmA=; b=LbOSKT
	wOTZMIsWLqzcpMbgTjgkZPCGjY56nj7NYr2qu3S0PeuKOzKBnyyYqKa5M0/4/Di4
	l93X3woVHDTmphdYIxKT7ov8QowuUXoHOwa3fKzdJXUtH4m0SXwQJdBiPSLWUS1T
	o89psM8RFEqcWycQ7F3r3Y17qIQySr0gSkO5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ITPyC5WU58ayV3ho2wgB9yUqDKPP8y0r
	vQBpf/IzA2HeaSmTOgUUYXY8fDZvGPX/xgG+14EbPjArIXJF/t7Qj43WOIZpntPC
	+MwdPogspDxODvxXVo21EFlTlHvMsiV6Eg8tqT5LvtXa2Q8QERbwMkNJRkxU3dxf
	OFYU/23EXHo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1635D22620;
	Wed,  3 Dec 2014 11:03:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8904F2261F;
	Wed,  3 Dec 2014 11:03:19 -0500 (EST)
In-Reply-To: <20141202215013.GB25338@peff.net> (Jeff King's message of "Tue, 2
	Dec 2014 16:50:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E63C2D76-7B05-11E4-B326-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260655>

Jeff King <peff@peff.net> writes:

> ... I'd consider trying to match diff.renames instead,
> which takes false/true/copies for its three levels. It may make sense to
> teach both places "copies-harder" or something similar, for
> completeness.

Yeah, I think that is a very sensible thing to do.
