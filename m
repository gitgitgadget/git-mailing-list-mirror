From: Yann COLLETTE <ycollette.nospam@free.fr>
Subject: Re: Problem while cloning a git repo
Date: Wed, 13 Nov 2013 08:58:33 +0100
Message-ID: <52833129.6060707@free.fr>
References: <597769726.308442105.1384260624974.JavaMail.root@zimbra35-e6.priv.proxad.net> <20131113002035.GK183446@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Nov 13 08:58:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgVLd-0000An-94
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 08:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758722Ab3KMH6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Nov 2013 02:58:45 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:32898 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758394Ab3KMH6o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 02:58:44 -0500
X-Greylist: delayed 68891 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2013 02:58:43 EST
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2f10:c960:21e:e5ff:fe1f:2dcf])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 14243D48171
	for <git@vger.kernel.org>; Wed, 13 Nov 2013 08:58:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131113002035.GK183446@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237781>

Hello,

When I perform the git clone via git, it works. The problem is only=20
happening via http.
I tried to play with http.postBuffer and I set this parameter to it's=20
maximum (a little bit before a git clone triggered a memory alloc=20
problem) and I see that something big is trying to be downloaded. But I=
=20
don't see such a big file in my history of commits. The maximum one=20
seems to be around 50 Mo ...

Le 13/11/2013 01:20, brian m. carlson a =E9crit :
> On Tue, Nov 12, 2013 at 01:50:24PM +0100, ycollette.nospam@free.fr wr=
ote:
>> Hello,
>>
>> When I clone a repository, I get an error from git:
>>
>> git clone http://192.168.0.18:8080/test test_Gerrit
>> Clonage dans 'test_Gerrit'...
>> remote: Counting objects: 25106, done
>> remote: Finding sources: 100% (25106/25106)
>> error: RPC failed; result=3D56, HTTP code =3D 200iB | 8.12 MiB/s
> curl code 56 is a receive error (CURLE_RECV_ERROR).  It sounds like
> you're encountering some sort of network error or broken proxy.  Does
> cloning this repository over the git protocol or SSH work, or can you
> try it over https (to avoid the proxy)?
>
