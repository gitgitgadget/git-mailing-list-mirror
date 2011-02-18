From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Fri, 18 Feb 2011 03:25:18 -0600
Message-ID: <20110218092518.GB30648@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 10:25:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqMah-0003uc-RY
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 10:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757707Ab1BRJZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Feb 2011 04:25:27 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59124 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab1BRJZY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 04:25:24 -0500
Received: by iwn9 with SMTP id 9so3430586iwn.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 01:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QGWn9L/nc7F/7gtcdUu9U7UXaXSxZIYLwdnilJx3fDw=;
        b=OPUKAfmk0h+ujJ4scv3/g0oiDKFuvf4FpB9DSOgUyCpwsVHvfSlfec3WlDvURXAQXC
         z2hY3jpDYpmL0I8Y++EU8Ak0vQAgq95Yv9x++/XrCkhYuSXtALS8YvPQ/S/lRzp90Rcs
         xhmA57Qr/WzaOX7fZCZspIi5N828lhOpu1VcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MAVv9HPoBfMw2+dUhDkaAH/qWpOs1wCfsBBMt9RfhQaA5bMnnBoAdUlxF7MSTPq0kB
         WN04I/AaMwyIwNo3jyxXkEirxbzSNuudaK9Sn3F5PAev2Oe54/u4OdWR2woNC1FvTsrE
         /U0azZxOBZKn04o27t2zd5Ku/yw1+7h1Lseo8=
Received: by 10.231.38.10 with SMTP id z10mr354375ibd.107.1298021123486;
        Fri, 18 Feb 2011 01:25:23 -0800 (PST)
Received: from elie ([69.209.72.148])
        by mx.google.com with ESMTPS id i16sm1578296ibl.18.2011.02.18.01.25.21
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 01:25:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167188>

Nguyen Thai Ngoc Duy wrote:
> 2011/2/18 Jonathan Nieder <jrnieder@gmail.com>:

>> Here's a variation on the theme that just moves source and .o files
>> (leaving questions about how to cope with breaking muscle memory for
>> the resulting executables for later). =C2=A0What do you think?
>
> External commands are now more visible. Nice.

Thanks again for both of your help.  I've put up an updated series at

 git://repo.or.cz/git/jrn.git flatten-source

Changes since the series sent to the list:

 - put headers in libgit/ with the source files.  I don't
   know what I was thinking before.

 - renamed nonbuiltin/ to commands/.  Names like
   commands/add--interactive.perl even seem to make a kind of sense.

 - moved the http support mini-library to http/.

 - renamed git_remote_helpers to python/, though I'm not very happy
   about that.

This is all very off-the-cuff.  I'd be happy for others to pick this
up and remold it to their taste (after all, I'm too used to the
current layout to remember what matters).  It doesn't feel cooked yet.
