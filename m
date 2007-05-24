From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 15:32:11 +0200
Message-ID: <8c5c35580705240632y6110e2f9u74c6f12e6f800523@mail.gmail.com>
References: <20070524072945.GO28023@spearce.org>
	 <Pine.LNX.4.64.0705241039200.4648@racer.site>
	 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241201270.4648@racer.site>
	 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241230410.4648@racer.site>
	 <Pine.LNX.4.64.0705241315290.4648@racer.site>
	 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
	 <20070524131108.GP942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Martin Waitz" <tali@admingilde.org>,
	"Alex Riesen" <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 15:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrDQV-0008Bo-TG
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbXEXNcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 09:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756816AbXEXNcT
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:32:19 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:33520 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721AbXEXNcT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:32:19 -0400
Received: by an-out-0708.google.com with SMTP id d31so39875and
        for <git@vger.kernel.org>; Thu, 24 May 2007 06:32:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=afoeRYeXU+M8CL0AJEVwbaHQuiguNZCOgPUEK5dUCHijfv1psoJlQ/qvtCAoFbn84msXA+w2tyqB2vPPPahoJFbNi+hKTQ45BAU9mRVTctewKOVG1mALQzrDS2MI5g3+n/9rVCjebG4tc+ruM1/+/ALNrRmxJJcr8Z+u+w3DZEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TE0KaFrc1jmZigamOoiWpZuUP/SxEinJi1dq9++w7kwcYVyJarbb1enUWq4ULJ+T6FOVS4qMiGZ2sp/7rzIBDyu6DB7CFyLC+XSldCwnEoajpdQ+L10MVUzPTZ5HgE8XosyS2RFQg9OO5yht4cwNGZ3HNUwtyWu05QqZ8yovRG8=
Received: by 10.114.159.1 with SMTP id h1mr868637wae.1180013532076;
        Thu, 24 May 2007 06:32:12 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Thu, 24 May 2007 06:32:11 -0700 (PDT)
In-Reply-To: <20070524131108.GP942MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48262>

On 5/24/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Thu, May 24, 2007 at 02:41:57PM +0200, Lars Hjemli wrote:
> > I think the whole point of the 'remote config' stuff is to get an
> > unversioned/out-of-tree .gitmodules file, right?
>
> Yes.
>
> > If so, one could put this file into the object db and refer to it with
> > something like 'refs/tags/subproject-config' or even
> > 'refs/misc/subproject-config'. Both of these refs will be found by
> > ls-remote and point to the object containing the suggested subproject
> > configuration.
>
> That's a possibility, but then...
>
> On Thu, May 24, 2007 at 01:43:54PM +0200, Sven Verdoolaege wrote:
> > Or do you propose we put the URL in a blob and put the object sha1
> > in there.  If so, who's going to create these blobs for the git://
> > and ssh:// protocols?  upload-pack?
>
> I don't think you can expect the user to this herself.

Well, my point would be that we already have the necessary plumbing to
solve the problem (discovery and distribution of out-of-tree objects).
Some porcelain support on top of this is all that is needed (well,
almost. I just tried downloading my own tarball, and got an error
about the ref not pointing to a commit. But that shouldn't be too hard
to fix)

-- 
larsh
