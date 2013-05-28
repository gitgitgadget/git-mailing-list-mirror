From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 28 May 2013 09:58:00 -0700
Message-ID: <CAFzf2Xzm4rG0AFEui7iU56HqX0vciVwWTd=Yb+TXLSmBa=Vbjw@mail.gmail.com>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
	<20130108062811.GA3131@elie.Belkin>
	<7vip78go6b.fsf@alter.siamese.dyndns.org>
	<CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
	<7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
	<20130528091812.GG25742@login.drsnuggles.stderr.nl>
	<CAFzf2Xx2mMO5XJ8n1UsUMMpDvi+KMUt9DpRe80X4zpG=THxSPw@mail.gmail.com>
	<20130528163416.GK25742@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Matthijs Kooijman <matthijs@stdin.nl>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 18:58:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNDs-0001b3-GZ
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 18:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934849Ab3E1Q6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 12:58:04 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:49949 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934805Ab3E1Q6D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 12:58:03 -0400
Received: by mail-lb0-f182.google.com with SMTP id z5so8057692lbh.13
        for <git@vger.kernel.org>; Tue, 28 May 2013 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=zgEnuMQFLLI6iwuco2radkS3vwGAr/kg8xZl+vFdCTc=;
        b=V9swqDeSbkdIFDoTW241m7XlQoFrI1C45GgCbtDjRDaE+IXgYiluuaWmn+4uUK1vGu
         x3UemiH2s8la2ZXakz6ydf5ZmtkYnW3tGFsVXgExPi8gHUVuqCRg/u7yEQD1RgMJ7BF6
         vCc+B7GKyHJ2RulwVWNybjkIcfIV5URmHAWiHJWRkb1VhMXKnjJp15ZbH79GxeY0+P/+
         5zAodnZlcZlSk0CqyISn9pVnCQBQyLEbaT1psF2am0SPkpnzZ9DykB5w+VNNTQTYvA8Z
         8rsMcXtIL1YCYAU88Bjc4+BJi098zGjBbCzOVMVmtFYphKAf3c7TYCwoh6KkJO8tqOwq
         13eA==
X-Received: by 10.112.180.232 with SMTP id dr8mr16867695lbc.67.1369760280574;
 Tue, 28 May 2013 09:58:00 -0700 (PDT)
Received: by 10.112.59.36 with HTTP; Tue, 28 May 2013 09:58:00 -0700 (PDT)
In-Reply-To: <20130528163416.GK25742@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225661>

Matthijs Kooijman wrote:

> In other words: we won't break existing clients if we suddenly send back
> one less commit than before, since the client just sends over what it
> wants and then assumes that whatever it gets back is really what it
> wanted?

Yes, depending on your definition of "break".

An advantage of that approach is that old clients would get the new,
intuitive behavior without upgrading. A disadvantage is that it is a
confusing world where the same command produces different effects when
contacting different servers.
