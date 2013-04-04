From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 4 Apr 2013 11:40:32 -0700
Message-ID: <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:41:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNp5s-0000KX-UH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761944Ab3DDSkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:40:33 -0400
Received: from mail-vb0-f53.google.com ([209.85.212.53]:39427 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761691Ab3DDSkd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:40:33 -0400
Received: by mail-vb0-f53.google.com with SMTP id i3so1551176vbh.12
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=diSKP78hT6efCfkbuOLFcK9s1T9M4SufYkZytk5TapM=;
        b=nzdH6tMtOZLlnwfB+p1E9+guz3ko4786nm8qG7e6x7OvfTx2BW75RNGeuufOZy+n8j
         fFgJAzvZxjlujLJDbqA0E2quzcEta4SDH8LrqpLIo6NMVxObMlGEBc38QiLkPv+zwD6J
         ZyLdZHhFwJwBb8jpa/O1fxBHxxoeWFvCVbzLTrQgHvTQhLkjYHzF4u/IcCm/JHqDQFgB
         uCAHyU1TRcFbgiS49VHOPUBX2PFxm/YvN6yFFB2bqaVaYD7hGhdlrHX6hx8biX+cq9Cv
         xbaPzYDMirWhy6YHA3ZlDpvXt1CWZPYkWfnGXZIGexrBJuefebOwkW9leUFh3B2OHbFZ
         2NRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=diSKP78hT6efCfkbuOLFcK9s1T9M4SufYkZytk5TapM=;
        b=GFeOLUAaPjhX2AD/jojA/oK5yDhqY4kyaxUw8C5eAr5iRofHcrVHBPDj8ScDC6rNHM
         78C9PeNNMaqoGMLQGc/Zc9UzbP5KYSpoZJQNgHtMKo/j94K71bj2WZRQ6OesF4AwzEh8
         CHVww1iLdUOt2jtfsiUtKWfSRCscOfwZejm0s=
X-Received: by 10.52.233.225 with SMTP id tz1mr4991061vdc.54.1365100832286;
 Thu, 04 Apr 2013 11:40:32 -0700 (PDT)
Received: by 10.220.236.130 with HTTP; Thu, 4 Apr 2013 11:40:32 -0700 (PDT)
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: KpRL2F56i9w_1s988cBG5Iq_hoI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220057>

On Thu, Apr 4, 2013 at 11:30 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>
> The purpose of this series is to convince you that we've made a lot of
> fundamental mistakes while designing submodules, and that we should
> fix them now.  [1/7] argues for a new object type, and this is the
> core of the idea.

I don't dispute that a new link object might be a good idea, but
there's no explanation of the actual format of this thing anywhere,
and what the real advantages would be. A clearer "this is the design,
this is the format of the link object, and this is what it buys us"
would be a good idea. Also, one of the arguments against using link
objects originally was that the format wasn't stable, and in
particular the address of the actual submodule repository might differ
for different people. So when adding a new object type, explaining
*why* the format of such an object is globally stable (since it will
be part of the SHA1 of the object) is a big deal.

            Linus
