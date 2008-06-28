From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 06:57:04 +0400
Message-ID: <20080628025704.GJ5737@dpotapov.dyndns.org>
References: <g43jlg$54g$1@ger.gmane.org> <-8386235276716376372@unknownmsgid> <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com> <7viqvuo4hq.fsf@gitster.siamese.dyndns.org> <9af502e50806271708p7979ae65k61b71be90efff2c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Jeske <jeske@willowmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 04:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCQdk-0003wU-Vo
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 04:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbYF1C5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 22:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbYF1C5N
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 22:57:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:9485 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbYF1C5J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 22:57:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so368220fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 19:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zvJpfH7F8IRLpjSvKT2LaqQ2AsaPu4cS436h814GGTg=;
        b=gNJPMW004DVIe2pdWwqR/xpiCa2hox8C56k3yG0/4RcHnxfba4Mn1RF4Ni5JBXHQ/J
         P8y+HrQgCTY6nNGrKgtSOIoMKJVxSNIBtA6NivmRNBeBzzGaWmavyoqp1bs3iel6wDqY
         PTxUkoGKiE74egv46OpG+kYGRwa0daLGuR2TQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mTffbTFuS7F0pRg7pkco3549z6Fzl0YFoNp9n/x15lBzbAZ+pny0QDRDApAB9xW648
         A6SvzfMsnkNTOsdgatf6EximlTP1EUiINY0m6P0KkINa75f/cs+8hm5TFtd6wjc2vp0+
         UYwHMNDOhJDdh2ahxyGnlA7NO4GO0/g3BkNwg=
Received: by 10.86.33.19 with SMTP id g19mr2907995fgg.4.1214621828814;
        Fri, 27 Jun 2008 19:57:08 -0700 (PDT)
Received: from localhost ( [85.140.169.188])
        by mx.google.com with ESMTPS id 4sm3858024fgg.9.2008.06.27.19.57.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 19:57:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9af502e50806271708p7979ae65k61b71be90efff2c4@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86696>

On Fri, Jun 27, 2008 at 05:08:57PM -0700, Robert Anderson wrote:
> 
> In the existing model which is being suggested as a way to get the
> desired workflow, there are two distinct classes of commits:  commits
> that are "for real", and commits that are "temporary", that are being
> used as some kind of workspace for orthogonalizing a set of changes,
> which will eventually be replaced by "for real" commits.

Not really. Good commits do not get replaced by anything. They are
just pushed to the public repo after being tested. Those commits
that have not passed the test should be amended and tested again.

> Yet git has
> no metadata to distinguish these two types of commits.  When only "for
> real" commits exist, I can push HEAD.  When "temporary" commits exist,
> I cannot, or insidious problems will ensue.  This metadata concerning
> "for real" or "temporary" commits is only maintained manually in the
> developer's head.

No, you can use a tag for that, which marks the tip of tested commits;
or you can make your test procedure to push commits automatically after
successful testing. There is no reason for Git to have any metadata for
that.

Dmitry
