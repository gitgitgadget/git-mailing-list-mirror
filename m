From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Wed, 22 Feb 2006 17:35:46 +0100
Message-ID: <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060220191011.GA18085@hand.yhbt.net>
	 <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
	 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
	 <43FB9656.8050308@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 17:36:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBwyW-0000ZS-Uy
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 17:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWBVQfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 11:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWBVQft
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 11:35:49 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:39228 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932310AbWBVQfs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 11:35:48 -0500
Received: by nproxy.gmail.com with SMTP id m19so958460nfc
        for <git@vger.kernel.org>; Wed, 22 Feb 2006 08:35:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mo4x5EtQW2mfP3qITzIf8cfjfMtM0n4S+16hcXPJcUvBQPS23/dlXjqKjz64Gm14YWTB0JE7kFZ5rEU8g6neyZKyRx8WCHGeY00EWQNOb0Ea29eEgqCO+0FtUEaV6agk0e5gbluYI0VHe+ftQaIOzERKJ0JUhb406+1BMofbzqs=
Received: by 10.48.244.12 with SMTP id r12mr1922655nfh;
        Wed, 22 Feb 2006 08:35:46 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Wed, 22 Feb 2006 08:35:46 -0800 (PST)
To: "Sam Vilain" <sam@vilain.net>
In-Reply-To: <43FB9656.8050308@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16602>

On 2/21/06, Sam Vilain <sam@vilain.net> wrote:
> Alex Riesen wrote:
> >>>Does not work here (ActiveState Build 811, Perl 5.8.6):
> >>>$ perl -e 'open(F, "-|")'
> >>>'-' is not recognized as an internal or external command,
> >>>operable program or batch file.
> >>Portability, Ease of Coding, Few CPAN Module Dependencies.  Pick any two.
> > Sometimes an upgrade is just out of question. Besides, that'd mean an
> > upgrade to another operating system, because very important scripts
> > over here a just not portable to anything else but
> >     "ActiveState Perl on Windows (TM)"
> > I just have no choice.
>
> Sure, but perhaps IPC::Open2 or some other CPAN module has solved this
> problem already.

IPC::Open2 works! Well "kind of": there are still strange segfaults regarding
stack sometimes. And I don't know yet whether and how the arguments are escaped
(Windows has no argument array. It has that bloody stupid one-line command line)

> I guess what I'm saying is that if you want to limit the modules that
> Perl script uses, you end up either impacting on the portability of the
> script or rediscovering problems with early wheel designs.

IPC::Open{2,3} seem to be installed on every system I have access to.
