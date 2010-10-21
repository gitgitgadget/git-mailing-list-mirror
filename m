From: Kevin Ballard <kevin@sb.org>
Subject: Re: bash completion broken on ubuntu 10.10?
Date: Wed, 20 Oct 2010 21:44:38 -0700
Message-ID: <15A9C855-A450-467F-9502-9ADA3D59F64F@sb.org>
References: <20101020230409.GB1767@neumann> <20101020225018.46f7e70e@montecarlo.grandprix.int>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 06:45:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8n26-0002P3-T4
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 06:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276Ab0JUEol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 00:44:41 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65245 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0JUEok convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 00:44:40 -0400
Received: by pvh1 with SMTP id 1so149404pvh.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 21:44:40 -0700 (PDT)
Received: by 10.142.158.19 with SMTP id g19mr265865wfe.319.1287636280468;
        Wed, 20 Oct 2010 21:44:40 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x18sm1622332wfa.11.2010.10.20.21.44.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 21:44:39 -0700 (PDT)
In-Reply-To: <20101020225018.46f7e70e@montecarlo.grandprix.int>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159483>

On Oct 20, 2010, at 7:50 PM, Peter van der Does wrote:

> On Thu, 21 Oct 2010 01:04:09 +0200
> SZEDER G=E1bor <szeder@ira.uka.de> wrote:
>=20
>> Hi,
>>=20
>> Git's bash completion script offers possible arguments to some
>> options, e.g. it lists pretty formats after 'git log --pretty=3D<TAB=
>',
>> merge tools after 'git mergetool --tool=3D<TAB>', refs after 'git co=
mmit
>> --reuse-message=3D<TAB>', etc.
>>=20
>> On a three day old ubuntu 10.10 install these don't work anymore; th=
e
>> completion script offers the list of files in all those cases.
>>=20
>> After a bit of investigation I found that when I press TAB after 'gi=
t
>> log --pretty=3D', then ${COMP_WORDS[COMP_CWORD-1]} contains '--prett=
y'
>> and ${COMP_WORDS[COMP_CWORD]} contains "=3D".  Weird.
>>=20
>> Then I remembered that we had some COMP_WORDBREAKS issues in the pas=
t
>> (db8a9ff, bash completion: Resolve git show ref:path<tab> losing ref=
:
>> portion, 2008-07-15)).  So I looked at my $COMP_WORDBREAKS, but didn=
't
>> see anything suspicious (it contains "'><=3D;|&(: ).  Removing the '=
=3D'
>> makes the listing after 'git log --pretty=3D' work, but breaks many
>> other things badly.
>>=20
>> I don't have any ideas what could possibly be wrong here (but it's t=
oo
>> late here for any bright ideas anyway...).  Could someone confirm or
>> deny this behaviour on ubuntu 10.10?
>>=20
>>=20
>> Thanks,
>> G=E1bor
>>=20
>=20
> My guess is that it has to do with Bash 4, the equal sign must be see=
n
> as a new word. I'm running Ubuntu 10.04 and have the same problem.
> I fixed the problem locally, I just don't know if that works on Bash =
3
> and I doubt it will work on Bash 3.
>=20
> I changed the script only for git log, not other commands yet, like=20
> git am --whitespace=3D<tab><tab>

Looks like you're right. I'm running bash 4.1.7 on OS X and it's broken=
 here.

-Kevin Ballard