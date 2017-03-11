Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15541FC43
	for <e@80x24.org>; Sat, 11 Mar 2017 01:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933058AbdCKBCW (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 20:02:22 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:35976 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbdCKBCV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 20:02:21 -0500
Received: by mail-ot0-f176.google.com with SMTP id i1so86860745ota.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 17:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=soAnpqJ6kGF37bSrM/s0iuadgoTkHYoqdgzgGLxKSZA=;
        b=HA9Y88z/pAmPUlrbZlApYnhh3zw1ExtZCaOIweXWwAIsM8brorCA1vtBp9EmXcRD31
         GB9XPNho5k9s6VgX46J5SGwWrHiprJvtTe3sM2yQVtpPLMh4SB+pUJKuQhrKymSriDyD
         NpNzL+qzbnk8GmKLkcJT78Vj0r4DbLaGI8JuV51rGdigo3xQSPWm7LVqsF0VoNnOTBGw
         dJqMx+EW4JUvhvyKGVxayTqMJMVUrCYaYhocT8e2vQDYep51BfL3njrioABvV48UDa2d
         91uLGc5sG+s6tM+fxJXh8FB0+IVvzS+5TT0JIFnIcwU65ad2iWzVPeeqkzKkY2c/CnYO
         Lrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=soAnpqJ6kGF37bSrM/s0iuadgoTkHYoqdgzgGLxKSZA=;
        b=W110eL/XtqwnuqW4GpfnWboI+xECaHMvu0b8zDoQ+J1CQmraRLWzaqxvw7SzUpwB8V
         GPU12KGNDWSrUmH7DHoZn51filFNSlIo5PMQP975Nm2eqhbj+w8oDKgOCLZL9HgATMCQ
         GQl0ulNedo+b6u9cn4TFwRgqaBpyZ3NIwhw2kZ9p6tZ748ypz9rKf96S/TIz3PvR/Leg
         726nBpnjHefRIq3wCHEVe4TppH3JgU+y3e4g+vJS5VjiY9h6/lQZHsxvZEpl6pb7jCNU
         j9TMKOxYHmsFbL2fwWDd2NXg7xHjWOZ4kqQw+nZaceZRu39Jr85bdU98bNQlbN44AzDu
         graw==
X-Gm-Message-State: AFeK/H07Ipqia9IUH+RBcncRFxto2vvHhGcmsH2P4Klm4lK0Ao0P1mbAVPhyM//dE7uzTW0xR7BhFGWWMctC+Q==
X-Received: by 10.157.68.209 with SMTP id p17mr12942391otg.244.1489194139245;
 Fri, 10 Mar 2017 17:02:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.80.172 with HTTP; Fri, 10 Mar 2017 17:02:18 -0800 (PST)
In-Reply-To: <20170311002615.GG26789@aiede.mtv.corp.google.com>
References: <8BE1A361-32BB-4164-AD54-949555855C52@cornell.edu> <20170311002615.GG26789@aiede.mtv.corp.google.com>
From:   Noam Postavsky <npostavs@users.sourceforge.net>
Date:   Fri, 10 Mar 2017 20:02:18 -0500
X-Google-Sender-Auth: SZ5-lWaXT7ivSXAckpdJXjFQFSI
Message-ID: <CAM-tV-9DV=XOVSehEfd2LiWYdubhwV7fC8uRnKqmFT_aTQ1OKg@mail.gmail.com>
Subject: Re: [GSoC] Move ~/.git-credential-cache to ~/.cache/git
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Devin Lehmacher <djl329@cornell.edu>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 7:26 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> I find that magit does rely on the socket path.
>
>     Start credential daemon on magit-credential-hook
>
>     If we let git start the daemon, Emacs will send a SIGHUP when git
>     finishes and closes the pty, killing the daemon.  Hence the need to have
>     our own daemon running first.

Magit doesn't really care about the particular path, but it does call
git-credential-cache--daemon directly which needs to be told where to
create the socket. I guess Magit could just default to using
~/.cache/git/socket if ~/.cache/git exists? (Magit users can override
the path regardless)
