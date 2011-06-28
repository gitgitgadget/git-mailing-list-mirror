From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: [PATCH] progress: use \r as EOL only if isatty(stderr) is true
Date: Tue, 28 Jun 2011 20:55:56 +0200
Message-ID: <20110628185556.GB385@sherwood.local>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 21:10:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbdg7-00075e-L1
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 21:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760857Ab1F1S5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 14:57:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46965 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760694Ab1F1S4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 14:56:04 -0400
Received: by bwd5 with SMTP id 5so424575bwd.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/hLmI8mUTSDbpXTHvGZm8D7PHrFkBoMh3gqJjjh92HU=;
        b=tP27smMPCYRslqp0PoFcRR1cRItTfjt0EDMkWaRZXO1ME8Vv6ASU2Avmanamzyx+xb
         wTMDGHsWjtRTVqSJkiwzq7Fhyg+Hy5tWQc4qCJbGJXe2TdMBHQ7D2qu5ZgilU4c5wNVx
         GeZJtGfFO9eiYuhtB/JiHx6gb6s1H10NHTFhc=
Received: by 10.205.81.76 with SMTP id zx12mr6005098bkb.82.1309287363437;
        Tue, 28 Jun 2011 11:56:03 -0700 (PDT)
Received: from sherwood.local ([82.113.99.172])
        by mx.google.com with ESMTPS id l24sm444506bkw.15.2011.06.28.11.56.01
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 11:56:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176416>

@ Junio C Hamano <gitster@pobox.com> wrote (2011-06-28 20:33+0200):
> [..]
> I thought that we try to disable the progress pretty much
> everywhere when we are not talking to a tty[..]

That is to say, at least some kind of progress_maybe_applicable()
or the like, instead of having things like

    builtin/pack-objects.c: progress = isatty(2);

spread out in the code, and just see what 'git grep -F isatty'
reports ...

--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
