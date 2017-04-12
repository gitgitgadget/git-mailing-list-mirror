Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C3B1FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 22:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbdDLWFN (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 18:05:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:49220 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbdDLWFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 18:05:11 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkgEO-1cNz6X10VA-00aTZk; Thu, 13
 Apr 2017 00:05:09 +0200
Date:   Thu, 13 Apr 2017 00:05:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stephen Hicks <stephenhicks@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Rebase sequencer changes prevent exec commands from modifying
 the todo file?
In-Reply-To: <CAKNkOnOkSgFei7jpck8Z7tH+jYn_MXvarA86GAadT8jJt4aO-g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704122355440.2135@virtualbox>
References: <CAKNkOnM366uiJKkz31hS8V3NTa8qksP2pXrH4+F-zodZaNdsqg@mail.gmail.com> <alpine.DEB.2.20.1703021617510.3767@virtualbox> <CAKNkOnOkSgFei7jpck8Z7tH+jYn_MXvarA86GAadT8jJt4aO-g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oFeZM97PW2LadqgLK++QO/yrrXm+t+EYEeE+1Q6XWdGbnytR+fd
 sJlX6/kDwRlfWb7OnOXJ/Uo+eiiXcrMC5/70EIj1MOcdJVAk/EHi6YHub7qoCs4X7gqtuaO
 Qcufky/3QkY0Emk66RlUgNveBwPOnsQpBys55T/0RsxN93+BLYsKLveNISei8mf0Y6pA6hj
 wY4tclnPKF8HdI0rMQwWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O8++8PF70JU=:IxnW6WQg8zW5HYA2UZJ1Dz
 zo5kAukdEmIx1jpCfsExRUQ00qamwDUJOHSceD/oSJxmFhwr6uputi1byQOsyXxMNvOxeeh1m
 R3dND8p7rlO0TlepQhG2kT9kEQYVJR2NhFGOUJsJPhw6LEAlvwY8IWL/6rDwPRHAM7DaaGeAj
 SaOcvmPibL7xtrh9G3X8ZObiJ9mbPgFuucu48ppTgZONW44oiTenoTzDyuy1MVHJKzx28mJ4z
 mhIJXluC8MJQhWD3vzgC0r7ZUYCPQKgtc/h4NvlJjJq04g8ffaHv0QdNL1gu5fTQxmwa6d90U
 U3vibc2wV/mUlnJICKU7u4YTMRQgRbrGZCSUC6FM4mPpenExiiG299f3Ytvagjy9naPA7NBWi
 dRtV7GgmOcwqs3Be9usvpHxyGEi7grB4/CAZeeQhZVw6s1MkptX0+Ex6WlmjHnWG0dRetJgd4
 ezjs0GluXPZ4dpV1OVHj0THvrJz1BixqbymiemqBckkZP+VlYByKwuVzU8XJ8KVuz4hrMgkLH
 k46DRSWQhuerr1S+sr6YtKTZTsn6TPe2IauMWVehLhZDs5jWwsGbHSFs/AClmbQ9kXUZPqfKc
 Lm+OZ0UdcoDYmOcnFasFo8R4c8TrgaMtexvX7N0m0Ef2eJGK3enGERWwSmoa6Aznc/JZa3RYe
 Si+s/ueUak3FL0d4OUJRvSqSKPQmYNS/4Fl6a3SMJy/pwy+XDw7pJbD09n9ubALTW5lCdtC6u
 x80SaUW9SOzB21VlTB3nrh/ZtrDk/Xfl8xVABwonhdwimOp3FH6S5KDiN8/aT38ro5OZ1miYN
 EKLYqgo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephen,

On Tue, 11 Apr 2017, Stephen Hicks wrote:

> Thanks for the tips.  I think I have an approach that works, by simply
> returning sequencer_continue() immediately after a successful exec.

I am not sure that that works really as expected, as you re-enter the
sequencer_continue() and neither the original author nor I expected nested
calls.

> I'm hesitant to only use mtime, size, and inode, since it's quite likely
> that these are all identical even if the file has changed.

Not at all. The mtime and the size will most likely be different.

I am reluctant to take your wholesale approach, as I perform literally
dozens of rebases with >100 commits, including plenty of exec calls, and I
want the rebase to become faster instead of slower.

> Say, the command is simply a `sed -i 's/^exec /#### /g'`, then the
> timestamp (in seconds) will almost definitely be the same, and the size
> and inode will be the same as well.

Try it. The inode is different.

> Granted this is a contrived example, but it would be unfortunate if
> accidentally keeping the size the same were to cause the change to not
> be picked up.
> 
> Another option would be to hash the contents, but at that point, I'm not
> sure it's any better than simply unconditionally re-parsing the TODO.

Again, my intent is to make rebase faster, not slower. Hashing the
contents would make it slower. So would re-reading it.

> https://github.com/git/git/pull/343

Thank you for starting to work on this. I left a couple of comments.
Please do not be offended by their terseness, I really wanted to point out
a couple of things I think we can improve together, but I am also way past
my bedtime.

Ciao,
Johannes
