Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E67320756
	for <e@80x24.org>; Thu, 19 Jan 2017 06:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbdASGdX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 01:33:23 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:32950 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbdASGdW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 01:33:22 -0500
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id v0J6XDcA008143;
        Thu, 19 Jan 2017 09:33:15 +0300
Date:   Thu, 19 Jan 2017 09:33:13 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Joao Pinto <Joao.Pinto@synopsys.com>
Cc:     <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
Subject: Re: Git: new feature suggestion
Message-Id: <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
In-Reply-To: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Jan 2017 10:40:52 +0000
Joao Pinto <Joao.Pinto@synopsys.com> wrote:

[...]
> I have seen a lot of Linux developers avoid this re-organization
> operations because they would lose the renamed file history, because
> a new log is created for the new file, even if it is a renamed
> version of itself. I am sending you this e-mail to suggest the
> creation of a new feature in Git: when renamed, a file or folder
> should inherit his parent’s log and a “rename: …” would be
> automatically created or have some kind of pointer to its “old” form
> to make history analysis easier.

Git does not record renames because of its stance that what matters is
code _of the whole project_ as opposed to its location in a particular
file.

Hence with regard to renames Git "works backwards" by detecting them
dynamically while traversing the history (such as with `git log`
etc).  This detection uses certain heuristics which can be controlled
with knobs pointed to by Stefan Beller.

Still, I welcome you to read the sort-of "reference" post by Linus
Torvalds [1] in which he explains the reasoning behind this approach
implemented in Git.  IMO, understanding the reasoning behind the idea
is much better than just mechanically learning how to use it.

The whole thread (esp. Torvalds' replies) is worth reading, but that
particular mail summarizes the whole thing very well.

(The reference link to it used to be [2], but Gmane is not fully
recovered to be able to display it.)

1. http://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/
2. http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217
