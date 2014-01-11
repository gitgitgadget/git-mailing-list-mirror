From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work
Date: Sat, 11 Jan 2014 19:50:08 -0000
Organization: OPDS
Message-ID: <18D97E9015B24D76845BFB980CB14CB8@PhilipOakley>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org><xmqqppo090m7.fsf@gitster.dls.corp.google.com><0AB7145111924BA986B1E172CD293B1D@PhilipOakley> <xmqqha9b909p.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 11 20:49:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W24Z6-0003kj-1u
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 20:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbaAKTtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jan 2014 14:49:49 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:42597 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752270AbaAKTtr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jan 2014 14:49:47 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtAYADaf0VJZ8YT8/2dsb2JhbABagwuJSrElAQIBAYEGF3RpAQGBHwEBFAEEAQEBAQMIAQEdER4BASELAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBhTgHAYISJcNlF44jZIMrgRMEiQuGE5sOgy08gSw
X-IPAS-Result: AtAYADaf0VJZ8YT8/2dsb2JhbABagwuJSrElAQIBAYEGF3RpAQGBHwEBFAEEAQEBAQMIAQEdER4BASELAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBhTgHAYISJcNlF44jZIMrgRMEiQuGE5sOgy08gSw
X-IronPort-AV: E=Sophos;i="4.95,644,1384300800"; 
   d="scan'208";a="598029048"
Received: from host-89-241-132-252.as13285.net (HELO PhilipOakley) ([89.241.132.252])
  by out1.ip06ir2.opaltelecom.net with SMTP; 11 Jan 2014 19:49:45 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240334>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>>I think we already use a nicer way to set up a page alias to keep
>>> old links working than making a copy in Documentation/; please mimic
>>> that if possible.
>>
>> This was mainly about ensuring that the 'git help' command could
>> access these extra extra guides that it currently misses. (Tt also
>> misses the 'user-manual', which isn't a man page, but could have a
>> link page to guide the seeker of truth between 'git help' and the
>> actual user-manual)
>>
>> The only method I can see for that (via help.c) is to get the 
>> filename
>> format correct.  Where you thinking of something else?
>
> I do not have an objection against the creation of giteveryday.txt;
> I was questioning the way the original everyday.txt was left behind
> to bit-rot.  It is good to keep _something_ there, because there may
> be old URLs floating around that point at Documentation/everyday.txt,
> but the contents of that file does not have to be a stale copy.
>
> Cf. bd4a3d61 (Rename {git- => git}remote-helpers.txt, 2013-01-31)
> for how we renamed git-remote-helpers.txt to gitremote-helpers.txt
>

The commit also highlighted a couple of other places I needed to update

What's the right set of options for format-patch to avoid the bulk 
deletions and bulk insertions between the old an new versions? That 
commit was amended in situ, so never had the three way 
delete/move/create problem.

We have:
everyday.txt (old) -> delete
everyday.txt (new) ->create (<5% similarity)
everyday.txt (old) -> giteveryday.txt (>95% similarity)

It just feels that 400+ lines of complete deletion doesn't need to be in 
the summary patch. I have it in my mind that we always end up with the 
deletions being listed.

Philip 
