From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Is anyone working on a next-gen Git protocol (Re: [PATCH v3 0/8]
 Hiding refs)
Date: Tue, 5 Feb 2013 12:14:32 +0100
Message-ID: <CACBZZX7G=V9L+zEA2MQFjQW8tRA0i1Gk3nUYdg5dDy35v74SEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 12:15:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2gUe-0005KP-8h
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 12:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817Ab3BELOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 06:14:54 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:54415 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab3BELOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 06:14:53 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so11003oag.30
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 03:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=1kHSMVavQbCS64LSgPffOZTTEWSxihtMIrfLw3ldS+0=;
        b=WJvxSr4h8U8t3/fXLjx4jfxTtN7koTO5/XWgCiSApGCIRxrgIrzaUyANjDLcYwFo0U
         5/+ilWVWMVAb8dz5J7/trZHazMsJuZu8JotPkpYQDJu5FsHUY2ALvwpfzjfCJrMDaWBL
         tarc6xDPxpZOmtmpL4D5CV9x8oTk21PsG5faMmJbgqaa3fzQWDyaG2wgUve49zJL90Wq
         oVfVrgikXU12om+eiHXR7vbnYk41uEFuWmg0hCm86hDFIvFPTDneZcFeig6tpAmqJO0D
         Dl9my7dGbyhDOCObYahwcdazSpGvoQG/kRYTX4jDcz3cTGH+RgPa2Fh6KVhvuwMECOTU
         /oEg==
X-Received: by 10.60.171.103 with SMTP id at7mr15873832oec.58.1360062892873;
 Tue, 05 Feb 2013 03:14:52 -0800 (PST)
Received: by 10.76.168.163 with HTTP; Tue, 5 Feb 2013 03:14:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215478>

On Wed, Jan 30, 2013 at 7:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The third round.
>
>  - Multi-valued variable transfer.hiderefs lists prefixes of ref
>    hierarchies to be hidden from the requests coming over the
>    network.
>
>  - A configuration optionally allows uploadpack to accept fetch
>    requests for an object at the tip of a hidden ref.
>
> Elsewhere, we discussed "delaying ref advertisement" (aka "expand
> refs"), but it is an orthogonal feature and this "hiding refs
> completely from advertisement" series does not attempt to address.

I'm a bit late to this so sorry if this has been covered before.

In the initial draft of this series the rationale for it was "reducing
the network cost while talking with a repository with tons of
refs"[1]. But later you seem to have changed your mind, and "network
bandwidth reduction of advertisement is a side effect of clutter
reduction, and not necessarily the primary goal".

Do you have any plans for something that *does* have the reduction of
network bandwidth as a primary goal?

In October I asked if anyone was working on a next-gen Git protocol[3]
that would provide clients with the ability to specify what refs they
wanted. You replied to me off-list saying "Yes".

Is this what you've been working on? Because if so I misunderstood you
thinking you were going to work on something that gave clients the
ability specify what they wanted before the initial ref advertisement.

I'm still very keen to have that ability, so if you're not working on
it I just might give it a go.

1. http://article.gmane.org/gmane.comp.version-control.git/213951
2. http://article.gmane.org/gmane.comp.version-control.git/213984
3. http://article.gmane.org/gmane.comp.version-control.git/214025
4. http://thread.gmane.org/gmane.comp.version-control.git/207190
