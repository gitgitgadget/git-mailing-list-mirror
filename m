From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 14:31:23 +0100
Message-ID: <320075ff0807290631l1f9a1e70jcb73bde7e2c86000@mail.gmail.com>
References: <20080728162003.GA4584@artemis.madism.org>
	 <20080728205923.GC10409@artemis.madism.org>
	 <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
	 <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com>
	 <20080729082135.GB32312@artemis.madism.org>
	 <20080729083755.GC32312@artemis.madism.org>
	 <20080729085125.GJ32184@machine.or.cz>
	 <alpine.DEB.1.00.0807291413460.4631@eeepc-johanness>
	 <20080729130713.GF32312@artemis.madism.org>
	 <alpine.DEB.1.00.0807291511400.4631@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"Petr Baudis" <pasky@suse.cz>,
	"Benjamin Collins" <aggieben@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Git ML" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:32:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNpJR-0005MG-Tp
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 15:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbYG2NbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbYG2NbZ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 09:31:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:41147 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbYG2NbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 09:31:25 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1673796nfc.21
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sYXpNp3HD81wp3iDL0SxcCFvZD1eoIjXRWaB5rEN5vY=;
        b=DHn8QxAqY/p+cHI3+10tVYqFbZLwRBQcSbulsdWidTIClVpeSslcRdcRMk4s4p8Gy8
         D7xEo0ZksD2/T101LOHQZwHOleddLl5fqN4/rmntlGOXU0qecUCFvWVcik9R/YhL79vr
         2SsYrphkRTIECsrcSQhEjn+gp4YPRe8vU0SJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Iyk+x/GqC8GvXyjgFPMAfu6hnAfkjvAcU8nYrkdCUuyX6/eKrPND8UNJJJ9FkzgklS
         AmYzsqXVFkmOVobu7tuPy94toLrcdkl/cQvwfcA1igv6OB1t19lIMS2GqLlwwBiUfqKd
         GdAFdvbIv3bTtLBSWu4FL7Eaogvy48OQcFGfY=
Received: by 10.103.192.10 with SMTP id u10mr3265117mup.29.1217338283277;
        Tue, 29 Jul 2008 06:31:23 -0700 (PDT)
Received: by 10.103.8.13 with HTTP; Tue, 29 Jul 2008 06:31:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807291511400.4631@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90639>

> I do not understand.  We are talking about three different things here:
>
> 1) the committed state of the submodule
> 2) the local state of the submodule
> 3) the state of the "tracks" branch
>
> We always have 1) and we have 2) _iff_ the submodule was checked out.  We
> only will have 3) if "tracks" is set in .git/config (for consistency's
> sake, we should not read that information directly from the .gitmodules
> file, but let the user override it in .git/config after "submodule init".
>

I think the implication is that .gitconfig states "I'm expecting that
submodule X will always be tracking branch name 'Y'" and that you
wouldn't ever override it in .git/config. If you then switched
submodule X to branch Z, then committed the superproject, that commit
would contain a change to .gitconfig also (to say I'm expecting to
track Z rather than X') ?

>> Or you need the submodule to be aware he's one, and then one would have
>> some kind of "magic" word to name this sha1. And tools would find out in
>> the supermodule what it translates into.
>
> You lost me there.
>

This sounds like it relates to the problem that what I call X and Z,
you might call Bibble and Bobble; you could use some kind of SHA1 in
lieu of a textual name to make sure everyone was talking about the
same thing ?

> Ciao,
> Dscho
>
>
