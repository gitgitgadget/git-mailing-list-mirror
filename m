From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] remote.c: introduce a way to have different remotes
 for fetch/ push
Date: Mon, 18 Mar 2013 18:17:15 -0400
Message-ID: <CAPig+cSQPtea3AYgsMuU9RE=ecfkbArx9bFJH686eitsF7FD0Q@mail.gmail.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
	<1363612575-7340-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 23:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHiNF-0002wX-PX
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 23:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478Ab3CRWRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 18:17:18 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:33322 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab3CRWRR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 18:17:17 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so6885765lab.33
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Bmk70jFqiUA5KfopbMO4wKFT19V5b3cLW6mCdG1mnZ8=;
        b=f55QSk0az+pLerUTu0k9uFu5Zr0wYR73TPtEVQ08ZHXWcw9K2ORIb2DJliyB/yia8J
         t9xUUpvB1WIJGoe2hwN92/SDLO+tCRti1XRj/tBFbauBq1XXUNOTxsmIrqSeUhul/8UN
         QmZhBay7cxb2Nnmc1Dfrp+8omTji4PxHYBMaeGxIy1FJ02rA8C8a0CD+ZkhmYGP7AWT+
         m+v51Ovm8Yw3Kv4+zxsYLH0/DfX0BrDArhAsDCeaISr+ArKqmWBWuOru+bodYFTcU7Nb
         KahU+qlUipw6jx7gOsXsUEukfStsrHuc+QegEEogiE6zLw2jCjk3CWwhSSctjjMUgLbk
         2hyA==
X-Received: by 10.112.30.104 with SMTP id r8mr7209291lbh.82.1363645035857;
 Mon, 18 Mar 2013 15:17:15 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Mon, 18 Mar 2013 15:17:15 -0700 (PDT)
In-Reply-To: <1363612575-7340-3-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: u8IdUzQC-hfQ4aG63bbfOvFpZw8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218459>

On Mon, Mar 18, 2013 at 9:16 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> remote.c: introduce a way to have different remotes for fetch/ push

s/ push/push/

> Currently, do_push() in push.c calls remote_get(), which gets the
> configured remote for fetching and pushing.  Replace this call with a
> call to pushremote_get() instead, a new function that will return the
> remote configured specifically for pushing.  This function tries to
> work with the string pushremote_name, before falling back to the
> codepath of remote_get().  This patch has no visible impact, but
> serves to enable future patches to introduce configuration variables
> to set this variable.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
