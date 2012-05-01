From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Location-agnostic submodules
Date: Tue, 1 May 2012 20:58:25 +0100
Organization: OPDS
Message-ID: <A688673CF88C4F469D3DF0D7E3AEFFA4@PhilipOakley>
References: <20120427143710.GA13953@pape.arcanes.fr.eu.org> <CABURp0qA9hK1fBd3rmLG61ErpbbzrcxO=AAmFOsoxjt=ozu09Q@mail.gmail.com> <20120430220244.GL22827@pape.arcanes.fr.eu.org> <CABURp0rUKubfWXxX2ABG2E4dRTEQh4zA0bZFOeXGwv2m4b0YaA@mail.gmail.com> <732A8D2DB3374CD6BC12A5E7C4384313@PhilipOakley> <7v4nrzaioc.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Phil Hord" <phil.hord@gmail.com>,
	"Pierre Thierry" <pierre@nothos.net>,
	"Git List" <git@vger.kernel.org>,
	"Jens Lehmann" <Jens.Lehmann@web.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKCl-00048o-6Y
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab2EAVBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 17:01:46 -0400
Received: from smtp2go.com ([207.58.142.213]:51901 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384Ab2EAVBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 17:01:46 -0400
X-Greylist: delayed 3205 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 May 2012 17:01:46 EDT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196748>

From: "Junio C Hamano" <gitster@pobox.com> Sent: Tuesday, May 01, 2012 6:57
PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Would an alternative be something like:
>>    git submodule update <module> --from <remote>
>>
>> so that the user can state which of the current submodule's remotes
>> should be used for fetching the desired update.
>
> Are you assuming that the <remote> in the above example will be different
> per invocation for a single user?

possibly, but more likely the user would have identified which is the best
remote to use to find her missing sha1.

>         I would imagine not---it would be more
> like "the upstream has this URL in .gitmodules, but this other mirror is
> closer to my network environment", i.e.
>
> cd <module's directory> && git config remote.origin.url $there
>
I was presuming a reverse time sequence, where the user had already set up
the desired remote, but hadn't managed to change the URL in .gitmodules; but
either way, the user then let's 'git submodule' do the hard work of fetching
the correct sha1 to checkout.

I didn't think that there was a command yet to do the URL update, which
would most likely match one of the sub-module's URLs.

> no?
>
>
Philip
