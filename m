From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: [PATCH] Silence cpio's "N blocks" output when cloning locally
Date: Fri, 28 Mar 2008 14:59:12 -0400
Message-ID: <3e8340490803281159t2ecdcdd6rea502331dcf04457@mail.gmail.com>
References: <1206685186-10352-1-git-send-email-bdonlan@fushizen.net>
	 <alpine.LSU.1.00.0803281400330.18259@racer.site>
	 <2145F4A8-7C6E-4AE9-A531-026DC65417BE@wincent.com>
	 <alpine.LSU.1.00.0803281728530.18259@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Wincent Colaiuta" <win@wincent.com>,
	"Bryan Donlan" <bdonlan@fushizen.net>, git@vger.kernel.org,
	gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 28 20:00:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfJo1-0005EJ-6p
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 20:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbYC1S7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2008 14:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbYC1S7R
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 14:59:17 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:31247 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbYC1S7Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Mar 2008 14:59:16 -0400
Received: by py-out-1112.google.com with SMTP id u52so556749pyb.10
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xATZOa9ClCyrO5+P8GdLeG5Tea1RgA7H9/sUXVmeqls=;
        b=rlndMSeTg9kKS9w3b+rYztV9FYDJhgh2UOwVz6uqSB5dY5bzUjNyBy+UBrqb8Wp/sI1sbSVKyjJmpxXo6yR+Wq0wTtW6XOxROP4PU/J7/Dg77myrXnf3kjiv6W/q2RH7UBDBKY6tjCF6CJIWNgBsSQQpPDC8tXkvBgIexcTswr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K8RIL60BEK3uTpkh4rRYLGliOKYkXo7ZW1Bxa1SbsxMMFuNc3tAd8dCjDOVXF6Po+ZYccnoSUeVOlcHjgbd9zUh+gf9V3InFxB3FVF/V6G3wiDuusfS4h40DlsJ5i8fQM5JGcF9bPbuL/XLtLOeMBwX+gDv+OzTzCSgCiv1iCck=
Received: by 10.65.196.2 with SMTP id y2mr7472404qbp.36.1206730752667;
        Fri, 28 Mar 2008 11:59:12 -0700 (PDT)
Received: by 10.64.49.9 with HTTP; Fri, 28 Mar 2008 11:59:12 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803281728530.18259@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78434>

On Fri, Mar 28, 2008 at 12:29 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Fri, 28 Mar 2008, Wincent Colaiuta wrote:
>
>  > El 28/3/2008, a las 14:01, Johannes Schindelin escribi=F3:
>  >
>  > >On Fri, 28 Mar 2008, Bryan Donlan wrote:
>  > >
>  > > >Pass --quiet to cpio in git-clone to hide the (confusing) "0 bl=
ocks"
>  > > >message. For compatibility with operating systems which might n=
ot
>  > > >support GNUisms, the presence of --quiet is probed for by grepp=
ing
>  > > >cpio's --help output.
>  > >
>  > >We have a builtin clone which is almost ready for 'next', and I t=
hink
>  > >that this issue would be resolved there anyway.
>  >
>  > In any case, I'd rather see the cpio check at configure-time rathe=
r than
>  > run-time.
>
>  That would have to be done via ./configure, missing out those people=
 who
>  do not run ./configure, but just make.

Some distributions don't run configure either, including debian (and
by extension, likely ubuntu). That said, if git-clone's going builtin
anyway, we might as well wait for that :)
