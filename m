From: Olaf Hering <olaf@aepfle.de>
Subject: Re: cover letter and cc list
Date: Mon, 23 Mar 2015 09:18:40 +0100
Message-ID: <20150323081840.GB9332@aepfle.de>
References: <20150320173504.GA6162@aepfle.de>
 <xmqqpp83ee2z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 09:19:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZxZw-0000YY-CI
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 09:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbbCWITN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 04:19:13 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:25058 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbbCWITM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 04:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1427098748; l=1164;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=qUrlT2Eggk+nISQ6LVPl3X4fJU1SHE3LDSlzX2uNKYs=;
	b=uaUMa2QXcwKv+POup5hcpmNbSdCHFQk6tXxTHox02M+ZeT5FimAObMMn4jCRhVQRvxs
	ZPJKFth8EErHetmh6Ylg+9p2lNnss1H8tcl83sDzaqEGs7yi+KmKue/tkB4QxMPlHuivl
	leMvPIKK/rshcV+tJRJe9szeK3VYFqrnWHc=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWtrWFmrD4pjkQ2b4qvS
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box (charybdis-ext.suse.de [195.135.221.2])
	by smtp.strato.de (RZmta 37.4 AUTH)
	with ESMTPSA id 4036cfr2N8J8xYh
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Mon, 23 Mar 2015 09:19:08 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 99D7E50278; Mon, 23 Mar 2015 09:18:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqpp83ee2z.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266127>

On Fri, Mar 20, Junio C Hamano wrote:

> Olaf Hering <olaf@aepfle.de> writes:
> 
> > What does it take to send the cover letter to all people which are
> > listed in the Cc: list of the following patches? Each patch has a
> > different Cc: list. The "git send-email --help" command suggests that
> > this cmdline should do it. But the cover letter goes just to the address
> > listed in --to=:
> >
> > env TMPDIR=/dev/shm LC_ALL=C git send-email -M --stat --annotate \
> >         --cover-letter --cc-cover --to=$address \
> >         $base..$head
> 
> First step is not to drive format-patch from within send-email I
> would think.  Instead prepare them in files in a directory (with
> format-patch -o $dir).  You can edit Cc: header in 0000-*.patch
> message while you proof-read what you are going to send out.

Thanks. Then I misinterpreted what --cc-cover actually means. All Cc:
lines have to be present in the cover letter already. Would be nice if
git would run a command like this to put the list into the coverletter:

 # git log --format=%b $base..$head | grep -iw ^cc: | sort -u

In the meantime I will remember to do that step manually.

Olaf
