From: Matthieu Imbert <matthieu.imbert@inria.fr>
Subject: Re: remote branches
Date: Sun, 13 Feb 2011 11:07:11 +0100
Message-ID: <4D57AD4F.3030109@inria.fr>
References: <4D578B6D.9090803@inria.fr> <AANLkTi=WPAYXg1NCyO+XDw8Jk5v=QBH3nM78CEHytuVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 11:07:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoYrP-0001Sp-S4
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 11:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab1BMKHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Feb 2011 05:07:15 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:62689 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753952Ab1BMKHN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Feb 2011 05:07:13 -0500
X-IronPort-AV: E=Sophos;i="4.60,464,1291590000"; 
   d="scan'208";a="91209140"
Received: from sso69-1-88-163-193-142.fbx.proxad.net (HELO [192.168.1.3]) ([88.163.193.142])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-CAMELLIA256-SHA; 13 Feb 2011 11:07:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
In-Reply-To: <AANLkTi=WPAYXg1NCyO+XDw8Jk5v=QBH3nM78CEHytuVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166653>

On 02/13/2011 10:17 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Sun, Feb 13, 2011 at 08:42, Matthieu Imbert<matthieu.imbert@inria.=
fr>  wrote:
>
>> $ git clone
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> linux-2.6.git
>>
>> - then i add a remote tracking branch:
>>
>> $ git remote add --tags drm-intel
>> git://git.kernel.org/pub/scm/linux/kernel/git/ickle/drm-intel.git
>
> You're adding a remote repository and tracking branches and tags from
> it.
>
>> - Then i do git fetch or git fetch drm-intel, but nothing happens, a=
nd git
>> branch -r still only show me origin/HEAD and origin/master, no drm-i=
ntel
>> branches, though these branches do exist since i can see them with g=
it
>> remote -v show drm-intel
>
> You didn't add any remote tracking *branch*, you added a remote and
> gave it the name "drm-intel". You could just as well do:
>
>      git remote add --tags some-random-name
> git://git.kernel.org/pub/scm/linux/kernel/git/ickle/drm-intel.git
>
> Also because you specified --tags you're only getting the tags on "gi=
t
> fetch", if you don't do that then:
>
>      $ git fetch some-random-name
>      remote: Counting objects: 567, done.
>      remote: Compressing objects: 100% (377/377), done.
>      remote: Total 488 (delta 371), reused 146 (delta 111)
>      Receiving objects: 100% (488/488), 91.42 KiB, done.
>      Resolving deltas: 100% (371/371), completed with 53 local object=
s.
>      From git://git.kernel.org/pub/scm/linux/kernel/git/ickle/drm-int=
el
>       * [new branch]      drm-intel-fixes ->  some-random-name/drm-in=
tel-fixes
>       * [new branch]      drm-intel-fixes-2 ->  some-random-name/drm-=
intel-fixes-2
>       * [new branch]      drm-intel-next ->  some-random-name/drm-int=
el-next
>       * [new branch]      drm-intel-staging ->  some-random-name/drm-=
intel-staging
>
> Which allows you to do:
>
>      $ git checkout --track some-random-name/drm-intel-fixes
>      Branch drm-intel-fixes set up to track remote branch
> drm-intel-fixes from some-random-name.
>      Switched to a new branch 'drm-intel-fixes'

You're right, the faulty option was --tags. Trying without this i was=20
able to fetch.
Thanks,

--=20
Matthieu
