From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFCv4 3/5] 2/2: Add Python support library for CVS remote helper
Date: Mon, 5 Oct 2009 15:31:33 +0200
Message-ID: <fabb9a1e0910050631j73bf7288w65da92806332d051@mail.gmail.com>
References: <1250480161-21933-1-git-send-email-johan@herland.net> 
	<1250480161-21933-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 15:40:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MunnD-0000Z7-FF
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 15:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582AbZJENiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 09:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbZJENiT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 09:38:19 -0400
Received: from mail-ew0-f217.google.com ([209.85.219.217]:43463 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZJENiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 09:38:18 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2009 09:38:18 EDT
Received: by ewy17 with SMTP id 17so2777293ewy.39
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=D686hiO8OXbZ9Hchi6Mi04kmWl+ccx6YIh3WP0/5ciE=;
        b=M6PPzLFf5jkUYeghPu83WBdOMeJcDnHJQUkRp2us4MW9pugUYbRxAPGywlTKoYGEfx
         o58+7KX5m/Kbq4RxRFa38/PNjoKZ1I3DCbwaaTPZPWzzo7gzdC+HpnMq9kJG/FTXyOlG
         YZ19y8tPwcVFcI1Psxu/Xcl3OrziDPIi5NYD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=DarG2Vb77CXi7pR7g38jqVRGRgzZKPH7YwX88XpHPlUlxgmLNOQWvzNLAaYTu79c01
         QyftK6Y8FcnOFm8AWJYvvlcwUWMgNPPqyc1VZZM02DV5PrKwCZWtthjx72tNfIqev0kz
         6mPJItIICxP8jHyvvFGDRCphqOV29jlwc+9nY=
Received: by 10.216.89.14 with SMTP id b14mr1014440wef.76.1254749513182; Mon, 
	05 Oct 2009 06:31:53 -0700 (PDT)
In-Reply-To: <1250480161-21933-4-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129562>

Heya,

On Mon, Aug 17, 2009 at 05:35, Johan Herland <johan@herland.net> wrote:
> This patch introduces the rest of a Python package called "git_remote_cvs"
> containing the building blocks of the CVS remote helper. The CVS remote
> helper itself is NOT part of this patch.

Might I suggest that we pool our efforts and instead create a structure like:

git_remote_helpers/
git_remote_helpers/__init__.py
git_remote_helpers/Makefile
git_remote_helpers/setup.py
git_remote_helpers/util.py
git_remote_helpers/git
git_remote_helpers/git/__init__.py
git_remote_helpers/git/
git_remote_helpers/cvs
git_remote_helpers/cvs/__init__.py
git_remote_helpers/cvs/changeset.py
git_remote_helpers/cvs/commit_states.py
git_remote_helpers/cvs/cvs.py
git_remote_helpers/cvs/revision_map.py
git_remote_helpers/cvs/symbol_cache.py
git_remote_helpers/hg
git_remote_helpers/hg/__init__.py
git_remote_helpers/hg/hg.py
git_remote_helpers/hg/export.py

I'm willing to spend some time to do the needed refactoring, but IIUC
Daniel said that you need to reroll the cvs series anyway?

-- 
Cheers,

Sverre Rabbelier
