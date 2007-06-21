From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: Strange diff behavior?
Date: Thu, 21 Jun 2007 09:46:02 -0700
Message-ID: <31e9dd080706210946i4821f300o55e89b67b3be562@mail.gmail.com>
References: <31e9dd080706201802h9dcbffawd82575d09e082155@mail.gmail.com>
	 <Pine.LNX.4.64.0706210212060.4059@racer.site>
	 <1182408458.6159.0.camel@localhost>
	 <Pine.LNX.4.64.0706211131160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Raimund Bauer" <ray007@gmx.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 21 18:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1PnM-0002EM-Po
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 18:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbXFUQqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 12:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753975AbXFUQqF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 12:46:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:65141 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbXFUQqD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 12:46:03 -0400
Received: by wr-out-0506.google.com with SMTP id q50so514509wrq
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 09:46:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O3qD08dVCkgjmNvqzApseXHa0rweB33490Gq92yhc+w7+uoQGtn8J8O9FlKEPPyhRCGi/SKm54dv26AQuBSE7yNMfoXc0Gao+zXeEmfjK7YjKknH85qIwn2kQnNlj2Hnf02MHBIcVZ5knPhVCdO53uu4ezcH2MgwdqUu5N7frfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gyxrdty29435aUnGM1Sk2iyjTPOpX//LMk0wKw1dcaPpnh5OFAjdhdQDiGU0EeXW5J78YsWNdK08TYu/IFIyplUY3ChAllnaIQ3KslUeCH4o6Igq56W0t3wI7Rhco7A2UmUa2hfzAp22wfUkMH1MpJlE0sfi5kBcapzMtMZvBQA=
Received: by 10.90.52.18 with SMTP id z18mr1898936agz.1182444362424;
        Thu, 21 Jun 2007 09:46:02 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Thu, 21 Jun 2007 09:46:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706211131160.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50642>

Ok, it was my bad. There *were* whitespaces on those lines, but in
HEAD^, not head. Git only cares when they are introduced, not when
they are removed. So git diff HEAD^..HEAD showed that strange line
removal/add but git diff HEAD..HEAD^ shows me the whitespace.

I recently set up emacs to strip whitespace whenever I save a file to
prevent git from complaining (and it's good practice anyway), so that
explains why I didn't expect the change

Sorry about the mixup, and thanks for your help.

On 6/21/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 21 Jun 2007, Raimund Bauer wrote:
>
> > On Thu, 2007-06-21 at 02:13 +0100, Johannes Schindelin wrote:
> >
> > > Just a guess: core.autocrlf=true?
> >
> > My guess: apply.whitespace=strip
>
> Much better guess, I guess. Jason?
>
> Ciao,
> Dscho
>
