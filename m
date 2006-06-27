From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: CFT: merge-recursive in C
Date: Tue, 27 Jun 2006 16:09:52 +0200
Message-ID: <81b0412b0606270709q7f5c9958w634041f7a5e0349f@mail.gmail.com>
References: <20060626233838.GA3121@steel.home>
	 <81b0412b0606270517y199fbc5cn9e19639b01813a7f@mail.gmail.com>
	 <Pine.LNX.4.63.0606271441320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Fredrik Kuivinen" <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 16:10:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvEGL-0006Jp-U2
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 16:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWF0OJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 10:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWF0OJy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 10:09:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:20801 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932284AbWF0OJx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 10:09:53 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2606303ugf
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 07:09:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rKtodaDvTct2a69ifHtcagO75Gg5j/MQN29aY5ujIs1uwm7Yy46yIh5ThgtnkVxIoKn0jZagvgGxB5tm3j12Bbc+2g/G/EuqfHYeCXu2Dp9rSHLL1+ePvDhhc2SCNsRFLIOgpc6iIcYxXJUYptz/DfqPIdUgr9/vwOW1MdS4gcU=
Received: by 10.78.156.6 with SMTP id d6mr2518150hue;
        Tue, 27 Jun 2006 07:09:52 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Tue, 27 Jun 2006 07:09:52 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606271441320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22739>

On 6/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > I finally got pis^Witched enough by my platform at work and decided
> > > to start the effort of converting Fredriks git-merge-recursive to C.
> > > At the moment it is the only one annoyingly slow thing there.
> >
> > Just tested it on my project. It's still the slow thing (even a bit
> > slower, looks CPU bound).
>
> Should improve when using git-merge-tree, and a faster path_list.
>

For the moment the most visible next offenders are calls to update-index.
I think about batching them (add, add, add, flush, rm, rm, flush,
stages, flush),
but maybe someone have a better idea?
