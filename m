From: =?UTF-8?B?R29uemFsbyBHYXJyYW11w7Fv?= <ggarra@advancedsl.com.ar>
Subject: Re: Git and securing a repository
Date: Thu, 03 Jan 2008 02:36:25 -0300
Message-ID: <477C7459.3020402@advancedsl.com.ar>
References: <477B39B5.5010107@advancedsl.com.ar> <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com> <477B6199.6070601@advancedsl.com.ar> <ee77f5c20801020126n1776d625ya6928c2e4bfdf497@mail.gmail.com> <477B69ED.3090107@advancedsl.com.ar> <m3ir2co5s4.fsf@roke.D-201> <20080103035838.GA24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 05:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAHnE-0002cY-EX
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 05:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbYACEe3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 23:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYACEe3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 23:34:29 -0500
Received: from echunga.terra.com ([66.119.66.230]:38345 "EHLO
	echunga.terra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbYACEe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 23:34:28 -0500
Received: from elimba.terra.com (elimba.terra.com [66.119.66.67])
	by echunga.terra.com (Postfix) with ESMTP id 728929540A9;
	Wed,  2 Jan 2008 23:34:27 -0500 (EST)
X-Terra-Karma: 0%
X-Terra-Hash: 01ae2625f2c4fe24d19c607a26072222
Received-SPF: none (elimba.terra.com: 66.119.66.67 is neither permitted nor denied by domain of advancedsl.com.ar) client-ip=66.119.66.67; envelope-from=ggarra@advancedsl.com.ar; helo=[192.168.1.3];
Received: from [192.168.1.3] (unknown [201.255.33.238])
	(authenticated user ggarra@advancedsl.com.ar)
	by elimba.terra.com (Postfix) with ESMTP id 537181BC056;
	Wed,  2 Jan 2008 23:34:26 -0500 (EST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080103035838.GA24004@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69508>

Shawn O. Pearce wrote:
>=20
> If you read the documentation carefully you will note that the
> pre-receive hook receives input on stdin; 1 line of data per ref
> that is being pushed with the old/new SHA-1 values and the ref
> name.  The hook exits 0 to allow all changes to take place and
> can exit > 0 to abort and disallow all updates.
>=20

Sure, but I cannot pass any sort of authentication to the script other=20
than rely on environment variables or system calls, as git will not=20
provide anything else.

To do proper authentication on a file or directory basis, I have to mix=
=20
two things then:

A user/group base authentication/login based likely on unix permissions=
=20
and ssh AND a pre-receive hook script that finds the user/group name an=
d=20
then checks whether the user can change that particular file/directory.

I hope the ref name is the (relative) path name to the file and not jus=
t=20
the file's basename.

If so, I can see that most of what I want to do is possible.  It is jus=
t=20
pretty far from being elegant or easy to set up.

To distinguish a bad commit due to tabs for example from an actual=20
permission trouble.  I'm assuming that the stderr/stdout of git hooks i=
s=20
redirected back to the client?

Even with all of that, it seems it is still not possible to limit pulls=
=20
to a certain directory only, right?

Anyway, I think I more or less have the answer I (sadly) expected.=20
Git's authorization mechanism is pretty much a roll your own type thing=
=2E=20
  I'll check out the python authorization script that Linus mentioned t=
o=20
see if that alleviates setup troubles a bit.

--=20
Gonzalo Garramu=C3=B1o
ggarra@advancedsl.com.ar

AMD4400 - ASUS48N-E
GeForce7300GT
Xubuntu Gutsy
