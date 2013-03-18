From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] remote.c: introduce remote.pushdefault
Date: Mon, 18 Mar 2013 18:19:45 -0400
Message-ID: <CAPig+cQ8wiYffxyucRRi5jOhFjv-O6x8OBx6wz6Q_zJzQyN=_A@mail.gmail.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
	<1363612575-7340-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 23:20:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHiPd-0004Sm-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 23:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab3CRWTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 18:19:47 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:35823 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150Ab3CRWTq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 18:19:46 -0400
Received: by mail-la0-f51.google.com with SMTP id fo13so6911370lab.10
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=XB0K9sl59uJr2ynPHE1GYSlCM8c44Fl2q3GEgcq6QHk=;
        b=jshAD4KiIQ5bMQAXV0crh4KwUhrhP36DAFjlEyhMCRxIjm3x1ecFVajeYoAGND9d2G
         C1DBv34XRWgbF8D4Ti6uIfYYnEoFwfOhpf3qgVQhfgHmoAgvF03nlZPMTA0+9ebAc1ns
         H2ra7PeAuCeKD8hpMeBsuxwudL0+n72O83dmlmOvTRN3gMNZdws5riakHyrrcDdaigwM
         ri1gdDi0HYWQxCW1sNfbTa2IMhEggqG+0C1QNiWMC744oyvG3yTpp9tialPYcxjzuBul
         ZoMzXTw3xIEJ/d4vwTA3glRNgecKrY9HufMByx8ex+Ygc/VjXrz7pyO4S8aUHteAo5re
         kRsA==
X-Received: by 10.152.128.98 with SMTP id nn2mr16284389lab.17.1363645185205;
 Mon, 18 Mar 2013 15:19:45 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Mon, 18 Mar 2013 15:19:45 -0700 (PDT)
In-Reply-To: <1363612575-7340-4-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: vO6zzKeoGTKa76jLDwGasYpKeu0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218460>

On Mon, Mar 18, 2013 at 9:16 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>  branch.<name>.remote::
> -       When in branch <name>, it tells 'git fetch' and 'git push' which
> -       remote to fetch from/push to.  It defaults to `origin` if no remote is
> -       configured. `origin` is also used if you are not on any branch.
> +       When on branch <name>, it tells 'git fetch' and 'git push'
> +       which remote to fetch from/push to.  The remote to push to
> +       may be overriden with `remote.pushdefault` (for all branches).

s/overriden/overridden/

> +       If no remote is configured, or if you are not on any branch,
> +       it defaults to `origin` for fetching and `remote.pushdefault`
> +       for pushing.
