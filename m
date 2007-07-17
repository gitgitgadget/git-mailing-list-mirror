From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 19:11:12 +0200
Message-ID: <469CF830.8040601@dawes.za.net>
References: <469CE836.6010508@arcom.com> <469CF2E6.1020104@lsrfire.ath.cx> <469CF52D.10407@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Amit Walambe <awalambe@arcom.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAqcs-0000EC-0o
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 19:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbXGQRNt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Jul 2007 13:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765944AbXGQRNs
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 13:13:48 -0400
Received: from sumo.dreamhost.com ([66.33.216.29]:48636 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765934AbXGQRNr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 13:13:47 -0400
Received: from spunkymail-a19.g.dreamhost.com (sd-green-bigip-207.dreamhost.com [208.97.132.207])
	by sumo.dreamhost.com (Postfix) with ESMTP id 34E39185E13
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 10:13:46 -0700 (PDT)
Received: from [192.168.201.100] (dsl-146-26-37.telkomadsl.co.za [165.146.26.37])
	by spunkymail-a19.g.dreamhost.com (Postfix) with ESMTP id CC52711B6D;
	Tue, 17 Jul 2007 10:11:43 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <469CF52D.10407@arcom.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52779>

Amit Walambe wrote:
> Thanks a ton everyone for all the replies.
> Here is the current status :
>=20
> Ren=E9 Scharfe wrote:
>> Amit Walambe schrieb:
>>> Hi!
>>> I was trying to do a git bisect on 2.6.22-git6 and 2.6.22-git8. For
>>> which I get following error :
>>> root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
>>> Bad rev input: v2.6.22-git6
>>
>> The -git snapshots are made automatically by kernel.org, and their n=
ame
>> is not included in the git repository.  You could create tags for th=
em
>> like this:
>>
>>  git tag v2.6.22-git6 8f41958bdd577731f7411c9605cfaa9db6766809
>>  git tag v2.6.22-git8 a5fcaa210626a79465321e344c91a6a7dc3881fa
>>
>> ... and afterwards you can use those revision names with bisect (or
>> other git commands).  I've got the commit IDs (i.e. those mysterious=
 40
>> hex digits above) from the first line of the changelogs; their URLs =
are:
>>
>>  http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.22-git6=
=2Elog
>>  http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.22-git8=
=2Elog
> I found the commit ids in following file as well :
> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.22-gi=
t6.id
> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.22-gi=
t8.id
>=20
> But telling good/bad points to git bisect still fails, whether I pass=
=20
> the commit-id or the tags I created with commands given by Ren=E9 :
>=20
> root@amit:/usr/src/linux-git # git bisect good=20
> 8f41958bdd577731f7411c9605cfaa9db6766809
> cat: .git/BISECT_NAMES: No such file or directory
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git # git tag v2.6.22-git6=20
> 8f41958bdd577731f7411c9605cfaa9db6766809
> root@amit:/usr/src/linux-git # git tag v2.6.22-git8=20
> a5fcaa210626a79465321e344c91a6a7dc3881fa
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
> cat: .git/BISECT_NAMES: No such file or directory
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git # git bisect bad v2.6.22-git8
> cat: .git/BISECT_NAMES: No such file or directory
>=20
> Thanks and Regards,

You need to start off by saying

$ git bisect start

to set up the necessary infrastructure.

Rogan
