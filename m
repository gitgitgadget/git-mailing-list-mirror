Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E929AC52D11
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 17:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjAZRSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 12:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjAZRSg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 12:18:36 -0500
Received: from pannekake.samfundet.no (pannekake.samfundet.no [IPv6:2001:67c:29f4::50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3A71BCF
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 09:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=gunderson.no; s=legacy; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hTCe51rsQj6w7C3ocjmiT9Vr0c1MySR1vGBoGAlU1jk=; b=eYnL4zEljIuPGkLSVZYiXMfKvR
        6aaZ6ha8jrSM/SAD9OaysRHi5/22ndoUdSuWEtna8OGY04bUBzjbU0j/qjBPf9riegZqnap0Ftdv1
        Ay1zwr4HDkMUMJOHYeya6pYupyY8aWL+6buRE0CsesWHTI1ap1S9O/gn/Py7prED9jIYhvPhT5FHP
        loD1sr1KzKKl1kFrkHB/MHRblKjQ9ulOR1EKuhUfj1u+P24mw0j4ejo122D4kue8m5tZrs7CLMtWE
        6GAQP6uTc1OUOBg8EXYxBkNjre9yoyYRLymDtgwdDAbeQNotvcm0ssaFrSeiOHioxXD3VYhY02XRr
        MRCxErng==;
Received: from sesse by pannekake.samfundet.no with local (Exim 4.94.2)
        (envelope-from <steinar+bounces@gunderson.no>)
        id 1pL5tO-00HNnX-Ph; Thu, 26 Jan 2023 18:18:30 +0100
Date:   Thu, 26 Jan 2023 18:18:30 +0100
From:   "Steinar H. Gunderson" <steinar+git@gunderson.no>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: git log --follow wrongly includes delete commit
Message-ID: <20230126171830.6qb46wa2ed5h2z3b@sesse.net>
X-Operating-System: Linux 6.1.3 on a x86_64
References: <20230126130509.ovii7ji7hi5wm7qx@sesse.net>
 <fcc08ee2-dc58-09da-dc60-c438cfbf6602@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcc08ee2-dc58-09da-dc60-c438cfbf6602@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2023 at 11:38:42AM -0500, Derrick Stolee wrote:
> It's actually a third option: it was deleted but also renamed in an
> independent point in history, but the delete is more recent "in time"
> that it shows up first, and the merge that resolves the issue doesn't
> show up at all.

I see! So basically my parser needs to also start tracking merges,
except --follow seems to be sort of odd with those as well (though
I think maybe it's changed in some fairly recent git version).

> (Note: I didn't include --follow here as it filtered the --graph
> output in a strange way, including dropping the merge commitswhich was
> confusing to me.)

I think you need to give -c or --cc or something similar to see merges in
--follow, but the man pages are not entirely clear to me.

/* Steinar */
-- 
Homepage: https://www.sesse.net/
