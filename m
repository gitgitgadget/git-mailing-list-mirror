From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Folder level Acces in git
Date: Thu, 03 Nov 2011 19:13:17 +0100
Message-ID: <4EB2D9BD.6020801@web.de>
References: <1320300655224-6958047.post@n2.nabble.com> <20111103071701.GA22412@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Magnus_B=E4ck?= <magnus.back@sonyericsson.com>,
	git@vger.kernel.org
To: redhat1981 <redhat1981@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 19:13:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM1n7-0002yO-8S
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 19:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247Ab1KCSNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 14:13:24 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:48220 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932703Ab1KCSNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 14:13:23 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 22D871A975D37
	for <git@vger.kernel.org>; Thu,  3 Nov 2011 19:13:22 +0100 (CET)
Received: from [192.168.178.43] ([79.247.240.8]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MdLcJ-1RdHes2kAl-00IUgX; Thu, 03 Nov 2011 19:13:21
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111103071701.GA22412@jpl.local>
X-Provags-ID: V02:K0:WxOvtbWRGu4FQJFZL3bWfnNudFU95SHptF64zSxKVR8
 cVTjhafyPx/muPkS3vkhcjH3e+Fff/EcsHMUJKDwtFW3yN34pm
 dfyjS+sJoOeq9Y03zWbr+kX+EzmMaeDoRc5FfXeLEKCFbN7GBw
 jdtNjRYit3w+cCeZZMfHrk4KXudhKHXDWYpPdCxNyoeYLl3QOa
 gAFkjxxShX4DAIaH8daCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184731>

Am 03.11.2011 08:17, schrieb Magnus B=E4ck:
> On Thursday, November 03, 2011 at 07:10 CET,
>      redhat1981 <redhat1981@gmail.com> wrote:
>> Inside the repository, testabc let us say there are folders folder1,
>> folder 2 etc, I want some users to have read/write, read or no acces=
s
>> to the folder1 or folder2, Is this possible in Git, I have done it i=
n
>> SVN, Please help!!
>=20
> Given Git's nature, you can't have read access restrictions on a sub-=
git
> level (i.e. file/directory level). For basically the same reason, you
> can never prevent users from making (local) commits that modify certa=
in
> paths (but you can encourage people to have local hooks to enforce su=
ch
> policies). What you *can* do is install a server-side update hook tha=
t
> rejects attempts to push commits that modify certain paths. If you're
> willing to trade Gitosis for Gitolite, you get that feature for free.

Directory read access control can be achieved by putting the directory
content into a submodule. You can then control who is allowed to clone
from the repo for that submodule separately from the superproject,
thereby disallowing a group of people to see (let alone modify) what is
in there.

http://progit.org/book/ch6-6.html
