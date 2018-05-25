Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2211F42D
	for <e@80x24.org>; Fri, 25 May 2018 05:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935163AbeEYFkN (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 01:40:13 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:43758 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbeEYFkM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 01:40:12 -0400
Received: by mail-io0-f169.google.com with SMTP id t23-v6so5087674ioc.10
        for <git@vger.kernel.org>; Thu, 24 May 2018 22:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zKau4g9SurQEz2h1RRjHhZBIcxYpYMB74H3slKqxUb4=;
        b=WL6MRvX2s98J26dInSf/csI93s1EYxajq3mDzY7hP9kW8mK3GVU2/R7jK9Almf/eiF
         6pjHkKb+WsKJly9bK+WmXcXhcbAEau7U+wMRUMZICC9+0PGCh9H/fM4mrleeicj+dDoQ
         Zle0GbZRAtgzY/rphb6ntJwm5YfpXuMJXf+KN93QE7Z0ofu5apHmYAIO/A0Te2NuVg6S
         wmqiBokQJJkNwDcdiEGSAmOtkntxi/dsFIjU5IJ98dFlpHRE+9605h7p0XOWrdXjfb7t
         +EYfJNSl4D5GDS60bTkRcMJREFNtI8IVZLf0NrhqEXfEWZOH29pcCfxfdpwIeIPWEzJh
         cC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zKau4g9SurQEz2h1RRjHhZBIcxYpYMB74H3slKqxUb4=;
        b=WCWwroTBamDmTlsUSfT1gDKK2M0aWu3E/M8GJ7THxuZZWYl6EY7d95ZisFVFF2lg0d
         89P3WHRaKua0dJBLC+97KI1xg9MLvVb79nqSg41re313cOKIAUee6BeL8KQVqM0zFgr2
         xeaZoA6/WLqiTBA/kg94fhOdLrXxIAdDEGXv6ud39h6XCQ+Ywi3YAYWq3trxpGYTok7j
         4u+iH37Q+ykWZ3hUHSkaVWalLeEhq+G3XkDopMGTkKTgIBUj+qcHJlrsC5T4qFTBYjty
         A+n5pP2e2Z0DZM79OByOEluchRj48hH2xe9IopeOvv4J8SBFbxna3wVBACjUUk5sBwue
         6w6w==
X-Gm-Message-State: ALKqPwdHGtcNFNqlcaMmPntt7hs6qpqkMhiKN+6t1EfXvQohDKJiSLZY
        w8+7iON0H2BttNPe3II5xdAd4jffFKClHBRJPmY=
X-Google-Smtp-Source: ADUXVKIlScWlMTSrlH2N28uWdePbEbm5KeYOIZr5U7+1u2rbSUZNwEALquIRf9RMo4zO48R4XZYWB8zwp4JSAQAvHtk=
X-Received: by 2002:a6b:1604:: with SMTP id 4-v6mr814507iow.147.1527226811337;
 Thu, 24 May 2018 22:40:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Thu, 24 May 2018 22:40:10
 -0700 (PDT)
In-Reply-To: <CAFazEUP5QJ+WzTkDK6qcgvW5Xwx79KYJWeb1vg41=pS8E8vypQ@mail.gmail.com>
References: <CAFazEUP5QJ+WzTkDK6qcgvW5Xwx79KYJWeb1vg41=pS8E8vypQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 25 May 2018 07:40:10 +0200
Message-ID: <CAP8UFD0ZLsZ97OJYyVTC0fqUJfxJyMzE+PRE4uYVwhDqdkgRTA@mail.gmail.com>
Subject: Re: git difftool with symlink to readonly jar failed
To:     "Etienne d'Hautefeuille" <sagoum.kakoum@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, May 24, 2018 at 11:11 PM, Etienne d'Hautefeuille
<sagoum.kakoum@gmail.com> wrote:
>
> #try  a diff
> git difftool --dir-diff 4cb98b4a307ce97d9e6b8e4b03211fa5ca8af7e7
> 0244799661b993b1f78fa5afb621de3fe4c4a39c
> fatal: impossible d'ouvrir '/tmp/git-difftool.UQ4mqo/left/jenkins.war' en
> =C3=A9criture: Permission non accord=C3=A9e

You should use LANG=3DC so that people can understand the error message.

Also git difftool launches another program that will actually perform
the diff. It looks like it is bcompare on your setup. Did you try with
another program?
