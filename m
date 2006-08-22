From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Subject: RE: HELP: GIT Cloning failed
Date: Tue, 22 Aug 2006 14:24:34 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E35C@NAMAIL3.ad.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>, "Patro, Sumant" <Sumant.Patro@engenio.com>,
	<linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 22 22:25:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFco6-0004ef-PP
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 22:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWHVUY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 16:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWHVUY7
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 16:24:59 -0400
Received: from mail0.lsil.com ([147.145.40.20]:48303 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751259AbWHVUY6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 16:24:58 -0400
Received: from milmhbs0.lsil.com (mhbs.lsil.com [147.145.1.30])
	by mail0.lsil.com (8.12.8/8.12.8) with ESMTP id k7MKOHXu028773;
	Tue, 22 Aug 2006 13:24:17 -0700 (PDT)
Received: from namail.ad.lsil.com (namail.co.lsil.com [172.21.36.18])
	by milmhbs0.lsil.com (8.12.11/8.12.11) with ESMTP id k7MJQaFE006826;
	Tue, 22 Aug 2006 12:26:36 -0700
Received: from NAMAIL3.ad.lsil.com ([172.21.36.22]) by namail.ad.lsil.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 22 Aug 2006 14:24:34 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HELP: GIT Cloning failed
Thread-Index: AcbGJrr698AbTL/ARJ6C3NVQm/onBgAATNxA
To: "Sean" <seanlkml@sympatico.ca>
X-OriginalArrivalTime: 22 Aug 2006 20:24:34.0765 (UTC) FILETIME=[FB8867D0:01C6C628]
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25872>

Hi,
On Tuesday, August 22, 2006 4:08 PM, Sean  wrote:
> It looks like the jejb scsi-misc archive might not have been
> configured properly for http transfers.  There's a script below
> which just uses git commands (not cogito) and the native git
> protocol which tests out okay here.
I will try with the script and rest of your comments as well.
Thank you for your guidence.

Regards,

Seokmann


> -----Original Message-----
> From: Sean [mailto:seanlkml@sympatico.ca] 
> Sent: Tuesday, August 22, 2006 4:08 PM
> To: Ju, Seokmann
> Cc: git@vger.kernel.org; Patro, Sumant; linux-kernel@vger.kernel.org
> Subject: Re: HELP: GIT Cloning failed
> 
> On Tue, 22 Aug 2006 13:25:23 -0600
> "Ju, Seokmann" <Seokmann.Ju@lsil.com> wrote:
> 
> Ju,
> 
> > Above script worked without any problem when I started 
> several months
> > ago and I'm not sure when did it stop working.
> > I'm using _cron_ utility on my Linux box for scheduled 
> execution of the
> > script.
> > 
> > Any comment would be appreciated.
> 
> It looks like the jejb scsi-misc archive might not have been
> configured properly for http transfers.  There's a script below
> which just uses git commands (not cogito) and the native git
> protocol which tests out okay here.
> 
> A few comments though:
> 
>  - Apparently the scsi misc tree you want is actually under "jejb"
>    rather than "marcelo" which you had in your script.
> 
>  - It's better to use the native git protocol when possible
>    (well, the benefits are less on initial clone, but it's still
>    a good practice)
> 
>  - You're causing a lot of unnecessary traffic for kernel.org by
>    cloning a fresh copy of all these trees, it would be much better
>    to clone just _once_ and then simply "git pull" in any updates.
> 
>  - Two of the trees you're cloning are very close in content to
>    each other (linux-2.6 & scsi-misc-2.6) so you can use the git
>    "--reference" option to share local objects saving disk space
>    (and reducing bandwidth needs even further)
> 
> Cheers,
> Sean
> 
> #!/bin/sh
> cd /home/git/kernels/2.4 || exit
> BASE="git://www.kernel.org/pub/scm/linux/kernel/git"
> rm -rf linux-2.4 linux-2.6 scsi-misc-2.6
> git clone $BASE/marcelo/linux-2.4
> git clone $BASE/torvalds/linux-2.6
> git clone --reference linux-2.6 $BASE/jejb/scsi-misc-2.6
> 
> 
> 
> 
