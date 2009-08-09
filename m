From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v4 0/5] Re: {checkout,reset,stash} --patch
Date: Sun, 9 Aug 2009 18:32:33 +0200
Message-ID: <20090809163233.GA12911@vidovic>
References: <200907271210.40001.trast@student.ethz.ch> <cover.1248815580.git.trast@student.ethz.ch> <20090809065207.GA14093@coredump.intra.peff.net> <200908091117.19167.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Aug 09 18:32:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaBKC-0000qk-Qh
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 18:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbZHIQcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 12:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZHIQck
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 12:32:40 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:34933 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbZHIQcj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 12:32:39 -0400
Received: by fxm28 with SMTP id 28so553648fxm.17
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=hb8YvhgWhfjAq8eOcUUd8vRZcLltwOAMX8WvjkHdW/Q=;
        b=uQEw30BTBONfasNklggJg0V/Uef/7rrGzuHrNMIM0LenHi6wqJljeeRH0be+3tXF5n
         +n3GTRs8zI7DwZX4gcaFiqEl5XicHVUIdCm8dhCLr41MwM7ofHh6D+3N4b2MJwLRqG8k
         7xeLV6UP+jntnoRMGPYY6JXA+Y4cPx85K1uDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LTvJJQ5RsDDkENRIo9pQd2VUaaGdf2xr9Km0VEIqs+zBIhsDvqtEDRPbvNNY1I0oc/
         /PGkShIjXYuyiKOPYP8evbK/5Klp5LgLH5NdKiLujRnmDeufGNVj09WVcliE9Yhdf3c+
         KFcabQvrHw5+SviPpk+sPP9P+8s2KL3srscyg=
Received: by 10.103.241.15 with SMTP id t15mr20870mur.4.1249835559932;
        Sun, 09 Aug 2009 09:32:39 -0700 (PDT)
Received: from @ (ABordeaux-258-1-17-85.w92-134.abo.wanadoo.fr [92.134.20.85])
        by mx.google.com with ESMTPS id y2sm15640469mug.42.2009.08.09.09.32.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Aug 2009 09:32:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200908091117.19167.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125352>

The 09/08/09, Thomas Rast wrote:
> Jeff King wrote:
> > 
> > Shouldn't the diff be reversed? That is, I think what users would like
> > to see is "bring this hunk over from the index to the working tree". But
> > we have the opposite (a hunk that is in the working tree that we would
> > like to undo).
> 
> Well, my thinking for the initial (restricted; you couldn't say 'git
> checkout -p HEAD~14') version went something like this: 'reset -p'
> should be the opposite of 'add -p', so it offers the same hunks with
> the question "Reset?".  Then 'checkout -p' should somehow follow suit,
> but asked "Discard?" (IIRC I even had it in all caps).

I agree this approach is fine. That said, I admit I've been confused at
the beginning. FMPOV, asking "Discard this hunk?" is a real improvement.

In the same way I'd change "Reset?" of 'git reset -p' to "Unstage?".
Otherwise, the end-user don't know if the command will discard the hunk
from the WT too.

Also, I'd expect to have 'git reset --hard -p' discarding hunks from
both the index and the WT (which is not possible for now unless I missed
something).

-- 
Nicolas Sebrecht
