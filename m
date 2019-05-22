Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3281F462
	for <e@80x24.org>; Wed, 22 May 2019 23:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfEVX6s (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 19:58:48 -0400
Received: from fallback9.mail.ru ([94.100.178.49]:60646 "EHLO
        fallback9.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEVX6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 19:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=raebF6/YpITQRoMzNmv3mreCjtgdC4fBStg//k1SGxc=;
        b=aAAwfBh98xYCusnWuxDwiKUBorUNI2mNDj/W7ro9Per9UeIGnz/BRGQkD1TD2iG5e3jSlshXNmXuPUcyGNOLg4ICnHWEsoS9OTDZkjOwyB+vqcHp3ELG/MMBILi6E/B05u5Li1X98cHXcr3x0lGv7tsSmnZ0qMNoRI49Xc9FA30=;
Received: from [10.161.64.55] (port=44104 helo=smtp47.i.mail.ru)
        by fallback9.m.smailru.net with esmtp (envelope-from <odnoletkov@mail.ru>)
        id 1hTb89-0005aU-ST
        for git@vger.kernel.org; Thu, 23 May 2019 02:58:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=raebF6/YpITQRoMzNmv3mreCjtgdC4fBStg//k1SGxc=;
        b=aAAwfBh98xYCusnWuxDwiKUBorUNI2mNDj/W7ro9Per9UeIGnz/BRGQkD1TD2iG5e3jSlshXNmXuPUcyGNOLg4ICnHWEsoS9OTDZkjOwyB+vqcHp3ELG/MMBILi6E/B05u5Li1X98cHXcr3x0lGv7tsSmnZ0qMNoRI49Xc9FA30=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <odnoletkov@mail.ru>)
        id 1hTb85-0007Hr-Kp; Thu, 23 May 2019 02:58:42 +0300
From:   Maksim Odnoletkov <odnoletkov@mail.ru>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, keithbsmiley@gmail.com
Subject: Re: [PATCH] Make stashing nothing exit 1
Date:   Thu, 23 May 2019 00:57:05 +0100
Message-Id: <20190522235705.68452-1-odnoletkov@mail.ru>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqh8bsphny.fsf@gitster-ct.c.googlers.com>
References: <xmqqh8bsphny.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-77F55803: 257C4F86AB09C89C5A78504BD2AC2941988784FC6C4AE31F8E606C7758DCCF7938E6B00D07E04D52630DDD76ADCAC530A7352590443CE85F
X-7FA49CB5: 0D63561A33F958A5867BAE59E8FD22F37A100C7D71A41D4FE39289C7DD464A8E8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224997C12C9E82E3FF883AA81AA40904B5D9CF19DD082D7633A093541453170D46FCD81D268191BDAD3D78DA827A17800CE779F2895567E1D60FCD04E86FAF290E2DBBC930A3941E20C675ECD9A6C639B01B78DA827A17800CE7AE179F64D23C94B9453FEB95D8B9A11FEFF80C71ABB335746BA297DBC24807EA27F269C8F02392CDC1A41FEE7B8D90AE3C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-Mailru-Sender: 19DA870CD1633C32D2D4C917A6A43E7313A012CC7A43647738E6B00D07E04D527151379E4073B2536E44F38C8238B89B3DDE9B364B0DF28904E2E3863F77217AF25921C611F62F88AE208404248635DF
X-Mras: OK
X-77F55803: 669901E4625912A97F9F52485CB584D7271FD7DF62800FDCFB0700F4FF9FAE78F15C8F31F5CAA50004BB9AF0F71D4F6180459D154BEF1356
X-7FA49CB5: 0D63561A33F958A5AD8BCB3DDB3444FBB07102D7E818D3E6DF45F86FF8CC88A88941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0FF045C6A0F83C8214574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: A5480F10D64C9005EB82917A46D9527681BB53D0BC867BBCF15C8F31F5CAA50047912599D6065A6E6E44F38C8238B89B3DDE9B364B0DF28904E2E3863F77217AF25921C611F62F88AE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Keith Smiley <keithbsmiley@gmail.com> writes:
> 
> > In the case there are no files to stash, but the user asked to stash, we
> > should exit 1 since the stashing failed.
> > ---
> 
> Sorry, but I fail to see why this is a good change.  Did you have
> some script that wanted the exit code from "git stash" to indicate
> if it had anything to stash and change the behaviour based on it?
> 
> Is it a big enough hassle to figure out if the "stash" command did
> something yourself that justifies forcing existing scripts that rely
> on "no-op is merely a normal exit" behaviour other people have
> written in the past several years?

The problem with current behaviour is it makes it hard to use stash in
scripts. A natural stash use case is: wrap some operation requiring a
clean working tree with a stash push-pop pair. But that doesn't work
properly when working tree is already clean - push silently does nothing
and following pop becomes unbalanced. You have to keep that in mind and
work around with something like:

if ! git diff-index --exit-code --quiet HEAD
then
	git stash push
	trap 'git stash pop' EXIT
fi

With this change this can be simplified to:

git stash push && trap 'git stash pop' EXIT

I don't mind keeping this new behaviour behind an option for
compatibility. Or alternatively resolve this use case by supporting
--allow-empty in stash-push. But my feeling is it is natural for 'git
stash push' to report error for no-op case because the command is
explicitly about creating new stash entries. A close analogy is 'git
commit' which errors on no-op. Contrary all commands treating no-op as a
success I'm aware of are not about creating new objects but about
querying or syncing.
