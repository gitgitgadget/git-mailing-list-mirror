Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0AA51F453
	for <e@80x24.org>; Thu, 25 Oct 2018 14:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJYX2I (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 19:28:08 -0400
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:62895 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeJYX2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 19:28:08 -0400
X-Greylist: delayed 967 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2018 19:28:07 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1540478336; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=fRafUg27BpWMcVVYWDMTJ3KWWI+pp+JmzQyrkscpg0UzxD6NvnUdPR1NsRyJBW2nzboRPaxl2jjcd
         pVEX/jNGiXpXdA3KgFJ92Nxtai5WVg2oCmt1OyBY+OJRvP3sLyJB4v6hw6oAf1D528eQ/8vEnDX7pi
         1p5y7CjVH/gerTwGyr9YglvhV/YsJmMa8pWIcnOoBQbBkiq82OSDEfA2zXK4rlWVT9OV8Iozh+ATXW
         mUdcJxEzw4PilX2zXa6N2keH7fcBgO0FCEgnq1hSs48zJ2AhGdVArzlUACPoRNTGp/R/s4gc4N0sbX
         XjUJ4ftTTTPB3Ek7AsLdocYU14GM4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:dkim-signature:from;
        bh=Q0Dbq5A5WfPVxVuhxIK+Rz+n9PwWZ2KP8wBxxL7Grgk=;
        b=SV9kohTlaDaR+ZR/3nRKC+XURfFz4fzyajsufhZg5qkmDI9Z1V5Y2Cc0QJfGO3LRVW8pSJU8EyEzZ
         Zaxc7AkfPTJk094owhD731d7RWoM/LiSyMa2cwlohqIk2n6EjwJURP5tZlO0ZSwMH/cJSfxvw/32rE
         uZ/0q8cn8IHRuyXkJO2Y07dBSSRu+yZIEVhBcGU8Gzbz0+Mg13LSvf4aQDKK99HNLsRkofgN5x4w6G
         vqa/mBjnu1M/UJxMzc4v2pXlSgKT3U53zwPhxYEqvONfeGEhrZ+coKISQpEayqUk6Shlnj25V69W+l
         /MGxOg2Kf17MFTOGdqZUeV/gFMr3l9Q==
ARC-Authentication-Results: i=1; outbound1.eu.mailhop.org;
        spf=softfail smtp.mailfrom=lakedaemon.net smtp.remote-ip=108.39.81.162;
        dmarc=none header.from=lakedaemon.net;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=Q0Dbq5A5WfPVxVuhxIK+Rz+n9PwWZ2KP8wBxxL7Grgk=;
        b=olMRqg1MlhJVC2QE6snnxZpmNKpBwIgK+jPW6UfL14wr3iBePkIfpX9BYslF7PObBrui22MJ2U49+
         sqObheqyALi3aqSEsDpL60p8UBxr7W4g7Ml90l+Vja0NRz/627RyhmHTi3S//gKUIgBPcLyadmClD5
         Wx0LYElE6jvLdaKvPVTJd8dd8hk2OCdSNa79WDurpuIqyPeVDFlDTE0ZikcXLYTDKUhduYuCZhobsk
         Me4AhYiH01kSOQdDz6u0xkDSz0x00/rgh3pfHWrLI3p5InY8t4u35W9kP6CAvj6lioJN2Zcpqpzkse
         yEOIq6olpXV/oHqnm+dPaa7b/AYTVNw==
X-MHO-RoutePath: amFjMjk5NzkyNDU4
X-MHO-User: ae623db7-d863-11e8-9048-075f73944867
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 108.39.81.162
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [108.39.81.162])
        by outbound1.eu.mailhop.org (Halon) with ESMTPSA
        id ae623db7-d863-11e8-9048-075f73944867;
        Thu, 25 Oct 2018 14:38:51 +0000 (UTC)
Received: from cerberus.lakedaemon.net (cerberus.lakedaemon.net [10.16.5.107])
        by io (Postfix) with ESMTP id C6CA3800B3;
        Thu, 25 Oct 2018 14:38:46 +0000 (UTC)
Subject: Re: the opposite of .gitignore, whitelist
To:     Junio C Hamano <gitster@pobox.com>,
        "lhf635@163.com" <lhf635@163.com>
Cc:     git <git@vger.kernel.org>
References: <201810251039388653199@163.com>
 <xmqqh8hak2mh.fsf@gitster-ct.c.googlers.com>
