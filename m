From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 00/31] refactor rebase
Date: Wed, 16 Feb 2011 22:41:55 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102162212360.14950@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <4D5BE49D.1040402@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 04:42:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppukp-0000gp-8I
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 04:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394Ab1BQDmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 22:42:01 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62171 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab1BQDmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 22:42:00 -0500
Received: by qyk12 with SMTP id 12so2295415qyk.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 19:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=OEDgNayh2nZIMEnL0JrRpZ9/K7gJ4gpbGXumgZuxfT0=;
        b=ZQM07UqLe/PUtrAQ5VT+RvFoxiUqjMpq2Nek+vYFmfOvb4xTPQ319Bo4iOINIclxQ9
         w9kc7WJD5724S+8GPCgVb+15kqpOZziXm0Q7cBI6iRTuKYgy7VZya76ISEADfxy4V6/S
         TolgtQrvDDL8wY3gwLt1d8yuea4OXPCd3dq3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=BuZglK2ilV8pUAIgUTtggtScYHD6M0NhDAlSAiZ0iPIq17FpEsvAKgjGx7IOPLDSRl
         HsCwJrqDSE+6awyDmWOmMvaKEB5muDN/aKtGpuQ5a/1Ys5fggZ6J3v/H6OOzovP9ZFGz
         VqzSXk6cM8Dw/d6AV+/BoZwezG5m1i+Ku3PjA=
Received: by 10.224.6.75 with SMTP id 11mr1839337qay.333.1297914119137;
        Wed, 16 Feb 2011 19:41:59 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g32sm384554qck.22.2011.02.16.19.41.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 19:41:57 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <4D5BE49D.1040402@viscovery.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167030>

On Wed, 16 Feb 2011, Johannes Sixt wrote:

> There's one annoying regression with this series: It does not accept
> abbreviated options anymore. In particular, 'git rebase --cont' is now an
> error. I use this a lot since I don't have command completion. This used
> to work (only) with interactive rebase.

Sorry about that :-(. That must of course be because I removed the
OPTIONS_SPEC from git-rebase--interactive.sh. Sounds like I should add
it back in git-rebase.sh. Can someone explain what the
OPTIONS_KEEPDASHDASH is for? Should I add that as well?

> And a side note: the error message is -- during a rebase that stopped at
> an 'edit' instruction:
> 
> $ git rebase --cont
> Usage: git rebase [--interactive | -i] [-v] [--force-rebase | -f]
> [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]
> 
> It nowhere mentions --continue, --skip, --abort etc. That's perhaps worth
> fixing.

Makes sense. If others agree, I will add that as well.

/Martin
