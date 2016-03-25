From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Fri, 25 Mar 2016 20:33:06 +0530
Message-ID: <CAFZEwPO+iMCkMiz9ByzHm3XX7DkvSqbkpHLS+KBhyNHpE2NVJA@mail.gmail.com>
References: <20160317014310.GA12830@sigill.intra.peff.net>
	<1458386735-8038-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPNK+XTjXzjn-Pv3iP4XiajXrdhUHWLz-8c0Ssy_Edkd7A@mail.gmail.com>
	<20160325155805.Horde.IaS9Rdqv5fu6BmOZCj5ulLW@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 16:17:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajTGr-0005g5-BM
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 16:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbcCYPDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 11:03:09 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33797 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbcCYPDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 11:03:08 -0400
Received: by mail-yw0-f196.google.com with SMTP id f6so9002191ywa.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=S1Lp695QcopKUV2R/zsVYqTEYr6UYoOCGiFHR9SiLW4=;
        b=kqWWW+I/sBND/ql6Ic6I9u/FsBtFUgSJZhYAM4TW/VtkspfIvMw5Uj9EbtZhlUggdz
         1XSf8bp87N8TqHc+4rXMwou+gyyl/TQD9ZYRRR/0qw3hTlNMlbz6DiTU6VLdGWE7v/E2
         XgJrGDAB8U74xjOe4De3zfEr7BcSDBfrfQgArNdLV92bV2V/bni3KY85j5BvFPEufbng
         TP+b7GAFtsFCGeisnl6wqz8NJKf6NjQqW7nHdV93QL7sJ06ezSNwwyLNmDiElHvng7OP
         rbCUC7/mcsvnjTLstRLB3BumhyEuGEDndP8e9ElE4cn3VcXOeF+ry5C8yLraS9t9APZ5
         gOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=S1Lp695QcopKUV2R/zsVYqTEYr6UYoOCGiFHR9SiLW4=;
        b=Xxr70QzZJBvceFx9mKgsctL0n3DRa1p9y2TTa3iyfLh+wKn3efaDPHGQzmLntLO+V+
         A2K5XV7+ykHFYs9Eu+cSGVtvrsDqBOFIgxaJ61J76KCg+TDl8QNxI7j3cJqX8gvg/B3L
         pNRcW9sNH019Q7/Bbp5h4gPWngCRKD4gKUvF/MrFB9wMtdzOq55ukwwPhIqJn9yRIgH2
         LEq8B8unRyce4s5yAaBaAbX5r6/2WhF3w+qXfIHUq//bf0s06OroJwhhSF2ONW/W9pV+
         Tjeua5xGBJpGuMkz7GS90r+FU8/34uapfHhvR6XY5Xqr2ZlCOEIzuP1gilGzZ9/VfAiL
         LHsQ==
X-Gm-Message-State: AD7BkJJw96MWFY/AQ/4R6wQi02vt9gAi/wIGwRHR75VnXTvqBYAdW7Nea84TN4pC+yCDQ1OYdlv1ql6i81ATrg==
X-Received: by 10.129.37.3 with SMTP id l3mr7438065ywl.128.1458918186633; Fri,
 25 Mar 2016 08:03:06 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Fri, 25 Mar 2016 08:03:06 -0700 (PDT)
In-Reply-To: <20160325155805.Horde.IaS9Rdqv5fu6BmOZCj5ulLW@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289896>

> Deprecating doesn't mean "removing".  It merely means that we add a note
> to the documentation stating that the option in question is deprecated,
> but we will keep supporting it for several years and releases to come.

Okay. Didn't know.

> This means that '--verbose' and '--show-diff' must coexist for quite a
> while, and 'git commit' should do the right thing even if both old and
> new options are combined.  And, of course, in combination with the new
> config variable(s).  I suspect that all this would be more than a half
> an hour job.

Now that I think of it again, I underestimated this. It will take a
lot more time and create a lot of confusion on my side.
