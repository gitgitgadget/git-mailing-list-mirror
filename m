From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to prefix existing svn remotes?
Date: Fri, 23 Jan 2009 14:02:31 +0100
Message-ID: <4979BFE7.8090402@drmicha.warpmail.net>
References: <20090122173211.GB21798@locahost> <4979A64E.6030608@drmicha.warpmail.net> <20090123124231.GA17616@locahost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U8OpYmFzdGllbiBNYXp5?= <melyadon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:04:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQLhY-0003iJ-M3
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 14:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbZAWNCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 08:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbZAWNCg
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 08:02:36 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40734 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755185AbZAWNCf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jan 2009 08:02:35 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.fastmail.fm (Postfix) with ESMTP id D15F02559A5;
	Fri, 23 Jan 2009 08:02:34 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 23 Jan 2009 08:02:34 -0500
X-Sasl-enc: tnmeiClSYa2l9B48sQoxcq7WTgO2iCkTBEbEb/j+qQuL 1232715754
Received: from [139.174.44.165] (wagner.math.tu-clausthal.de [139.174.44.165])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 007802E4D8;
	Fri, 23 Jan 2009 08:02:33 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <20090123124231.GA17616@locahost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106879>

S=C3=A9bastien Mazy venit, vidit, dixit 23.01.2009 13:42:
> Hi Michael,
>=20
> Thanks for your reply.
>=20
> On Fri, Jan 23, 2009 at 12:13:18PM +0100, Michael J Gruber wrote:
>> The following works for me:
>>
>> 0) fetch to make sure you're current (optional)
>> 1) edit .git/config and add the prefix (right hand side of the
>> refpsecs), or really rename in any way you want
>=20
> OK.
>=20
>> 2) rename the existing remote branches in the same way
>=20
> I'm not sure how I can do it. 'trunk' is the only remote-tracking svn
> branches under .git/refs/. Here is how it looks:
>=20
> ls -R .git/refs
>  .git/refs:  heads  remotes  tags
>  .git/refs/heads:  master
>  .git/refs/remotes:  trunk
>=20
> Still, a 'branch0' remote exist:
>=20
> git show-ref
>  refs/heads/master
>  refs/remotes/branch0
>  refs/remotes/trunk

You can do (bash)

for b in trunk branch0
do
  git update-ref refs/remotes/yournewprefix/$b refs/remotes/$b
  git update-ref -d refs/remotes/$b
done

OTOH, any incarnation of "git -m" (with or without "-r", specifying
refs/remotes/trunk, remotes/trunk or trunk) failed.

Michael
