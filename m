From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git checkout -t -B
Date: Tue, 28 Aug 2012 00:09:44 +0100
Organization: OPDS
Message-ID: <10B409063A944B298250064D2DB0BAB7@PhilipOakley>
References: <CAHtLG6QgnvG6eYEChojY_jB25QWqxis6brbst2ff5FixFLAXAw@mail.gmail.com> <7v8vd1v6q2.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 01:09:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68RI-0005nK-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 01:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab2H0XJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 19:09:42 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:25376 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754849Ab2H0XJl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 19:09:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsEMAGL3O1BZ8rU+/2dsb2JhbABFhgOFP641AQKBAoEIghsFAQEEAQgBARkPAQUeAQEhCwIDBQIBAQIVAQQCBSECAhQBBAgSBgcXBgESCAIBAgMBh20DBgqnZIk1DYlOgSGJBGOBEAtLg2EyYAONXIYmjGGFB4Jk
X-IronPort-AV: E=Sophos;i="4.80,322,1344207600"; 
   d="scan'208";a="45736451"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip07ir2.opaltelecom.net with SMTP; 28 Aug 2012 00:09:39 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204385>

=46rom: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, August 26, 2012 7:38 PM
> =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:
>
>> git checkout -t -B origin/abcde
>> works
>>
>> but
>> git checkout -B -t origin/abcde
>> does not.
>>
>> Could you document the order of parameters or fix the behaviour?
>
> It is crystal clear that -b/-B/--orphan must be followed by the name
> of the branch you are creating from the SYNOPSIS section of the
> documentation.
>
>    NAME
>    ----
>    git-checkout - Checkout a branch or paths to the working tree
>
>    SYNOPSIS
>    --------
>    [verse]
>    ...
>    'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>]
> [<st..
>    ...

I didn't find it immediately obvious, but with 6/6 hindsight it is=20
clearly indicated.

However the -t option isn't listed within the synopsis, and does=20
immediately follow the -b & -B in the options list which could confuse=20
some readers who would stick it after the -b ;-)

Should the -t and -l options be shown in the synopsis?

>
> However, the option description can use some improvement.  It
> currently reads:
>
>    -b::
>            Create a new branch named <new_branch> and start it at
>            <start_point>; see linkgit:git-branch[1] for details.
>
> as if it and <new_branch> are freestanding arguments.
>
> I think we should describe the option like this:
>
>    -b <new_branch>::
>            Create a new branch named <new_branch> and start it at
>            <start_point>; see linkgit:git-branch[1] for details.
>
> The description for "-B" and "--orphan" options share the same
> issue.
>
> I suspect that documentation for other commands may share this
> issue.  It would be good if somebody can check the option
> description section and make sure there is no discrepancy like this
> by comparing it to the SYNOPSIS section (or "git cmd -h") for all
> manual pages.
>
> I'll patch only "git-checkout.txt" myself for now; hint, hint.

I searched for all occurrences of '[[' which would indicate a double=20
optional argument within the synopsis and only found git-read-tree.

I don't think it has the same problem but I wasn't sure of the priority=
=20
order between the '[]' and '|' selectors in the multi-choice cases.

I haven't seen anything definitive on how one should read the synopsis.=
=20
I thought the order of some option could be exchanged, as rev-parse say=
s=20
that they can be combined (for the right commands).

>
> Thanks.
> --
