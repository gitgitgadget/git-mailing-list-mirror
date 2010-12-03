From: demerphq <demerphq@gmail.com>
Subject: Re: Problems using perl's Git.pm module
Date: Fri, 3 Dec 2010 10:02:19 +0100
Message-ID: <AANLkTikDCNLLTdKyUT8_RXLWhJ8onMKh8EBpg_=iQUzW@mail.gmail.com>
References: <20101202114003.GA26070@raven.wolf.lan>
	<AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
	<7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
	<AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
	<20101202181425.GG3962@burratino>
	<AANLkTimKKssBbtuLKCqG9WGbOe+-CH4pc5PDaNxCH_PS@mail.gmail.com>
	<20101203083827.GD26070@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, demerphq <demerphq@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gm
X-From: git-owner@vger.kernel.org Fri Dec 03 10:02:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PORXB-0004Hh-C4
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 10:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab0LCJCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 04:02:22 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36679 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab0LCJCU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 04:02:20 -0500
Received: by qyk12 with SMTP id 12so11419415qyk.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 01:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=iKJ755N8RGm6UTcbeVszjo4bpcWAIr5ntnWdptcuEks=;
        b=xfJVVQNbMjP4ZWsrEmcvkQZZQzOOHPstfs0oxhM3QLB+dmM/K2ANx0/ez0juldPvZu
         IuHuZyIOG2aZ5q7y3AsSBSW60Y9o30Ho6bm4W1DoxoENmFl6sr21JmNg8mM8D2P7bdk8
         09kVneFiIpR8ALiCtc/MJ3til5G7E5ewga+dE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=SeEs7wjQDda8clhiZ9uSZofCC+fkZ8Pz+3/5KfXBGgIkt6QCydhnSElQjrn7YAFVsW
         d6o5aZKgQuKALnvJzKfQ5bDRwV+3hJTWnNdLBhlifmwmwYo0dEfvXIQZ0T8TmlofY2BZ
         0vcwIHZ13JiEyQiqMWA9vPmJvWsshUFhosQ/w=
Received: by 10.229.251.204 with SMTP id mt12mr1031112qcb.182.1291366939589;
 Fri, 03 Dec 2010 01:02:19 -0800 (PST)
Received: by 10.229.192.193 with HTTP; Fri, 3 Dec 2010 01:02:19 -0800 (PST)
In-Reply-To: <20101203083827.GD26070@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162777>

On 3 December 2010 09:38, Josef Wolf <jw@raven.inka.de> wrote:
> On Thu, Dec 02, 2010 at 07:41:00PM +0100, demerphq wrote:
>> Well, the counter =A0arguments are:
>>
>> No back-compat layer for older gits. Tight binding to a particular g=
it
>> - no availability of upgrades independent of upgrading git.
>
> I don't understand this one. Why do you need independent upgrades her=
e?
> Since Git.pm comes with git core, the installed version of Git.pm sho=
uld
> always match the installed version of git.

Because in my experience coding a tool against a particular version of
Git.pm basically means that tool has to be on the same git version or
higher than the version you coded against.

There is no easy/safe way to update Git,pm to provide a consistent
interface to older gits.

>
>> No
>> availability or review of the module on the standard venues for doin=
g
>> so for Perl modules. CPAN, CPANTESTERS, smoke reports, etc.
>
> A module on CPAN has better tests for perl integration.
> A module in git-core has better tests for git integration.
>
> You trade one for the other. The question is which is more critical. =
IMHO,
> git-integration is more critical.

A CPAN module would be automatically tested by the CPANTESTERS
community against whatever git people happened to have lying around,
and those tests would necessarily occur on a myriad of systems, and
when failures occurred they would be automatically registered in CPAN
rt bug tracking system, and available in various summarized and
detailed forms from multiple locations.

Those test results and integration efforts would be automatically fed
back to the module author, be publicly available on several websites,
including via CPAN itself, and if it should happen that the p5p group
were to somehow break Git.pm somehow we would know about it, and be
able to fix perl itself without Git.pm having to change. Admittedly
this is unlikely given the nature of the code.

So really, by tightly binding the package to git all that you
guarantee is that the version of Git.pm installed by git will work
with the git you have installed. It does not say that any program
written against that version of Git.pm will continue to work on a
later version, or that people stuck on a older version of git will be
able to use it.

cheers,
Yves







--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
