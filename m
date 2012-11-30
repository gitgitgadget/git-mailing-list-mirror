From: Michael Weiser <m.weiser@science-computing.de>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Fri, 30 Nov 2012 11:45:32 +0100
Message-ID: <20121130104532.GC2640@science-computing.de>
References: <20121127163004.GC7499@science-computing.de>
 <CABPQNSYhscHdnTFLye=oif_R84kpdaVsrCK+-174v7Ugrae_yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 11:55:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeOFt-0000dV-Vs
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 11:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467Ab2K3KzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 05:55:19 -0500
Received: from mx4.science-computing.de ([193.197.16.30]:11259 "EHLO
	mx4.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab2K3KzR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2012 05:55:17 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Nov 2012 05:55:17 EST
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id EF170414008;
	Fri, 30 Nov 2012 11:45:31 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7b6nVYVB+hEZ; Fri, 30 Nov 2012 11:45:31 +0100 (CET)
Received: from science-computing.de (dhcphag71-95.science-computing.de [10.10.11.95])
	by scmail.science-computing.de (Postfix) with ESMTPS id 435F7414006;
	Fri, 30 Nov 2012 11:45:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CABPQNSYhscHdnTFLye=oif_R84kpdaVsrCK+-174v7Ugrae_yQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Erik,

On Fri, Nov 30, 2012 at 11:20:52AM +0100, Erik Faye-Lund wrote:

> > +#if defined(__linux__)
> > +               struct stat st;
> > +               if (!stat("/proc/self/exe", &st)) {
> > +                       abs_argv0 = xstrdup(real_path("/proc/self/exe"));
> > +               }
> > +#elif defined(__APPLE__)
> > +               /* Mac OS X has realpath, which incidentally allocates its own
> > +                * memory, which in turn is why we do all the xstrdup's in the
> > +                * other cases. */
> > +               abs_argv0 = realpath(argv0, NULL);
> > +#endif
> ...perhaps a "GetModuleFileName(NULL, ...)" for Windows is in place here?

Agreed. However, I do not use git on Windows and don't have a Windows
devel toolchain in place. So I guess this should be added in a separate
patch by someone actually in need of it and in a position to develop and
test it?

Thanks,
-- 
Michael Weiser                science + computing ag
Senior Systems Engineer       Geschaeftsstelle Duesseldorf
                              Martinstrasse 47-55, Haus A
phone: +49 211 302 708 32     D-40223 Duesseldorf
fax:   +49 211 302 708 50     www.science-computing.de
-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Michael Heinrichs, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
