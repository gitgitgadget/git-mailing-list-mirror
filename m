From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: checkout on an empty directory fails
Date: Thu, 05 Jan 2012 20:33:25 +0100
Message-ID: <4F05FB05.3090706@dirk.my1.cc>
References: <4F0576D9.4030207@gmx.de> <CACsJy8A42n4t+WqGaTx7vDQ3jP_YkD1bB0WL9amrrg1B4eOx7w@mail.gmail.com> <4F0599E0.7090902@gmx.de> <4F05ACD6.6040603@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmVuw6kgRG/Dnw==?= <doss@gmx.de>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 05 20:33:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rit4B-0001UD-Ob
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 20:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479Ab2AETda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 14:33:30 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:59128 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324Ab2AETda (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 14:33:30 -0500
Received: from [84.176.33.34] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Rit43-0006fF-1S; Thu, 05 Jan 2012 20:33:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4F05ACD6.6040603@ira.uka.de>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187991>

Am 05.01.2012 14:59 schrieb Holger Hellmuth:
> On 05.01.2012 13:38, Ren=C3=A9 Do=C3=9F wrote:
>> git status says not special informations.
>=20
>  versus
>=20
>> red@linux-nrd1:~/iso/a> git status
>> # On branch master
>> # Changed but not updated:
>> # (use "git add/rm <file>..." to update what will be committed)
>> # (use "git checkout -- <file>..." to discard changes in working
>> directory)
>> #
>> # deleted: SP601_RevC_annotated_master_ucf_8-28-09.ucf
>> # deleted: rtl/ether_speed.vhd
>> # deleted: rtl/ether_top.vhd
>> # deleted: rtl/ether_tx.vhd
>> # deleted: rtl/takt.vhd
>> # deleted: sim/makefile
>> # deleted: sim/tb_ether_top.vhd
>> #
>=20
> This *is* special information: It tells you that master has those 7
> files but your working directory has none of them (i.e. it is as if y=
ou
> had deleted them from your working directory).
>=20
> "git checkout <branch>" switches between branches, *but* leaves chang=
es
> you made (files you edited, added or deleted) intact! This is so you =
can
> switch branches before commiting if you suddenly realize you are in t=
he
> wrong branch.
>=20
> "git checkout -- <paths...>" or in your case "git checkout -- ." is
> different, it really overwrites the files in your working dir with th=
e
> versions stored somewhere else, by default from the index.
>=20
>> What means the point in checkout?
>=20
> "." is simply your current directory

Another way of reviving the deleted files and restore the master branch=
 is

$ git checkout -f master # or git checkout --force master

This will unconditionally checkout master and overwrite the local
changes, including the deletions Holger mentioned.

=46or me, "checkout --force" is more intuitive than "reset --hard" or
"checkout .".

    Dirk
