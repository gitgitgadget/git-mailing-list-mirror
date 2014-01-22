From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work -> relnotes
Date: Wed, 22 Jan 2014 00:22:19 -0000
Organization: OPDS
Message-ID: <2D10AF8E0C024CC5A817528582FDE07D@PhilipOakley>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org><xmqqppo090m7.fsf@gitster.dls.corp.google.com><52CFACBB.7000805@atlas-elektronik.com><F11CD558C63947F9B4AA75501D2F9F62@PhilipOakley><52D91B0E.6080000@atlas-elektronik.com><BA4E87FA92ED4E8FB2C00F013BD7B3FF@PhilipOakley> <xmqqob34synq.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>,
	"GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 01:21:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5lZv-0007NC-Et
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 01:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbaAVAV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 19:21:56 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:52551 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750824AbaAVAVz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jan 2014 19:21:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AghGADAO31ICYJZt/2dsb2JhbABagwtIA4h+sy8BAgEBC4EHF3RpAQGBHwEBFAEEAQEBAQMIAQEdER4BASELAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBhTgHAYITJcJmF45/NYJ2gRQEiQ+GF5sUgy08
X-IPAS-Result: AghGADAO31ICYJZt/2dsb2JhbABagwtIA4h+sy8BAgEBC4EHF3RpAQGBHwEBFAEEAQEBAQMIAQEdER4BASELAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBhTgHAYITJcJmF45/NYJ2gRQEiQ+GF5sUgy08
X-IronPort-AV: E=Sophos;i="4.95,697,1384300800"; 
   d="scan'208";a="452827989"
Received: from host-2-96-150-109.as13285.net (HELO PhilipOakley) ([2.96.150.109])
  by out1.ip01ir2.opaltelecom.net with SMTP; 22 Jan 2014 00:21:53 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240809>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Determining which is the current release note is possibly more
>> problematic, which should be when making the documentation.
>
> Hmmm.... Why?
>
> You are already aware of the stale-notes section, no?  Isn't the top
> one the latest?

It's that the 'git help release-notes' would _include_ the latest 
release notes, not just link to them (which is what the stalenotes 
currently does). Or at least that was the idea.

Trying to determine the latest version, and then include those release 
notes, and the subsequent maint notes, into the putative 
"release-notes(7)" man page, without causing you any maintenance hassle, 
was the conceptual problem.

I already have a local patch that creates a stalenote.txt file, and 
includes that in a "release-notes(7)" man page, but it still leaves the 
actual release notes in a separate plain text file, linked from the man 
page, rather than being right at hand, which is what I think readers 
would expect.


My other question would be to ask how you normally manage the up-issue 
of the stalenotes, and when you would normally create that section in 
git(1) as I didn't see any ifdef::stalenotes[] being defined anywhere 
else.

Philip
