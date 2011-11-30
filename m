From: Tor Arntsen <tor@spacetec.no>
Subject: Re: two branches: keep one difference but merge others forth and back
Date: Wed, 30 Nov 2011 13:37:13 +0100
Message-ID: <CABNEGjwJTBEvTcYPS1+DfJGuASGnaQq3wM=zYshvYXdhmnUEUg@mail.gmail.com>
References: <jats5v$r7c$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 13:37:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVjPd-0006sy-7r
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 13:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab1K3MhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 07:37:16 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55330 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1K3MhO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 07:37:14 -0500
Received: by bkas6 with SMTP id s6so812120bka.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 04:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=y8qjeTRcOin5hpIpjms9QyL7rxF4X6DqbqxWL5NAUxM=;
        b=lNsPdO0fRFaPekX9CmOZoVCoZuxjPL6iyjOH1+WDevd3ugmrE1kK5PgRlO2t044SC9
         QMDgrIHeIrUv2wFfdKxmvs+2CxvHpcYrbGMS7M7yc0goTwMkK37Rl8hUcrMPMjOyJezM
         24kD8maYg2OQQyzYRGMAsxEqY3lHPffH49uhE=
Received: by 10.204.130.90 with SMTP id r26mr2227857bks.46.1322656633437; Wed,
 30 Nov 2011 04:37:13 -0800 (PST)
Received: by 10.223.114.146 with HTTP; Wed, 30 Nov 2011 04:37:13 -0800 (PST)
In-Reply-To: <jats5v$r7c$1@dough.gmane.org>
X-Google-Sender-Auth: bRY9zgSpZ4F2NWftNmxGccR2TAs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186123>

On Sun, Nov 27, 2011 at 18:31, Gelonida N <gelonida@gmail.com> wrote:
> Hi,
>
>
> Is this possible.
>
>
> I'd like to have two branches.
>
> If possible I would be able to merge forth and back between both of them.
>
> However I would like, that certain differences will be kept between both
> branches.
>
> Is there any way to tell git to permanently ignoring certain commits
> from merging?

Instead of merging, you could use rebasing. So you have one
development branch where you do all the changes, and then another
branch where the only commit there is that special difference (as in
your /usr/bin/bash example). From then on you only develop/maintain
the original branch, and then you rebase the 'special' branch on top
of the development branch. Then you get all the updates, plus your
special change applied on top each time.
Likewise, if you have two variants (say, one /bin/bash, another
/usr/bin/bash, and then one with /usr/local/bin/bash) then create two
branches and rebase them on top of the third branch (the development
branch) every time you wish to deploy new updates.

-Tor
