From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Wed, 4 Sep 2013 23:08:46 +0100
Organization: OPDS
Message-ID: <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com><xmqqd2opu8hr.fsf@gitster.dls.corp.google.com><CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com><xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com><20130904081047.GB2582@serenity.lan> <xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, "Andreas Krey" <a.krey@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>,
	"John Keeping" <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Sep 05 00:08:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHLFl-0001Ex-SQ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 00:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756339Ab3IDWIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 18:08:42 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:26540 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753023Ab3IDWIl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Sep 2013 18:08:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiwMANauJ1JOl3GZ/2dsb2JhbABbgweJbLhVBAQBgSgXdGgBAYEfAQEUAQQBAQQBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHFwYBEggCAQIDAQuFLQcBghIZCro4jiGBP4MkgQADiH2GEppMgTqBZzuBLA
X-IPAS-Result: AiwMANauJ1JOl3GZ/2dsb2JhbABbgweJbLhVBAQBgSgXdGgBAYEfAQEUAQQBAQQBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHFwYBEggCAQIDAQuFLQcBghIZCro4jiGBP4MkgQADiH2GEppMgTqBZzuBLA
X-IronPort-AV: E=Sophos;i="4.90,1023,1371078000"; 
   d="scan'208";a="436093885"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip03ir2.opaltelecom.net with SMTP; 04 Sep 2013 23:08:39 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233880>

From: "Junio C Hamano" <gitster@pobox.com>
> John Keeping <john@keeping.me.uk> writes:
>
>> I think there are two distinct uses for pull, which boil down to:
>>
>>     (1) git pull
>>     (2) git pull $remote $branch
>>
>> For (1) a merge is almost always the wrong thing to do since it will 
>> be
>> backwards and break --first-parent.
>>
>> But for (2) a merge is almost always the correct thing to do (in fact 
>> it
>> may even be correct to create a merge commit even when this fast
>> forwards) because this most likely comes for a pull request workflow.
>
> Peff already covered (1)---it is highly doubtful that a merge is
> "almost always wrong".  In fact, if that _were_ the case, we should
> simply be defaulting to rebase, not failing the command and asking
> between merge and rebase like jc/pull-training-wheel topic did.
>
> We simply do not know what the user wants, as it heavily depends on
> the project, so we ask the user to choose one (and stick to it).

We only offer a limited list. It won't be sufficient for all use cases. 
It wasn't for me.

The ability to say 'stop' if it doen't match expectations, as 
the --no-ff option would give, would be a help, as the user can then 
decide what to do (read the manual or `google` the problem perhaps ;-). 
the option of having a hook (if suggested), while suitable for advanced 
users won't help those that need that help, rather a few simple safe 
options are needed.

I generally support the ability to set an option to reject non-ff pulls.

>
> I am not sure about (2), either.  Is it really "almost always the
> correct thing to do"?  I tend to think myself that (2) is a lot more
> likely to prefer merging than (1) would, but I certainly wouldn't
> say "almost always".  Again if "almost always" were the case,
> wouldn't it make sense for that mode of invocation of the command to
> even defeat "pull.rebase" configuration and default to merge, unless
> explicitly told to "pull --rebase" from the command line?
>
> (the last question is rhetoric, if anybody is wondering).
> --
Philip 
