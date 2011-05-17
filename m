From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] compat/regex/regexec.c: Fix some sparse warnings
Date: Wed, 18 May 2011 00:52:40 +0200
Message-ID: <BANLkTimQ9N3kYP+fWj+ifnav67fBYo1-oA@mail.gmail.com>
References: <4DD2B304.90305@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed May 18 00:52:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMT8A-0004VR-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 00:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487Ab1EQWwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 18:52:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38474 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464Ab1EQWwl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 18:52:41 -0400
Received: by fxm17 with SMTP id 17so797831fxm.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8scdrMtJEvCXfsPno7pnqyVXl0mJz4jtS/XTF297yJw=;
        b=VXjicZ7god0hNcYPuhYCM9VWm83wKyQeGAFZp2Eciwcj566LXFL/5mvI+PZ4iFx4qu
         JzQWV+PkTeLDzd5WRLfI/+OR539gKfBv1yWUcqfeRaFQnZ4Z+AN57+5oElSfHGet+3gV
         L5+XtPgfQw3MgF2oHyJ+e3Qr6wVNkAag+NSTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UYKNep9lD4yqfDiSxQQw6tQORvH+wI3YVhAem209Lp8nxvHciO46wyLxJTmSySQN98
         YH3mrvBJ5bqHmATdluzSycJL5QfvkU7W+gA/hRfLc4dHPyI6buapCm0OLkXY7AJd5b8a
         iHG/t660mc7qg3TW6uqAY+xoN2Df1nfDwVKTQ=
Received: by 10.223.59.81 with SMTP id k17mr1479121fah.94.1305672760194; Tue,
 17 May 2011 15:52:40 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Tue, 17 May 2011 15:52:40 -0700 (PDT)
In-Reply-To: <4DD2B304.90305@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173830>

On Tue, May 17, 2011 at 19:40, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> In particular, sparse issues the following warnings:

Aside from this specific change, I think it's a problem that we pull
in external libraries, then apply patches to them that upstream would
probably want, don't tell upstream, and will inevitably have to deal
with conflict when we merge in new versions from upstream.

Maybe we should have some file with contact details for these compat
libraries, and try to resolve issues with upstream if we need to apply
patches like this one?
