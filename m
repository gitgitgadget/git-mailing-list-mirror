Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08711C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 13:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FC6610A0
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 13:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJ3NYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 09:24:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:34277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhJ3NX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 09:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635600076;
        bh=uvOYgmvzfGy6Vv6M8A9pd6Z4p/p/AmUtfXdGBvUvyw8=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=gdwl2PRZB0txR+fNsZxr1/I84OCOXI1f3LT4Yl9WZ/T2+J14/haRrrgHQnNtVSogJ
         lJA8uI2IzUkhdm1oACOaZusfjmO43uWZ7Dc5/48H75akJbml+ntaZEB1m/BwyzwT8o
         ig9x9hn2ZTyiDm08ocdShrcARooyJcXoD4pTXL2w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.9.46] ([62.202.180.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1mIIKb0mN7-00OWLc; Sat, 30
 Oct 2021 15:21:16 +0200
Subject: Re: Git not commiting anything if file created and "git add"ed in
 pre-commit hook is the only file in the staging area
From:   Peter Hunkeler <phunsoft@gmx.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailinglist <git@vger.kernel.org>
References: <0165d68f-79a7-d8b7-1bba-89a1449e87a7@gmx.net>
 <YXnNvyi62j5gcxQV@camp.crustytoothpaste.net>
 <dd79e443-3bb9-8b83-746b-7db7c4997ee3@gmx.net>
Message-ID: <c5507ba6-6e31-b143-9791-0bcff54acb64@gmx.net>
Date:   Sat, 30 Oct 2021 15:21:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <dd79e443-3bb9-8b83-746b-7db7c4997ee3@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: de-CH
X-Provags-ID: V03:K1:xypknqQAbNn9SZP97YVZn5DYf2U+7mdIBfAMxBIWN0UuBq6cV33
 16KUmPmclep+aOy0GyVIYnW5OoY7M7IWYKoW6zzcinNKESSsvUlZkGXPNhL/C2OAcYg/TqC
 5yl68IRWWpMWoqpaT0DyAiOfxLr2KWS/Xy026rUIKRcRylSnESpgb5Oge+/V+9LqUSGt7HS
 9g2JBYjl1e8ihSRMB7dow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1kM9rE2feAA=:ECbTFZsDZTM2kO3tSqbytG
 FYpy0DfirBzqRY2dbqFqXxK/xAwhrBy+Rv+9Hqj66OP8BfQyLeIb8Vkoe9D/Z7b7vTq1k7DiM
 V+Jsg02eTvm9W0DTtucsb/b/66BHP28CG+rbFKyt4Ip7GiJqTdG+Ep4N6A5laR/D56gtZNLmi
 24mSoKK9htLFzYyvwFnIFXnlFWpRXKR5TjXR9dYOKOk+pPcfY7iVhUY2BxJcapM1661mCZSmz
 gQjoI5JJ0wknEcFbsLB6OuDn+tQI/a7U84crBI8peHbupO486GPjMDWIHEWz+C2RqZcS6NyEC
 FGIK7uSI20qU+isxfZYqaz0kprPoPVix3bORrAsRz++IhnbxHdRUpeAXnfW4hE16naY45jeQf
 dK0Zgn2RIdtkzlZ2T252xVjXF6MSNlmi8vwFtJ4Nw/xR4DIe9JU2iAQb7MihbkJWdQrLSNswN
 oGDFpwqaZd6bg8fJ1zzhpyldTN97jIXuC2dm+RFJTVWLavxZjxuiARsb8Qi7ou4W44UTCmccb
 DW2CAS6CUV4gVYYRTjile72FEBfKjylcHyidijQ4apcZJz4aibooVmVAFWqcE1OwHw23DQGmb
 EimUWGS6LYXWibJuJhBaE9QvsuWEjwVxKbg/Ic9c3hjgBu9+KEiVWy9I75RbLy+7/CRFlnoez
 uC+VNgAEZyko6R74em0hiZfJvMT0ByzzasLUdpEzf9GiTc+4g4S48S6V96lol22n3soVgOTEi
 wmCtQ2VQEOgGz6k6z5N+ryH52vL4Bjy37cNYRW01VYwn19OAqo7V5L6XiwXcjl+87RPTkm88A
 RVA08Z9HLIRgvYy97i4kSBy7zyBfwzjTG/h8CJleq0hUprRAAGoS9Vh9GGoupPIE2xYkCb/yc
 oNRlLT3jnNKraVGJTrOAiC3wCJdQo8roPE201RgBaSNC3Ackfp/x0XCRzq7eT2q79oUs51udg
 p3vGZ1oz1kG/NVezLXHIKt6t0IWp4HcIMuPm4QwNVcXiR9wy+nItJDFmFy0KgbqRD7W3/m8co
 +3LLGONOvFx68aYaRPjkZkSlTgxYEPZ/oUGg0U6zJ/9vV9a42Xro7HL8k3ArBTxuR2GElDmSy
 6PeHnzqjJC7BU0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pardon my ignorance, but I'm unlear as to how to proceed further with my
issue.
What is the proper process to report a bug, and get a consense whether
it is accepted or rejected?

Regards
Peter

Am 28.10.2021 um 14:08 schrieb Peter Hunkeler:
> Am 28.10.2021 um 00:07 schrieb brian m. carlson:
>> I should point out here that it isn't intended for pre-commit hooks to
>> be used this way; they're intended to verify that the commit meets some
>> standards, not to modify it, although it is of course possible to do.
>>
> I can accept that comment. However:
>
> - wouldn't you agree that git should work consistently? It does not in
> this case. If there is anything to be commited in the index, then the
> "git add" from within the pre-commit hook *is* respected in this commit.
> If there is *nothing* to be commited, except from what was added by the
> pre-commit exit, then it is ignored *for this commit*, but it is added
> and will be commited next time. This is inconsistent behaviour.
>
> - if the decision will be *not* to allow adding from within a pre-commit
> hook, then the "git add" should be rejected. And the documentation
> should say so.
>
> I'll have to understand what all the comments from you and others mean
> (still a git newbee).
>
>> In general, you want to avoid adding automatically generated files to
>> your repository.=C2=A0 That tends to bloat the repository needlessly an=
d is a
>> great way to lead to frequent, hard-to-resolve merge conflicts.
>>
> I'm trying to use git to keep track of changes to my website, which uses
> some framework. The problem is: Some changes modify filesystem entities,
> only, while other changes modify the content of some mysql tables. So I
> need to pack an unload of those tables into the commit. I can do this
> manually (and forget every now and then :-), or I thought the pre-commit
> hook would be a good place to automate this. And, yes, it may well crete
> merge conflicts.
>
> I understand the pre-commit hook is a local thing, and I have to make
> sure the same is active in all repositories. Definitely not something to
> use in a widely shared project.
>
> Thanks a lot
> Peter

