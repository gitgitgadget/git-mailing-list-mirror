From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git checkout -t -B
Date: Tue, 28 Aug 2012 21:01:21 +0100
Organization: OPDS
Message-ID: <87A0826508F54AD6A049B71BC5AD8E0A@PhilipOakley>
References: <CAHtLG6QgnvG6eYEChojY_jB25QWqxis6brbst2ff5FixFLAXAw@mail.gmail.com> <7v8vd1v6q2.fsf@alter.siamese.dyndns.org> <10B409063A944B298250064D2DB0BAB7@PhilipOakley> <7vsjb7q5rq.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 22:01:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6RyY-00005w-Up
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 22:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab2H1UBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 16:01:19 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:44640 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753081Ab2H1UBS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Aug 2012 16:01:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AskNAAcjPVBZ8rU+/2dsb2JhbABFhgOFP64qBAEBAnuBCIIbBQEBBAEIAQEZFR4BASELAgMFAgEDFQEEAgUhAgIUAQQaBgcXBhMIAgECAwGHdgqpEpMzgSGJZ4EQC0uDYTJgA41cmA+CZA
X-IronPort-AV: E=Sophos;i="4.80,328,1344207600"; 
   d="scan'208";a="549109656"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip06ir2.opaltelecom.net with SMTP; 28 Aug 2012 21:01:16 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204449>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Tuesday, August 28, 2012 12:22 AM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> I searched for all occurrences of '[[' which would indicate a double
>> optional argument within the synopsis and only found git-read-tree.
>
> Double-optional?  That is not an issue.

For clarification, I was picking out the particular case that I saw in
the git checkout syntax of an option (which necessarily starts with a
first `[` ) which is actually then a multi-choice option, so has a
second '[' for that, and then has the required parameter after the
closing ']' of the multi-choice, then another ']' after the parameter - 
hence my 'double optional argument' statement.

It was the multi-choice option, with parameter case that I was looking
for, as that multi-choice part would be easy to confuse with the normal
list of many options.

>
> If an option always takes a parameter, we would have
>
> git cmd [--option parameter]
>
> instead of one of
>
> git cmd [--option]
> git cmd [--option] parameter
> git cmd [--option] parameter...
>
> and if we had
>
> --option::
>        This option distims the parameter ...
>
> that needs to be updated to
>
> --option parameter::
>        This option distims the parameter ...

Agreed.

Philip
