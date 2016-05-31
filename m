From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Tue, 31 May 2016 16:19:39 -0400
Message-ID: <CAPig+cTycj-N3FtkvRzWbm+UdYtQWBb6BCZH-798VLi+jOxy_Q@mail.gmail.com>
References: <20160530232142.21098-1-e@80x24.org>
	<20160530232142.21098-2-e@80x24.org>
	<CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
	<20160531074506.GA8911@dcvr.yhbt.net>
	<CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
	<20160531182932.GA27021@dcvr.yhbt.net>
	<CAPig+cSrqs7W2hSz6Z4_O9U52gUJFCqTSfRL0E0b=d=bO9RCEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Tue May 31 22:19:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7q8f-0007JH-Jv
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 22:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbcEaUTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 16:19:41 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35525 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbcEaUTk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 16:19:40 -0400
Received: by mail-io0-f193.google.com with SMTP id k19so286209ioi.2
        for <git@vger.kernel.org>; Tue, 31 May 2016 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=yOXUQ5m/fvxXt/j4OFSyS6IRFRtiRP1vp38lCYuK10c=;
        b=gxo7xJG6gpOTllMLJ2UTNk2rlAE1IbOwkjca3pS637Z6t6CW2vo8BX1VV4U5J89AJl
         UbN5zfDscnRsDyDAERRVgh/MF6tmTsvQUXNFOZ9ac19cnXoQA+1Y3xHM9TvjozezHnms
         lblmb5xVR6BehWk63rD+INm6t1aBC/BT9bszrpbhThtk7whFsh9yX/HWMXGopg2C2iAa
         mE6fAQcJQMchMyK8T3u2E/DdMvhcoeBjR5qOMOR4UMZWWUf/+khh6lTqQOjhmg0+NE1j
         vacxDeWh+63zZaLJKoNYzJNvZbpW58QC4Euo3x4Cnzawcdwr9OohH8uzlrXIMqjJLmaH
         9J5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=yOXUQ5m/fvxXt/j4OFSyS6IRFRtiRP1vp38lCYuK10c=;
        b=HyOFEHiWX1cjWjTqTq14n1VhBPc5a/2NinnCR7+815RQsKBmirXpbHOiQzooLGWiQf
         EvkZyyJ6mR62uDtG+RooCulqIyv4ghLe+2ORNESaYzpyuIYcV17GZJVGqZkS2VG7JVsI
         O5mYzFHeMH5TealXbcuI93KbQ1/ZfdrPpPPu+jnqEsMOeEVx+j23DqiekG4qYFk75WRE
         EkiD+Jmar1R2D/K4Yj04+kSg4I6lz8ztuHYFXKOkrX+uSNw5DZIw2j3RinD+rcxGChV0
         jEBlMlCRQR0eNRUvbZOE3XQJK6fBLqIy9+jJzSnU+RGdcfqGz1orz8PDZWUnBizVve6u
         IZww==
X-Gm-Message-State: ALyK8tInicvSUgkoB3/ANjvXFttnr0oycwPMqckJHifpRvLsdy+M+36iVmUGI+qOYbDyy2HqlOdstBpOLJQMpw==
X-Received: by 10.107.132.40 with SMTP id g40mr603343iod.34.1464725979996;
 Tue, 31 May 2016 13:19:39 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Tue, 31 May 2016 13:19:39 -0700 (PDT)
In-Reply-To: <CAPig+cSrqs7W2hSz6Z4_O9U52gUJFCqTSfRL0E0b=d=bO9RCEQ@mail.gmail.com>
X-Google-Sender-Auth: VLkrHIUh8Rnkjk0ziO9DByGOARg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296012>

On Tue, May 31, 2016 at 4:12 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On reflection, even with the '^' anchor, it isn't safe the way it's
> coded since '^' will match following a newline, won't it? Therefore,
> because 'line' isn't necessarily NUL-terminated, the pattern could
> match on some line beyond what get_one_line() considers the "current
> line".

I guess that behavior only kicks in if you specify REG_NEWLINE, which
you didn't.

> This makes the hand-coded is_mboxrd_from() even more attractive; plus
> you can re-use it in patch 2.
