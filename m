From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH da/difftool-mergtool-refactor] Makefile: fix permissions
 of mergetools/ checked out with permissive umask
Date: Sun, 9 Oct 2011 06:43:33 -0500
Message-ID: <20111009114333.GA29829@elie.hsd1.il.comcast.net>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
 <1313652227-48545-4-git-send-email-davvid@gmail.com>
 <20111009091617.GA29150@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 13:45:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCrp9-0002tA-KZ
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 13:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1JILns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 07:43:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51389 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab1JILnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 07:43:47 -0400
Received: by iakk32 with SMTP id k32so6270489iak.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dklLZ92uZXi8EufE123/Fridd3sWIyr8ihFNtIdLOzQ=;
        b=Nv5lPl5f/2IWoY6cpYHUZ6MvUocHkpYZkga1MpMV5x6AXHyL5U+Nug9jpdu7XT+oUv
         tnpglePPMy9tZtUbIvleG90/wiENCLYy9ChbI3LEAresUuDtPPOi0TiJQaMw/oZxFDK2
         kmmPFVzf3zFmhWcJq9cjtCg+BWtjWz4gWwBm0=
Received: by 10.42.172.74 with SMTP id m10mr8912369icz.1.1318160626928;
        Sun, 09 Oct 2011 04:43:46 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c22sm11273745ibg.9.2011.10.09.04.43.45
        (version=SSLv3 cipher=OTHER);
        Sun, 09 Oct 2011 04:43:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111009091617.GA29150@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183200>

Jonathan Nieder wrote:

> ---
[...]
> Since debian/rules install is run as root, the default is for tar to
> act as thought --preserve-permissions were passed

I should have said: "when 'make install' is run as root, ...".

Typically people building git for private use would run "make install"
as root when installing to /usr/local, but as an unprivileged user
when installing to $HOME.  The RPM packaging runs "make install"
without special privileges and the Debian packaging runs it as (fake)
root, iirc.

Sorry for the lack of clarity.
