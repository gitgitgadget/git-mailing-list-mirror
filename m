From: demerphq <demerphq@gmail.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 6 Feb 2013 18:45:56 +0100
Message-ID: <CANgJU+V5bhdpN_kWxQPEJgx24LXLtQJWRbnHwkSgm9zFwzm+fA@mail.gmail.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
	<87sj5cvxnf.fsf_-_@lifelogs.com>
	<7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
	<87k3qoudxp.fsf@lifelogs.com>
	<7vvca7291z.fsf@alter.siamese.dyndns.org>
	<87lib3uats.fsf@lifelogs.com>
	<7v7gmn1xqi.fsf@alter.siamese.dyndns.org>
	<871ucto4vj.fsf_-_@lifelogs.com>
	<7vvca5mmmt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ted Zlatanov <tzz@lifelogs.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 18:46:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U394i-0002gG-RW
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 18:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378Ab3BFRqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 12:46:00 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:33437 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757448Ab3BFRp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 12:45:57 -0500
Received: by mail-qa0-f45.google.com with SMTP id g10so2430241qah.4
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 09:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ur7/960zf8g88G3EvkVi+symjVNrszY5jjCCc8FmQek=;
        b=bqRfrPmNmX4E8qy0DvqW33aa79fIRHEyyVJL6CF1AUQWtdZ/Lc/ciRz3q9zMs1LhcJ
         80+rLwMA+fmhMAibFj/RgopmczkKpZl60oy06oBjGp4j8k2dovMZtqtrtMbzoTmITjwd
         8x2CBeSJsgkX7rYi3YE2U12sH8SSGfm6LNTz/whpAvBkjqpZmc2N9Pn7yRPqnZB8lZ6J
         xFvQKUbpfqVJO9Db83lAU4DrUrCxSUR89Y5WZPVBlA+QuwmVCTCX5t67bA3p3N5hFP8l
         cdq2y7sn6p+akrrPdwGvcG9dM+AdtXaWABeuQuwEq+out0ARVzWIwsbN3lsNnsq+Xqmq
         p79w==
X-Received: by 10.224.52.68 with SMTP id h4mr20978929qag.17.1360172756327;
 Wed, 06 Feb 2013 09:45:56 -0800 (PST)
Received: by 10.49.94.196 with HTTP; Wed, 6 Feb 2013 09:45:56 -0800 (PST)
In-Reply-To: <7vvca5mmmt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215602>

On 6 February 2013 17:29, Junio C Hamano <gitster@pobox.com> wrote:
> Ted Zlatanov <tzz@lifelogs.com> writes:
>
>>  - As in C (see above), we avoid using braces unnecessarily (but Perl
>>    forces braces around if/unless/else/foreach blocks, so this is not
>>    always possible).
>
> Is it ever (as opposed to "not always") possible to omit braces?

Only in a statement modifier.

> It sounds as if we encourage the use of statement modifiers, which
> certainly is not what I want to see.

As you mention below statement modifiers have their place. For instance

  next if $whatever;

Is considered preferable to

if ($whatever) {
  next;
}

Similarly

open my $fh, ">", $filename
   or die "Failed to open '$filename': $!";

Is considered preferable by most Perl programmers to:

my $fh;
if ( not open $fh, ">", $filename ) {
  die "Failed to open '$filename': $!";
}

> You probably would want to mention that opening braces for
> "if/else/elsif" do not sit on their own line,
> and closing braces for
> them will be followed the next "else/elseif" on the same line
> instead, but that is part of "most of the C guidelines above apply"
> so it may be redundant.
>
>>  - Don't abuse statement modifiers (unless $youmust).
>
> It does not make a useful guidance to leave $youmust part
> unspecified.
>
> Incidentally, your sentence is a good example of where use of
> statement modifiers is appropriate: $youmust is rarely true.

"unless" often leads to maintenance errors as the expression gets more
complicated over time, more branches need to be added to the
statement, etc. Basically people are bad at doing De Morgans law in
their head.

> In general:
>
>         ... do something ...
>         do_this() unless (condition);
>         ... do something else ...
>
> is easier to follow the flow of the logic than
>
>         ... do something ...
>         unless (condition) {
>                 do_this();
>         }
>         ... do something else ...
>
> *only* when condition is extremely rare, iow, when do_this() is
> expected to be almost always called.

if (not $condition) {
  do_this();
}

Is much less error prone in terms of maintenance than

unless ($condition) {
  do_this();
}

Similarly

do_this() if not $condition;

leads to less maintenance errors than

do_this() unless $condition;

So if you objective is maintainability I would just ban "unless" outright.

Cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
