From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Mention libiconv as a requirement for git-am
Date: Tue, 31 Jul 2007 23:18:28 -0400
Message-ID: <fcaeb9bf0707312018p25297d76g50489fa303856dd6@mail.gmail.com>
References: <20070731150948.GA9947@localhost>
	 <f329bf540707312003i60e910e9kf97d2f50fdecbed2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <J.Sixt@eudaptics.com>
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Aug 01 05:18:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG4jK-0005b9-Hj
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 05:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbXHADSb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 23:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbXHADSb
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 23:18:31 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:20359 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbXHADSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 23:18:30 -0400
Received: by an-out-0708.google.com with SMTP id d31so13275and
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 20:18:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NqytbsyK9nMWTr/SjdNO7obwiczrVqfA3PeShNbKqu4cqvrBrDeLB6Am7IHeflmMioJQE1+oyW0Lqbv9qttZhiDfGPWt15l0dBnm5mT7suT5lk6ZLu5rByIiz3O/+VMAtfs2ozDbmcekjtLnp+5xltcIvGUucHyxMH83IDg3PG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LTrs97Z7E+sQS+fq6arc81cXluHENY9tbDHZtEHpHBskVDdSB49OsZkYSJm9wQSWjBjpVyazVuL+yp+lCIIgii+lPxwp4uZy9CvAWya4Z51l0DHBfgI23F6FFGKnCgIh0H8zhzRiCjXTMvwAPyc0RcbcbkL/3scUG+OALGL9KHM=
Received: by 10.100.106.5 with SMTP id e5mr137799anc.1185938308956;
        Tue, 31 Jul 2007 20:18:28 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Tue, 31 Jul 2007 20:18:26 -0700 (PDT)
In-Reply-To: <f329bf540707312003i60e910e9kf97d2f50fdecbed2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54401>

I'm sorry I judged by reading Makefile without actually testing your
installation, so I might be wrong. By default Makefile set
NO_ICONV=YesPlease on MinGW so it won't use libiconv even if it
exists. You need to unset NO_ICONV and set NEEDS_LIBICONV in
config.mak in order to enable it.

I'm going to test it tomorrow.

On 7/31/07, Han-Wen Nienhuys <hanwenn@gmail.com> wrote:
> libiconv is already in there, version 1.11,
>
> [lilydev@haring gub]$ grep bin.libiconv
> target/mingw/gubfiles/installer-git-master-repo.or.cz-git-mingw.git/files.txt
> \usr\bin\libiconv-2.dll
>
> I don't understand your request: do you want to have some flags added
> to the environment?
>
> 2007/7/31, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> > ---
> >  Han-Wen, any chance to include libiconv to the installer? You may need
> >  to set NEEDS_ICONV, ICONVDIR and NO_ICONV properly to make git-am work.
> >
> >  README.MinGW |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/README.MinGW b/README.MinGW
> > index 89b7065..c0b8f66 100644
> > --- a/README.MinGW
> > +++ b/README.MinGW
> > @@ -28,6 +28,7 @@ In order to compile this code you need:
> >         zlib-1.2.3-mingwPORT-1.tar
> >         w32api-3.6.tar.gz
> >         tcltk-8.4.1-1.exe (for gitk, git-gui)
> > +       libiconv-1.9.2-1-{lib,bin}.zip (for git-am, from http://gnuwin32.sourceforge.net/packages/libiconv.htm)
> >
> >
> >  STATUS
> > --
> > 1.5.0.7
> >
>
>
> --
> Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
>


-- 
Duy
