From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 04 May 2016 14:15:39 -0700
Message-ID: <xmqq8tzpfrt0.fsf@gitster.mtv.corp.google.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
	<1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
	<1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
	<F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
	<5729DF25.7030503@ramsayjones.plus.com>
	<xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
	<xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
	<20160504192516.GD21259@sigill.intra.peff.net>
	<xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
	<20160504200635.GA22787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 23:15:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay494-0004Cp-Sw
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbcEDVPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:15:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751844AbcEDVPm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:15:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B8A2D18CC2;
	Wed,  4 May 2016 17:15:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CRYFDgvco5o1/11mQ2vlsF8+Mlc=; b=mNTOen
	X7Xpnv7fkw/8z4FGvvuYp+VxklOxraPk8rC4cvQT9m2ACZ2CWhCfkImD19MVzCgq
	Hq6F4d3t/DkQZk1q7+tj+kHqvKARMbZK0ae6YSM8wnSZZ/e7063uzh50awtDVrRx
	IvRLmbP0xMFbjs/1bDMY8+zRkOApykk5iygtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=parRSIl1WuwPtSzCpmTVo8hz2lLlyivW
	eLNrz3upAghG53njVFaJArQkgMsM9fI621+gy7l4wjt7INEsTBylxcwaW8tbILAT
	HYRKwMM1I8DLP4g91yE8zn9zQHugX8+fv8Q1lmUgCujtUFQ+hYn00iPvF4ytm+96
	HeVRZ8v5cUc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B04CA18CC1;
	Wed,  4 May 2016 17:15:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A4F018CC0;
	Wed,  4 May 2016 17:15:41 -0400 (EDT)
In-Reply-To: <20160504200635.GA22787@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 May 2016 16:06:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B148B50-123D-11E6-83CD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293593>

Jeff King <peff@peff.net> writes:

> On Wed, May 04, 2016 at 12:57:31PM -0700, Junio C Hamano wrote:
>
>> > Is it worth just making this a perl script, rather than a shell script
>> > with a giant inline perl script? Perl is actually really good at doing
>> > that "grep" as it reads the file. :)
>> 
>> OK.
>
> Hmm. This new version uses File::Find:
>
>> +sub lint_it {
>> +	lint($File::Find::name) if -f;
>> +}
>> +
>> +find({ wanted => \&lint_it, no_chdir => 1 }, "Documentation");
>
> That will inspect non-source files, too.
>
> Would:
>
>   open(my $files, '-|', qw(git ls-files));
>   while (<$files>) {
>     chomp;
>     ...
>   }
>
> make sense? Or a simpler but non-streaming spelling:
>
>   my @files = map { chomp; $_ } `git ls-files`;

I forgot to say that I wanted not to rely on "git" (i.e. OK to use
this on tarball extract).

> Or just taking the list of files on the command line as your original
> did, and feeding `ls-files` from the caller. That also lets you do
> "link-gitlink git-foo.txt", etc.

Yes, I think that is the most sensible.
