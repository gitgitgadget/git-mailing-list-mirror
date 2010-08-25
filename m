From: Daniel Pfeiffer <occitan@t-online.de>
Subject: Re: Compiling git with makepp patch
Date: Wed, 25 Aug 2010 22:41:58 +0200
Message-ID: <4C758016.8070104@t-online.de>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de> <4C71A53F.2020108@t-online.de> <20100824043220.GA20037@burratino>
Reply-To: occitan@esperanto.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: occitan@esperanto.org, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 22:42:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoMnY-0004fV-15
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 22:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab0HYUmK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 16:42:10 -0400
Received: from mailout05.t-online.de ([194.25.134.82]:48167 "EHLO
	mailout05.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab0HYUmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 16:42:09 -0400
Received: from fwd09.aul.t-online.de (fwd09.aul.t-online.de )
	by mailout05.t-online.de with smtp 
	id 1OoMnL-0005xc-3J; Wed, 25 Aug 2010 22:42:03 +0200
Received: from [192.168.0.10] (Xj2k44ZewhO1Chcv+Qi5rbZA72jl1up3Q1fIFgHe-lWnfF5ov1q1eI7rgwEaCA1wcm@[84.177.184.117]) by fwd09.aul.t-online.de
	with esmtp id 1OoMnJ-1qAs1Q0; Wed, 25 Aug 2010 22:42:01 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.4) Gecko/20100608 Mnenhy/0.8.3 Thunderbird/3.1
In-Reply-To: <20100824043220.GA20037@burratino>
X-ID: Xj2k44ZewhO1Chcv+Qi5rbZA72jl1up3Q1fIFgHe-lWnfF5ov1q1eI7rgwEaCA1wcm
X-TOI-MSGID: 4c4a007b-2b9b-41ce-8fc1-7429eab2ae5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154467>

  la 08/24/2010 06:32 AM Jonathan Nieder skribis:
> Hi,
>
> Daniel Pfeiffer wrote:
>> The file needs to be built immediately so
>> that it can be included, before reading the rest of the makefile.
>> But the dependency is only known to be phony after running the rule.
>> Here you have a hen-egg problem, where I have no clue how Gnu make
>> can cope (this is the one case where it requires .PHONY).
> GNU make, unlike, say, pmake, reads all the rules before it runs
> anything iirc.  So you can have
>
>   -include foo
>
>   foo:
> 	echo bar:>foo
> 	echo '	echo hi'>>foo
>
> and it will cope okay.
While that is not the usual use-case for -include, the file might very =
well=20
define some macros, and the rest of the makefile, indeed the foo-rule i=
tself=20
might depend on those macros.  Better to have things in a clear order!

> Anyway, the git makefile is very far from topologically sorted; if
> you are suggesting we change that, that's fine with me, as long as
> the new rule is somehow justified and consistent.

coralament / best Gr=C3=B6tens / liebe Gr=C3=BC=C3=9Fe / best regards /=
 elkorajn salutojn
Daniel Pfeiffer

--=20
lerne / learn / apprends / l=C3=A4r dig / ucz si=C4=99    Esperanto:
                     http://lernu.net  /  http://ikurso.net
