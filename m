From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 1/5] Add platform-independent .git "symlink"
Date: Sun, 17 Feb 2008 23:37:20 +0100
Message-ID: <8c5c35580802171437x5c952c32we38f9a62288d6c84@mail.gmail.com>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
	 <1203286456-26033-2-git-send-email-hjemli@gmail.com>
	 <alpine.LSU.1.00.0802172224550.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 23:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQs8z-0001Zo-3L
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbYBQWhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319AbYBQWhW
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:37:22 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:47054 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbYBQWhU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:37:20 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2450146wah.23
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 14:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=81q6XXHFr4JfbGw4WzXVdPgBO7sPc4vxPxX4Y6UUm0Q=;
        b=TtaSlvdrRJf1RuVL7K4FOG9K1chzLsNeyGK/RL5O6pdFE/r5NL+n+BBOQZHnasZQixGKc+oEwreEe2s1/kWw8PUA3tLz9NFZuyAg5mnDLTIDwxkyIJ8mV8YUoQR19FM8xz3Nc6r4snVZbc3CbO1SoWrRRNqOoMLlD2FkOylVhxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=POO3lU1/a0iavT25XDu+jWClwAd0UG6lDhqez8LnMrAtZZgunyTnDSqgBEa5HoXiRuIjEOezxe3mF/KOX6pqV5YLYlf+rXHNF7q3gaFDKJPCPBb08FegHEeRhS6jlJNPm1lJ878vRsGr9P7Zu9T+NpleXXSros5pJ3P5bVXhoEM=
Received: by 10.115.90.1 with SMTP id s1mr2431388wal.50.1203287840488;
        Sun, 17 Feb 2008 14:37:20 -0800 (PST)
Received: by 10.115.92.8 with HTTP; Sun, 17 Feb 2008 14:37:20 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802172224550.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74201>

On Feb 17, 2008 11:25 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 17 Feb 2008, Lars Hjemli wrote:
>
> > @@ -302,6 +305,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >        */
> >       offset = len = strlen(cwd);
> >       for (;;) {
> > +             gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> > +             if (gitfile_dir && is_git_directory(gitfile_dir)) {
> > +                     if (set_git_dir(gitfile_dir))
> > +                             return NULL;
>
> Should this not complain loudly?  Really loudly, as in die()?

Yes, I'll resend. Thanks.

--
larsh
