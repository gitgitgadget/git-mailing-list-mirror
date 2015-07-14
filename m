From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/16] worktree: use "git reset --hard" to populate worktree
Date: Tue, 14 Jul 2015 17:09:07 +0700
Message-ID: <CACsJy8ADt=f0X+aGLJi2ozWVMmx6aNjOoiYXw9J-Km_O=TsNkQ@mail.gmail.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
 <xmqqsi8rzyzo.fsf@gitster.dls.corp.google.com> <55A4DC1C.90908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 14 12:09:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEx9j-0008WS-G1
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 12:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbbGNKJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 06:09:38 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35461 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbbGNKJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 06:09:37 -0400
Received: by igcqs7 with SMTP id qs7so78080126igc.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M23CkJ/ArKtySIs/WgmV/MzUdatWKjYjvX/e4Em48/s=;
        b=hEQXEv4DI6qHTBzuIotYjjN95sAONO3ues0MYjviZhojOQyAc3C4142xKAsppIsjvk
         e+nDJ0ohPnFFtaWtBH+r/50mYprnle34YPG7FZiOnMBSkeetkgW97H3ZzMt3LHoL/d7q
         9PKEpCGE+UVMdbJP+39fqsnM9abQa4QMNYG4tD6qo6vURT5IU5+df41tIPRxxCx5ggBd
         qYHga/iRqQxZDkkCkxntSGHoM9OSCocIomyzdIKQ4m6Y3Z60ozVurAPfQ+hfEabqX5Ib
         pB/pnlz+lS5JyKCPnnI8qP07wjXfZQH/elp8KnPnnn3wuvIjOq5sD2dtwQjEgG9PLQLt
         bMcw==
X-Received: by 10.107.168.99 with SMTP id r96mr21333370ioe.141.1436868576746;
 Tue, 14 Jul 2015 03:09:36 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Tue, 14 Jul 2015 03:09:07 -0700 (PDT)
In-Reply-To: <55A4DC1C.90908@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273947>

On Tue, Jul 14, 2015 at 4:53 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Related to that, I'm interested in "worktree list", and I'm wondering
> how many more worktree commands we foresee, and therefore how much
> refactoring should be done: Currently, the parsing of the contents of
> .../worktrees/ into worktree information is done right in prune-spcefic
> functions. They will have to be refactored. The following questions come
> to my mind:
>
> - Is a simple funtion refactoring enough, or should we introduce a
> worktree struct (and a list of such)?
> - Should each command do its own looping, or do we want
> for_each_worktree() with a callback?

fhe for_each_xxx sounds like a good pattern to reuse.

> - Is a fixed output format for "list"[1] enough, or do we want something
> like for-each-ref or log formats (GSOC project...)?

We could stick to a fixed format for "worktree list" then introduce
--format later if one output does not please everybody.

> - Finally: Who will be stepping on whose toes doing this?

I'm happy to step aside and let people implement it. I still have
plenty of hanging topics to finish up :(
-- 
Duy
