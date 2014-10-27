From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: Anomaly with the new code - Re: git-svn performance
Date: Mon, 27 Oct 2014 23:26:28 +0000
Message-ID: <1414452388.89217.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Tue Oct 28 00:26:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XitgI-0002GK-D2
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 00:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbaJ0X0a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 19:26:30 -0400
Received: from nm28-vm5.bullet.mail.ir2.yahoo.com ([212.82.97.65]:47411 "EHLO
	nm28-vm5.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752521AbaJ0X0a convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 19:26:30 -0400
Received: from [212.82.98.58] by nm28.bullet.mail.ir2.yahoo.com with NNFMP; 27 Oct 2014 23:26:28 -0000
Received: from [212.82.98.96] by tm11.bullet.mail.ir2.yahoo.com with NNFMP; 27 Oct 2014 23:26:28 -0000
Received: from [127.0.0.1] by omp1033.mail.ir2.yahoo.com with NNFMP; 27 Oct 2014 23:26:28 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 535738.7342.bm@omp1033.mail.ir2.yahoo.com
Received: (qmail 57485 invoked by uid 60001); 27 Oct 2014 23:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414452388; bh=WgWVoMQxiALsnMX/QUXlu+sIxxWutZcp6i/w6AVUe2w=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=TY374UunUoizMoM5gGESb1Ite7J0pvLDpflnyY0r9spPSYZKOci46p2ZqU+iULcq1kYlWKrqe++3kgZy/9qGd/OqwaWwmsizaOf+KmxHGoolRoA8tYlPvaPvKLJda6uJExx09ox7bwma/5pi55AEM7Vc3hWr8kzbmvkoBTmFUzs=
X-YMail-OSG: sIqnKJkVM1lK5Ux6ThBaJSkf935bXPPdTgudmC9xhRrYisG
 Kdm.9_rGSKAPr3nbj9LCbDgqdO2MSy1NrFNDBbnYq9PbHmP3HkUCtnJJw_fM
 ff.RtyYu4IkIGh95tAGOTlD_U08qYkg8TMdFfZbikOM0z5vqfbOlz7JBzdN9
 auk0A2Ymf.QnyR1xLCVgrfhzyZd5L3DIWmTFviUY7un1nwRtzRNhTcY7l.Ox
 _LTHOGW.Rbx2e.v.eFhseLGYmzFIw3IP4V9fRB3aw_zXxHVXXBieqO4ZwGFb
 A0CoZEWUGBxaeb4PjEJesd9dSXmjO1qZnVwKf4V9i2slQaXSloaL4Zt5491A
 Tu_tnQNYxwoPqS4tMp0wrZYSJIqONTkoehmn3jcafuIEvTxSdHbY7DadgDPX
 KwjNE1xao7mNBwtvdX.Y66dhVww0WF6azmtEKDp2dpOUoCtXnBTm.uUmRS0d
 5K9TC1bxjGsupfQL2Br3j7jQcS26CEiZeqPu_UNL6NUYunTa4UmRxykBwFu5
 Ia7Hojo9m9InX.NNs9k3_C7HPNQC03EzK1cEeTfxOQyjxx8bs9VRJv1C1HQg
 M9adhwCQ.R7p.X3raZS9ekSBs1vPeaayQOa3wSl_mEirWTmHaKs9.uNwbeLi
 02uTIO9E-
Received: from [86.30.137.134] by web172306.mail.ir2.yahoo.com via HTTP; Mon, 27 Oct 2014 23:26:28 GMT
X-Rocket-MIMEInfo: 002.001,LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBNb24sIE9jdCAyNywgMjAxNCAxNjo1NiBHTVQgRXJpYyBXb25nIHdyb3RlOg0KDQo.RXJpYyBXb25nIDxub3JtYWxwZXJzb25AeWhidC5uZXQ.IHdyb3RlOg0KPj4gV2hpY2ggU1ZOIHZlcnNpb24gYXJlIHlvdSB1c2luZz_CoCBJJ20gY2xvbmluZyAoY3VycmVudGx5IG9uIHIzNzN4eCkNCj4.IGh0dHBzOi8vc3ZuLnItcHJvamVjdC5vcmcvUiB1c2luZyAtLXN0ZGxheW91dCBhbmQNCj4.IHVuYWJsZSB0byBzZWUgbWVtb3J5IGdyb3d0aCBvZiB0aGUBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------------------------------
On Mon, Oct 27, 2014 16:56 GMT Eric Wong wrote:

>Eric Wong <normalperson@yhbt.net> wrote:
>> Which SVN version are you using?=A0 I'm cloning (currently on r373xx=
)
>> https://svn.r-project.org/R using --stdlayout and
>> unable to see memory growth of the git-svn Perl process beyond 40M
>> (on a 32-bit system).
>
>git-svn hit 45M and took 11:44 to finish.=A0=A0=A0My ping times to
>svn.r-project.org is around 150ms (I'm running this from a server in
>Fremont, California).=A0 I'll keep the repo around and periodically fe=
tch
>to see how it runs.

I'll apply the 10 patches against 2.1.0 and see then. As I wrote
in my last reply, my 3rd clone took about 8 hours to finish,
and the max resident size is about 700MB (according to GNU "time").

AFAIK the hosting server is in northern Europe (Copahagen?), I think,
so it is supposed to be faster for me fetching from UK.
