From: Yann COLLETTE <ycollette.nospam@free.fr>
Subject: Re: Problem while cloning a git repo
Date: Thu, 14 Nov 2013 09:20:51 +0100
Message-ID: <528487E3.6020503@free.fr>
References: <597769726.308442105.1384260624974.JavaMail.root@zimbra35-e6.priv.proxad.net> <20131113002035.GK183446@vauxhall.crustytoothpaste.net> <52832DA0.7040108@free.fr> <20131113234057.GA314350@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 09:21:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgsAj-00021w-E3
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 09:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab3KNIVB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Nov 2013 03:21:01 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:48982 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721Ab3KNIU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 03:20:59 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2f10:c960:21e:e5ff:fe1f:2dcf])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7E2A2940228
	for <git@vger.kernel.org>; Thu, 14 Nov 2013 09:20:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131113234057.GA314350@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237819>

I am not able to clone via https because gerrit doesn't propose this wa=
y=20
of cloning.
When I clone via http, I see that git is starting the download of objec=
ts:
remote: Counting objects: 256, done
remote: Finding sources: 100% (256/256)
Receiving objects: 46% ... (this part always fails at 46 %).
So, I think that the proxy part is not a problem (there is no proxy set=
=20
here).
If I set GIT_CURL_VERBOSE=3D1 before cloning, I've got the following er=
ror:
* Problem (2) in the Chunked-Encoded data
* Closing connection 1

YC

Le 14/11/2013 00:40, brian m. carlson a =E9crit :
> On Wed, Nov 13, 2013 at 08:43:28AM +0100, Yann COLLETTE wrote:
>> Hello,
>>
>> When I perform the git clone via git, it works. The problem is only
>> happening via http.
>> I tried to play with http.postBuffer and I set this parameter to
>> it's maximum (a little bit before a git clone triggered a memory
>> alloc problem) and I see that something big is trying to be
>> downloaded. But I don't see such a big file in my history of
>> commits. The maximum one seems to be around 50 Mo ...
> Please keep the list in CC.
>
> http.postBuffer doesn't affect clones, only pushes, so that isn't
> relevant here.  You're experiencing something that is dropping the
> connection over HTTP.  So you either have a bad proxy, or something e=
lse
> is causing the connection to be dropped.  Since it's only over HTTP, =
I
> suspect it's the former.
>
> Do you have HTTPS, and if so, does it work if you try to clone over
> that?
>
