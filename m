From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit [its a workspace id, isn't it?]
Date: Sat, 14 May 2005 15:02:41 +1000
Message-ID: <2cfc403205051322026f3189da@mail.gmail.com>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <2cfc4032050512183788e01fc@mail.gmail.com>
	 <20050513222502.GD32232@pasky.ji.cz>
	 <2cfc403205051316495b46115e@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 07:02:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWond-0003tA-GD
	for gcvg-git@gmane.org; Sat, 14 May 2005 07:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVENFCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 01:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVENFCo
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 01:02:44 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:65404 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262463AbVENFCm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 01:02:42 -0400
Received: by rproxy.gmail.com with SMTP id i8so297700rne
        for <git@vger.kernel.org>; Fri, 13 May 2005 22:02:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dR20HpvaP4U+ot2RULIaQRaGiWSH3RRS0bllnhmNe0lRxHgL9PMImPE5AW2SMt1ZmFfzjXPy/NMd/Bj7IfaZi8k8BoepBMcbbturnHGRsW5dViys1PDRZVk5nukEcSvNSa7iSfJj6DVKNZy+s5N/7IXpDGwZtGl6PqGqDdtbNmo=
Received: by 10.38.88.73 with SMTP id l73mr1122919rnb;
        Fri, 13 May 2005 22:02:41 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Fri, 13 May 2005 22:02:41 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <2cfc403205051316495b46115e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Of course, this graph wasn't really the best example of a traditional
SCM branch or the point I was trying to make.
> 
> Rn -------------
> |      \         \
> Rn-1 Ba,n   Bb,n
> |     /             |
> Rn-2             |
> |       \           |
> Rn-3 Ba,n-1  |
> |    /             /
> Rn-4 -----------

It's more like:

Tn     B,W(a),n
|        |                 \
|        B,W(a),n-1   B,W(b),n-1
|        |                  |
Tn-1  |                   |
|        B,W(a),1------|
|       /
Tn-2

Branch B diverges from the main trunk T, parallel (but frequently
convergent) development in branch B happens in two workspaces W(a) and
W(b).

So a branchid would track all commits that contribute to a branch,
while a workspace id would track which commits happened in which
workspace, to enable the reconstruction of the merge order of the
global history with respect to the workspaces that perform commits.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
