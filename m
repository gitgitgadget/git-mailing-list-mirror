From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Provide a 'git help user-manual' route to the docbook
Date: Tue, 18 Feb 2014 22:39:02 -0000
Organization: OPDS
Message-ID: <5561391C5EED4114A90C35518558A267@PhilipOakley>
References: <1392472299-3780-1-git-send-email-philipoakley@iee.org><1392472299-3780-2-git-send-email-philipoakley@iee.org> <xmqqha7wdvpz.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Thomas Ackermann" <th.acker@arcor.de>,
	"W. Trevor King" <wking@tremily.us>,
	"David Aguilar" <davvid@gmail.com>,
	"Kevin Bracey" <kevin@bracey.fi>,
	=?iso-8859-1?Q?Ondrej_B=EDlka?= <neleai@seznam.cz>,
	"Phil Hord" <hordp@cisco.com>,
	"Sebastian Schuberth" <sschuberth@gmail.com>,
	=?iso-8859-1?Q?=D8ystein_Walle?= <oystwa@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 23:39:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtJl-0000Qc-65
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 23:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbaBRWjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 17:39:04 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:64424 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751404AbaBRWjC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 17:39:02 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtRPAJzgA1MCYJCb/2dsb2JhbABZgwY4EAOJBLd6AQECAQELgRUXdGkBAYEfAQEUAQQBAQQBCAEBLhYIAQEhCwIDBQIBAxUMJRQBBBgCBgcXBggLCAIBAgMBDASFKAcBghMZDAnMX44xMzWCdoEUBIkQhhqKOJBygy08
X-IPAS-Result: AtRPAJzgA1MCYJCb/2dsb2JhbABZgwY4EAOJBLd6AQECAQELgRUXdGkBAYEfAQEUAQQBAQQBCAEBLhYIAQEhCwIDBQIBAxUMJRQBBBgCBgcXBggLCAIBAgMBDASFKAcBghMZDAnMX44xMzWCdoEUBIkQhhqKOJBygy08
X-IronPort-AV: E=Sophos;i="4.97,503,1389744000"; 
   d="scan'208";a="601547021"
Received: from host-2-96-144-155.as13285.net (HELO PhilipOakley) ([2.96.144.155])
  by out1.ip06ir2.opaltelecom.net with SMTP; 18 Feb 2014 22:38:59 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242364>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> diff --git a/Documentation/gituser-manual.txt 
>> b/Documentation/gituser-manual.txt
>> new file mode 100644
>> index 0000000..9fd4744
>> --- /dev/null
>> +++ b/Documentation/gituser-manual.txt
>> @@ -0,0 +1,34 @@
>> +gituser-manual(7)
>> +=================
>> +
>> +NAME
>> +----
>> +gituser-manual - a link to the user-manual docbook
>> +
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git help user-manual'
>> +
>> +link:user-manual.html[Git User's Manual]
>
> Is it just me, or is typing
>
> $ git help user-manual
>
> and not seeing the manual itself, but only a link you have to click
> to get there a worthwhile addition?

It is a half-way house, partly because the current 'git help <name>' 
processing always assumes that the target is a man page, and that the 
page name will always be 'git<name>. Thus the current user-manual isn't 
immediately visible to the help system. Also it's not (quite reasonably) 
formatted as a man page either.

This was an attempt to offer more ways for users to discover the 
user-manual, as it would also be listed in the 'git help -g' output. To 
make that work required a proper man-page, hence the patch. Also I was 
avoiding the renaming of the user-manual.txt & user-manual.html file 
because of possible link breakages from external sources.

>
> I would not mind having a clickable link in the output from
>
> $ git help git

There is now a link within the git(1) page, though folk maybe leaping 
past it to the list of commands and env variables, etc.

I'm generally in favour of providing more help sign-posting from more 
directions where possible.

>
> or something that does already have other useful information, though.
>
>> +
>> +DESCRIPTION
>> +-----------
>> +Git is a fast, scalable, distributed revision control system with an
>> +unusually rich command set that provides both high-level operations
>> +and full access to internals.
>> +
>> +The link:user-manual.html[Git User's Manual] provides an
>> +in-depth introduction to Git.
>> +
>> +SEE ALSO
>> +--------
>> +linkgit:gittutorial[7],
>> +linkgit:giteveryday[7],
>> +linkgit:gitcli[7],
>> +linkgit:gitworkflows[7]
>> +
>> +GIT
>> +---
>> +Part of the linkgit:git[1] suite
>> diff --git a/builtin/help.c b/builtin/help.c
>> index 1fdefeb..be7c39d 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -427,6 +427,7 @@ static struct {
>>  { "modules", N_("Defining submodule properties") },
>>  { "revisions", N_("Specifying revisions and ranges for Git") },
>>  { "tutorial", N_("A tutorial introduction to Git (for version 1.5.1 
>> or newer)") },
>> + { "user-manual", N_("A link to the user-manual docbook") },
>>  { "workflows", N_("An overview of recommended workflows with 
>> Git") },
>>  };
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
