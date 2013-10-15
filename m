From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH v5] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Tue, 15 Oct 2013 17:58:18 -0500
Message-ID: <87wqlexhth.fsf@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
	<A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
	<660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
	<AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com>
	<79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com>
	<xmqqbo2qb0wk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 16 00:58:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDZU-0000KS-0f
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933654Ab3JOW6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:58:32 -0400
Received: from plane.gmane.org ([80.91.229.3]:46383 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933584Ab3JOW6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:58:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VWDZN-0000HL-BE
	for git@vger.kernel.org; Wed, 16 Oct 2013 00:58:29 +0200
Received: from nat-128-62-43-188.public.utexas.edu ([128.62.43.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 00:58:29 +0200
Received: from keshav.kini by nat-128-62-43-188.public.utexas.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 00:58:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-128-62-43-188.public.utexas.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:MMQK5lHyOLqTHrSyoPcvwOb5r1k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236215>

Junio C Hamano <gitster@pobox.com> writes:
> Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:
>
>> "git diff -M --stat" can detect rename and show renamed file name like
>> "foofoofoo => barbarbar". But if destination filename is long, the line
>> is shortened like "...barbarbar" so there is no way to know whether the
>> file is renamed or existed in the source commit.
>
> Is "destination" filename more special than the source filename?
> Perhaps "s/if destination filename is/if filenames are/"?
>
> 	Note: I do not want you to reroll using the suggested
> 	wording without explanation; it may be possible that I am
> 	missing something obvious and do not understand why you
> 	singled out destination, in which case I'd rather see it
> 	explained better in the log message than the potentially
> 	suboptimal suggestion I made in the review without
> 	understanding the issue. Of course, it is possible that you
> 	want to do the same when source is overlong, in which case
> 	you can just say "Yeah, you're right; will reroll".
>
>         The above applies to all the other comments in this message.
>
> Also "s/source commit/original/".  You may not be comparing two
> commits after all.
>
>> Make sure there is always an arrow, like "...foo => ...bar".
>> The output can contains curly braces('{','}') for grouping.
>
> s/contains/contain/;
>
>> So, in general, the outpu format is "<pfx>{<mid_a> => <mid_b>}<sfx>"
>
> s/outpu/&t/;
>
>> To keep arrow("=>"), try to omit <pfx> as long as possible at first
>> because later part or changing part will be the more important part.
>> If it is not enough, shorten <mid_a>, <mid_b>, and <sfx> trying to
>> have the maximum length the same because those will be equaly important.
>
> A sound reasoning.

Also s/equaly/equally/;

-Keshav
