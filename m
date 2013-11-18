From: ycollette.nospam@free.fr
Subject: Re: Problem while cloning a git repo
Date: Mon, 18 Nov 2013 08:31:39 +0100 (CET)
Message-ID: <24843648.320766230.1384759899814.JavaMail.root@zimbra35-e6.priv.proxad.net>
References: <528487E3.6020503@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 18 08:32:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViJJc-0001WG-N4
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 08:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882Ab3KRHbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Nov 2013 02:31:51 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:54479 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab3KRHbu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Nov 2013 02:31:50 -0500
Received: from zimbra35-e6.priv.proxad.net (unknown [172.20.243.185])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 410C3940078
	for <git@vger.kernel.org>; Mon, 18 Nov 2013 08:31:40 +0100 (CET)
In-Reply-To: <528487E3.6020503@free.fr>
X-Originating-IP: [93.31.210.54]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Win)/7.2.0-GA2598)
X-Authenticated-User: ycollette.nospam@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237977>

When I clone a git repo from github (via https), I've no problems.
It looks like that the problem is only related to my "special" repo wit=
h big zip commited inside.

YC

----- Mail original -----
De: "Yann COLLETTE" <ycollette.nospam@free.fr>
=C3=80: git@vger.kernel.org
Envoy=C3=A9: Jeudi 14 Novembre 2013 09:20:51
Objet: Re: Problem while cloning a git repo

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

Le 14/11/2013 00:40, brian m. carlson a =C3=A9crit :
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

