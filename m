Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3678920705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933047AbcIEVIz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:08:55 -0400
Received: from [195.159.176.226] ([195.159.176.226]:60299 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S933004AbcIEVIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:08:54 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1bh18D-0004Ij-F3
        for git@vger.kernel.org; Mon, 05 Sep 2016 23:08:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Christian Neukirchen <chneukirchen@gmail.com>
Subject: git commit -p with file arguments
Date:   Mon, 05 Sep 2016 23:08:31 +0200
Message-ID: <87zinmhx68.fsf@juno.home.vuxu.org>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed the following suprising behavior:

% git --version
git version 2.10.0

% git add bar
% git status -s 
A  bar
 M foo

% git commit -p foo
[stage a hunk]
...
# Explicit paths specified without -i or -o; assuming --only paths...
# On branch master
# Changes to be committed:
#       new file:   bar
#       modified:   foo
#

So why does it want to commit bar too, when I explicitly wanted to
commit foo only?

This is not how "git commit files..." works, and the man page says

            3.by listing files as arguments to the commit command, in which
           case the commit will ignore changes staged in the index, and
           instead record the current content of the listed files (which must
           already be known to Git);

I'd expect "git commit -p files..." to work like
"git add -p files... && git commit files...".

Thanks,
-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org

