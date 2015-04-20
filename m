From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] config.c: split some variables to $GIT_DIR/config.worktree
Date: Mon, 20 Apr 2015 10:22:39 +0700
Message-ID: <CACsJy8CLHwkiRn6+f4rjXDjWzJsJN8eN7rZJVewZg6mmrncbRQ@mail.gmail.com>
References: <1427371464-22237-1-git-send-email-pclouds@gmail.com>
 <1427804079-13061-1-git-send-email-pclouds@gmail.com> <20150413233739.GA786@wheezy.local>
 <20150418111023.GA1496@lanh> <20150420025110.GD786@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 05:23:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk2Im-0003DJ-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 05:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbbDTDXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 23:23:11 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37930 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbbDTDXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 23:23:10 -0400
Received: by igbhj9 with SMTP id hj9so50476123igb.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2015 20:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+x7byq7F5z0OVbx4RcM0D6zYFuwaatDMpSbNK3qhUKc=;
        b=U9otbYKcwD9/ONuWk562kqNXbjNOf+oOEIRd3etmfh84ptpS0QPauqeu+tSvYnNnBH
         qT6RKYE+1OXblIRSUqa3jg0yRukH2KZq6OBug1i2vKd94HpqTSzRGa3a/7RSSw2H68gz
         sW7fRVkZpd6Ujqm80xqdgfjmReOxr9CfTK9Q9d2UdwBCLQxyLajJqz4aR/eASqdFk0hu
         FprMI0Ufvia7xwgF8sJcFudI5DXxKq2cImqe1R5AtFiJK5EdVZVIQq8TKm4ivagR7bWT
         kaTdOQQ91qUGP/l0mItGQbfsYeEb1ANcljrN29Ek2xYsLVoVMhBdWLD5zWe19cHA+qKq
         Ph6Q==
X-Received: by 10.42.64.76 with SMTP id f12mr16346502ici.93.1429500189644;
 Sun, 19 Apr 2015 20:23:09 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Sun, 19 Apr 2015 20:22:39 -0700 (PDT)
In-Reply-To: <20150420025110.GD786@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267448>

On Mon, Apr 20, 2015 at 9:51 AM, Max Kirillov <max@max630.net> wrote:
> By the way, if checkout --to run on repository created
> before the feaure added, the linked checkout will not be
> able to use own variables. Should checkout --to check that
> the file exists and create it in case it does not?

Yes it should. I made some changes for that [1] but haven't posted in
the list yet because it's incomplete imo. I should check again after
reinitializing the repo, whether core.worktree is in
info/config.worktree, if not warn the user. This could happen if the
user defines a custom template.

[1] https://github.com/pclouds/git/commit/f2276a37039d7a1f99fbcbc72e7d87b0782e4663
-- 
Duy
