From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: unclear documentation of git fetch --tags option and tagopt config
Date: Thu, 13 Dec 2012 23:54:45 -0000
Organization: OPDS
Message-ID: <084AB408ED4E4CF3B048B8615658F158@PhilipOakley>
References: <CAHtLG6Ti7yPFfhTb2qfSKE1+5n4Ftey4DQeqpm3SSL-bOfspUg@mail.gmail.com> <7v7golzta8.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 00:55:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjIcF-0002Sz-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 00:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312Ab2LMXyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2012 18:54:43 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:31802 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756300Ab2LMXym (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2012 18:54:42 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFAF9pylBcHmeG/2dsb2JhbABFhjiFP7J4F3OCGQUBAQUIAQEZDwEFHgEBIQsCAwUCAQECFQEEAgUhAgIUAQQIEgYHFwYBEggCAQIDAYdwAxOPFZp1iTMNiVWBIopMaYMwMmEDjXyGN40NhRGCcw
X-IronPort-AV: E=Sophos;i="4.84,276,1355097600"; 
   d="scan'208";a="408258744"
Received: from host-92-30-103-134.as13285.net (HELO PhilipOakley) ([92.30.103.134])
  by out1.ip03ir2.opaltelecom.net with SMTP; 13 Dec 2012 23:54:40 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211479>

=46rom: "Junio C Hamano" <gitster@pobox.com> Sent: Thursday, December 1=
3,=20
2012 6:44 PM
> =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:
>
>> With git fetch --tags
>> or remote.origin.tagopt =3D --tags
>> git fetch only fetches tags, but not branches.
>> Current documentation does not mention that no branches are fetched =
/
>> pulled when --tags option or remote.origin.tagopt =3D --tags is
>> specified.
>
> In the canonical form you spell out what you want to fetch from
> where, and a lazy "git fetch" or "git fetch origin" that does not
> specify what are to be fetched are the special cases.  Because they
> do not say what to fetch, they would become a no-op, which would not
> be very useful, if there is no special casing for them.  Instead,
> they use sensible default, taking refspec from the configuration
> variable remote.$name.fetch.
>
> Giving refspecs or the "--tags" option from the command line is a
> way to explicitly override this default, hence:
>
>    $ git fetch origin HEAD
>
> only fetches the history leading to the commit at HEAD at the
> remote, ignoring the configured refspecs.  As "--tags" is a synonym
> to "refs/tags/*:refs/tags/*", "git fetch --tags origin" tells us to
> ignore refspecs and grab only the tags, i.e.:
>
>    $ git fetch origin "refs/tags/*:refs/tags/*"
>
> which does not grab any branches.
>
> You can of course do:
>
>    $ git fetch --tags origin=20
> refs/heads/master:refs/remotes/origin/master
>
> --

What would be the best way of updating the documentation to clarify the=
=20
point? Given ch3cooli's previous surprise.
