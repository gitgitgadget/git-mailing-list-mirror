From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/2] gitweb: change format_diff_line() to remove
 leading SP from $diff_class
Date: Mon, 17 Oct 2011 14:22:16 -0700
Message-ID: <7v62jnl3ef.fsf@alter.siamese.dyndns.org>
References: <CAFo4x0LP4fXgSNAnss_WRLo-TH_qe=esYn7P+=iS6t87tdzcbw@mail.gmail.com>
 <m38voj72xy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 23:22:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFudc-00018R-78
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 23:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab1JQVWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 17:22:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903Ab1JQVWT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 17:22:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36D9B5245;
	Mon, 17 Oct 2011 17:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=enhQteQDtXcWwMoumwvnm4cJ30k=; b=vfWD5/
	jTmAfGVxSG+J9R1sY1g4eqZvR6mHest/d3IwbnsOAaG03Ww+2Sci1xFJKTWjkVsg
	aJMUeSu8lZHroIhio4qhFfd9+OeSdLGg6Ue9KlaecaRhAy83XpVjMLk9GbJPNyJw
	Le61NxLKaZ7J022baWin2hy2IsydywF3s6IDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KVSUYPjKXJ9veu9M0bGKAMeJU7R1ww/v
	46TKC1YA2jK11afuijySCKa0wwKBlGXsEIRuDedP9e9kRlchDfjXDq5tUN2QpEJM
	UcyDJDhZ40T4SXWuT9TMtD018A2JU4Vlrz7QSfyYBDIOc0pYgBLEHeCzeU1IFNWm
	wmEcBqXMIVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DA805244;
	Mon, 17 Oct 2011 17:22:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6BF15242; Mon, 17 Oct 2011
 17:22:17 -0400 (EDT)
In-Reply-To: <m38voj72xy.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Mon, 17 Oct 2011 13:56:30 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1749BA30-F906-11E0-A9AE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183824>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, it is common to either have following patches to be chain
> reply to first patch, or better provide cover letter for patch series
> and have all patches be reply to cover letter.

It may be a good discipline for 14 patch series, but it doesn't matter for
something this small.

>>  gitweb/gitweb.perl |   24 +++++++++++++-----------
>>  1 files changed, 13 insertions(+), 11 deletions(-)
>> 
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 85d64b2..095adda 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2235,28 +2235,30 @@ sub format_diff_line {
>>  		# combined diff
>>  		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
>>  		if ($line =~ m/^\@{3}/) {
>> -			$diff_class = " chunk_header";
>> +			$diff_class = "chunk_header";
>>  		} elsif ($line =~ m/^\\/) {
>> -			$diff_class = " incomplete";
>> +			$diff_class = "incomplete";
>>  		} elsif ($prefix =~ tr/+/+/) {
>> -			$diff_class = " add";
>> +			$diff_class = "add";
>>  		} elsif ($prefix =~ tr/-/-/) {
>> -			$diff_class = " rem";
>> +			$diff_class = "rem";
>>  		}
>
> Hmmm... that reminds me: this if-elsif chain is a bit ugly, but would
> be hard to replace without given ... when, I think.

I wasn't reading the existing context line, but now that you mention it,
they are not just ugly but are borderline of being incorrect (e.g. it does
not catch a broken hunk-header that begins with "@@@@" for a two-way
merge).

Assuming that $from->{'href'} has all the parents (i.e. 2 for two-way
merge), shouldn't the code be more like this?

	# combined diff
        my $num_sign = @{$from->{'href'}} + 1;
	my @cc_classifier = (
		["\@{$num_sign} ", "chunk_header"],
                ['\\', "incomplete"],
                [" {$num_sign}", ""],
                ["[+ ]{$num_sign}", "add"],
                ["[- ]{$num_sign}", "rem"],
        );
        for my $cls (@cc_classifier) {
                if ($line =~ /^$cls->[0]$/) {
                	$diff_class = $cls->[1];
                        last;
		}
	}

Also don't we want to use "context" or something for the css class for the
context lines, instead of assuming that we won't want to paint it in any
special color?
