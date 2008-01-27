From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: I'm a total push-over..
Date: Sun, 27 Jan 2008 18:06:02 +0300
Message-ID: <20080127150602.GK26664@dpotapov.dyndns.org>
References: <4797518A.3040704@op5.se> <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com> <4798B633.8040606@op5.se> <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com> <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org> <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com> <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org> <e51f66da0801260416p5f5ffb98w16fe832fe62dc7c9@mail.gmail.com> <alpine.LFD.1.00.0801262247140.3222@www.l.google.com> <e51f66da0801270145w41a94414g7bebd4a31293344d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 16:06:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ95o-0007S4-6O
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 16:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYA0PGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 10:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbYA0PGJ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 10:06:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:42903 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbYA0PGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 10:06:08 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1352839fga.17
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 07:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=5Pb+vpvo7K1i4K2ovL3i5mZZ+OpHhHkoxuUPuUM1m5M=;
        b=KveBhK/JjKvMkzXAFzQT/WogydJc2rP057xPhaRt4pCR55EZ7EtznRmNh1nHAaFNKD3/7LPlzDgpu7pJ1gfaODHO0mkWfEGfTN2W1DmdXeGS0qv5ku6tLmGCoz5a6eO1Mv1JjWKbKvRHd5l7+ZQ/mscDHhhokkHtyJgbTZhvQVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=mVDxSShCUk+tejC5Sq/1xSOSSHVkxbF3MB9h23DUW+34zegxyx+6aaWlFZgA/y1RrsUyGbvnA/pvKq5HHeWNE//PJ8N6I4TMZjHqZDiyv1VM7yHMAUVenzVmPksZCc7odUEVSwn792//sEfN2AyFMIbSy22oPlUQnVXIhtz07Zg=
Received: by 10.86.99.9 with SMTP id w9mr4160266fgb.58.1201446365591;
        Sun, 27 Jan 2008 07:06:05 -0800 (PST)
Received: from localhost ( [85.141.188.123])
        by mx.google.com with ESMTPS id l19sm6657260fgb.9.2008.01.27.07.06.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Jan 2008 07:06:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e51f66da0801270145w41a94414g7bebd4a31293344d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71819>

On Sun, Jan 27, 2008 at 11:45:25AM +0200, Marko Kreen wrote:

> The minus:
> - some memory i/o overhead which may or may not matter

If a string is short, it will probably reside in the processor cache, so
there is no real memory i/o overhead here. For more longer strings, it
may be better to do that in short chunks, so each chunk can reside in
the cache. But I don't think filenames are long, so it is not an issue
here.

> - the parts would not be fully generic, but special to hashing

I think the second part can be rather generic to be reused for hashing
something else that does not require filename specific case-folding.

Dmitry
