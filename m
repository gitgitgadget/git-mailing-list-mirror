From: "Dan McGee" <dan@archlinux.org>
Subject: Re: [PATCH] send-pack: respect '+' on wildcard refspecs
Date: Fri, 19 Oct 2007 20:00:37 -0500
Message-ID: <449c10960710191800j3e61b80cma2c582080c1dd07c@mail.gmail.com>
References: <20071019090400.GA8944@coredump.intra.peff.net>
	 <449c10960710190510y3af3ffa2ydb9ae4a01b5d480c@mail.gmail.com>
	 <20071019122755.GA17002@coredump.intra.peff.net>
	 <449c10960710190638j5823b19dl903ae369965e884e@mail.gmail.com>
	 <20071019134339.GA21852@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 20 03:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij2hv-0004lz-DT
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 03:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbXJTBAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 21:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbXJTBAi
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 21:00:38 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:53926 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbXJTBAh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 21:00:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so609284rvb
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=gjgIghPQSVTER4rJ7FAW2+AGIvTLLFDBqO082pOdui0=;
        b=KCQp0IJw9CsH0A3SGaLN4FauB1SOsaKzgNlip5/McmygLDFcsS87tam5xGm6PXgyoPqkHoIPLZwEU9WwnqNoOlPujkobestfxFdgj3u2zQHCzQFOtsI/HUXuMV1RCW0iEcnfkXMlRxVZrsC8OpzlCVcT0nbHgkgAV8qwTej7qCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=qGqgGsKjxyy+EyfOPvxkGiI7nuN1Oq3gMqehbgVA02jWyQ78vqJeTHiOsRKMsHkCda6KjlZoHEasNZgpHhIkBQloSBp27Os+1tfEsSr/rwSLINOWFSdewky+Emo4vC56ioZk9zBcJXwEVHhNK0qPxWCy7nV2k10a6AA8qVBqmKI=
Received: by 10.114.52.1 with SMTP id z1mr2669719waz.1192842037277;
        Fri, 19 Oct 2007 18:00:37 -0700 (PDT)
Received: by 10.114.67.15 with HTTP; Fri, 19 Oct 2007 18:00:37 -0700 (PDT)
In-Reply-To: <20071019134339.GA21852@coredump.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 4f942e0f11865357
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61776>

On 10/19/07, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 19, 2007 at 08:38:06AM -0500, Dan McGee wrote:
>
> > origin(junio)/master: 58ba4f6
> > origin(junio)/next: fe96ee67ec5840
> > spearce/master: 7840ce6cb24a9d
> > spearce/next: 2fe5433b416f0df
> >
> > Can you let me know what commit you based the patch off of? I'm at
> > work for the next 8 hours or so, so I can't look in to this a whole
> > lot until tonight.
>
> It is based on Shawn's next, 2fe5433b. Are you sure you're not doing
> something silly like executing an older version of git that is in your
> PATH?

Turns out I didn't have GIT_EXEC_PATH set up right. Once I do that,
everything seems to work just fine.

Thanks for looking into this Jeff, and git-bisect just won me over. It
made easy work of finding the commit that broke this.

-Dan
