From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH v0] sha1_name: grok <revision>:./<relative-path>
Date: Sat, 22 Dec 2007 03:15:28 +0700
Message-ID: <fcaeb9bf0712211215p5d63a434r63340c1f579569bc@mail.gmail.com>
References: <20071218173321.GB2875@steel.home>
	 <200712182224.28152.jnareb@gmail.com>
	 <20071218222032.GH2875@steel.home>
	 <Pine.LNX.4.64.0712182239500.23902@racer.site>
	 <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
	 <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
	 <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
	 <Pine.LNX.4.64.0712191334460.23902@racer.site>
	 <fcaeb9bf0712210617x2bafa33cp15815a59fc631f45@mail.gmail.com>
	 <7vbq8k7x91.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Dana How" <danahow@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 21:15:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5oHj-0007C1-Sq
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 21:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbXLUUPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 15:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbXLUUPa
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 15:15:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:13846 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbXLUUP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 15:15:29 -0500
Received: by fg-out-1718.google.com with SMTP id e21so219299fga.17
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 12:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QK6iXYkgEPDdq9Rz8iMoxugTXDI+uhxMIp6MeRSmPM0=;
        b=xVpzRtDtXfXu4y5n2bOPDcpDBWCGxKUxKzF592LTahYZcBALumQnmjJ80lx8wEtnFwKxwErFSRfVlb8AqI9aNCkHNUTl4ewRDcuXDiagA323AVvKNNPFQBHFAX0jdBf02lVlc0QNXs9k4ZqhGT+qf3GQhcHX1SxkJykg3r/uSGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O/UbbqkYCQc4Qa49kuoyn0lDUTCP6i6zN5kSvo4pF+9S02kHlXALbcoHfbMaJKEign9MzkWuV9KADkV/9hJRmBK67q9tllpKJcvZkMXEaWDZNkuuokrReIsB0XGdVmokHboGN6lTt1uXYp6tJx948FNjLRUCuHLN6w68VfKnOlE=
Received: by 10.86.89.4 with SMTP id m4mr1485635fgb.12.1198268128248;
        Fri, 21 Dec 2007 12:15:28 -0800 (PST)
Received: by 10.86.53.17 with HTTP; Fri, 21 Dec 2007 12:15:28 -0800 (PST)
In-Reply-To: <7vbq8k7x91.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69089>

On Dec 22, 2007 12:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> >> Note that this patch does not handle "../", and neither do I plan to.
> >
> > Junio's rc1 announcement got me to read this. It would be indeed
> > useful as I usually work in deep subdirs. However, from my user
> > perspective, the right approach is to make <treeish>:path always be
> > relative to current directory. If you want absolute path, use
> > <treeish>:/path. More intuitive but it breaks current behavior.
>
> I do not know if you followed the discussion thread, but the
> <treeish>:relative-path has been shown to be broken semantics,
> so even if it may be "intuitive", it is intuitive only to people
> who do not understand the brokenness.  Please read the one that
> Dscho talks about windows drive letter and Linus agrees that is
> a good analogy.
>
> It might be possible to do <commit>:relative and apply that only
> to direct user input, but I do not think it is worth the
> compatibility and complexity hassle.

Argh! I missed that thread. Will shut up now :-X Thanks for the pointer.
-- 
Duy
