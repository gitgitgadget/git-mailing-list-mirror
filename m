Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3541F453
	for <e@80x24.org>; Sat,  9 Feb 2019 16:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfBIQr4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 11:47:56 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46679 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbfBIQr4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Feb 2019 11:47:56 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 90454210A8;
        Sat,  9 Feb 2019 11:47:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 09 Feb 2019 11:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keith.so; h=
        content-type:mime-version:subject:from:in-reply-to:date:cc
        :content-transfer-encoding:message-id:references:to; s=mesmtp;
         bh=4bkBXDPgSPgLdPjDuSmk+X8o/HV8o/WAKC7KiH+Xg64=; b=qtx4Z5GpVLrd
        WESUnrknVKaQGoTUP/SqW5OCJN64QhK9W1jRDg7DpWu52omM9ZJUim1+mp34WYDe
        tAJCRTDufjwauxQAxQSzsaAC7Jlr/TJZyEAyMS5IIjWd0CZQzSDSF7thENdr7DqE
        pKOh1iFXZHdV9wsJNZY8I8d198tWBps=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=4bkBXDPgSPgLdPjDuSmk+X8o/HV8o/WAKC7KiH+Xg
        64=; b=7wdtKHBSM9NQajwAnBOXBWKeP4AlfxvSvqtwePVWu2JiW+gMML8ffXhpl
        IGOz6B07OBvHM4CjHnrecj6zNbZkAQXJ2FszAAkSRkQkBTpkzybv+LztW+Zw5yE9
        hJXF0bD47BaykSVcIqpUn1Z6epj2NshKQJa+jkoySof4HjbCSQuvmaLBV/HXEbHG
        x84ai/1zawA4mOGPVX3Aa4wF3Mo1lbLYNBCR3znjlPS1ez48pu+ZkggSrDnK9jDk
        FgX6zUxF1HPACe0TP7KqFV+ku836nSJ2PDsLFrmBjGhz7dLMctkJWOT+EIr1/JFz
        L++ZEeGbySacv7RQgfROdhWmUYpvQ==
X-ME-Sender: <xms:NwRfXDyM28R0UasgafXKYASybqX_6qKr-l27HFOpjwGOLPUYXC0rMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrleeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucenucfjughrpegtggfuhffojgffgffkfhfvsehtqhhmtdhhtddvnecuhfhrohhmpe
    fmvghithhhucfumhhilhgvhicuoehksehkvghithhhrdhsoheqnecuffhomhgrihhnpehp
    uhgslhhitgdqihhnsghogidrohhrghenucfkphepudefiedrvdegrddvfedrgeelnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehksehkvghithhhrdhsohenucevlhhushhtvghrufhi
    iigvpedt
X-ME-Proxy: <xmx:NwRfXDgRQ551EMTX-KEdBSNchfzFP3V5ID9LHgwbCGrJm-um1M3AYg>
    <xmx:NwRfXBQqR8kBiB-T9QBYt2MK2hIpBHSZ3vvyLzZ9Y9T4qSIZv9MqOQ>
    <xmx:NwRfXE2HVGw85Jt94WqXoeSuAcFTgUqhTgUkFVURxUYDBPcDw2Q6dA>
    <xmx:OARfXD-OmHweKTzB0q-FFcsVHjxl_JhFVbjYu2g3A0ecI1iTlVF2xQ>
Received: from [172.16.140.246] (unknown [136.24.23.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6FAB310288;
        Sat,  9 Feb 2019 11:47:51 -0500 (EST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Add support for 'git remote rm' in Bash completion script
From:   Keith Smiley <k@keith.so>
X-Mailer: iPhone Mail (16D39)
In-Reply-To: <20190209062706.GF30548@zaya.teonanacatl.net>
Date:   Sat, 9 Feb 2019 08:47:46 -0800
Cc:     Sergey Zolotarev <szolot4rev@gmail.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <831E8C20-CCB9-4E99-9FFD-DA7CCF825C3D@keith.so>
References: <20190209052434.20616-1-szolot4rev@gmail.com> <20190209062706.GF30548@zaya.teonanacatl.net>
To:     Todd Zullinger <tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It would be great if we could land this. Non of the other solutions since I p=
roposed my patch have happened, so in the meantime this would be nice to hav=
e.


--
Keith Smiley

> On Feb 8, 2019, at 22:27, Todd Zullinger <tmz@pobox.com> wrote:
>=20
> Hi Sergey,
>=20
> There was a previous discussion of this in December 2017,
> which might be useful:
>=20
> https://public-inbox.org/git/01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a10=
6f37f1d9-000000@eu-west-1.amazonses.com/
>=20
> It didn't end with a patch applied, but it's likely worth
> reading to help you make a case for a similar patch.
>=20
> One of the points in that thread is that the rm subcommand
> is not shown in completion intentionally, as the preferred
> subcommand is remove.  But it should be possible to offer
> completion of the remotes after a user types rm, which I
> imagine is the more helpful part of the completion.
>=20
> Also, you'll want to add a signoff to the patch if/when you
> resend it (refer to Documentation/SubmittingPatches, if you
> haven't already).
>=20
> Sergey Zolotarev wrote:
>> ---
>> contrib/completion/git-completion.bash | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
>> index 499e56f83d..fa25d689e2 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2334,7 +2334,7 @@ _git_remote ()
>> {
>>    local subcommands=3D"
>>        add rename remove set-head set-branches
>> -        get-url set-url show prune update
>> +        get-url set-url show prune rm update
>>        "
>>    local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
>=20
> So instead of this change you could adjust the subcommand
> line, something like:
>=20
> -    local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
> +    # Don't advertise rm by including it in subcommands, but complete
> +    # remotes if it is used.
> +    local subcommand=3D"$(__git_find_on_cmdline "$subcommands rm")"
>=20
> I haven't test that, but the code looks like it hasn't
> changed since the last time we talked about this -- when I
> did test the suggestion :).
>=20
>>    if [ -z "$subcommand" ]; then
>> @@ -2379,6 +2379,9 @@ _git_remote ()
>>    prune,--*)
>>        __gitcomp_builtin remote_prune
>>        ;;
>> +    rm,--*)
>> +        __gitcomp_builtin remote_rm
>> +        ;;
>>    *)
>>        __gitcomp_nl "$(__git_remotes)"
>>        ;;
>=20
> I don't think you need this chunk, do you?  I think that's
> only useful for completing options to the subcommand, which
> 'git remote rm' lacks.
>=20
> I believe you can simply skip it and let the case fall
> through to the last item which simply completes the
> available remotes, just as 'git remote remove' does.
>=20
> Hope that helps,
>=20
> --=20
> Todd

