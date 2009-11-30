From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git archive without path
Date: Mon, 30 Nov 2009 18:45:35 +0300
Message-ID: <37fcd2780911300745r79c0cb54ifc3af5e79bb963e4@mail.gmail.com>
References: <20091130123203.GA11235@dpotapov.dyndns.org>
	 <4B13C2FE.3040707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 16:45:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF8Rb-0008In-S4
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 16:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbZK3Ppb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 10:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbZK3Ppb
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 10:45:31 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36549 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbZK3Ppb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 10:45:31 -0500
Received: by bwz27 with SMTP id 27so2613556bwz.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 07:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zy+qeGugAgVZGhC/reySU9TZ5mdoeXxUN6BtxhB3e9A=;
        b=jk2Efl1OZPyXYjbE9JPHU14EUMcixgJ0zQUobYy2rYJHux89/CiZ41PvPtcUGRqhQj
         QIGcqEhw5TMoPuia8I02Bqxwv465BfbkTyVbi6HeDArBTuYf8jGxCe11BxsWqYhXzKMT
         8Bj9trhY4RhEsOZqss5msgrGR/zPIXipoL0Do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WuVF7A1Z/Gb4jA8PilIY9wUdE1rRDw8/yGJXOSgJhmMeXWeo0Q2uCkbuScj2//QHhy
         g8XoXf+BCWG9wXUI/Cch0bfuvUOw6qP4JdNmm1F2r7Lck0nnR3jVSOxVDsEDUCCsnTDv
         XL6nxH+wzyZRp2rf8kIp8hk5fthNxIvbZkabQ=
Received: by 10.239.163.222 with SMTP id q30mr493723hbd.128.1259595935814; 
	Mon, 30 Nov 2009 07:45:35 -0800 (PST)
In-Reply-To: <4B13C2FE.3040707@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134115>

On Mon, Nov 30, 2009 at 4:05 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> Depends on the definition of "all" :)

I don't think it caries any restriction clause in this case....

>
> In fact: Two mighty powers are fighting right now for the primacy in the
> Land of the Git, and both carry the name "consistency" on their flags.
> One is the "order of the consistency of generations", also named
> "backwards compatibility", and one is the "order of the consistency of
> commands", also named "user experience".
>
> Many commands have different defaults with respect to how they behave in
> a subdirectory (compare status to ls-files, e.g.), and the discussion
> about how to best change that are underway, most prominently in the case
> of git grep.

Well, "order of the consistency" is a noble cause, but I don't think the
situations are comparable. The man page for git-grep has never claimed
that git grep works on all files. Also, git grep works on the working tree
by default, so defaulting to the current working directory at least makes
some sense. I cannot say the same about git-archive, which only works
on the repository and if I specified some revision without any path then
I expect to have the whole archive not some part of it just because I
happened to be in some subdirectory.

So, in the case of git-grep, we speak about changing the behavior that
was well-known, often used, and documented as such. On contrast,
git-archive documented as including all files if path is not specified.

Dmitry
