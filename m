From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-p4 question
Date: Fri, 10 Aug 2007 10:10:59 +0200
Message-ID: <81b0412b0708100110w6ff90215gd5c367fb65e2ae21@mail.gmail.com>
References: <69b0c0350708091953wdc9c22vd2b17b1edd1c5cd2@mail.gmail.com>
	 <81b0412b0708100106m3123a504p16309b6e06cd9609@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Govind Salinas" <govindsalinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 10:11:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJPaV-0002xR-Sx
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 10:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbXHJILH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 04:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbXHJILG
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 04:11:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:47996 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbXHJILB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 04:11:01 -0400
Received: by nf-out-0910.google.com with SMTP id g13so209595nfb
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 01:11:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=saMWNl7Y2yk54geyh1pMC4t20Maqs7pj2Np4kcumjmnfSWmQBwgbzXwUVxcCOminisLj+2LmlKx1wQoBX23+EEnGOiVVfjaKnzys1yurIAge+AK4rGo5noAqbYogsqe3XDlOv2OU+7cvQ/fctytwQmmJ74vGyyicKMx+Q5raOrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qwiFUrOnI8acbpexDo6aleMsptg+jDDn91O+F29xVDFuFOAn1RXhrQgmKQVdC9mZbkLpfk4VgsPkuy8iVlhPFc4ygkAYmik93iQtnrLGAHfVpYcTU9/4ziDfJB8JbKGSSHPFNlvd5V4APjnhgRewXqoYSst1Qzp960FMNYv0L9Q=
Received: by 10.78.162.4 with SMTP id k4mr1198660hue.1186733459814;
        Fri, 10 Aug 2007 01:10:59 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Fri, 10 Aug 2007 01:10:59 -0700 (PDT)
In-Reply-To: <81b0412b0708100106m3123a504p16309b6e06cd9609@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55521>

On 8/10/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 8/10/07, Govind Salinas <govindsalinas@gmail.com> wrote:
> > If I can just sync from p4 and then sync my binary share and THEN tell
> > git-p4 that //depot/my/product/... maps to c:\path\src\realworkhere,
> > get it to import history etc,  then I would be set.
>
> git-p4-import.bat can import a state from the client have-list,
> but it does not import the history. It can import the history
> separately, so that you can stitch it into a merge which will be
> the state imported from the client. Complicated, but I couldn't
> bring myself to figure out the history automatically.

Err, example:

Import a state from p4 client:

  git-p4-import -y -c client-name -e

Import p4 history of a path mapping:

  git-p4-import --p4-path //perforce/path \
    --local-path very-local-path \
    --p4-range '@1234,5678' \
    --start start-commit \
    --branch branch-name

The last argument (--branch) is optional, will just store the last imported
commit there. start-commit will be assumed current HEAD, if omitted.
