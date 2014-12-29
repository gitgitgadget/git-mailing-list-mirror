From: "Randy J. Ray" <rjray@blackperl.com>
Subject: Re: Git's Perl scripts can fail if user is configured for perlbrew
Date: Mon, 29 Dec 2014 15:57:30 -0600
Message-ID: <54A1CE4A.7020408@blackperl.com>
References: <54A085D1.8060407@blackperl.com> <54A159D7.5010307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:57:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5iJt-0002Ay-On
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbaL2V5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2014 16:57:40 -0500
Received: from shell1.rawbw.com ([198.144.192.42]:17069 "EHLO shell1.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbaL2V5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:57:40 -0500
Received: from ventrue.local ([12.69.179.130])
	(authenticated bits=0)
	by shell1.rawbw.com (8.14.9/8.14.9) with ESMTP id sBTLvX3d054677
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 29 Dec 2014 13:57:37 -0800 (PST)
	(envelope-from rjray@blackperl.com)
X-Authentication-Warning: shell1.rawbw.com: Host [12.69.179.130] claimed to be ventrue.local
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <54A159D7.5010307@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261891>

On 12/29/14, 7:40 AM, Torsten B=F6gershausen wrote:
> Having problems with different perl installations is not an unknown p=
roblem
> in Git, I would say.
>
> And Git itself is prepared to handle this situation:
>
> In Makefile I can read:
> # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/=
perl).
>
> (What Git can not decide is which perl it should use, the one pointed=
 out by $PATH or /usr/bin/perl.)
>
> What does
> "type perl" say ?
>
> And what happens when you build and install Git like this:
> PERL_PATH=3D/XX/YY/perl make install
>
> -----------
> Are you thinking about changing
> ifndef PERL_PATH
> 	PERL_PATH =3D /usr/bin/perl
> endif
> -- into --
> ifndef PERL_PATH
> 	PERL_PATH =3D $(shell which perl)
> endif
> ---
>
> At first glance that could make sense, at least to me.

The problem in this case is the Perl being used at run-time, not=20
build-time. The building of git is done by the homebrew project in this=
=20
case, so I don't have direct control over it.

Randy
--=20
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""=
""""""""
Randy J. Ray      Sunnyvale, CA      http://www.dereferenced.com
rjray@blackperl.com
twitter.com/rjray
Silicon Valley Scale Modelers: http://www.svsm.org
