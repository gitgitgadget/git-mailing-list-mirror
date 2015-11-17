From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Tue, 17 Nov 2015 12:04:18 -0800
Message-ID: <CAGZ79kZGdOCzJ5V-RZcBbZE09HsSUQrypHaFT-N8wks7NA=21Q@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<20151113233807.GD16173@sigill.intra.peff.net>
	<20151113234116.GA18234@sigill.intra.peff.net>
	<CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
	<564A279C.6000802@web.de>
	<CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
	<564A4DB1.4070507@web.de>
	<CAGZ79kZhn59GTs9LRnAoPrSwf43jjgi0_qWibrQ8gCvjas_MKA@mail.gmail.com>
	<564B8406.9070706@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 17 21:04:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZymUK-0000R5-3Y
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 21:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbbKQUEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 15:04:20 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36138 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbbKQUET (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 15:04:19 -0500
Received: by ykdr82 with SMTP id r82so25933420ykd.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 12:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ys8dPx3FgU0l7hHMnr7qjzsbwpPbT/U0sNdUQuIYW2s=;
        b=cfLegT0NxDDZY6i5aQBjeNhVNdJCVc40pv2v132+LJW1w8etl6kdhEhrhO5wDGP3P7
         5TgXoelHPZ+oIrB2bxbecdI8hTWv8dNGsM6hQG4WUpX61KWNrK3PPtKZ/pFcSSr3voVB
         kqbpbnXXQorMZFG3tOhpy5nZIg8qS0UJDegt5Sps5T7AxcE47UpeHa99LmBYqYkOyGd+
         JJkBrhQXd4p73vbFTWKyW8gFwm2twgqS9D0cqXtzCwihlE77hnfXfosMDS5BuhVUPbAz
         8I6ROndhJzC1HtzIDFjBTdUjIxI3RET+2ntNguMtS/JLDndO5hdTFggVPFbVbI3zDZ9M
         vMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ys8dPx3FgU0l7hHMnr7qjzsbwpPbT/U0sNdUQuIYW2s=;
        b=Y+V+a3pZsQ1PdiKGJd82CvLCWpwlgD7vl67HIy9JyE7GnD+eFPu9lBoX8yzSn06g3a
         6ON+kFZF+K2dGhSwhLyvt5ytxfdE8mT0ndgheaRt6Qk/uJTGPahIvEozqLl2GjjHNLSB
         jfJ7sAYBkRWCbkMEUQZ05QS6WOZI4m7GKn+55t5Iaic6CryGX4s8Y+j3pOLBMA3VB/tP
         b3vCuQBe8nWedn7n57jDDnbl06DSTPagbzI1ItdvQ8+C09u5cJjPFthvQd0ZKuhHotJj
         rCbJMgdP+zPrGfSisT4pBCErZKWiuG0AybdW18neytl2S0yPWYrM8ktBpzVw3JD2AaGe
         b7lQ==
X-Gm-Message-State: ALoCoQlyBCTnGvlC/jwAqsv6b4jHTYx0C3psOGljYaitla0OCFLRB0G7JD20M5P2xCUqCje5hcrn
X-Received: by 10.129.78.216 with SMTP id c207mr23627080ywb.320.1447790658366;
 Tue, 17 Nov 2015 12:04:18 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Tue, 17 Nov 2015 12:04:18 -0800 (PST)
In-Reply-To: <564B8406.9070706@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281415>

On Tue, Nov 17, 2015 at 11:46 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>
> But for quite some time you'll have older servers out there that
> don't support fetching a single sha1 or aren't configured to do so.

Only when talking about the open source side. If you have all the
submodules/superprojects on your companies mirror, you can control
the git installations there.

> Wouldn't it be better to give the user an appropriate warning and
> fall back to cloning everything for those submodules while using the
> optimized new method for all others and the superproject? Otherwise
> you won't be able to limit the depth if only a single submodule
> server doesn't support fetching a single sha1.
>

I think warnings are fine, but no fallbacks. The warning could look like:

    Server for submodule <foo> doesn't support fetching by sha1.
    Fetch again without depth argument.

and keep going with the other submodules. This would allow the user
to make an informed decision if they want to have the fallback solution
(which requires more band width, disk space)
On the other hand, that's what people do today, so it's not that bad either,
so I guess falling bad would work too.
