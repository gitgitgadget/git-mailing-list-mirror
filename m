From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 11:15:02 -0500
Message-ID: <30e4a070801110815q1dee8f0cr7966fc2896e4c790@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	 <30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com>
	 <alpine.LSU.1.00.0801111348230.31053@racer.site>
	 <30e4a070801110653n61a826c0y33ed13f95cddf25d@mail.gmail.com>
	 <m3odbsmlkr.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 17:16:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDMXu-0006DU-Ks
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 17:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759256AbYAKQPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 11:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759416AbYAKQPH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 11:15:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:57570 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758287AbYAKQPF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 11:15:05 -0500
Received: by wx-out-0506.google.com with SMTP id h31so738164wxd.4
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TFzsTt5r2eKwvwmyU25MWWOIv09/DylYQwl1lF2su28=;
        b=L0NuF/Q8t+UKzknHr+psHDeoa81sdVXAeRDAGMmdcDa5YZ6vhyb4rWi/EUyVKldts3/5A7akahNMrH0N2Jygo/Ecy3fCEXDPPXw8foywfeZbhs/iBJ+Q+kUvtMbSWC4rJog/LHMsG9Hurdh+5EEPwsk1f8KZGWwxX/Us0VDIf8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C17g4XWWggktBqjJBkYpXZzcDWCf1PnAZddP+1OsC9E+zkSkK8Vkreu6Y5mogIEhRGhyRvttZF2bjhS8hRoCNAE9Po5RvJ6YIVt7s9eVSJwblCgLXUnZ5QHEa3WWp4uy+WwdTsohmXUlSEHZU08j4aZ3vbAgyhlSyXWs3hLRMY4=
Received: by 10.142.237.20 with SMTP id k20mr1738546wfh.227.1200068103026;
        Fri, 11 Jan 2008 08:15:03 -0800 (PST)
Received: by 10.143.159.5 with HTTP; Fri, 11 Jan 2008 08:15:02 -0800 (PST)
In-Reply-To: <m3odbsmlkr.fsf@roke.D-201>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70172>

On Jan 11, 2008 10:25 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> Mark, if this change is mainly about the fact that git doesn't allow
> to specify default remote to fetch for detached HEAD (and submodules
> use detached HEAD), why not provide "branch.HEAD.remote" etc., which
> would be used _only_ if we are on detached HEAD (i.e. branch has no
> name).
>
Practically speaking, this would just change the name of the config
variable (from remotes.default to branch.HEAD.remote). However, this
value is used *whenever* the current branch does not have
corresponding branch.<name>.remote, and that is not restricted to
detached heads, it applies anytime the current HEAD is not a tracking
branch. So, I believe remotes.default better reflects this generality
than does branch.HEAD.remote.

Mark
