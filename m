From: =?iso-8859-1?q?Gr=E9goire?= PARIS <postmaster@greg0ire.fr>
Subject: Re: Bypassing hooks while cherry-picking
Date: Fri, 4 Mar 2016 00:18:57 +0100
Message-ID: <56D8C661.9000303@greg0ire.fr>
References: <56D576A1.3020202@greg0ire.fr>
	<xmqqwppj1c83.fsf@gitster.mtv.corp.google.com>
	<56D8B895.9030308@greg0ire.fr>
	<xmqqk2lj189l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 00:19:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abcWQ-0006yT-Cm
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 00:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772AbcCCXTB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2016 18:19:01 -0500
Received: from smtp21.services.sfr.fr ([93.17.128.1]:62684 "EHLO
	smtp21.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcCCXTA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 18:19:00 -0500
Received: from filter.sfr.fr (localhost [84.99.208.145])
	by msfrf2102.sfr.fr (SMTP Server) with ESMTP id B58347000064;
	Fri,  4 Mar 2016 00:18:57 +0100 (CET)
Authentication-Results: sfrmc.priv.atos.fr; dkim=none (no signature);
	dkim-adsp=none (no policy) header.from=postmaster@greg0ire.fr
Received: from [192.168.1.22] (145.208.99.84.rev.sfr.net [84.99.208.145])	(using TLSv1
	with cipher DHE-RSA-AES128-SHA (128/128 bits))	(No client certificate requested)
	by msfrf2102.sfr.fr (SMTP Server) with ESMTP id 7F5BE7000089;
	Fri,  4 Mar 2016 00:18:57 +0100 (CET)
X-SFR-UUID: 20160303231857521.7F5BE7000089@msfrf2102.sfr.fr
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
In-Reply-To: <xmqqk2lj189l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288223>

Le 03/03/2016 23:55, Junio C Hamano a =C3=A9crit :
> Gr=C3=A9goire PARIS <postmaster@greg0ire.fr> writes:
>
>> Not sure how cherry-picking is managed, and whether commit is able t=
o
>> see that we are doing a cherry-pick, and end it up properly. Anyway,
>> with Kevin's patch, we should be able to happily use cherry-pick
> [Please do not top post]
>
> It is somewhat sad to see such a response as that is backwards.
>
> "cherry-pick --continue" originally was "I am done with the commit I
> was asked to deal with, so please replay the next one", and in order
> to "be done with" the commit, you would used "git commit" yourself,
> with whatever necessary options (e.g. --no-verify, -s, -c) you want
> to affect the behaviour of the "git commit".
>
> It is a later invention that "cherry-pick --continue" additionally
> creates a commit when the user, even though she claims to "be done
> with", hasn't actually made the commit before going on to replay the
> next one.  It was accepted as a short-cut as most of the time you do
> not give any option to your "git commit" invocation, but probably
> was a misguided invention--it made new people somehow think that
> they are not allowed to run "git commit" to conclude the conflict
> resolution, when in reality that is an acceptable and primary way
> to do so and "--continue" is a mere short-hand.
>
> As "git commit" does have options other than "--no-verify" that
> affects the way it behaves, and can gain more such options in the
> future, having to keep adding corresponding options to "cherry-pick
> --continue --more-options" will not be a good solution in the longer
> run.
>
>
Sorry for top-posting, I'll keep in mind to not do this.

You're describing very precisely how using cherry-pick --continue makes=
=20
me feel. I checked again right now and even though there is a comment t=
o=20
make me understand that commit would do a great job at solving my=20
problem (hint: and commit the result with 'git commit'), I failed to=20
notice it.

I agree with you, adding every commit option is not a good solution=E2=80=
=A6=20
Maybe a good solution would be to display a special message when using=20
cherry-pick --continue with unrecognized options? Like for instance

 > hint: try git commit --no-verify, then git cherry-pick --continue to=
=20
replay the next commit

What do you think?

--
greg0ire
