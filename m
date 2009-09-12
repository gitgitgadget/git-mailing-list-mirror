From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [DIFF] build git on armv6l emulator with uclibc
Date: Sat, 12 Sep 2009 22:42:30 +0200
Message-ID: <20090912204230.GA31317@localhost>
References: <200909122218.07830.farmatito@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tito <farmatito@tiscali.it>
X-From: git-owner@vger.kernel.org Sat Sep 12 22:43:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmZQx-0004ui-AB
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 22:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbZILUmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 16:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbZILUmj
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 16:42:39 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37463 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbZILUmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 16:42:38 -0400
Received: by bwz19 with SMTP id 19so1404436bwz.37
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=eknm/CjB54du2gEx30MxZQQYmqMrdaemD5kKO6lWAfI=;
        b=OfaTE1v8fqlyapIe2KooSsK6XKINlG0EY12YgpuvqG1kaFyNIs6Wy2xgwpw1WrrZ6U
         hAGcC0Br5l8rqU/f6sSjs2bhbCdCZHx6ax6YpUXk71rhYkccTnSmOmUcgU6WulYKQSMg
         hWkkgfdtie4St55OD4IszYsW48O9vYBjJsGEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=QKMk4x7qGcoo3AVUe2T1kCklaZKIc7aUmx0Pt25XfYtQSEh/QGsyGrispBjOYaqFZl
         7XRvxUJihEP7QHsC0Om/3mTul6Uq2isX6GVpWIqjljPTeycspGMqLVbB0yzQPPcLY650
         S9ikc62e6jtkjpXfQf4VjdwdPBfnJNtNf+73A=
Received: by 10.204.160.86 with SMTP id m22mr3509396bkx.82.1252788161070;
        Sat, 12 Sep 2009 13:42:41 -0700 (PDT)
Received: from darc.lan (p549A70ED.dip.t-dialin.net [84.154.112.237])
        by mx.google.com with ESMTPS id f31sm3189294fkf.8.2009.09.12.13.42.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Sep 2009 13:42:40 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MmZQU-0000T8-Un; Sat, 12 Sep 2009 22:42:30 +0200
Content-Disposition: inline
In-Reply-To: <200909122218.07830.farmatito@tiscali.it>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128295>

On Sat, Sep 12, 2009 at 10:18:07PM +0200, Tito wrote:

> +#if 0
>  		mtime.nsec = ST_MTIME_NSEC(st);
> +#else
> +		mtime.nsec = (unsigned long int)st.st_mtimensec;
> +#endif

You can do this instead:

$ echo NO_NSEC=YesPlease >> config.mak
$ make

Clemens
