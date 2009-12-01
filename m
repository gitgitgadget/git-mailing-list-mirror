From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Make linking to actions requiring JavaScript a feature
Date: Tue, 1 Dec 2009 17:51:11 +0100
Message-ID: <200912011751.12172.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <7veinjn7nc.fsf@alter.siamese.dyndns.org> <7v4oob8pap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:59:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFW4d-00067l-KU
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbZLAQ7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270AbZLAQ7X
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:59:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:32177 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbZLAQ7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:59:22 -0500
Received: by fg-out-1718.google.com with SMTP id e12so1889064fga.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GtIL/Yxebnkz9R4KEInymHs8e8gvaNqanA4nxYOv5uU=;
        b=HmcV5C+S9bKq/0aAWGxT223bInpVHAa8QkLg/FuWRHRx0O3lvYaOKL5o17bEcULl4y
         O31lxVfqzKBnPnHVhIphvUOASmuVJkoDUJ7Edl+av9q1sN2mqF5KoEe85rPHzZjdU/0h
         KQJ8V1sP1IlDTzsTtQAkkKbXZQubHFi28YYL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=N46F8yT2Kfgz1cqDFJ2wVBuPAKtEeFeEgT56t21B8Hl4sY6hmWb4HtFsbfA7Md3eTb
         882qtyO6oy10jyJ7k/pDqfmdEY50//W+qwJUYNTsNvzS7h6h91dYFqaMgyNHmB25C0vl
         Wev21ra018ZHnPY28v4wWLH2/ogcHXPwXM2mw=
Received: by 10.86.210.32 with SMTP id i32mr5557517fgg.60.1259686767739;
        Tue, 01 Dec 2009 08:59:27 -0800 (PST)
Received: from ?192.168.1.13? (abwm69.neoplus.adsl.tpnet.pl [83.8.236.69])
        by mx.google.com with ESMTPS id l12sm2660703fgb.5.2009.12.01.08.59.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 08:59:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4oob8pap.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134227>

On Tue, 1 Dec 2009, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I had to step back a bit and ask myself what we are trying to achieve
> > here.  When the current blame and incremental one are both working
> > perfectly and well, will there be a reason for the end users to choose
> > between them when they click?
> >
> > My answer is no.  If the incremental one gives nicer user experience in
> > all cases, it will be shown without the non-incremental one; if the
> > incremental one makes the server or network load too heavy, a site owner
> > may decide to show only the non-incremental one.
> >
> > That makes my addLinks suggestion a change that would help _only_ while we
> > are working kinks out of the incremental one.
> >
> > Let's not waste too much effort doing that.  Sorry for suggesting.
> >
> > Letting the site owner choose if the site wants to set the "incremental if
> > possible" boolean would be more than adequate, I think.
> 
> Sorry, but I guess I dropped the ball after this message.  If I understand
> correctly, the conclusion is that I can apply the patch in this one
> 
>     From: Jakub Narebski <jnareb@gmail.com>
>     Subject: [RFC/PATCH] gitweb: Make linking to actions requiring JavaScript a feature
>     Date: Thu, 26 Nov 2009 21:12:15 +0100
>     Message-ID: <200911262112.16280.jnareb@gmail.com>
> 
> and shipping 1.6.6 with it (perhaps setting 'default' to '[0]' instead)
> would be both reasonably safe and allows easy experimentation by willing
> site owners (or individual gitweb deployment), right?

Yes, I think it is right.

As a followup to this mail I have sent modified version of patch mentioned
above, only with default setting for 'javascript-actions' changed to '[0]'
(disabled), and new patch adding link to 'blame_incremental' action in an
ordinary 'blame' view and vice versa, so even if 'javascript-actions' is
turned off one can experiment with AJAX-y blame.

 gitweb/gitweb.perl |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

-- 
Jakub Narebski
Poland
