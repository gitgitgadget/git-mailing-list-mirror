From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC update] Sequencer: Debating the UI
Date: Tue, 14 Jun 2011 00:31:43 -0500
Message-ID: <20110614053143.GA24882@elie>
References: <BANLkTinxx5qFuhwsUt3JeXOO7TjBj8wFvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 07:32:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWMEJ-0002Fe-3Q
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 07:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605Ab1FNFbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 01:31:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58515 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab1FNFbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 01:31:52 -0400
Received: by iyb14 with SMTP id 14so4413627iyb.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 22:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Jbajsl/QtlRX6JjUvlfFHn/tz+BwwHAkT45fmD+QDe4=;
        b=nTNGuPJnmpGtBMBVKVcd64h0dEAFbOa5Qd5r8l7B4n03N81IRNv5XZav2QF1Lv597/
         BF41JyeEpNIKiH+nxbPD+BLlYmdznLnlOYq0T7ur0ARadsB+9ox00nBY7WZcIknksZm8
         KBBS55Gp+Ot/d4vpaL2h34vFI4wLI0ndfnkng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k7yHiq8FuV3OBjhbhu/PSJDRkVhigop/7/6KdvwNmlphNEzF67xq0/vmU0xBWktro9
         nCTC6eHslmDVTsxuUZYJs2i38z9457XpgMlMlpdYQQ2zMsOJ8IpStn1uwHmCk9gWq2hq
         NEq1K/jmJOun0CcqhdmjjgnRmSlgQ9Z4C6rTY=
Received: by 10.42.149.72 with SMTP id u8mr7176952icv.445.1308029512130;
        Mon, 13 Jun 2011 22:31:52 -0700 (PDT)
Received: from elie (adsl-68-255-110-0.dsl.chcgil.ameritech.net [68.255.110.0])
        by mx.google.com with ESMTPS id d6sm5405984icx.13.2011.06.13.22.31.49
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 22:31:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinxx5qFuhwsUt3JeXOO7TjBj8wFvw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175745>

Ramkumar Ramachandra wrote:

> I might like
> to send a quick series based on my earlier series for inclusion, but I
> can't figure out a good subset:

I would love to use a working "cherry-pick --continue". :)  I would
use it like this:

	$ : grumble, grumble, source package format that requires a
	$ : tarball followed by a linear sequence of patches
	$ git checkout -b release+patches v1.0
	$ git cherry-pick --no-merges -x -s HEAD..origin/master
	... ticks away for a while, then presents a conflict
	$ git diff; fix fix fix; git add -u; make test; git commit -v
	$ git cherry-pick --continue
	...

	$ git diff origin/master; # matches up?  good.
	$ git format-patch -k --patience -o patches v1.0..HEAD

Speaking of which, do you have a git tree that testers should use /
send patches against?  E.g., is the "sequencer" branch at
git://github.com/artagnon/git.git the one to play with?

Thanks; exciting times.

Regards,
Jonathan
