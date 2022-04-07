Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29800C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 08:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbiDGJBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 05:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243491AbiDGJBK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 05:01:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9158B939D0
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 01:59:08 -0700 (PDT)
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.90,241,1643670000"; 
   d="scan'208";a="10835888"
Received: from nautfst12.univ-lyon1.fr (HELO [134.214.142.79]) ([134.214.142.79])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 10:59:08 +0200
Message-ID: <6a5152c1-7bb4-220c-cdce-33e93ea9c7c6@univ-lyon1.fr>
Date:   Thu, 7 Apr 2022 10:59:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V1 1/1] contrib/vscode/: debugging with VS Code and gdb
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     "derrickstolee@github.com" <derrickstolee@github.com>,
        "git.jonathan.bressat@gmail.com" <git.jonathan.bressat@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <6f4b924d-0a13-b267-6766-a3620936b686@univ-lyon1.fr>
 <20220405224502.38544-1-cogoni.guillaume@gmail.com>
 <20220405224502.38544-2-cogoni.guillaume@gmail.com>
 <66f08cb2e81647e29a080af05d7c867e@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <66f08cb2e81647e29a080af05d7c867e@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/22 10:47, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Apr 06 2022, COGONI Guillaume wrote:
> 
> I really don't mind having some guide for VSCode in our developer
> documentation, but I think if we (as a free software project) are
> recommending proprietary software we should put that in some context
> where we explain if/why it's needed, and if free alternatives are also
> suitable.

Note that VS Code is mostly open source (the pre-compiled binaries are 
proprietary, but the source code is MIT licenced, 
https://github.com/Microsoft/vscode). Not to be confused with Visual 
Studio, which is fully proprietary, but is a totally different tool 
(AFAIK, they only share the name).

> I haven't used the VSCode integration you're documenting, but from the
> diff and the "gdb" mention I gather that this isn't using some "native"
> debugger of MSVC/VS's, but just using the VSCode editor as a wrapper for
> gdb?

Yes (gdb or lldb under the hood). As usual, it adds a GUI layer, but 
also a configuration layer where you specify how to launch the debugger 
in a launch.json file, and this is where the little script in contrib/ 
is handy to generate a launch.json adapted for Git.

> If that's the case wouldn't it suffice to link to some generic getting
> started guide for debuggers? And e.g. recommend the GDB manual, maybe
> there's a better online reference (I read it locally), but e.g.:
> https://www.sourceware.org/gdb/current/onlinedocs/gdb.html

To me the point of the doc within Git's repo is to document git-specific 
aspects, and I agree that pointing to a generic doc is better than 
re-writing one. If I had written the patch I'd have made the general 
paragraph on debugger benefits a bit shorter, but it's already rather 
short so I'm OK with the patch in its current state.

> Then if we're recommending GUI wrappers those are a dime a dozen,
> e.g. Emacs's GUD mode:
> https://www.gnu.org/software/emacs/manual/html_node/emacs/Debuggers.html

To me this is out of the scope of the patch (the real point to me was to 
increase the discoverability of contrib/vscode), but sure, documenting 
other GUI wrappers would be nice.

-- 
Matthieu Moy
https://matthieu-moy.fr/
