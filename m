From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: git merge after git cherry-pick?
Date: Wed, 23 Jul 2008 19:14:49 +0200
Message-ID: <48876709.3090504@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:16:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhwf-00087O-Qm
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 19:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbYGWRO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 13:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYGWRO4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:14:56 -0400
Received: from morch.com ([193.58.255.207]:38687 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbYGWROy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 13:14:54 -0400
Received: from [192.168.1.214] (ANice-157-1-140-70.w90-52.abo.wanadoo.fr [90.52.83.70])
	by morch.com (Postfix) with ESMTP id 0B82D2841
	for <git@vger.kernel.org>; Wed, 23 Jul 2008 19:16:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89717>

Hi,

Still being a newbie...

On a branch, b, made off of master, I've made the commits b1, b2, b3 an=
d=20
b4.

Back on master, I need commit b1 and b3 immediately. So I:

$ git checkout master
$ git cherry-pick "b1's SHA"
$ git cherry-pick "b3's SHA"

Now, both b and master contain b1 and b3. How do I now create a log of=20
"what remains to be merged from b to master", i.e. only b2 and b4? And=20
how do I merge b2 and b4 to master, so master's log shows b1, b3, b2 an=
d=20
b4 and doesn't show b1 and b3 twice, which is what I get if I:

$ git merge b

after the cherry-picks above. Also I noticed, that if I merge master=20
into b (to keep up-to-date with master) b1 and b3 are also mentioned tw=
ice.

I did notice that cherry-pick created new SHA1 IDs for the commits for=20
b1 and b3 on master (as indeed man cherry-pick also says). Maybe=20
cherry-pick is not the right tool for the job. Is there another way to=20
"copy"/"merge" only b1 and b3 (but not b2 and b4) from b into master=20
maintaining merge history and avoiding them being mentioned twice later=
?

At the time of writing b1-b4, I did not know that b1 and b3 would be=20
needed separately, so I didn't put (b1 and b3) and (b2 and b4) on=20
separate branches. I did notice though, that they weren't an intricate=20
part of "the new feature". Is it required that I then do the work in=20
separate branches?

I hope this is possible as I'm thrilled with git!

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
