Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953F6C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F1D6113D
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhKJU2b convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 10 Nov 2021 15:28:31 -0500
Received: from elephants.elehost.com ([216.66.27.132]:46630 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhKJU2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 15:28:25 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AAKPXwe015441
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Nov 2021 15:25:33 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Glen Choo'" <chooglen@google.com>, <git@vger.kernel.org>
References: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com> <kl6lh7cjvpm3.fsf@chooglen-macbookpro.roam.corp.google.com> <000101d7d661$cbfa4fb0$63eeef10$@nexbridge.com> <kl6lee7nvm6t.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lee7nvm6t.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: RE: [RFC] Branches with --recurse-submodules
Date:   Wed, 10 Nov 2021 15:25:27 -0500
Organization: Nexbridge Inc.
Message-ID: <000a01d7d671$1c7d4820$5577d860$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDlN6LuBtE+8KJlFzsXRydDgnoDhAJi8ei9ARt/QEgCTGGYma20G4Ag
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 10, 2021 2:35 PM, Glen Choo wrote:
> 
> Overall, I think your workflow is not too dissimilar to the UX we are proposing
> :)
> 
> <rsbecker@nexbridge.com> writes:
> 
> > 4. If working on the submodule, use a branch, not a commit - typically off
> main.
> 
> With the proposed UX, step (4) would happen automatically when using
> "branch --recurse-submodules". Users would get a safer and more
> convenient default.

I think this might be more reliably done using a switch in .gitconfig to enable the capabilities. Perhaps something like:

submodule.fetch-branches=true

> > What I could see as a possible improvement is to add the branch ref to the
> submodule ref file - not replacing the commit but adding to it. I do worry that
> there are unintended (unforeseen) side-effects that will result from this,
> however, including potential merge conflicts. Two people working on the
> same commit but different branches may mess the ref file, so not really a
> good idea.
> 
> It's an interesting idea, but as you noted, it is quite thorny. I would also like to
> see more information being captured by the superproject tree (instead of
> just .gitmodules), but I'm also not sure how we might do that.

I'm suggesting this instead of a command-line option because this seems more like a policy-based process that you would either always want or never want. I would not like to depend on a developer making the call each time a clone occurred. I'm sad to admit that I don't really know where to start on this enhancement, though, even if approved.
-Randall

