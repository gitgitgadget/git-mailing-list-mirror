Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5FD20248
	for <e@80x24.org>; Thu, 28 Feb 2019 23:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfB1XFW (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 18:05:22 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:32769 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfB1XFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 18:05:22 -0500
Received: by mail-wm1-f43.google.com with SMTP id c13so7596046wmb.0
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 15:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vCJMT2p9wxrJeBpMu3epXmVSFQvw9HZI8Oqfo6HkepQ=;
        b=XvsEVT1/zphVn6B/cAgH6iYH9sJR8A01KNH1uZmKGrOFZI827De/DTZ3HlGEm5LgZl
         amYRgTd2jwvyasipZubZAmF+SyMERp503BphpM+LSmfL4lTREdrmypPGqBufZRecn32g
         5+hmjIBueybg2ubh3b0ApFAUujYfi5/AqjlEIx0DqdH/N3trdxqsGYWHfuNoeUOgfQuQ
         zGwn55BKXFnYPDwUVjDmfOOlAks8UiOajuL/L7N1AE6l50b4x9Hz45kqtEZsEwFW5L/Z
         On1dGUIVQ7XQHKo6VBDxVOGCzUZtNzWsGDnnWuxzzwQipv9FvKFUO4XzGpElVups8nDS
         gsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vCJMT2p9wxrJeBpMu3epXmVSFQvw9HZI8Oqfo6HkepQ=;
        b=rrVfIrkjO3Yz8j6XpOzz0x1sC/S6nXYv9ecQ0W+hhenm8m3hyjY3zpa0ZTem3HyKDk
         PH0X056c11oE29oCzRFjMTktzk7Kyp/l6cV4yweKPqh6w2sNs7DMvSNKn3GYyVeh8UD+
         W0tK5WHsMWXj6Kby55vS4b8oxVPWFt2M+MmNCcFd86b4NAkYyguEsog0pBBCH9ftCi6p
         NG+e6v7IjZOVjQwB2JV16gBC94LQ37nOcjb5JlRe4q4cz7RSDDRAn89AZ6fQfbU+W0lt
         CLCHoZglNa2z9SCUNAiaDtnhCw3M3SyxOnMVYntgnV9wGKFrK4GvQ2vtALvdf138hurB
         A4dg==
X-Gm-Message-State: APjAAAVZZk1xSCnX5S/WZ3OWe/e0xkylCGBoZlbcA0lsOr31onMqKvOj
        wvRg7XdooS9v+n6hjm+9/M0=
X-Google-Smtp-Source: APXvYqwiDcLGsGbPGAMBBUbIxazMbGlLGOWv3N+embaAHSUy3qxAkaMKmrkKCv7S9VVL/Ve+0Il4SA==
X-Received: by 2002:a1c:9e4b:: with SMTP id h72mr1326105wme.76.1551395120529;
        Thu, 28 Feb 2019 15:05:20 -0800 (PST)
Received: from szeder.dev (x4d0c4522.dyn.telefonica.de. [77.12.69.34])
        by smtp.gmail.com with ESMTPSA id v20sm4367559wmj.2.2019.02.28.15.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 15:05:19 -0800 (PST)
Date:   Fri, 1 Mar 2019 00:05:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
Message-ID: <20190228230517.GL19739@szeder.dev>
References: <20190228223123.GZ16125@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190228223123.GZ16125@zaya.teonanacatl.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 28, 2019 at 05:31:23PM -0500, Todd Zullinger wrote:
> I was playing with the completion.commands config added in
> 6532f3740b ("completion: allow to customize the completable
> command list", 2018-05-20) and noticed an issue removing
> multiple commands.
> 
> I wanted to remove completion for cherry and mergetool, so I
> added them both to the config:
> 
>     git config completion.commands "-cherry -mergetool"
> 
> But git still completes cherry in this case, only removing
> mergetool.  Swapping the items in the config yields the
> opposite result (cherry is removed and mergetool is not).
> 
> With luck this will be a clear and easily resolved issue in
> list_cmds_by_config() (in help.c).

Indeed, this seems to fix it for me:

diff --git a/help.c b/help.c
index 520c9080e8..f2c6f0c9f7 100644
--- a/help.c
+++ b/help.c
@@ -393,8 +393,8 @@ void list_cmds_by_config(struct string_list *list)
 		const char *p = strchrnul(cmd_list, ' ');
 
 		strbuf_add(&sb, cmd_list, p - cmd_list);
-		if (*cmd_list == '-')
-			string_list_remove(list, cmd_list + 1, 0);
+		if (*sb.buf == '-')
+			string_list_remove(list, sb.buf + 1, 0);
 		else
 			string_list_insert(list, sb.buf);
 		strbuf_release(&sb);


