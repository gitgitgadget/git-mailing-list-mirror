From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sat, 2 Feb 2008 18:59:05 +0100
Message-ID: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com>
References: <1201948579-11807-1-git-send-email-hjemli@gmail.com>
	 <alpine.LSU.1.00.0802021550130.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 02 18:59:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLMeZ-0003st-8z
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 18:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbYBBR7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 12:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbYBBR7J
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 12:59:09 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:53508 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbYBBR7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 12:59:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1611254wah.23
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TirZOKtBqP0QqVBGsu2HWlUBYrStpKqrpdcks0E0Oz4=;
        b=xRXGQ3X+58BRky2gBOy90EMfz2Sg9EFvq2ufz57ZZEUG9FHVXM4dXwKZesTet3L97roFm4MHFqJSbFu7M1h/GYvOWuk4hOPwQL9zksf6h3pXJ4w0xkNhv9t0g2SfVP8DTr0ILNo+TbR8XLys9YoKl8X/ws3KDAq0h/kB/nCHH3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VV6K6x1wfCcb5+1Kir4qWfG9/xAUp1GoNdYBgI3Kc2LY+rwOesWA7a4eRNvUeLudJ/uzEIrymFjLJ70C/ZzjW0h9lUYAcb0FugKz8jYpDBAK3A5dgEC04aZEzmefHDdNVBuRyy7UnOw9snszSlsaDHNYctK/ghh3eZRrbFR9uAg=
Received: by 10.114.169.2 with SMTP id r2mr5306555wae.76.1201975145757;
        Sat, 02 Feb 2008 09:59:05 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Sat, 2 Feb 2008 09:59:05 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802021550130.7372@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72292>

On Feb 2, 2008 4:56 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 2 Feb 2008, Lars Hjemli wrote:
>
> > +static const char *read_gitfile_gently(const char *path)
> > +{
> > +     static char buf[PATH_MAX + 10];  /* "GITDIR: " + "\n" + "\0" */
>
> Why say "GITDIR:"?  Do you want to be able to set other things there, too,
> like GITWORKDIR?

Not ATM, but it might become useful to specify some other bits of
configuration in this file (especially if one uses multiple workdirs).

Your other comments also made perfect sense so I'll send a reworked patch.

--
larsh
