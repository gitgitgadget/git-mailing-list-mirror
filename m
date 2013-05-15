From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Wed, 15 May 2013 23:22:55 +0100
Organization: OPDS
Message-ID: <AE3E8FA3205F42C5B11F3617987BEA05@PhilipOakley>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 00:22:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uck64-00027b-UQ
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 00:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab3EOWWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 18:22:53 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:20004 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751757Ab3EOWWw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 May 2013 18:22:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah0OALkJlFFOl3Xl/2dsb2JhbABbgweDc4U/t1UEAQMBfBd0ghoFAQEFCAEBGRUeAQEsAgMFAgEDFQEEAgUhAgIUAQQIEgYHFwYBEggCAQIDAYdpAxOrMohoDYhhgSaLIoFsN4J8MmEDjmeGaI1/hSODETs
X-IronPort-AV: E=Sophos;i="4.87,679,1363132800"; 
   d="scan'208";a="424087553"
Received: from host-78-151-117-229.as13285.net (HELO PhilipOakley) ([78.151.117.229])
  by out1.ip03ir2.opaltelecom.net with SMTP; 15 May 2013 23:22:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224451>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Wednesday, May 15, 2013 9:34 PM
> Hi,
>
> I've been using Git from the start, but only lately have I forced
> myself to configure upstream branches for all my branches, and I've
> found a few things more convenient, but others completely contrary to
> what I expected.
>
> Inconvenient:
>
> Before, I used to do 'git fetch' to simply fetch from 'origin', but
> now, it depends on where 'upstream' is set to.
>
> Convinient:
>
> Now, I can just do 'git rebase --interactive' and I don't have to
> specify the starting point, which is particularily useful when there's
> a lot of branches one depending on another.
>
> I think I'm using 'upstream' for something it was not intended to, and
> I think the current 'upstream' behavior should be split into
> 'upstream' and 'base'.
>
> == base ==
>
> The 'base' branch will be set each time you create a branch from 
> another;
> 'git checkout -b foobar master' sets 'master' as the 'base' of 
> 'foobar'.
>
> Then you can do 'git rebase foobar@{base}' or simply 'git rebase', and
> Git will pick the right branch to rebase unto, even if you have no
> 'upstream'
> configured.
>
> This way 'git fetch' will keep picking 'origin', and other commands
> that make use of 'upstream' would be undisturbed.
>
> If both 'base' and 'upstream' are defined, I think 'git rebase' should
> use 'base', but since that would break old behavior, perhaps there
> should be a configuration variable to enable a different behavior.
>
> I already started writting the patches, and although tedious, I think
> they they'll be rather straightforward, but I thought it would be best
> to hear some opinions first.
>
> What do you think?
>
> -- 
> Felipe Contreras
---
Sound a reasonable idea. On some patches I was working on I had to 
[chose to] add a tag for the base which made it easier to rebase later.

The other point is that I had already noted that the glossary doesn't 
include the many "base" terms in use that aren't always well understood.

Philip Oakley 
