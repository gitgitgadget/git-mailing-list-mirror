Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415341F404
	for <e@80x24.org>; Mon, 19 Feb 2018 21:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbeBSVpI (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 16:45:08 -0500
Received: from titan.plasma.xg8.de ([85.10.203.189]:37496 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753624AbeBSVpH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 16:45:07 -0500
X-Greylist: delayed 1334 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Feb 2018 16:45:07 EST
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w1JLMpbX029831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 22:22:51 +0100
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w1JLMpiO029830
        for git@vger.kernel.org; Mon, 19 Feb 2018 22:22:51 +0100
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w1JLMaEi010087
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 22:22:36 +0100
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w1JLMaSD010086
        for git@vger.kernel.org; Mon, 19 Feb 2018 22:22:36 +0100
Date:   Mon, 19 Feb 2018 22:22:36 +0100
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     git@vger.kernel.org
Subject: Git should preserve modification times at least on request
Message-ID: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

please ensure to CC me if you reply as I am not subscribed to the list.

https://git.wiki.kernel.org/index.php/Git_FAQ#Why_isn.27t_Git_preserving_modification_time_on_files.3F 
argues that git isn't preserving modification times because it needs to 
ensure that build tools work properly.

I agree that modification times should not be restored by default, 
because of the principle of least astonishment. But should it be 
impossible? The principle of least astonishment does not mandate this; 
it is not a paternalistic principle.

Thus, I do not get at all
- why git doesn't *store* modification times, perhaps by default, but 
at least on request
- why git doesn't restore modification times *on request*

It is pretty annoying that git cannot, even if I know what I am doing, 
and explicitly want it to, preserve the modification time.

One use case: I have lots of file lying around in my build directory 
and for some of them, the modification time in important information to 
me. Those files are not at all used with the build tool. In contrast to 
git pull, git pull --rebase needs those to be stashed. But after the 
pull and unstash, the mtime is gone. Boo.

Please provide options to store and restore modification times. It 
shouldn't be hard to do, given that other metadata such as the mode is 
already stored. It would make live so much easier. And the fact that 
this has made into the FAQ clearly suggests that there are many others 
who think so.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
