From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: whomto.pl -- finding out whom to send patches to
Date: Sat, 31 May 2008 12:03:54 +0200
Message-ID: <19f34abd0805310303i526f6b4dv167355103665ac42@mail.gmail.com>
References: <20080529210018.GA5508@damson.getinternet.no>
	 <483FB39A.4070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	"Jan Engelhardt" <jengelh@computergmbh.de>,
	"Sverre Rabbelier" <alturin@gmail.com>,
	"Joe Perches" <joe@perches.com>, git@vger.kernel.org
To: righi.andrea@gmail.com
X-From: git-owner@vger.kernel.org Sat May 31 12:04:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2NxB-0001TH-3r
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 12:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbYEaKDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 06:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbYEaKDz
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 06:03:55 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:13136 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYEaKDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 06:03:54 -0400
Received: by rv-out-0506.google.com with SMTP id l9so240616rvb.1
        for <git@vger.kernel.org>; Sat, 31 May 2008 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zuoYqCSdzXhHtenhU5r/fPRmvTuNXV2PfrM9q42HsYg=;
        b=fcumTieEuKiqPzGcvslg9pIl1Z4GDAiHKpi5Ho35GnPpKf8MwoPfVwtRGyfWA8/rlSsJelc7l4iArhk8YxgOb0SMwGS+WjFd7XbukWg+rdxt2obRFyXauYNaObqYaooXmIEFnECHEvPy8ACsCg/ITbSo0s9Bxu/FE5N4M5rD9G4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SbD/HgxHwC8f1iUEJ+5MLJpr3PCmaVXiR9FqptCs/3c56GlvVa47lyvo2lyL+Bxm1l0dmCMDRFrkLVvHyOI+z0re3sIDB+7WJkMevRgSK1aznid6MPuX15i0FhOZkW/DbsPonO1QhWLfh5yMzNYoDRHsC41U6hO5amCtu/15Xr8=
Received: by 10.141.67.21 with SMTP id u21mr3648858rvk.222.1212228234148;
        Sat, 31 May 2008 03:03:54 -0700 (PDT)
Received: by 10.141.145.9 with HTTP; Sat, 31 May 2008 03:03:54 -0700 (PDT)
In-Reply-To: <483FB39A.4070104@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83369>

On 5/30/08, Andrea Righi <righi.andrea@gmail.com> wrote:
> Vegard Nossum wrote:
>
> > Hi,
> >
> > I've written this perl script that takes a patch as input and prints the
> > authors/committers of the affected lines, using git-blame as the back end.

...

> > (Improvements are of course also welcome.)
> >
>
>  Minor fix: do not git-blame /dev/null in patches that add new files.
>
>  -Andrea
>
>  diff -urpN linux/whomto.orig.pl linux/whomto.pl
>  --- linux/whomto.orig.pl        2008-05-30 09:43:08.000000000 +0200
>  +++ linux/whomto.pl     2008-05-30 09:49:26.000000000 +0200
>  @@ -101,6 +101,7 @@ sub parse_patch {
>
>         for (@p) {
>                 if (m/^--- .*?\/([^\s~]*)/) {
>  +                       next if ($1 eq 'dev/null');
>                         $file = $files{$1} = {
>                                 chunks => [],
>                         };
>

I missed that, thanks :-)

(Other diff programs may also use other paths for new files, so I'm
also adding an -f check.)


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
