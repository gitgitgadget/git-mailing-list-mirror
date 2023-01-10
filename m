Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3646FC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 21:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjAJVJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjAJVJl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 16:09:41 -0500
Received: from denver.dinauz.org (denver.dinauz.org [37.59.56.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D245F4BB
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 13:09:36 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by denver.dinauz.org (Postfix) with ESMTP id 3CF5A60581;
        Tue, 10 Jan 2023 22:09:33 +0100 (CET)
Received: from denver.dinauz.org ([127.0.0.1])
        by localhost (denver.dinauz.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f9DsjTkocjah; Tue, 10 Jan 2023 22:09:33 +0100 (CET)
Received: from [192.168.1.6] (176-143-2-105.abo.bbox.fr [176.143.2.105])
        by denver.dinauz.org (Postfix) with ESMTPSA id 0E8FC6047E;
        Tue, 10 Jan 2023 22:09:33 +0100 (CET)
Message-ID: <4c2d2581-5f69-6e42-73e8-9c64d9bad4bc@trigofacile.com>
Date:   Tue, 10 Jan 2023 22:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Ignored commits appearing in git blame
To:     Michael Platings <michael@platin.gs>
Cc:     Barret Rhoden <brho@google.com>, git@vger.kernel.org
References: <b1051e73-e663-82bf-bda6-015e64102248@trigofacile.com>
 <xmqq5ydgwcj9.fsf@gitster.g>
 <CAJDYR9RnWuO66i9aLdACox+GRSpidyWyZkS_2hHWH=1v2cfbtA@mail.gmail.com>
From:   =?UTF-8?Q?Julien_=c3=89LIE?= <julien@trigofacile.com>
In-Reply-To: <CAJDYR9RnWuO66i9aLdACox+GRSpidyWyZkS_2hHWH=1v2cfbtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

Thanks for having taken time to respond!

> You're right, ideally 36944f2b16 should have disappeared from the
> output at line 5. The way the ignoring algorithm works is that it
> tries to find a line in the previous commit with similar content.
> Since there's so little content to compare I guess the algorithm plays
> it safe and gives up.

OK, I understand.


> On the one hand this is annoying because an
> empty line or single curly brace should be trivial for the algorithm
> to deal with. On the other hand "which change caused this empty line
> to be here?" is not a very interesting question so hopefully won't be
> too much of a problem for you in practice.

I agree.


> There are a couple of
> annoyances with the feature I'd like to fix (the main being that
> there's no way to enable it globally) and I'll add this to the list.
> However I'm unlikely to get to it soon. I won't complain if you beat
> me to fixing it :)

Thanks for having considered the bug report.
In case it helps, I've noticed that if I add the "-w" flag (to ignore 
whitespace in comparisons), the git blame output no longer shows that 
revision which was asked to be ignored.

   git blame -w --ignore-revs-file .git-blame-ignore-revs radius.c

I don't know whether it is a coincidence (especially when 
.git-blame-ignore-revs contains in fact commits of code reformatting and 
whitespace cleaning) or it would also help for other kind of commits to 
ignore.

-- 
Julien ÉLIE

« Le bonheur, c'est de continuer à désirer ce que l'on possède. »
   (Saint-Augustin)
