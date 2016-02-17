From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] Turn git-rebase--*.sh to external helpers
Date: Wed, 17 Feb 2016 21:40:32 +0700
Message-ID: <CACsJy8AAhpKbRi7QznwqAQ+uBb1SuFJCCh=cSw58oeuV1n_90g@mail.gmail.com>
References: <vpqio1nsk0q.fsf@anie.imag.fr> <1455716201-29784-1-git-send-email-pclouds@gmail.com>
 <alpine.DEB.2.20.1602171513140.6516@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 17 15:41:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW3Hy-0008U0-4s
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 15:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423552AbcBQOlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 09:41:05 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34270 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965322AbcBQOlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 09:41:03 -0500
Received: by mail-lf0-f49.google.com with SMTP id j78so12172622lfb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 06:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UwRwvOAo4TpKatCwxX3dWPUub7wrJPhEkB9/5aNp0d4=;
        b=EV+XAaI69CsyARHzdzXl4c82WzDcuab82sIrLqEl26qSTu4tbmUthE46KwRC33yvnW
         65cN5UywOtdqBwqS+lRwov8lW1TRiE9cm8vP9Wpqe4m4439H0oTM4WMZi7h4IC/9kZXa
         Es8rmr7pBFmzpR+2lPGo0tyNM0EXczkmb3JGdDRID3pcrM96DaHGm82Sb+ZjIA2w/QIR
         bHl1Y/fD6NBCRUkMDfA2bpo5qIJEbSMX4LfeLNEa9clue3DkHyBDmyhoRJTWO2YXMHiS
         a6KWMTauzSq68WJj9fc7qt+POjuEdHTxS9oV4smQuvDHA90AOe2VwUnIX2BpPuO7ioH3
         CrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=UwRwvOAo4TpKatCwxX3dWPUub7wrJPhEkB9/5aNp0d4=;
        b=OhXILhRIPdnnJRe4bNvfCCfWDA5X+l6es3XgW/7x88gXILSU+u16T1yrm46lGdbN1D
         myYsl5snsxVBMUrZcEN6hZlC+fgHaDXlgqZnZpLLRjV8XuMH6J6YECKij+5OeyyON1jO
         7Up0I45xa/mkd7qEnAmiVhUg7mVcmZyviKETywTLp2lzjGeEYKqF7561spQT7zgE8/Nm
         1yg47l09gDAXmseoxMClOftrsi0tldNBvcxeVcFhhdVa3tKGhJ2LuukdmUGgHJW6JrSO
         EdtrfwLTqQgU/xrP4ykYtbtjOv9rnZqVT+yOnXwtzCTCYnfhvzQxqamtFksQT7CKii+F
         oy/Q==
X-Gm-Message-State: AG10YOQJtcKb9YL6Z2olRIzsqsumN5zZ4ydLmifs0bhJGyyRPRJ5gdjoUTiuP99oYB8q0tkSzQr01sPVWvM5YQ==
X-Received: by 10.25.159.68 with SMTP id i65mr943377lfe.94.1455720061957; Wed,
 17 Feb 2016 06:41:01 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 17 Feb 2016 06:40:32 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602171513140.6516@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286507>

On Wed, Feb 17, 2016 at 9:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I already started a different route locally (nothing to show yet, mostly
> because I have to write emails and try to triage the bug tracker instead
> of doing real work *grmbl*): add a rebase--helper and off-load heavy-duty
> work from the scripts to that helper.
>
> There are major benefits to do it that way:
>
> - we can focus on the really rewarding parts first, i.e. the parts that
>   make the interactive rebase so painfully slow,
>
> - it allows for a painlessly incremental conversion,
>
> - if multiple people are interested in working on the conversion, it can
>   happen in parallel.
>
> And probably a few other upsides.

Now it does sound fun (and probably feel rewarding too), even to GSoC students!
-- 
Duy
