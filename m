From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Thu, 21 May 2015 20:58:35 +0100
Organization: OPDS
Message-ID: <B2DD947EDB314A2C878567932ECB974E@PhilipOakley>
References: <20150519132958.GA21130@frolo.macqel> <xmqq617oa75l.fsf@gitster.dls.corp.google.com> <20150519214719.GA12732@frolo.macqel> <xmqqiobop67k.fsf@gitster.dls.corp.google.com> <20150521071518.GA8675@frolo.macqel>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
	"John Keeping" <john@keeping.me.uk>
To: "Philippe De Muyter" <phdm@macq.eu>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 21:58:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvWcA-0007T3-BS
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 21:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbbEUT6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 15:58:39 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:15328 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755929AbbEUT6g (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 15:58:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CeDwCvN15VPF4aFlxcgxCBMoZNbcMnBAQCgU5NAQEBAQEBBwEBAQFBJBtBA4NZBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMRBAEBAQklFAEEGgYHAwwIBgESCAIBAgMBiBMMtTedQAwBH4s6hQWDHoEWBYwChnh4hgibJIIsHYFTPTGCRwEBAQ
X-IPAS-Result: A2CeDwCvN15VPF4aFlxcgxCBMoZNbcMnBAQCgU5NAQEBAQEBBwEBAQFBJBtBA4NZBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMRBAEBAQklFAEEGgYHAwwIBgESCAIBAgMBiBMMtTedQAwBH4s6hQWDHoEWBYwChnh4hgibJIIsHYFTPTGCRwEBAQ
X-IronPort-AV: E=Sophos;i="5.13,471,1427756400"; 
   d="scan'208";a="520492551"
Received: from host-92-22-26-94.as13285.net (HELO PhilipOakley) ([92.22.26.94])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 21 May 2015 20:58:34 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269651>

From: "Philippe De Muyter" <phdm@macq.eu>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>; "Jeff King" <peff@peff.net>; "John Keeping" 
<john@keeping.me.uk>
Sent: Thursday, May 21, 2015 8:15 AM
Subject: Re: identical hashes on two branches, but holes in git log


> On Tue, May 19, 2015 at 03:12:31PM -0700, Junio C Hamano wrote:
>> Philippe De Muyter <phdm@macq.eu> writes:
>>
>> > On Tue, May 19, 2015 at 09:01:10AM -0700, Junio C Hamano wrote:
>> >> Philippe De Muyter <phdm@macq.eu> writes:
>> >>
>> >> > Trying to understand, I have eventually done "git log" on my 
>> >> > branch and
>> >> > on v3.15 with the following commands :
>> >> >
>> >> > git log v3.15 --full-history --decorate=short | grep '^commit' > 
>> >> > /tmp/3.15.commits
>> >> > git log --full-history --decorate=short | grep '^commit' > 
>> >> > /tmp/mybranch.commits
>> >>
>> >> Either
>> >>
>> >>     git log --oneline v3.15..HEAD ;# show what I have not in 
>> >> theirs
>> >>
>> >> or
>> >>
>> >>     gitk v3.15...HEAD ;# show our differences graphically
>> >
>> > This shows the commits in my branch starting from the most recent 
>> > common point,
>> > thus my commits, but I see differences in the files not explained 
>> > by my commits,
>> > but by the fact that many older commits (between v3.13 and v3.14) 
>> > are missing on
>> > my branch, but still in both branches I have a commit called v3.14 
>> > with the
>> > same hash.  Is that normal ?
>>
>> Sorry, cannot parse.  Neither of the above would show files, so just
>> about the place where you start talking about "I see differences in
>> the files", you lost me.
>
> Look at the other part of the thread, with the discussion with Jeff 
> and John
>
> The light has come, and what I understand is:
>
> don't trust the default (ordering) mode of 'git log' :(


Surely the question now should be "What should the man page say that 
would have explained the default ordering mode in an understandable way, 
rather than the current misunderstanding?".

What 'ordering' were you 'trusting' (presuming) anyway? The current 
default mode doesn't actually say anything about the order anyway (as 
you've discovered).

>
> I surmise this happens only when 'git merge' has been used.
>
--
Philip 
