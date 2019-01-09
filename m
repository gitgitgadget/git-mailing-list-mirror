Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A8451F803
	for <e@80x24.org>; Wed,  9 Jan 2019 16:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfAIQUu (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 11:20:50 -0500
Received: from smtp38.i.mail.ru ([94.100.177.98]:34082 "EHLO smtp38.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730871AbfAIQUu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 11:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=OKhC5eyqsUU3dGTfpza37pc4E+Wc4gQ4DnladqpMdGo=;
        b=uvkFBjJk/vdKE6Nn06cOjtjnmesJe7Cg93XeMxyOo5ep1P4yydyv4NA12tUcskUiwZ4ugAKHXd2Snw5pxMDhMiusNsqBSvsqclOSAtKUt3/3Ui0fMMXDZ0abKWyntrhxl1aN25O1g/x6iUR+3RGIUaoHugQgFg/Tcl30Vm4b0bE=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1ghGb0-0000J9-U8; Wed, 09 Jan 2019 19:20:47 +0300
Date:   Wed, 9 Jan 2019 19:20:45 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     git-users@googlegroups.com
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [git-users] git checkout file with custom mtime
Message-ID: <20190109162045.4mit42qvnz6fpb3j@tigra>
References: <951cafaa-877b-4815-862f-5ffc43e6976a@googlegroups.com>
 <1413fbaa-8a83-0f43-afcb-5cb67683b505@iee.org>
 <CAPktr3k6GmYkTE9=0jcs8+4BEeeAnvQa6daxnwcqTwrL91Y-ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPktr3k6GmYkTE9=0jcs8+4BEeeAnvQa6daxnwcqTwrL91Y-ug@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Authentication-Results: smtp38.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-77F55803: BBE463BEF7A60BD05A78504BD2AC29419E620A54DAF35E3B6CCD58C4AE6F5B22264EE55812B6AA07BE5CE3E4D9543A5A
X-7FA49CB5: 0D63561A33F958A5EAFC083BCB7B527EC2326A0F9C8F9F3ABD87E39700BE26DA8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22498BFD6B1B042489AC3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE77E1C1A36D5859E4ACD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7969708C34243A2ECFCA3D8DFFF213B3B75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA4806103E8E3017268FCC966E39C96FDFC59B8C681F8837A39FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 05, 2019 at 10:44:47PM +0100, Daniel Fanjul wrote:
> I'm on Ubuntu. I do not use LFS. I track mods and saved games of
> Skyrim with git, TESV.exe sorts the saved games only by their mtime. I
> know it is not the most usual use case for git.
> 
> I agree with that viewpoint and I like the way git works right now, I
> do not want to change that. Checking out the saved games and then
> fixing the mtime works but forces a lot of unneeded I/O.

You might find this overview of git-annex vs git lfs useful:
https://lwn.net/Articles/774125/

Also see this recent thread on the Git list:
https://public-inbox.org/git/79fd2b4e-243c-a9f5-3485-2954fb0f50ef@aixigo.de/

