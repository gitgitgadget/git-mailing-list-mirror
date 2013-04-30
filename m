From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 13:07:25 +0700
Message-ID: <CACsJy8Af5Z6DzsAchu2MpMeanTEJiF-DwhdPMGE9n6QKf2K6Eg@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 08:08:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX3jN-0002jH-1U
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 08:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab3D3GH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 02:07:57 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:40940 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3D3GH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 02:07:56 -0400
Received: by mail-ob0-f177.google.com with SMTP id ef5so134995obb.36
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yC0buYj0lpnwetm1kKYpnVT33/ijM2XrjCjQnddphJ8=;
        b=fZUFQE2H8B/LR54sQEmR89rEStzXkT/aWkDO+xGV9Eo4GbpDNXU1GjQ2UG6Zii2Jql
         Jz6dnKxYuapkCqC8fEOcKYN95M50112PG9rLN5EGo62j9IuIQUC6v1NUY8J/CDpu03Li
         33WsSG5N8zpYdr/oPw75WSwMOYuZcWlAAkSd6crQalyfiBNbw6FaL3at4rkLcSY0xU8t
         6M9FVsga1zfv3mNtwoITgE10nsO9KhpUnzA71b3pSd0M4f0yJpEgJ8hcC2JK5DgLG5gd
         Tdv4M5TerpkTA0hHHUChpIHt8MCEs5VfUDH+xcTc4Mbb+R7noVUlPC0tRAy5Hb6L0Bf4
         yeFQ==
X-Received: by 10.182.33.40 with SMTP id o8mr16008638obi.39.1367302076083;
 Mon, 29 Apr 2013 23:07:56 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Mon, 29 Apr 2013 23:07:25 -0700 (PDT)
In-Reply-To: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222909>

On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
> remove '~0', and we can remove 'HEAD', but we can't remove '{0}'?
>
> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
> 'master@'.
>
> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
> use 'git show @~1', and all that goody goodness.

This patch also allows funny things like @{-1}@ (wanted to try the
cute syntax @{u}@ but too lazy to setup upstream)

$ ./git rev-parse @{-1}
7e6a0cc47da79dd22c0338aee8750fda92ced5d9
$ ./git rev-parse @{-1}@
7e6a0cc47da79dd22c0338aee8750fda92ced5d9
$ ./git rev-parse @{-1}@{0}
@{-1}@{0}
fatal: ambiguous argument '@{-1}@{0}': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
--
Duy
