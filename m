From: Tony Luck <tony.luck@intel.com>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 11:46:38 -0700
Message-ID: <CA+8MBbJNZdkpOhA5Kke0VqUA9qCFdzfEP5cWPTMF3eUfDsGRiQ@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
	<20110714183710.GA26820@sigill.intra.peff.net>
	<CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
	<20110714190844.GA26918@sigill.intra.peff.net>
	<CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
	<20110714200144.GE26918@sigill.intra.peff.net>
	<69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
	<20110714203141.GA28548@sigill.intra.peff.net>
	<CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
	<20110715074656.GA31301@sigill.intra.peff.net>
	<CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
	<CAJo=hJtuxNLhSjn_sDJxG7xu5k2wbJ_QLf_n+Z1E=o2AndAuJQ@mail.gmail.com>
	<CA+55aFw_XjWm+4XwsN6CRJnsrcEu5YEChOHSHN51UUBN6PynWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 20:46:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhnPQ-0004qs-Gf
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 20:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab1GOSqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 14:46:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51904 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab1GOSqj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 14:46:39 -0400
Received: by vws1 with SMTP id 1so1066556vws.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=952fPHuJ9ytC+CsyK2NVA4s/MXLRHqPAYclC73qzriE=;
        b=Z+wem3iN+4CWeH+KT79drU9OpK1sXzVC9amByc1fXfjQZ18j3S6OA0OxVWEDAb85RS
         1T0eVnGuavtBXUApgwzY39F+mndkM/T1G5QCsARe5tg+FtXZ/tpf9cwYGcZt3N6SwLL/
         t/LLs/jYsMeT2qfgY8GUywXVrsubbnkstA8gk=
Received: by 10.52.24.74 with SMTP id s10mr4477510vdf.111.1310755598569; Fri,
 15 Jul 2011 11:46:38 -0700 (PDT)
Received: by 10.220.159.75 with HTTP; Fri, 15 Jul 2011 11:46:38 -0700 (PDT)
In-Reply-To: <CA+55aFw_XjWm+4XwsN6CRJnsrcEu5YEChOHSHN51UUBN6PynWw@mail.gmail.com>
X-Google-Sender-Auth: isAX3nqp_J-Qy6KRG2eOH5iYWfo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177209>

On Fri, Jul 15, 2011 at 9:44 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Btw, I do agree that we probably should add a warning for the case
> ("your clock is wrong - your commit date is before the commit date of
> your parents") and maybe require the use of "-f" or something to
> override it. That would certainly be a good thing quite independently
> of anything else. So regardless of generation counts, it's probably
> worth it.

What if my clock is wrong in the opposite direction - set to some time
out in 2025.
It would pass the check you propose and let the commit go in - but would
cause problems for everyone if that tree was pulled into upstream.

You'd also want a check in pull(merge) that none of the commits being
added were in the future (as defined by the time on your machine).

-Tony
