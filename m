From: Ephrim Khong <dr.khong@gmail.com>
Subject: Re: [PATCH 0/3] nd/multiple-work-trees updates
Date: Wed, 18 Mar 2015 09:04:45 +0100
Message-ID: <5509319D.9070109@gmail.com>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 09:04:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY8yF-0005A3-MV
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 09:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbbCRIEu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2015 04:04:50 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33743 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbbCRIEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 04:04:48 -0400
Received: by wgbcc7 with SMTP id cc7so28087053wgb.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=MdMJbwa57m9OZgwF32fF3QtkVt+Kpje8XvSoxosHEvY=;
        b=BHrLBkg8FWNapOR7X/ZhAFgzbjaO4dw6REABsQjJKtqB/WdTTSYgEKsCjkhkZLdAuT
         xwMUKS8Vsjjqz49W8pAE2WaTf9t5aDeX7ywNzgXXo4j0U3rCIvHGBm7t6hLOhhJ9eTRd
         tCYkPFpkSgDpxDRgrvI+P+rpLHgqVIPnmaR4Dd+ubiRM66zNaJI4bpG0at9v/QmBOqFU
         iP1STT2DjIHhg253z4dRCCS1xWj0g+U52xXtuWzQxFk5W4INgAJu+qU3PDgA70Bu0MMy
         AniOutfgas+g3XjWFYFk17Bwis2TW63jv/F5+JRnL/stqPL+DP9ECPIDHhXEfHquRcTb
         j/ew==
X-Received: by 10.194.122.232 with SMTP id lv8mr134226842wjb.146.1426665887064;
        Wed, 18 Mar 2015 01:04:47 -0700 (PDT)
Received: from [10.0.100.231] (merlin.mvtec.com. [62.96.232.130])
        by mx.google.com with ESMTPSA id vq9sm23318295wjc.6.2015.03.18.01.04.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 01:04:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265691>

Without having looked into this and nd/multiple-work-trees, but with=20
"make multiple checkouts aware of each other" in mind: Could this=20
mechanism be re-used to make alternates aware of each other, to mitigat=
e=20
the dangers of having  git gc  on an alternate remove objects that are=20
used by a referencing repository?

Thanks
- Eph

On 03.01.2015 10:41, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> These patches are on top of what's in 'pu'. They add
> --ignore-other-worktrees and make a note about current submodule
> support status. I don't think submodule support is ready yet even
> with Max Kirillov's series [1]. His 03/03 is already fixed in 'pu'
> though, so only 01/03 and 02/03 are new.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/261107
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
>    checkout: pass whole struct to parse_branchname_arg instead of ind=
ividual flags
>    checkout: add --ignore-other-wortrees
>    git-checkout.txt: a note about multiple checkout support for submo=
dules
>
>   Documentation/git-checkout.txt |  9 +++++++++
>   builtin/checkout.c             | 19 +++++++++++--------
>   t/t2025-checkout-to.sh         |  7 +++++++
>   3 files changed, 27 insertions(+), 8 deletions(-)
>
