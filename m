From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: submodule init problem
Date: Wed, 25 Jul 2007 22:25:28 +0200
Message-ID: <8c5c35580707251325i2633777pdd7604b541506533@mail.gmail.com>
References: <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	 <8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
	 <b6ebd0a50707201023h12ed3c61v31ccb2b356c1ee42@mail.gmail.com>
	 <7vsl7jvthk.fsf@assigned-by-dhcp.cox.net>
	 <d4b731510707241709pcad0a4bj85b71892cd2de84c@mail.gmail.com>
	 <d4b731510707241730u45755c0dwfde5e0b14b14f1da@mail.gmail.com>
	 <20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0707201933360.14781@racer.site>
	 <7vir89fe1l.fsf@assigned-by-dhcp.cox.net>
	 <20070725081508.GN1591MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Ricky Nite" <ricky.nite@gmail.com>,
	"Chris Larson" <clarson@kergoth.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed Jul 25 22:25:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDnQL-0007mq-BF
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 22:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbXGYUZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 16:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbXGYUZa
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 16:25:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:54815 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbXGYUZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 16:25:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so340309wah
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 13:25:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c7tXuBHS9PXMBI3UISJ2iqrY8z8u+91ok1NIGeqOn1MyizdmpR4BWOdoBeBopyAuCM/Sw4zWJ6u/rR26lnfEo/JfmOL7CnVAonXnVxeCvj+fSxm+DKItyKIFe8UuXocwVLQdy38j2EzFz0vL+SA5+lH4yP0QAd5QWRGpzsyTYBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sdPqezdzE2YN7hZP98L5aD/l1LKrEdeFGwMI0elJ/d1ZAOwyxQ0U9zLo7pn4QJ7Q0Gf3gCp1kGx8dvlQD+9S4U7sZyx+Kk7+ve3JmXkFeuRdzXXOrCeu48yLJflcOgGb1B/sR9XDYF98B93PSdSL8gGYbBae9EcJuz2iOJJzovw=
Received: by 10.115.22.1 with SMTP id z1mr1008148wai.1185395128533;
        Wed, 25 Jul 2007 13:25:28 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 25 Jul 2007 13:25:28 -0700 (PDT)
In-Reply-To: <20070725081508.GN1591MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53714>

On 7/25/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Tue, Jul 24, 2007 at 06:49:26PM -0700, Junio C Hamano wrote:
> > Ok, this appears it most likely to be related to the fact that
> > one is a prefix of the other in problematic case.
>
> Yes, this has been noted before and Chris Larson sent in a patch,
> but he didn't follow up on it.

The following seems to work (in my limitied testing):

  eol='$'
  git config --get-regexp '^submodule\..*\.path$' "^$1$eol"

--
larsh
