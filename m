From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] a tale of Git 2.5, ssh transport and GIT_* environment variables
Date: Fri, 04 Sep 2015 11:18:01 -0700
Message-ID: <xmqqpp1yf3qe.fsf@gitster.mtv.corp.google.com>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
	<20150904125448.GA25501@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:18:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXvYv-0002iT-IV
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 20:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270AbbIDSSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 14:18:05 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35072 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbbIDSSE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 14:18:04 -0400
Received: by pacfv12 with SMTP id fv12so31771971pac.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YdZUDpCGa5U2DY2Rv8iF1KJQ6WoKt56TuDAldg2ptko=;
        b=WoS/0QQPgoK7+rr9vCBrZQiNfAksJHmQ6SNFTTrRn+fvF9ttfP8PuDAi5Fglm9+/T6
         PWMQt4d5XCrk3l6SeFGW196xGqLabwLkCupUdMn5ybDoW2Mbx30gMqAAHxPG3b06ucMe
         I1br5bpEnDM8C9vt8opOWDmVX6kFUbMVdpwvGN5WY0WJMiT3VGMbRQWylB/zqaDv7LBS
         i2JpAo2U5KQ4p7xDshNpkPg41t3wPESf8mY8JZelYpt0QdIf4l6PVL5bPprnl+2yTIxf
         9F/hm+dAsTsS89b/oTb7UPuzNwkZ+bY3p/GkX2IjV9NqnfXKAFpe2rDlMPepOpYz36M0
         /F/Q==
X-Received: by 10.68.242.42 with SMTP id wn10mr10976905pbc.77.1441390683208;
        Fri, 04 Sep 2015 11:18:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id ea13sm3277865pac.30.2015.09.04.11.18.02
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 11:18:02 -0700 (PDT)
In-Reply-To: <20150904125448.GA25501@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 4 Sep 2015 08:54:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277327>

Jeff King <peff@peff.net> writes:

> It shouldn't be necessary for $GIT_DIR, but it makes sense for other git
> variables. E.g., with "AcceptEnv GIT_*", "git -c" config is propagated.
> E.g.:
> ...

Just to make sure I got you correctly, you are saying that "we
propagate, but that is not correct. We should stop doing so", right?
