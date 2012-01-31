From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix an "variable might be used uninitialized" gcc warning
Date: Tue, 31 Jan 2012 13:43:02 -0600
Message-ID: <20120131194302.GD12443@burratino>
References: <4EEBC9D6.6010204@ramsay1.demon.co.uk>
 <20111216235908.GA5858@elie.hsd1.il.comcast.net>
 <4F2834AD.20004@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 31 20:43:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsJbt-00006R-3g
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 20:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab2AaTnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 14:43:16 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45206 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab2AaTnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 14:43:15 -0500
Received: by vcge1 with SMTP id e1so361647vcg.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 11:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QHJAAWisiu6sYIq9f3O0X4KU2+KmAdrMWF396kcXHT8=;
        b=rvoi2Eopt/cyIX+zD7Olroy9SuOINxUSjEN788bOhNEh3AitN0ii7SHLFymSU7NJ/Z
         4TotMn5CpLUPx8ts6GVk+/qt/marlRXGxdcJ9+5VEtVF/N+n2m0KaGxBAC5PZRNQOObd
         YSDJ80ZL5/CYW1KmSCzA4e8J3ZfiB9ECtxgpA=
Received: by 10.220.151.136 with SMTP id c8mr13177685vcw.47.1328038994854;
        Tue, 31 Jan 2012 11:43:14 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id eh3sm20232644vdc.2.2012.01.31.11.43.13
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 11:43:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F2834AD.20004@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189468>

Ramsay Jones wrote:

> The versions which complain are 3.4.4 and 4.1.2, whereas 4.4.0 compiles
> the code without complaint. So, gcc *may* be getting more sane, but I wouldn't
> bet on it! :-P
>
> I've had examples of this kind of warning, which relies heavily on the
> analysis performed primarily for the optimizer, come-and-go in gcc before

Yep, judging from the commit message, Junio found the same warning
in 4.6.2.

[...]
> Having said that, unless you are going to decree that the project only
> supports gcc (and presumably only some particular versions of gcc), then you
> may well find similar warnings triggered when using other compilers anyway ...

Sure, when the control flow grows too complicated, that's probably worth
fixing anyway, for the sake of humans especially.

Sometimes gcc is the only crazy one, though. ;-)

Thanks for the update.
Jonathan
