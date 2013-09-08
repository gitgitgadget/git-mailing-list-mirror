From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 17:46:59 -0500
Message-ID: <CAMP44s01wK3Cf1ChOx=J7YKv0VgjYQB+NvyTt4-Mahsu4qG4iw@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
	<CAMP44s0kMbXvcJbWvJDu=8A5iOeH4fsMGUdT-ehXKNXiV1FQ1Q@mail.gmail.com>
	<522C168B.7050300@bbn.com>
	<xmqqa9jn6v6q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 00:47:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VInl5-0003Wh-JL
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 00:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879Ab3IHWrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 18:47:03 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:37223 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3IHWrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 18:47:01 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so4339278lab.34
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 15:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z438ttYeuBAofN8Iqj+v9UUUDNbqIepBoCNZBAcJQNA=;
        b=LzqIOqfhpi2PsakjdXH8W6/s29Z6zEHzeROKRjAHGh4nqi9CXUzblCuYtyKSLEsH/M
         Rqrwl8/2xU54H0dUbvm21No+a6tv4Pjsr/VA0O03g9cnWENO1uDiB1MtuntuGjzazEpZ
         gQs9lXqTZnG7aGbR6mW3ZSbwcerRCIYM7WItZc3ZtN0KvtgDk26WhEPp+a4VvnK6d+04
         Y2gmmL4lQ8FIh2/PVZktOFBGYCiYRHo0Rh02lmztV0dvYT15Nv2jzZh3413gitGiKkQL
         b0VKlNqEnkRVn1bz+SSLz+sfkN72mOGzU4OwSdNUEsOWXDicpBfNODGfvO8ZYqPx/0c0
         NqfA==
X-Received: by 10.152.120.73 with SMTP id la9mr13464504lab.3.1378680420032;
 Sun, 08 Sep 2013 15:47:00 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 15:46:59 -0700 (PDT)
In-Reply-To: <xmqqa9jn6v6q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234274>

On Sun, Sep 8, 2013 at 1:10 PM, Junio C Hamano <gitster@pobox.com> wrote:

>     pull.<someoption> = rebase | merge [| always-fail]
>
> makes that choice in a clear way, I think.
>
> Regarding the verb "integrate".

I doubt anybody thinks of pull being an "integration", and even if it
is, it's still doesn't explain what 'integration = merge' means. To be
human friendly you would need to say 'integration-type' or
'integration-kind', or 'integration-mode', then a human would
understand, "oh yeah, the mode I'm using to integrated is a merge, got
ya'.

But why bother with yet another useless concept the user has to learn?
The user doesn't need to learn about this concept of "integration",
all the user wants is to map:

git pull --rebase
=> pull.<name> = rebase

git pull --merge
pull.<name> = merge

That's it. And my proposed name, 'mode' does the trick just fine.

pull.mode = rebase | merge | merge-no-ff

-- 
Felipe Contreras