From:   Jason Cooper <jason@lakedaemon.net>
Openpgp: preference=signencrypt
Autocrypt: addr=jason@lakedaemon.net; prefer-encrypt=mutual; keydata=
 xsBNBFhlctIBCACjfeHra5mqnKUI6ik5jKjek8whdcSwnBjfpuPytzw6C+6fNBGrqkUfOOie
 eaDF5W+iRVSogx0WXiit5sE26AODmdvixSlgCE1328WN0syqP7onVIQcX+63S5JJxEHwbWXh
 3ui8BVwTXQRhFVxruRyTlDoNVc3S8ELx3dS+Ci/WAr2XW0ZrPtCXS7xIirsCeUa79iXr1qlk
 yBQAVIvKL/N7cmRkNp7CTM4wOGNT2MvDwiJWDkeGM9ayHbfyEhnjxS9I1oYz7qLAJZURw0N3
 YeWEjxL1dRBxg/RInB1tQHPjGd3J1fRL73yGzn3qp8/qB8fLXkasceazrMBHIZ8cWIv/ABEB
 AAHNKUphc29uIENvb3BlciA8SmFzb24uQ29vcGVyQGRhcmttYXR0ZXIuYWU+wsDuBBABAgCY
 BQJYdTguIBQAAAAAABYAAWtleS11c2FnZS1tYXNrQHBncC5jb22MLxSAAAAAACAABnByZWZl
 cnJlZC1lbWFpbC1lbmNvZGluZ0BwZ3AuY29tcGdwZW1sCAsJAwIBCggHAhkBBReAAAAAGRhs
 ZGFwOi8va2V5c2VydmVyLnBncC5jb20FGwMAAAADFgIBBR4BAAAABBUICQoACgkQiNcnbaLA
 kz6whQf9FMzuoaL5a1cWs1uSqzHV5EPSsdn6Y9uMrvQ5dQjvqzQz7Rfl5PQkQgEepDXE836V
 AU/N0t3aIGef5UiQZKrdAK1gJRtqBumjkz/t/V6PZ6SgN8wkIdz5yX3Wa2sJ0qRWNqdV2bzC
 tghczqDhYfGCzDvko1W9ji57wGitc0wK7QnSfCflQwO/E3bU0qJL+tJmhTg796A872NTKHWq
 NHkRFjhP7qn3gyKW77JFP7NThgb4NHyLIsqIvH+58sSoMlVm71WRf043V0dG+PTvOQLUU3uE
 OnM0haH8oowdBGJh0TWnG+xUXtuBfnF9Jvl77h149WIeFibOfjub9/laoSf2xs7ATQRYZXLS
 AQgAxC9eRG0T7zw/Xo6vC/7DzCyO7nexLQtoK3I0rXs+7LlWWs0FoaHf7ERHLWW0fy7jmN9d
 Wumx56snt8r9F1JUy0dba9IngNYiJElIfoq6Zdg5xgbUE8gP3RKP2bUu7seaoBhKPtny4hY0
 XuiXiKHoeMzGiTBuyigFFF/QS3cmXGp8iHFaHBwn0xMLz2gi+pyYkqjdVR/76qV9fGtlKiab
 S/QdLJ3qTmScY1Kkxzvs6ljyEiZDQKscXiCAbsfpWjvYwt3JC01b1TcAYbNn6Nm+dbgPEr+Z
 mPsVGSWN+Pi60cagsaYRYRUjPOdOPOMyCqmxcVtqMjaT/waGp9Gau3wrxwARAQABwsGBBBgB
 AgErBQJYZXLTBRsMAAAAwF0gBBkBCAAGBQJYZXLSAAoJELmWTEcn+90JTRkIALehTijuSTqA
 tqRC9E2lNFp85MnsmD1HwRvBuBdpfUB5VakeW5j61xa11XGYYNgp+DRm36HQMJKwDLXd/EGI
 yR5gx+PSy2UWl0iRZMJBHbOFAdsOcvymSsCS3LpnpPwHvfHZydU5VQdUNbb7V/QSdv05klds
 N9RNb1rVxL69UL8khq4e2N0CUf8mDTY+UqrG7x46/Hko5jhfX0Gtnl9SKy2gQqxSkEkexdUS
 mhb7b8uS4kPJBCVaPAUtOt161H8OO0vFl47u7R3VOfGm28lKlRcVheHyZprSlBt5YBl4wYEK
 Cm8k1C+DvgaQHy0wLu+CVKe3l3qk88m7ZerOOCmVuPMACgkQiNcnbaLAkz64xgf8C8zUJCae
 u1vHf8jq2OHWlBMTskArXP9mnS8ZWR9qGaySBGa2DzoYrSN6HfAyIBlCopUaWJ3KGEicUOtR
 PkmWvoCH0toetJyCNjxXo3yZeSqyL5AUwf24dSa74y8WW6CAfL6i+sd8aTOvhRDQWuJ964n0
 p9Drz/gjOYVH+pq8Xalr8QiWH/3c1iiBAbe4C0TLUZeEk3zGpkC334npe8QPqdSV7Vds1IHl
 EjwoLE3JzSRCqlWhsHJYWltiDw2hE1cPWgi3MYUTE6FkDFTByPwL0RPl9XMrrQfWANkBgLpa
 oC5ZoU8+Nm7SmrJSBeB9ZSuY6vfUPUGV9K8dqTrnbSYz+w==
Message-ID: <c166b421-a228-8349-0815-2ebb9dcab998@lakedaemon.net>
Date:   Thu, 25 Oct 2018 10:38:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqh8hak2mh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,


On 10/25/18 1:37 AM, Junio C Hamano wrote:
> "lhf635@163.com" <lhf635@163.com> writes:
>
>> I have a good idea, add a file to git that is the opposite of .gitigno=
re...,
> Do negative patterns in .gitignore file help without inventing
> anything new?
I did this several years ago in an attempt to track /etc/ (minus
ownership, of course) without storing secrets in the git history.=C2=A0 A=
s
the system grew and was maintained (read: crap added), the negative
patterns grew untenable.=C2=A0 I quickly realized it wasn't the correct w=
ay
to solve the problem.

Unfortunately, shortly after realizing this, I left that project.=C2=A0 S=
o I
never had the chance to develop a proper solution.=C2=A0 However, the con=
cept
of a '.gitonly' file was exactly was I was seeking.=C2=A0 So, for what it=
's
worth, I've definitely had at least one legit usecase for this feature.

The usecases tend to center around tracking select files within the
rootfs of a full-blown operating system.=C2=A0 Or a subset thereof.

hth,

Jason.

