From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Mon, 11 Jun 2007 10:05:53 +0200
Message-ID: <81b0412b0706110105t369d908v70a140505caee778@mail.gmail.com>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
	 <alpine.LFD.0.99.0706102206590.12885@xanadu.home>
	 <81b0412b0706110024mf975011t27b23555f6a23cc6@mail.gmail.com>
	 <7vbqfnrl54.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Johan Herland" <johan@herland.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 10:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxeua-00018P-Ci
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 10:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbXFKIF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 04:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbXFKIF4
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 04:05:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:55492 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbXFKIFy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 04:05:54 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1416780ugf
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 01:05:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dv4gInCcBq3oSnJmwpDWFP+nILQVsFr6vS7hO75QJTguSZDqRpsz2IL7z9HZ4DMwK2K9qP1D4wEuxguu5rNHz/Toep2SAyB8aTDAs6EYpXoXHxjzI+V2Y9QevXpkYhRkEHqGLT9NjiH1aQp06qXY3pygg3uSd87k4U/1mUXi568=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ifj8r53ZwGZMMzV/1ri8h8G8LW/D12RAvwkqtSDvFuSaY+GsJ0dv1LmE6LAMVerfBkq2LZI5IcHcoQv/6ZJHO5nAJK9Tp2kJ1xkgKHnJcSjwLZgthuvzcDsdx5g03mT76kVYPf4qN+iPeKR9Y151yC1YcUjC4bhRagEanQ8JfzM=
Received: by 10.78.185.15 with SMTP id i15mr2044273huf.1181549153528;
        Mon, 11 Jun 2007 01:05:53 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Mon, 11 Jun 2007 01:05:53 -0700 (PDT)
In-Reply-To: <7vbqfnrl54.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49830>

On 6/11/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > It is still a reference, really. Besides, if it is not under refs/, we'd
> > have to change fetch/push to allow distribution of the notes/annotations
> > (there are special assumptions regarding reference names starting
> > with "refs/"). Right now it just works.
>
> Two issues.
>
> One is that it is unclear is how the reachability rules should
> be.  Should an ??/?{38} entry in the refs/annotations/commits
> protects the commit the entry talks about (i.e. ???{38}) from
> getting pruned?

I think it should be the other way around: annotations get loose
and reported as such (and maybe even removed) by git-fsck.
