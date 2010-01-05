From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: How to exclude files from "git diff"
Date: Tue, 5 Jan 2010 20:54:08 +0300
Message-ID: <37fcd2781001050954y778ba661n7cee6cda699968c2@mail.gmail.com>
References: <6dc9ffc80912180909q2e9cbe30r7c802a2152c5954@mail.gmail.com>
	 <20100105064509.GC19025@coredump.intra.peff.net>
	 <6dc9ffc81001050620q55c23072p93f58c8685d77f9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 18:54:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSDbk-00037j-Eq
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 18:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab0AERyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 12:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594Ab0AERyL
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 12:54:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:5592 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab0AERyK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 12:54:10 -0500
Received: by fg-out-1718.google.com with SMTP id 22so6536849fge.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 09:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=GYWZaqHnwtmUqUaUgWJTwK9f9mYrPxcQk5BuJuweKfo=;
        b=PRU27C5APwp7fniJAequQt8prrsgn9kMXAOp6MXUECZbcsmNM0fiS1j5HnkNlXZ6WX
         1E4atJhlCb9wX17/VjnFd1xD+uXCgcql111n0eJV3QcFnnrrZKClDCO9q3SyD9BfMk+A
         nWiJPxZHliL0tmiUPjIDofbKSOvr8B1qs3zbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xUYPIllCoNMMIz9HRABaSQ+pLfkYJL3JYpMmrXUIsxQOWFl9Kg4sUBOoHss5I6udHU
         XPO1mAqExOjhLADwVCgP1KL3x4U+L+TDUr3p867ICW/Y8kd5LFX48HzUtGTlELs4U58U
         MBTcR7z4TZLsNcAF/7CfBQxOZeIGa5Gp515/o=
Received: by 10.239.187.82 with SMTP id k18mr492183hbh.5.1262714048983; Tue, 
	05 Jan 2010 09:54:08 -0800 (PST)
In-Reply-To: <6dc9ffc81001050620q55c23072p93f58c8685d77f9d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136196>

On Tue, Jan 5, 2010 at 5:20 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>
> Yes, I want those files in repository. They are for my personal use only.

If you modified some file locally and do not want to see and commit
those modifications, you may want to use:

git update-index --assume-unchanged foo

After that, git will not notice any change to `foo'. So, 'git diff' and any
other command (such git commit -a) will ignore those changes.

Warning: using  --assume-unchanged may result in losing your changes
if you switch between branches containing different versions of 'foo'.

Normally, when you try to do that, git will not allow switch to another
branch saying that `foo' is modified. But using --assume-unchanged
disables this check. But if you have the same `foo' on all branches
then switching between branches will preserve your modifications.


Dmitry
