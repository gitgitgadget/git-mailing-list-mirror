From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 4/5 v4] log: parse detached options like git log --grep foo
Date: Wed, 04 Aug 2010 11:41:03 +0900
Message-ID: <87sk2v14n4.fsf@catnip.gol.com>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
	<1280478669-22973-4-git-send-email-Matthieu.Moy@imag.fr>
	<7vvd7tlzfu.fsf@alter.siamese.dyndns.org>
	<vpqtyncdeuc.fsf@bauges.imag.fr>
	<7vsk2wk8lc.fsf@alter.siamese.dyndns.org>
	<vpq8w4ob3yz.fsf@bauges.imag.fr>
	<7vlj8nipl9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 04:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgTuz-0005r3-IV
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 04:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757682Ab0HDClQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 22:41:16 -0400
Received: from lo.gmane.org ([80.91.229.12]:43367 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756298Ab0HDClP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 22:41:15 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OgTus-0005p2-8Z
	for git@vger.kernel.org; Wed, 04 Aug 2010 04:41:14 +0200
Received: from 218.231.154.125.eo.eaccess.ne.jp ([218.231.154.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 04:41:14 +0200
Received: from miles by 218.231.154.125.eo.eaccess.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 04:41:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 218.231.154.125.eo.eaccess.ne.jp
System-Type: x86_64-unknown-linux-gnu
Cancel-Lock: sha1:IAmmk+kx3NDO9rNNVnEFIBY1EpA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152554>

Junio C Hamano <gitster@pobox.com> writes:
> this---the users won't miss the "--opt <string>" feature because that is
> not a common practice.
>
> And I was agreeing to that.

No, that would be not good -- GNU getopt_long supports that form, and
AFAICT, both the "--foo=bar" and "--foo bar" forms are widely used (I
certainly use both all the time), for roughly the same reasons both
"-Oarg" and "-O arg" are both common[*].

In the case of "optional-argument options", the "--foo bar" (and "-O
bar") form doesn't work, which is an unfortunate (but apparently
unavoidable) inconsistency, but optional-argument options are rare
enough that this doesn't really effect the usage patterns of more
conventional options.

[*] both forms are useful -- sometimes it's handy to bundle up the
option-argument with the option, e.g., when writing a throw-away script,
to avoid whitespace issues, but sometimes it's useful to keep it
separate, e.g. so that shell filename completion works on the
option-argument.

-Miles

-- 
Justice, n. A commodity which in a more or less adulterated condition the
State sells to the citizen as a reward for his allegiance, taxes and personal
service.
