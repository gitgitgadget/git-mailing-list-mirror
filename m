From: Leif Gruenwoldt <leifer@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Mon, 12 Dec 2011 14:13:45 -0500
Message-ID: <CALFF=ZRB7qjj7VMhzr12ySdHmZsySoqceu5brFht8rX1+W3NPg@mail.gmail.com>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org>
 <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
 <4EE61EED.50604@ursus.ath.cx> <CALFF=ZRYB1LkAY5WSC4Eydu-N0KNnWLLM2CfbSXZji18yO82gw@mail.gmail.com>
 <4EE64B04.8080405@ursus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:14:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaBKQ-0008Oq-Jp
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab1LLTOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:14:20 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53141 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab1LLTOS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:14:18 -0500
Received: by qcqz2 with SMTP id z2so3843922qcq.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 11:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tjtc0jgbDLtQ8j6rPrNhyuZqgcjlBz2tR7jlkzS7RZ4=;
        b=EtYlJXrO/76nqeHK6p6RQPLFew4yuWBZNmil5SKctlDIrrmR0vz4nj3RCgRTU6oA45
         1U9+PX9jgODEe7VZNGxrqpVrONA25hkYnyNVl5V+UxXJ5myFEhLLeg68yZJyvpf+7Te2
         iocXUxNDG8Ma184AtSyLNJRDxye8f9e6rwelw=
Received: by 10.50.156.129 with SMTP id we1mr16544012igb.60.1323717256133;
 Mon, 12 Dec 2011 11:14:16 -0800 (PST)
Received: by 10.231.1.32 with HTTP; Mon, 12 Dec 2011 11:13:45 -0800 (PST)
In-Reply-To: <4EE64B04.8080405@ursus.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186934>

On Mon, Dec 12, 2011 at 1:42 PM, Andreas T.Auer
<andreas.t.auer_gtml_37453@ursus.ath.cx> wrote:

> The next question is: Wouldn't you like to have the new stable branch only
> pulled in, when the projectX (as the superproject) is currently on that new
> development branch (maybe master)?
>
> But if you checkout that fixed released version 1.2.9.8, wouldn't it be
> better that in that case the gitlinked version of the submodule is checked
> out instead of some unrelated new version? I mean, when the gitlinks are
> tracked with the projectX commits, this should work well.
>
> And what about a maintenance branch, which is not a fixed version but a
> quite stable branch which should only have bugfixes. Shouldn't the auto-pull
> be disabled in that case, too?
>
> I think the "auto-pull" behavior should depend on the currently checked out
> branch. So the configuration options should allow the definition of one or
> more mappings.

Yes. I think you nailed it. The floating behaviour would best be
configured per branch.

An aside. Would this mean a "git pull" on the product repo would
automatically do a pull (git submodule update) on the submodule too?
