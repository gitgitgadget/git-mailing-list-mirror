From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/8] dir.c: git-status --ignored: don't list empty
 directories as ignored
Date: Mon, 18 Mar 2013 17:59:29 -0400
Message-ID: <CAPig+cTzOtN128FOFAEui8YBoy1Q89Yb=iSGtVsgi2jLs7AeOQ@mail.gmail.com>
References: <514775FA.9080304@gmail.com>
	<51477901.9020804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 23:00:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHi6X-0007sk-KY
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 23:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934112Ab3CRV75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 17:59:57 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:41167 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757046Ab3CRV7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 17:59:30 -0400
Received: by mail-la0-f51.google.com with SMTP id fo13so6881703lab.38
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=gZzaCIjOedTwm+02k/saqClyE97r+h490MznsliP2Lc=;
        b=xuXqiJ1+wlfmBYGsaIz0SFQCf2L2Tpak/Fujs5YWwC8oE6fOcua/V+lDfU+VlMhf3h
         xkexHWue4A6PEoBWYU6E/bOxZQDifpX738iSpdz1yx8gqyTOHi5yGJADKS0TX+Lfsz/M
         Z7BbEcpqCLibyFzus3WL/or706cEHgSdh+WQElzmuibRUzvPZ4BUT7ZSROHtiHoPsL1W
         Pj3exdiu0aJpG8X2ZFowdtbeb1HDM8j+7Yzo2i0kA9UoV5RWNSQxke5yIYLoqElxjJ8Y
         z8hPVzoHvQMsxBTRp1+6rw/Zu3uqUpseeOCmz1/wURuEFWiYc3YhiZ74UzjeXk3EltUP
         zuSg==
X-Received: by 10.112.134.166 with SMTP id pl6mr7041963lbb.68.1363643969213;
 Mon, 18 Mar 2013 14:59:29 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Mon, 18 Mar 2013 14:59:29 -0700 (PDT)
In-Reply-To: <51477901.9020804@gmail.com>
X-Google-Sender-Auth: d1gTXopsACmb60UuOX-7FPS8WkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218456>

On Mon, Mar 18, 2013 at 4:28 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> When checking if a directory is already listed as untracked (i.e. shouldn't
> be listed as ignored as well), don't assume that the dirctory has only

s/dirctory/directory/

> ignored files if it doesn't have untracked files, as the directory may be
> empty.
