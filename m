From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: Feature request: fetch --prune by default
Date: Fri, 20 Jul 2012 09:28:08 +0200
Message-ID: <068F71AC-DACD-4545-AB21-F911A934DA3E@gmail.com>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com> <20120719115558.GC29774@sigill.intra.peff.net> <88300470-AB41-4317-8B97-81DC18FD5899@gmail.com> <20120719213438.1cc7ca77a9cb3367a3be0539@domain007.com> <E94B0D74-2BB8-4B3E-BFB9-A2CFE9C2A7BB@gmail.com> <500904B0.9030309@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 09:28:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ss7dK-0001uU-DJ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 09:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353Ab2GTH2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jul 2012 03:28:13 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38263 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab2GTH2M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2012 03:28:12 -0400
Received: by weyx8 with SMTP id x8so2355912wey.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=6+XKFPt/w96HXgyU3/7xspvogBHK26dyD8vaBrbVY0M=;
        b=JEX4Cd6tJSu9QFZ75G3wppnoPtBBgyjo/s3i6QmgN/Z5Nem8zt9BTyKDfEOQv+6CZE
         O5ImGE3gg/tk9PQxqG7koxAK4CtZ0emcuNWMuqVzVOx1MRjWe+xg8LUj39xXZZHRQRD1
         MZEqbDIX2QgoZu63xH/dZuSsjkp7Aqx3DzfuYGNMABbej8sW/YcAIcvFcIdp2z+MvSL1
         YAb+ZZLCSQJQmD8LuSq7A3TzYzzKfGpsOk39G0VjTLTQJ3COIbhHN/KegprP0naD05iv
         sCMbxkI8NK+fa0E8uljUpqNRbIFxEBGpujMWr97Nyo7bjOyi5UVQI+zSvz7PJe8pHvVe
         hnVw==
Received: by 10.180.14.193 with SMTP id r1mr11518939wic.19.1342769291011;
        Fri, 20 Jul 2012 00:28:11 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id ef5sm12855882wib.3.2012.07.20.00.28.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Jul 2012 00:28:10 -0700 (PDT)
In-Reply-To: <500904B0.9030309@viscovery.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201761>


On 20 Jul 2012, at 09:11, Johannes Sixt wrote:

> Am 7/19/2012 23:20, schrieb Alexey Muranov:
>> On 19 Jul 2012, at 19:34, Konstantin Khomoutov wrote:
>>=20
>>> On Thu, 19 Jul 2012 18:21:21 +0200 Alexey Muranov
>>> <alexey.muranov@gmail.com> wrote:
>>>=20
>>> [...]
>>>> I do not still understand very well some aspects of Git, like the=20
>>>> exact purpose of "remote tracking branches" (are they for pull or
>>>> for push?), so i may be wrong.
>>> This is wery well explained in the Pro Git book, for instance. And =
in
>>> numerous blog posts etc.
>>=20
>> I have read the Pro Gut book and numerous blog posts, but i keep
>> forgetting the explanation because it does not make much sense to me=
:
>>=20
>> "Tracking branches are local branches that have a direct relationshi=
p
>> to a remote branch.  If you=92re on a tracking branch and type git p=
ush,
>> Git automatically knows which server and branch to push to.  Also,
>> running git pull while on one of these branches fetches all the remo=
te
>> references and then automatically merges in the corresponding remote
>> branch." etc.
>=20
> Note the difference between "tracking branch" and "remote tracking
> branch"! The "remote tracking branches" are the refs in the refs/remo=
tes/
> hierarchy. The "tracking branches" are your own local branches that y=
ou
> have created with 'git branch topic thatremote/topic' (or perhaps 'gi=
t
> checkout -b'). The paragraph talks about the latter.

Hannes, thanks for the explanation, so i was confused once again.

Various blog posts do not make the terminology clear, for example
http://gitready.com/beginner/2009/03/09/remote-tracking-branches.html
sais that there are only "two types of branches: local, and remote-trac=
king", while i think it depends on perspective.
There are in fact
1. remote,
2. remote-tracking (which are local!),
3. truly local:
  a) which are tracking some remote-tracking(!) branches,
  b) and which are not tracking.

I think i was also misguided by Konstantin, who wrote that "you create =
a remote tracking branch when you intend to actually *develop* somethin=
g on that branch" :).

-Alexey.