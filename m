From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 14:35:07 -0500
Message-ID: <20120525193507.GA5184@burratino>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
 <7v4nr4t9gc.fsf@alter.siamese.dyndns.org>
 <20120525182558.GC4491@burratino>
 <7vsjeortwu.fsf@alter.siamese.dyndns.org>
 <20120525184408.GA4740@burratino>
 <7vobpcrstn.fsf@alter.siamese.dyndns.org>
 <20120525191701.GA4944@burratino>
 <vpqvcjknjo0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 25 21:35:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY0Ik-0006Dv-W6
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 21:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab2EYTfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 15:35:16 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:42850 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab2EYTfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 15:35:15 -0400
Received: by ghrr11 with SMTP id r11so657132ghr.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 12:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5M+LROjLlr0ArMq+vJ87kLXabCs651n6It6yQo4Oij0=;
        b=zQqTH0/I7JLYDzI9nwt/mwdQONAxjRoYSS1uWpHge+iIggs3DalhcoVqNOc6WGuMvP
         iifloME6OKKjaG37dZPic9A1y5wVXBAxmrzPdLTuNtkx0QveYnxgIsBMWAA4FwW4ibLT
         pOKRrj7Fooxps1+M3otvkmIf6V2cc4YTiMhoLIUCwgEYwYqPhUMzn7VJ6TP/fS3I8l/9
         XV2kX/d0G+LUcOn7dHlDV8RUwAI/yh95DMLzvzb5NjntOOmG35svIgRMfBEvwNYAyvXg
         dUHWzvc9DXt5onPvEhsEYF6O9+bbP5/Hmnf5zCdV7LJ1MrrbYnhqFXa01IVGUvyOjr8q
         aGMQ==
Received: by 10.50.212.37 with SMTP id nh5mr80410igc.63.1337974514445;
        Fri, 25 May 2012 12:35:14 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b11sm8292290igq.7.2012.05.25.12.35.13
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 12:35:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqvcjknjo0.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198513>

Matthieu Moy wrote:

> That's another good thing with XDG (~/.config Vs ~/.cache/ for example),
> but I don't think Git would have anything user-wide that would not be
> configuration.

Of course, but your home directory that you read with "ls -A" does.
Putting configuration in ~/.config makes it easier to find amid all
that noise.

That said, as Junio wrote before[1]:

> It is not _too_ bad to treat ~/.gitconfig specially and support reading
> from ~/.$SOMEGITTTYNAME/{excludes,attributes} files.

That's what vim does --- its main configuration file is ~/.vimrc, and
there are also some supporting files in ~/.config/vim/.

Wouldn't that be a good place to start?

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/133343/focus=135921
