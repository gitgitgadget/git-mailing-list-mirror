Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F06C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 05:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJKF6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 01:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKF6I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 01:58:08 -0400
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 22:58:05 PDT
Received: from mariecurie.slightlybroken.com (mariecurie.slightlybroken.com [116.203.185.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAB080BC1
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 22:58:05 -0700 (PDT)
Received: from labrat.space (adsl-178-38-36-59.adslplus.ch [178.38.36.59])
        by mariecurie.slightlybroken.com (Postfix) with ESMTPSA id 68D18413C4B9;
        Tue, 11 Oct 2022 07:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=labrat.space;
        s=201904; t=1665467493;
        bh=P5bAAUJN/FoxDwfxo0rbrAhCl+K94V5aLR5mLWBYedQ=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:To:CC:Date:
         Subject:Content-Type:Content-Disposition:Reply-To:In-Reply-To:
         MIME-Version:Message-ID:References;
        b=h6BqWY3EXN9xC3uHBhAoIAL3RNu2i+SNYuSo9euqEPlmB283qM9IdBY4ejOG8y4lh
         Tv62fkWg/55I589+dYiAYcf5pE6bKZTuckNr0sXTjazx5OgSeoT6tr6DBfoaOOqA+l
         XJxZa6baHw/Oi3KL5HR3hT85xNrJz8NaZud87muf8wNs67bjXyRVjVI2JNswI/Jzd0
         cVErx6WmiqKabKltffz+QDSpyim7dKl5aePj4NIB/QHmOLscTPxIJh/m02xmEYb32F
         5yVXPFrhSLGdPE6WEa257lq3vtFD+w24oywOxx/HGmWif7sreHmFLg+Wa6ij/RFO+o
         F+OmPwlNeBDRg==
Date:   Tue, 11 Oct 2022 07:51:30 +0200
From:   Reto <reto@labrat.space>
To:     Elsie Hupp <git@elsiehupp.com>
Cc:     git@vger.kernel.org
Subject: Re: Multiple --global config workspaces?
Message-ID: <20221011055130.gvoh44rbulg3f4jn@feather>
Mail-Followup-To: Elsie Hupp <git@elsiehupp.com>, git@vger.kernel.org
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 11:06:32PM -0400, Elsie Hupp wrote:
> What might possibly help in this situation could be if I could have the global ~/.gitconfig somehow delegate to separate .gitconfig files in each of the workspace folders I have set up, e.g.:

> ~/Repositories/github/.gitconfig
> ~/Repositories/gitlab/.gitconfig

That already exists, git-config(1), look for "Conditional includes"
That way you can do it per top level folder or whatever makes sense for
you.

Examples:

; include for all repositories inside /path/to/group
[includeIf "gitdir:/path/to/group/"]
	   path = /path/to/foo.inc

; include for all repositories inside $HOME/to/group
[includeIf "gitdir:~/to/group/"]
	   path = /path/to/foo.inc
