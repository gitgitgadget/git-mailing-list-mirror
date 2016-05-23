From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/5] worktree lock/unlock
Date: Mon, 23 May 2016 00:51:09 -0400
Message-ID: <CAPig+cQVaMOKtbUCWdZqYDO8ZUZkVcSJH14S=2xrZiDVJ59Xdg@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160522104341.656-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 06:51:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4hpj-0005Yy-IT
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 06:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbcEWEvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 00:51:11 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:34943 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbcEWEvK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 00:51:10 -0400
Received: by mail-it0-f41.google.com with SMTP id z189so20459824itg.0
        for <git@vger.kernel.org>; Sun, 22 May 2016 21:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=Pr+nueObncuWUzPt0HlBmPQSe8n55klprvAYvDArQ6Y=;
        b=DsE5Chgj/RpHOBk9YShIEH2REOzC3zGTzYduBBm9OsMhkbLMGZxv+u7uSUScLDqdYS
         CzH3PV0wYeiGSrN3l6MpjiAykrcyRtnQ6JRkBMuJ68iqTVV6wWg3WkmNqTAXUeFf2xCD
         lblIlwt5rYWrezJfZGdWmLPdrolAkI2Lu1l/DKqmry2fKR8WU+BlRovutdKo98/IWXLf
         RrmfdBEL1gjn3lhvlvHHoNviYzubm33u3Cr9/B/TUdK9O9jtAUqsj6rz0TaWmMFNQ6yX
         hxadEpijZXeA4kxzKTTOvmVrCapts170NGGd3DeA7F0HGT1L8oyfjfXIhrsyhnc6ewA9
         iyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Pr+nueObncuWUzPt0HlBmPQSe8n55klprvAYvDArQ6Y=;
        b=WNwz0Mx7jR5rLi29SonEQCzeUVIou0r+WXRCF/6K3+NcngpkUCLAkWYhlW0EJXvxWd
         njTWzdozGO5h5ofE+2QtB+6ux/1z9J6lA6QofVOgjQagFKGmFyqUomBwFgISneb/2Ahp
         Z/jAdEQQXVPUjSW+JGPvZ5VlSECJfEusFP9fqONG5hMqa4lRCYqWrX71AmaTvizKPiwH
         o1iqAVhtAW06otVJkfoSGhucRFeYjGLnNo3nQzUO4eVroOyOyijOsWeRBiJZyaG6EwZA
         K8v6R3h3GlX18gx1S/RSayuwfq8CgDalmcu2f8FGXIHwF8k9TCvCQrzLVaiN13lpu6Qk
         I3xg==
X-Gm-Message-State: AOPr4FW8bA1rOFD7y/ydd8XY2wlQXHChfvcfkjzeth+Yv2EyUdyFz679IR2t2f4ceKrqYb6e+WS0Rve+OIwt6g==
X-Received: by 10.36.55.141 with SMTP id r135mr9243799itr.73.1463979069552;
 Sun, 22 May 2016 21:51:09 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 21:51:09 -0700 (PDT)
In-Reply-To: <20160522104341.656-1-pclouds@gmail.com>
X-Google-Sender-Auth: UHfIFgYIRcHfmyeKXWn4OiuDjEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295309>

On Sun, May 22, 2016 at 6:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This should address all of Eric's comments (thanks!). An extra change
> I made is free_worktrees() at the end of {,un}lock_worktree() to avoi=
d
> leaking. This series depends on nd/worktree-cleanup-post-head-protect=
ion.

Thanks, this addresses all my comments from the previous round (aside
from the suggestion to add a 'locked' field to 'struct worktree' and
populate it automatically, which you elected to defer for the
present).

I re-read the entire series and, aside from the typo in the
documentation update of patch 4/5, everything looks fine, and the
series is:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
