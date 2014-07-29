From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Amending merge commits?
Date: Tue, 29 Jul 2014 22:38:57 +0100
Organization: OPDS
Message-ID: <9EFB89B516004883AC0FD774595B84E7@PhilipOakley>
References: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com><87r4147agk.fsf@osv.gnss.ru><CAK3OfOhFzbUA7gZbox84W=VC+0aSuiNc-XRP_MTyYy1UeFFzZQ@mail.gmail.com><DFE66A48CBC646E795B3B4A0903AB19E@PhilipOakley> <CAK3OfOgZt55+tKv5455Jk-F=buULtftmCasbxHYcxGzppbWcfg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Sergei Organov" <osv@javad.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Besen, David" <david.besen@hp.com>,
	"git discussion list" <git@vger.kernel.org>
To: "Nico Williams" <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 23:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCF6x-0004Lo-IQ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 23:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbaG2VjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 17:39:03 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:38836 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753918AbaG2VjB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 17:39:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiUaAM4T2FNOl3UmPGdsb2JhbABagw6BKYJ4hDeBBMsJBQECAQGBEhcFAQEBATg2g34FAQEEAQgBARkVHgEBIQUGAgMFAgEDFQMCAgUhAgIUAQQaBgcDFAYTCAIBAgMBiCkMqA+Gf5BggSyOIIMANoEbBZE1ojI8Lw
X-IPAS-Result: AiUaAM4T2FNOl3UmPGdsb2JhbABagw6BKYJ4hDeBBMsJBQECAQGBEhcFAQEBATg2g34FAQEEAQgBARkVHgEBIQUGAgMFAgEDFQMCAgUhAgIUAQQaBgcDFAYTCAIBAgMBiCkMqA+Gf5BggSyOIIMANoEbBZE1ojI8Lw
X-IronPort-AV: E=Sophos;i="5.01,759,1400022000"; 
   d="scan'208";a="117158715"
Received: from host-78-151-117-38.as13285.net (HELO PhilipOakley) ([78.151.117.38])
  by out1.ip07ir2.opaltelecom.net with SMTP; 29 Jul 2014 22:38:57 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254473>

From: "Nico Williams" <nico@cryptonector.com>
> On Tue, Jul 29, 2014 at 2:29 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> From: "Nico Williams" <nico@cryptonector.com>
>>> Local merge commits mean that you either didn't rebase to keep all
>>> your local commits on top of the upstream, or that you have multiple
>>> upstreams (the example exception I gave).
>>>
>>> Conversely, if you always rebase your local commits on top of the
>>> upstream then you won't have merge commits to worry about.
>>>
>> Whilst it may not be "the Git Way", I'd expect that in many less well
>> informed companies, the need to keep merge commits fom other lines of
>> development would be quite a common (political ) technique where some
>> preparatory branch needs to be merged in before one's feature can be
>> completed (similar to all those cases on the list when folk say 
>> 'builds on
>> top of xy's commit deadbeaf)
>
> The way we did this at Sun, first with Teamware, then later with
> Mercurial, was as follows:
>
> - "projects" kept their own clone repos of the upstream
> - engineers working on a project cloned the project repo ("project 
> gate")
> - engineers pushed/pulled to/from the project gate
> - each project gate had a gatekeeper whose job it was to periodically
> rebase onto the latest upstream
> - then engineers would rebase onto the new project gate
>
> No "merge turds" (Sun speak) were ever allowed in any upstream,
> whether a project gate or the ultimate upstream.  All commits had to
> be organized according to specific rules, and squashed.  These rules
> applied at the project gate and in the upstream.
>
> - when the project was ready for integration the gatekeeper would
> rebase and squash as necessary, then push to the upstream
>
> (I'm eliding some details.  In particular when an intermediate
> upstream rebased the previous head was left available as a "snapshot"
> to make the equivalent of git rebase --onto possible.)
>
> The upshot was: all local commits were always on top of whatever the
> next upstream in the chain was.  Always.  No merge commits ever.
>
> That workflow works just fine with git.

I'm not saying that it isn't a good technique and can work well. Rather 
I'm saying we should be tolerant of the rules and techniques of others 
who do have 'merges' in their workflow organisation. They may have a 
very long QA delay between feature 'done' and feature 'done done tested 
merged', which requires maintaining merges of done items that aren't yet 
merged to master. Such techniques are more common in mixed engineering 
than pure software environments (where engineering rules apply, and 
software has to follow)

>  It worked really well at Sun
> (with thousands of engineers working on Solaris alone).  And it should
> work well for anyone who doesn't have two or more forked upstreams to
> follow.

I'm just cautious of an accidental one size fits all approach, so the 
ability to rebase lines of development which contain merge commits 
should be possible (with an appropriate and documented option) without 
hidden traps.
>
Philip 
