From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Potential bug in git client
Date: Wed, 11 Jun 2014 12:55:23 +0200
Message-ID: <5398359B.6060907@gmail.com>
References: <CAKY5LXywixV3dWcCcVPTvyFrScJjLd8eoVs=RA1VRcrzUgtThQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?V29qY2llY2ggUHJ6eWJ5xYI=?= <przybylwojciech@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 12:55:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WugBk-0007lv-Tu
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 12:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbaFKKzZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2014 06:55:25 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:56813 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbaFKKzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 06:55:24 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so3541096wes.41
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=xm9N8L/GBvpAVshCpqVQxi+3J+QsU17U3LKenmTUJhg=;
        b=wj5dQNSPt2Zq/iVDdxHUzU5WXgGcfy3Ir6YayxyGKuV4237DQEgjQbwQTIkbgMBV8k
         qbtj2W7RWLlpHQsaVpy2bkj+qMgc3ZDRd8hYFXBmYyn8Iw+ZVhSm54yX+x7e7OctBctk
         nV1VV5fTs/mqxQLB18MtigdIwgshp5WAZfZOEAJ83v06pTrwN85Vw9qCHjYu0GEXDgT1
         Y1hGJ7V6ykg0AvPEGS/MK4C+ImY7v/y3nBcJIGPR83N7rRXi6UFRmIHEpGx0xDnxlBYQ
         1XFCyLxeW0Ac/jSWNV13vwDxzqoCoQ2+97YM6bFCOoC6ACP05QfpY4Qp0z4KNFGAgPye
         L/4w==
X-Received: by 10.180.12.33 with SMTP id v1mr32111092wib.0.1402484123256;
        Wed, 11 Jun 2014 03:55:23 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id wk8sm33678648wjb.22.2014.06.11.03.55.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 03:55:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CAKY5LXywixV3dWcCcVPTvyFrScJjLd8eoVs=RA1VRcrzUgtThQ@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251360>

On 11.06.2014 12:21, Wojciech Przyby=C5=82 wrote:
> Hi All
>=20
> When I was tagging, I think I might have discovered a git client bug.
>=20
> HOW TO REPRODUCE:
> - Clone a repo into 2 separate directories. Presume there is a tag
> "v0.1" already in there and it is set on say 10 commits ago.
>=20
> - In first directory change the tag to a different place and push it
> to the server:
> git tag -d v0.1
> git tag v0.1
> git push --tags origin master
>=20
> - In second directory try to update the tag...
> git pull --all --tags
> git fetch -all --tags
> THIS DOES NOT WORK, tag is still at old place, but it says "Already u=
p-to-date".
>=20
> - I noticed when I use:
> git fetch --tags
> it works fine and updates the position of the tag, or if I remove tag
> from local git manually (rm .git/refs/tags/v0.1) and update again.
>=20
> Is it a bug or I am doing something wrong? I use git version 1.7.9.5.
>=20
> Cheers
> Wojciech

Tags are intended to not change without the user knowing.
To gain more understanding on that, maybe read the man page of
git tag (see the discussion on retagging)
https://github.com/gitster/git/blob/master/Documentation/git-tag.txt#L1=
66
