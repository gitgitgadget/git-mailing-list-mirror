From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-add: allow --ignore-missing always, not just in dry run
Date: Fri, 20 Jan 2012 13:56:31 +0100
Message-ID: <87mx9icz28.fsf@thomas.inf.ethz.ch>
References: <1326923544-8287-1-git-send-email-dieter@plaetinck.be>
	<7vobu0liwj.fsf@alter.siamese.dyndns.org>
	<8762g87y4q.fsf@thomas.inf.ethz.ch>
	<7v8vl3jzst.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 13:56:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoE1K-0007oa-I3
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 13:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935Ab2ATM4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 07:56:38 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:25802 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445Ab2ATM4h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 07:56:37 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 20 Jan
 2012 13:56:33 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (192.101.176.246) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 20 Jan
 2012 13:56:33 +0100
In-Reply-To: <7v8vl3jzst.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 19 Jan 2012 10:46:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [192.101.176.246]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188875>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>>   $ git grep 'git[ -]add' t/ | wc -l
>>   1540
>>   $ git grep 'git[ -]update-index --add' t/ | wc -l
>>   269
>>   $ git grep 'git[ -]update-index --add' v1.6.0 t/ | wc -l
>>   251
>>   $ git grep 'git[ -]add' v1.6.0 t/ | wc -l
>>   705
>
> Stop being silly.
>
> Have you actually looked at these usage?  Some of them are genuinely
> testing if "git add" works correctly, so it is out of the scope of this
> discussion, but others that could be "git update-index" are feeding the
> paths known to the script to exist (and we want 'git add' to error out
> if that is not the case).

I'm sorry if I sound silly, that was totally not the point.  I also
admit that I did not look at the usages at all.  I merely wanted to
point out that the understanding in the git community *itself* has
evolved to use git-add instead of git update-index --add in its own
scripting.  Admittedly the statistics are even more striking than I
could possibly hope for.

So I am challenging the notion that git-add is not recommended for use
in scripts, which is how I understood your parenthetical remark

} If somebody is writing a script using "git add" (which is not recommended
} to begin with)

We're no longer following that advice ourselves, how can we expect users
to adhere to it?

> More generally, scripts in t/ directories are "scripts", but it is totally
> different from the kind of "user facing script that behaves as if it is a
> complete command, taking its own command line arguments, passing them
> through to the underlying plumbing commands".

I don't understand what distinction you are trying to make here.  Maybe
my mental model of the plumbing/porcelain separation (which is mostly
about interface stability) is wrong?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
