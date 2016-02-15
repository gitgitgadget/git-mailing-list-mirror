From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Disown ssh+git and git+ssh
Date: Mon, 15 Feb 2016 13:16:05 -0500
Message-ID: <CAPig+cQ6JC65QkH=8nJ9Qwghr6cwv0BsB5TRDeg=gZmDpcdcHg@mail.gmail.com>
References: <xmqq7fi8s4dx.fsf@gitster.mtv.corp.google.com>
	<1455546546-65710-1-git-send-email-cmn@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>
X-From: git-owner@vger.kernel.org Mon Feb 15 19:16:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNh4-0003jR-MW
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 19:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbcBOSQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 13:16:10 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36812 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbcBOSQG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 13:16:06 -0500
Received: by mail-vk0-f53.google.com with SMTP id c3so113709933vkb.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 10:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=hCFjZGX3q8GsRglxJC//G1vBW1K3xm48v1FAmOKozTc=;
        b=zw2pHw34ITDoAMGzpXX1NA822q8AY0k0NIBdGaGaRi6KyujWBEtyCR7Iv2impY1usi
         XJZyDqzW4ht9oABalBjMsH4xtdtupJCsE/Myb2EG7apEq+PjYfMOBHxc58Zmd9tG8eHq
         xKEliCptVx+B1DdN/1OHYjAFNfWA0ta9qU08tHgPgvYAMjO189U7uxJFWOEOwjwm/135
         /EgfYLXkoQ8bX7S0+U9vmKDojyupy/cJ2S85ljdFcdPipU4XnqjPzCTKWQTtUtaOd1to
         cNTt0I8cmUkvyGyCt5bWkVBTVqjFYL0FXfFlpFp6r94tuw2TCkHBpFNWsncOALLmV1oz
         XgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hCFjZGX3q8GsRglxJC//G1vBW1K3xm48v1FAmOKozTc=;
        b=h4jYvRyaSAx/SWZs5L0KKMmKqB5ZwuJi9UM5iJyc469Spq+8NnnqNqAHTpC7wTpDsy
         UBJzex2FMN+Cj2S+C0XJpCaXb9OQBcyvf5TVGnnXMCCsM/4Ii8zpLkVBXt6rY2Kb7KLM
         +Hr7Zu6G/riBExAeiZXhhg4ImMB0+mLYghXdjX0NkkMSAAaVFwIhqvF9mUhfm2g2Mf/J
         Bm+2mL4M7PTiRNI2kGVl4kUDpewcGhH5Qouy7ZyeVtnA0NBlej0xq9wIdOREP9Oc3tax
         29kXllZGR03miLGOfO7vxQFcbzSM7FbUmcyc1txY7WqLryKku6nNjbB8WU5NiaEdS4+H
         z5ig==
X-Gm-Message-State: AG10YOS3qfERQ0uvLMx/Nyecc9DZ8YPoyKfk9HNyQSA6T00YFEXLGk3WB06XPVBTHi+PNtcSMXy3ANnVnl63nQ==
X-Received: by 10.31.141.2 with SMTP id p2mr14247498vkd.37.1455560165504; Mon,
 15 Feb 2016 10:16:05 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 10:16:05 -0800 (PST)
In-Reply-To: <1455546546-65710-1-git-send-email-cmn@dwim.me>
X-Google-Sender-Auth: V2BAZMMqp6-diHtkO1WlmNzS_bs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286222>

On Mon, Feb 15, 2016 at 9:29 AM, Carlos Mart=C3=ADn Nieto <cmn@dwim.me>=
 wrote:
> These were silly from the beginning, but we have to support them for

It might be helpful to cite some reference to support the claim that
they are "silly" since it's not necessarily obvious to readers who did
not following the discussion.

More below...

> compatibility. That doesn't mean we have to show them in the
> documentation. These were already left out of the main list, but a
> reference in the main manpage was left, so remove that.
>
> Also add a note to discourage their use if anybody goes looking for t=
hem
> in the source code.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> ---
>         if (!strcmp(name, "git"))
>                 return PROTO_GIT;
> +       /*
> +        * These ways to spell the ssh transport remain supported for
> +        * compat but are undocumented and their use is discouraged
> +        */
>         if (!strcmp(name, "git+ssh"))
>                 return PROTO_SSH;
>         if (!strcmp(name, "ssh+git"))
> @@ -1002,6 +1002,10 @@ struct transport *transport_get(struct remote =
*remote, const char *url)
>                 || starts_with(url, "file://")
>                 || starts_with(url, "git://")
>                 || starts_with(url, "ssh://")
> +               /*
> +                * These ways to spell the ssh transport remain suppo=
rted for
> +                * compat but are undocumented and their use is disco=
uraged
> +                */
>                 || starts_with(url, "git+ssh://")
>                 || starts_with(url, "ssh+git://")) {

A little "comment" bikeshedding: Aside from undesirably interrupting
the code flow, these large comment blocks draw far too much attention
from the reader than these deprecated spellings of "ssh" deserve, thus
making them seem overly important. How about minimizing their
importance by giving them minimal commentary?

    || starts_with(url, "ssh://")
    || starts_with(url, "git+ssh://") /* deprecated */
    || starts_with(url, "ssh+git://") { /* deprecated */

The term "deprecated" should be sufficient to explain that their use
is discouraged and why they are not documented anymore, and if a
reader wants to know more, the commit message can be consulted for the
full story.
