From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: Sharing home and etc files with git
Date: Thu, 5 Jun 2008 15:48:17 -0700
Message-ID: <94ccbe710806051548x485aefe8j2ad6b40b74d68747@mail.gmail.com>
References: <48484607.5090505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: iiijjjiii <iiijjjiii@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 00:49:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4OGd-0002wN-H7
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 00:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbYFEWsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 18:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbYFEWsT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 18:48:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:8118 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbYFEWsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 18:48:18 -0400
Received: by wa-out-1112.google.com with SMTP id j37so535536waf.23
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=kOrH+6pcoyTtfYggqZ8CWWCxgKNrW4q0nEALFGFuNN8=;
        b=uQHkwxuX1J3XLya7HO/tWzMTmZUDJx9jteXjJC0SDYwAXeeYJCKZBJalwABq++ZfuK
         kd/a0BpgM6DWj8OrZiEx1rbF3DcHKbYAHkONid7eTtqwDo55sPukgc7DxyVaTuKsfoUO
         I5kECRtCDlBSZcLL9mzYC4p6k10X8jjlBrfJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ApANn05VGmysJ+AlScqfAJnVHgc03F068G2K9WNWsBzT2vVy+G0aNblYGKU/MEnvK6
         pJbYPLE567DNi+x5OyxLmM95eU7HnoL2XvgiAZnMod8jeBms3FGzpe4hulCKG/t/xPsO
         HS3e7RpimGCdpvQNTInsCeXu2X2HumWisNrZ0=
Received: by 10.115.49.11 with SMTP id b11mr2305526wak.117.1212706097981;
        Thu, 05 Jun 2008 15:48:17 -0700 (PDT)
Received: by 10.114.148.17 with HTTP; Thu, 5 Jun 2008 15:48:17 -0700 (PDT)
In-Reply-To: <48484607.5090505@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: cc8f6857bbcc1594
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83990>

On 6/5/08, iiijjjiii <iiijjjiii@gmail.com> wrote:
> I would like to use git to keep revision histories of my home and etc
> directories. I have several computers and I like to keep their environments
> similar. I could see git pulls updating .bash_aliases, .bashrc, and various
> bash and perl scripts I create in the home directory, and updating /etc
> config files. Git pushes would share any recent changes to other computers.
> This way no matter which computer I am working on, the environment will be
> similar and I can make changes and know they will be copied to the others.
>

Completely understandable; also remember that pushing, unlike pulling, does not
update the working tree (and you wouldn't want it to).

>  I haven't figured out a good way to deal with the files that have local
> settings in them. Using .gitignore feels a little overkill. Only certain
> lines of the files need to be unique. Once they are set, I'd like subsequent
> changes to be updated. I could cherry-pick manually but I'd like a more
> automated method. I have read about etckeeper, git-home-history and gibak,
> but they seem to be designed for backing up and versioning files on one
> computer and not for sharing files.
>
>  Has anyone done something similar using git or is another tool more
> suitable.
>

I'm fairly certain there are tools out there for this, but what I do is I have
all of the files that I want to add (such as ~/.${SHELL}rc, ~/.${SHELL}.d/*,
and .emacs) into ~/.git-home; then I symlink all of these files/directories
into my $HOME (with a short script that's also checked in).

I then throw this entire repo somewhere where all my other machines can
pull/push from, and I resolve merges as needed.  It works fairly well.

-- 
Kelvie Wong
