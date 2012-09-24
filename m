From: Johan Herland <johan@herland.net>
Subject: Re: [BUG?] Path limiting in "git log" when run from another subdir
Date: Mon, 24 Sep 2012 16:11:11 +0200
Message-ID: <CALKQrgdhFCUs+gqT=PrT3w7suGzvnj7Wo8GfipHHQm6b=TZF+A@mail.gmail.com>
References: <CALKQrged+ptCQYm-=JKRborrAeKmaNFG=rDS8BQK5CNhwqjnkQ@mail.gmail.com>
	<CACsJy8CECnFbkD6QFWiDMxz6J4mOngrmHPwjuXvsFBUXhNc1_w@mail.gmail.com>
	<CALKQrgfb8qbeKmCzri27iA1qk9H8R4FgyA-YsUQf_JQRWvGK4g@mail.gmail.com>
	<CACsJy8A4-XC7AS4ZqZ1Whsoo-mztTNFvEnk810e10-rwXBkJHA@mail.gmail.com>
	<CACsJy8AXonkSXNU_uUXh=d2wojOhAn+S1JW7eUMywxohnAOXjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:11:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG9Nd-0007Cd-Pt
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab2IXOLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:11:17 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:56313 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab2IXOLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 10:11:16 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1TG9NT-0000mD-8H
	for git@vger.kernel.org; Mon, 24 Sep 2012 16:11:15 +0200
Received: by oago6 with SMTP id o6so5418823oag.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 07:11:11 -0700 (PDT)
Received: by 10.60.170.9 with SMTP id ai9mr6802621oec.36.1348495871872; Mon,
 24 Sep 2012 07:11:11 -0700 (PDT)
Received: by 10.76.128.204 with HTTP; Mon, 24 Sep 2012 07:11:11 -0700 (PDT)
In-Reply-To: <CACsJy8AXonkSXNU_uUXh=d2wojOhAn+S1JW7eUMywxohnAOXjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206273>

On Mon, Sep 24, 2012 at 3:39 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Mon, Sep 24, 2012 at 8:30 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> Any special in gitdir/worktree setting?
>
> What does "GIT_TRACE_SETUP=1 git log -- /Documentation" show?

FWIW, this issue is resolved as far as I'm concerned. I was simply
using the wrong syntax...

Anyway, with current master:

$ GIT_TRACE_SETUP=1 ../git log -1 -- /Documentation
setup: git_dir: .git
setup: worktree: /home/jherland/git/git
setup: cwd: /home/jherland/git/git
setup: prefix: t/
fatal: '/Documentation' is outside repository

With v1.7.11:

$ GIT_TRACE_SETUP=1 ../git log -1 -- /Documentation
setup: git_dir: .git
setup: worktree: /home/jherland/git/git
setup: cwd: /home/jherland/git/git
setup: prefix: t/
commit 0ce2e396ee9fb0fa07e8381b338e49859dbf03db
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Jun 17 14:07:15 2012 -0700

    Git 1.7.11

    Signed-off-by: Junio C Hamano <gitster@pobox.com>


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
