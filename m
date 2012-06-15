From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incorrect v1.7.10.4 tag on github?
Date: Fri, 15 Jun 2012 12:14:18 -0700
Message-ID: <7vvcis9ylx.fsf@alter.siamese.dyndns.org>
References: <77A5E1CD-836A-4747-9E62-42C25C0D8B7D@sfu.ca>
 <20120615182534.GB14843@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Graham Ballantyne <grahamb@sfu.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 21:14:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfbyU-0006R0-2J
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 21:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab2FOTOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 15:14:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab2FOTOV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 15:14:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B6CD98DB;
	Fri, 15 Jun 2012 15:14:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KG/Mzo/9uhcVAoF4sBob+qyCUw0=; b=wkuD3H
	Kr0v506Nevh60zFBYHnP+7BW9ZS7ix9+Ldi5OwkAKdW8hdWq7eyAxdXKTMQiwkD8
	e+BEUPHNsrKkmkjG5vf2g5aviYFS5zn1KIO3F+I39UJX5ga7RQVRmJwLR01qrIu3
	Ljr3fZZGFgCzyIh13Fklnyb5du8XzKSrSsefg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LO9o+45GeRZGQJ/NOIUhQkT0/JTMOUy9
	kKDM1ysEiA6fQwy3p6j8FOs4DYqtFPPESU/Cv3NhguiK0KtePROK5njpiaoZ6ODS
	bWtIslckm1Gr/i0aIO2cXvW3R4aMxgi/0Rjxafq7Y6y48yUdhGw2RMnsd6UqlR6Y
	kH1TmsK/vPA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91F9398DA;
	Fri, 15 Jun 2012 15:14:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 261F598D9; Fri, 15 Jun 2012
 15:14:20 -0400 (EDT)
In-Reply-To: <20120615182534.GB14843@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 15 Jun 2012 14:25:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F1772AA-B71E-11E1-A599-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200083>

Jeff King <peff@peff.net> writes:

> On Fri, Jun 15, 2012 at 09:51:00AM -0700, Graham Ballantyne wrote:
>
>> I just downloaded the 1.7.10.4 tag from github. After compiling and
>> installing, git --version returns "git version 1.7.10.3". I think that
>> tag might be pointing to the wrong commit?
>
> Looks like 121f71f (Git 1.7.10.4, 2012-06-03) forgot to update DEF_VAR
> in GIT-VERSION-GEN. Operator error from the maintainer?

Thanks for noticing.

> It builds with the right version from the git repository (which runs
> git-describe and sees we are on the v1.7.10.4 tag), but exporting the
> tag's contents and building fails. I suspect that the git-1.7.10.4
> tarball on kernel.org would also have the same problem.

It builds correctly if you download the tarball from the official
location in the [ANNOUNCE] message.  This is because the build
procedure for the official tarball does a bit more than just running
"git archive-tar", which is what gitweb download interface does
(namely, it adds the correct "version" file).
