From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Fri, 6 May 2011 02:03:39 -0500
Message-ID: <20110506070339.GC13351@elie>
References: <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
 <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
 <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
 <4DB9329E.7000703@op5.se>
 <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
 <7vhb986chl.fsf@alter.siamese.dyndns.org>
 <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
 <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
 <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
 <20110506065601.GB13351@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 09:03:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIF4o-0001q0-JL
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 09:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab1EFHDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 03:03:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64612 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab1EFHDo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 03:03:44 -0400
Received: by iwn34 with SMTP id 34so2454005iwn.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 00:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fh1Iz1t2p9ZlD+XkppyICSku2yb2I2D7V0RB9mQtHhM=;
        b=S9kl0Lv5VFUx4aESqotjN9L1p5eYBXJrWAl6May2LFON+fhP88uq+WgmuSOF07FqBx
         8z8ZWYplHbM/f/fPRn1sq49gOuaFZzc5BaVQA/sBvIbsfSyI8gZu4r9fpUQlnViW7iiV
         HtLbGgia9L7wRJKPsZgkbmwU7f12j+BwoavVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yALqGxOIbWH7G5B5n/67N6EVLyj/YM1MoqRGV2zaA6KVf3FF4oFUjTzRaVhiWPRjLt
         KeBs+lDOUAqsPNvSF1/EcxPWzEeFMW9mfHkUMYFZepLIwDDt+1dTeYYfWpxbI/+19x0u
         LI6MN+gzLREh76We1CTG1camqlqJFip3EQIow=
Received: by 10.231.31.129 with SMTP id y1mr1959858ibc.138.1304665423720;
        Fri, 06 May 2011 00:03:43 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id y10sm1239163iba.46.2011.05.06.00.03.41
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 00:03:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110506065601.GB13351@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172949>

Jonathan Nieder wrote:

> 	install:
> 		install -m0755 git-work $(prefix)/bin
> 		install -d -m0755 $(prefix)/share/man/man1
> 		gzip -9 <git-work.1 >git-work.1.gz
> 		install -m0644 git-work.1.gz $(prefix)/share/man/man1/
> 		install -d -m0755 $(prefix)/bin

I'm sorry; I don't even know what sequence of keystrokes I used to
make this upside-down series of commands.  The intent was rather

	install: git-work git-work.1.gz
		: executable
		install -d -m0755 $(prefix)/bin
		install -m0755 git-work $(prefix)/bin
		: manual page
		install -d -m0755 $(prefix)/share/man/man1
		install -m0644 git-work.1.gz $(prefix)/share/man/man1

Sorry for the noise.
