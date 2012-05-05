From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sat, 5 May 2012 17:52:16 +0100
Organization: OPDS
Message-ID: <703DFCB358F74F9D87F12C22B782EA61@PhilipOakley>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Jeff King" <peff@peff.net>, "Scott Chacon" <schacon@gmail.com>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Matthieu Moy" <matthieu.moy@imag.fr>,
	"Piotr Krukowiecki" <piotr.krukowiecki.news@gmail.com>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 05 18:52:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQiDJ-0005ms-9N
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 18:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194Ab2EEQwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 12:52:04 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:46618 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756315Ab2EEQwD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 12:52:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuQKAA9apU9cHlGK/2dsb2JhbABFhXKFSKYZAoEegQiCBwUBAQQBCAEBGRUeAQEcBQUGAgMFAgEDFQEEAgUhAgIUAQQIEgYHFwYBEggCAQIDAYdvAwYJp1OIRA2JU4EviGhogXeDETVjBI16k0OFA4Jq
X-IronPort-AV: E=Sophos;i="4.75,536,1330905600"; 
   d="scan'208";a="392409930"
Received: from host-92-30-81-138.as13285.net (HELO PhilipOakley) ([92.30.81.138])
  by out1.ip02ir2.opaltelecom.net with SMTP; 05 May 2012 17:52:00 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197125>

From: "Felipe Contreras" <felipe.contreras@gmail.com> Sent: Saturday, May 
05, 2012 2:04 PM
> Proposal:
>
> Avoid the terms 'cache' and 'index' in favor of 'stage'.
>
> Advantages:
>
> The term 'stage' is more intuitive for newcomers which are more
> familiar with English than with git, and it seems to be a
> straightforward mental notion for people from different mother
> tongues.
>
> It is so intuitive that it is used already in a lot online
> documentation, and the people that do teach git professionally use
> this term.

I've never found any of the terms to be great (as per this discussion ;-).

The term that helped me most, heard on one of the git videos, was "it's like 
a manifest", alluding to a 'shipping manifest', which then leads to both the 
"staging area" and "index" terms. Though "index" is probably too technical 
for most folk.

The allusion to shipping a consignment or rail marshalling (classification) 
yards, and similar frieght flows, may be another way for _explaining_ the 
term chosen for the preparation, consolidation and aggregation of the next 
shipment (commit). Most other VCS systems hide this stage (sic), hence the 
difficulty in explaining this to the lay person.

> Risks:
>
> People might be accustomed to the current options, and might take some
> time to get used to the new term. Scripts might be relying on the
> current options.
>
> There's also the possibility that a lot of people prefer the terms
> 'cache' and 'index', but from the countless discussions on this
> subject, that seems to be rather unlikely.
>
> Migration plan:
>
> Follow a typical obsolete/deprecate process; for a period of time warn
> that the options are obsolete and shouldn't be used, in case there's a
> lot of people against this, this period would allow for them to shout;
> then remove them.
>
> Rationale:
>
> First of all, this discussion _always_ keeps coming back, so its clear
> something needs to be done, and in the last big discussion the
> consensus was that 'stage' was the best option. In summary:
>
> cache: a 'cache' is a place for easier access; a squirrel caches nuts
> so it doesn't have to go looking for them in the future when it might
> be much more difficult. Git porcelain is not using the staging area
> for easier future access; it's not a cache.
>
> index: an 'index' is a guide of pointers to something else; a book
> index has a list of entries so the reader can locate information
> easily without having to go through the whole book. Git porcelain is
> not using the staging area to find out entries quicker; it's not an
> index.
>
> stage: a 'stage' is a special area designated for convenience in order
> for some activity to take place; an orator would prepare a stage in
> order for her speak to be successful, otherwise many people might not
> be able to hear, or see her.  Git porcelain is using the staging area
> precisly as a special area to be separated from the working directory
> for convenience.
>
> The term 'stage' is a good noun itself, but also 'staging area', it
> has a good verb; 'to stage', and a nice past-participle; 'staged'.
>
> -- 
> Felipe Contreras

Philip 
