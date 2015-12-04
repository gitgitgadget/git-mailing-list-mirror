From: Stefan Beller <sbeller@google.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Fri, 4 Dec 2015 13:50:25 -0800
Message-ID: <CAGZ79kZMNuiiH=8zu4pJXazW8MNYCu_59MBh7iX0f0ws3dfsYA@mail.gmail.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
	<CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
	<20151204212712.GA22493@sigill.intra.peff.net>
	<CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jason Paller-Rzepka <jasonpr@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:50:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4yFP-0007A5-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696AbbLDVu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:50:28 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35161 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070AbbLDVuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:50:25 -0500
Received: by ykba77 with SMTP id a77so139745015ykb.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 13:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kDLp/70U34F6S93kSidsnL0MykBue11MtOH8AFgre3k=;
        b=BujGwBAU6P4NLhs8k36A6b7cCKIy0GWXl8g5aeoI0nMf76Elr+40Wilm8dHWv476Z7
         T3c+4eYPd/fDi1LDP6SFlQjW6r5tpTO2Uej5LhKtDQ4Q4v+k+0aax07MSL20Phdx8CHx
         M9AEDaGNetruIyp1LY3sOaUv8VpgtW5o8rJA0fa8ziDv/P5x8lTIUxxPtW/TUn0P6x0e
         4hE/GWX7ePi2NzcPvntD6DGIOWwn52aJR44DrDRLluQSTttYqnKtc4vj2jNrbskpZvR3
         /SJkfiCKbmzkHang5Oi5wxt5tBj+1ckQBjbUObN4W2/0oQQPQojr3LI1eiqKye7YhpsW
         HEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kDLp/70U34F6S93kSidsnL0MykBue11MtOH8AFgre3k=;
        b=J8/SwxfxfduE+hl1Zq0d8BV1ihWOioBXflI+eC3G56rmCGruoQevn/6lvtVKbNj3yE
         FRc8U7hbi1v34UNNSV3YULa0+WeGUXHER/xEX72OlkBGo5U/Ja8SQFZ14Gh6JEudYOM2
         C6t8LEWeXjVNbvD/swkfRd2lOMcUgzIbje/ZBN3uwdwqBp+eqf35iIizJXl7hPVuGTxB
         a6P93FyphLz+6hJdHEzloDzgFl1t+QTOAb8VXjB3BceX8qgnkZ8qdvMcIoPCGaSv5ytg
         6cQosWaqN9X95xsTe/4uLdoNf6LTkulppPfaiIb+vsPUJGapqQteC6MjvO/Rj1iLLCrJ
         e9iw==
X-Gm-Message-State: ALoCoQnJFRatUzaHnekcqz6YbshNmySSxTdT5q5xLIlzluI4fTO7UgT2xebr0RTQQv7D4Tio9oAc
X-Received: by 10.13.251.2 with SMTP id l2mr13360041ywf.44.1449265825161; Fri,
 04 Dec 2015 13:50:25 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Fri, 4 Dec 2015 13:50:25 -0800 (PST)
In-Reply-To: <CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282010>

I can reproduce it now. Instead of using my $random version, I just
needed origin/master
to reproduce.

The second fetch is invoked via
(as outputted via GIT_TRACE=1 git -C git fetch --depth=8)

13:44:56.863841 run-command.c:343       trace: run_command:
'fetch-pack' '--stateless-rpc' '--stdin' '--lock-pack' '--thin'
'https://github.com/git/git/'

so it seems like there is no explicit depth given, so I think the 0
comes from the initialization step and nobody touched it to fill with
meaningful values.
