From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 15:04:03 +1000
Message-ID: <BANLkTi=-RYfUrPt+LkUA9GA6_vmTzVkQnQ@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com>
	<BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
	<4DB84D65.6070906@gmail.com>
	<BANLkTimyFmujc+Lsd7DMWfJgUzZME+Sveg@mail.gmail.com>
	<BANLkTi=vJeUAwMH0Fa7SXmK=2hwu8vnPGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 07:04:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFJOr-0005wr-6g
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 07:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab1D1FEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 01:04:07 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48794 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab1D1FEG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 01:04:06 -0400
Received: by ewy4 with SMTP id 4so712821ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 22:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=vKKrcbmeAqHli0BIAv69UuTWc8iZUsZR1x4TWWfJd5c=;
        b=hiFtCBGlFflV67/cCTASbMEKjz/ub+5As/0cfA3TUre4A9QwbD4xa9VHV+p7BskX3Y
         TDve+2rJRej5JST2rLKx8jYdtOU5HAIW+2liHfJOhDO8v4itdiMxvQnZS+ircZ7NmRL7
         I8V6Kyt6wzf89Kn+IFyqv2GKLxhJ2vqyShTWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=OcQynuOnMX9jp23raPREmxjPoIpMRaOf094LGRqDQF9ffFPOZjqhGdyKylyzzrTelj
         L8KzfTAjSRy/5xE09uK2V1t3OqNrWk8JyHZ23lp3+Zz+Yvhq90Eygb2fkpcVBF00u8sf
         WVeMI43zgXacBoPQtt6ReI4kPatea8zpBmUn0=
Received: by 10.14.32.13 with SMTP id n13mr1410346eea.21.1303967043435; Wed,
 27 Apr 2011 22:04:03 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 22:04:03 -0700 (PDT)
In-Reply-To: <BANLkTi=vJeUAwMH0Fa7SXmK=2hwu8vnPGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172316>

The concept of a division of responsibilities between 3 roles seems to
be misunderstood.

There are 3 roles:

   application, plugin and package.

The application provides the plugin manager.
The disribution provides the package manager.
The package manager packages the plugin as a OS-specific package.
The package manager installs the package, containing the plugin.
The package manager calls the application's plugin manager to activate
the plugin

Optionally, the application delegates plugin installation request to
one or more package managers.

Simple, isn't it?

Ruby (and to be honest, npm) got it wrong because they have a plugin
manager that wants to be a package manager.


jon.
