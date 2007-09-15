From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Sat, 15 Sep 2007 17:24:02 +0200
Message-ID: <8c5c35580709150824l6eb4fa40l7ef77db03a48af4b@mail.gmail.com>
References: <20070906075104.GA10192@hand.yhbt.net>
	 <20070906210155.GA20938@soma> <20070906213556.GA21234@soma>
	 <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com>
	 <20070906235516.GC4538@xp.machine.xx>
	 <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com>
	 <20070907084352.GD4538@xp.machine.xx>
	 <8c5c35580709070313l4b815ddbg70be8fb0aef4eefd@mail.gmail.com>
	 <8c5c35580709150708k5acdeabdh17fc7ef30ee3eb79@mail.gmail.com>
	 <20070915143743.GB4957@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Peter Baumann" <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 15 17:24:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWZVD-0003f3-7e
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 17:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbXIOPYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 11:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbXIOPYG
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 11:24:06 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:49298 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbXIOPYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 11:24:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so923617rvb
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OjeCLVV4V63jYfGzB+B5Gtrf8qh+lv2c+JnylxNTelM=;
        b=cDHRa/Irf/gxEANfHZBJ4xYfNhFwwOHYnbhgqPfAL0PmT6RZKZy+VsZ92WtkqJmdPhUCyFL/V4VLXUEBslQjguA9BA5lrEf+I76xOyD3xzCXv4zvVry6jlbAm+xcktDf+cWO0Qrwcj+5FEm6IRFloGvRnW9hnlHWnyAXpby0Z+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qxqSonDVL17u9wLaBY/CAVqwCAmn33aByQOArTUxVI8ZllW82txBTDYVJ7sNnobnWRPB8AGtGKadAA8KtMJ0I/umcbKqyNXxL4NTvq18tW406LeMdEhAcWRaMrQJ5+qQfebIsWglz+VDqYwpYAtLr4Kqn3gxPKb7MDF4oyq2kp8=
Received: by 10.114.135.1 with SMTP id i1mr1141822wad.1189869842647;
        Sat, 15 Sep 2007 08:24:02 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Sat, 15 Sep 2007 08:24:02 -0700 (PDT)
In-Reply-To: <20070915143743.GB4957@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58254>

On 9/15/07, Peter Baumann <waste.manager@gmx.de> wrote:
> On Sat, Sep 15, 2007 at 04:08:31PM +0200, Lars Hjemli wrote:
> > On 9/7/07, Lars Hjemli <hjemli@gmail.com> wrote:
> > > On 9/7/07, Peter Baumann <waste.manager@gmx.de> wrote:
> > > >    lets reset 'trunk' to its state before the merge and
> > > >    'branch1' to the merge commit, before fixing the bug in 'branch1'.
> > > >
> > > >        a-b-c-d-e    trunk
> > > >           \      \
> > > >            \ -x-y m branch1
> > >
> > > Yeah, this would certainly not be handled correctly by dcommit using
> > > --first-parent (but it could be handled by (a correct implementation
> > > of) --upstream).
> >
> > Actually, I don't think there's any way to handle this correctly. The
> > current git-svn will do the right thing except in cases like the one
> > you described, and in these cases it can be _forced_ to do the right
> > thing by editing the grafts file, so I'll drop the whole --upstream
> > idea.
> >
>
> What do you mean by editing the graft file? Remove (the wrong) parent
> from the merge commit by a graft?

I imagined just changing the order of the parents.

-- 
larsh
