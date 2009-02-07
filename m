From: James Pickens <jepicken@gmail.com>
Subject: Re: [BUG] 'git log --quiet' doesn't suppress the output
Date: Sat, 7 Feb 2009 00:18:52 -0700
Message-ID: <885649360902062318n4e51ded0r957f6199ff9afc1a@mail.gmail.com>
References: <885649360902041819k4a168407wc57017e6a1c7d00a@mail.gmail.com>
	 <20090206191146.GC19494@coredump.intra.peff.net>
	 <885649360902062244v715a61b7nf32003c97cc4f707@mail.gmail.com>
	 <20090207065602.GA14995@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 08:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVhUD-0001qK-IU
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 08:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbZBGHSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 02:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbZBGHSy
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 02:18:54 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:61381 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbZBGHSx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 02:18:53 -0500
Received: by wa-out-1112.google.com with SMTP id v33so559490wah.21
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 23:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=cIw/ZRNTjlhxGiasnkJyWsX2YfqCBnZbDSM/+EFV+3E=;
        b=kP83RhB8Zr7iCc9ho1GPrB3q0LASIAmGbIIUgb+1IfD3o2y1Pd3a7RrXigCzf2v7aF
         z4bGl9JOUPEKtZe9Z3rxt0165pMzRToetM7yQfkwrzJ5DKAynlIh1sBf8JIOKJlf9mII
         hOG2khCNYz958mdcUkKkxdclUPZDN3wf/PvO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=kz9aCfxiI7RZP7rBDyxmGQA+HX+wVOFoNEvUPAIU5YoMkyxwLbuGj2Z8Vsx5PHuQ6n
         uXnOtBeKjOlDKmN+3K+xaI3UnZnY0wEIuCLcFvF+dOtfAbtaoQ6GUjk5NwBBPeIbL8i4
         VxCl4eCIy+NHivvTDordyznqfZcwjoXY2W1b4=
Received: by 10.114.211.17 with SMTP id j17mr1835456wag.61.1233991132829; Fri, 
	06 Feb 2009 23:18:52 -0800 (PST)
In-Reply-To: <20090207065602.GA14995@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108820>

On Fri, Feb 6, 2009 at 11:56 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 06, 2009 at 11:44:59PM -0700, James Pickens wrote:
>
>> I was writing a script, and looking for a way to figure out
>> whether there were any commits in origin/master that aren't in
>> master (i.e., whether I need to pull before I can push), and 'git
>> log --quiet origin/master..master' was the first thing I thought
>> of.
>
> OK, that does make sense.
>
> In this case, though, you should be using the "git rev-list" plumbing
> instead of the "git log" porcelain for a script. And "git rev-list" does
> support "--quiet", but it doesn't quite do what you want. It silences
> the output, but the exit code does not depend on whether or not there
> were any commits in range.

Thanks for the tip; I'll just use rev-list and check if it gave any
output.

James
