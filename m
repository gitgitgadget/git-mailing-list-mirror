From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] contrib: Replaced /bin/sh with /bin/bash to make
 scripts with Bash syntax work on Solaris.
Date: Sat, 7 Aug 2010 22:11:42 -0500
Message-ID: <20100808031142.GA20077@burratino>
References: <1281099365-11978-1-git-send-email-asgeir@twingine.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Asgeir S. Nilsen" <asgeir@twingine.no>
X-From: git-owner@vger.kernel.org Sun Aug 08 05:13:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhwKB-0004ly-6z
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 05:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab0HHDNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 23:13:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37799 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab0HHDNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 23:13:10 -0400
Received: by gwb20 with SMTP id 20so3141961gwb.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 20:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=i4Z1mrQHj006GYZxHWhVozDY+6m5URp6lsF9t3iwLUc=;
        b=BC86zXNi4Hqgj045/HzDAAUkaO4NLAE1XfndCTiqXeT1VMGYRVX+KgrjnTddu4WC3K
         RmHVT3Gzg72lTjZq70Qdn5Ae9lyqbBU2Pjz5nbrZIANOBffWw+uVK3NWfeajJTFStN0O
         5pJzlfNISbEUlB2tw99SVsilbmS0kr3/fmYXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ohM4ns1YUV+L8EY38UJzHofYYwMfJDCmIJB17xI+N05DU7NImGHakaBIEvAyu0g22K
         6JbsEtLevRw1I97qzHdycbhZ5nEVtSMGuRB6lFYcBO9ofJ706ohxeLFXP/9YHOBsBSix
         +M4eADxArW0CA6m+w497BJ+ERo1294ZKmQGsA=
Received: by 10.150.197.3 with SMTP id u3mr2791930ybf.318.1281237187212;
        Sat, 07 Aug 2010 20:13:07 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id c2sm1320553ybi.9.2010.08.07.20.13.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 20:13:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281099365-11978-1-git-send-email-asgeir@twingine.no>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152880>

Asgeir S. Nilsen wrote:

> +++ b/contrib/ciabot/ciabot.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash

Maybe, relying on a sane $PATH:

	#!/usr/bin/env sh

Not sure what would happen on the less unixy platforms.

Relying on POSIX execlp:

	# shebang line omitted for portability

Simplest of all is to tweak the #! lines in whatever script is used to
deploy the scripts from contrib.  I would not mind seeing an
install-contrib target incorporated into the Makefile that does that.
