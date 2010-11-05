From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Problems switching branches
Date: Fri, 5 Nov 2010 15:41:52 +0700
Message-ID: <AANLkTinN7xE5eR7ncyr+mVhyNbz1r5Au=LFCJQgh8fMr@mail.gmail.com>
References: <loom.20101103T032930-451@post.gmane.org> <loom.20101104T012032-963@post.gmane.org>
 <AANLkTikK93Jt+dAkpp6K-hQEo6D67q5OKJSLs+g0YL4y@mail.gmail.com> <4CD3A5D9.6070802@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Maaartin-1 <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Nov 05 09:42:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEHsJ-0006ir-ME
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 09:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab0KEImP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 04:42:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47354 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab0KEImO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 04:42:14 -0400
Received: by wwb39 with SMTP id 39so1143753wwb.1
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=72V4brnNUpbYGmN8Vwfi7qArcvGqDLehpQLSsw3mngw=;
        b=bZ74V6yhVe6sFWPJbHbTkl8GH5lkka3cQ4xTqVb+89MIT6vcDCz+3M4dX3uFSh3Nhs
         r09zBu7BW2B7pLhZUxiEVzCvWuEepeNM4tCKtNGMnBa43EXb2at0sR8suWnNQxFEuYCu
         3AC4TwCQ/EliQhO6WkVVrEcLnxxdqCfxYc3/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=B/8PcXnWOMT+BcHoGwWmKJ7ERN68Nv5u7XFglzrNdqI2GijqWqZx/4021ECkQcOWJi
         2EOULoXzmS+WZCVjy/Ig0AVmEhEFeONHsVrBa4+0yJ9Gt37V8GnuQDb3b+V8ZlIHMbhk
         oqyfKXrjySEpC8dmDJUZt7CjqYTt9HLbVwCw0=
Received: by 10.216.172.9 with SMTP id s9mr1802010wel.56.1288946532468; Fri,
 05 Nov 2010 01:42:12 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Fri, 5 Nov 2010 01:41:52 -0700 (PDT)
In-Reply-To: <4CD3A5D9.6070802@seznam.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160807>

On Fri, Nov 5, 2010 at 1:36 PM, Maaartin-1 <grajcar1@seznam.cz> wrote:
>> But your approach may be better. Yes, I think it's possible. Any
>> suggestion for checkout's new argument? --no-overwrite-untracked seems
>> too long.
>
> I would go even further: a switch called "ignorant" or "lenient"
> allowing to always switch branches in a non-destructible way. All files
> normally causing abort would be left unmodified, so you could do
> git checkout --ignorant forth; git checkout back
> and would (assuming you started in branch "back") land in the original
> state without loosing anything. Of course, this means, that the ignorant
> checkout doesn't lead you into a clean state, but that's why I'd like to
> use a switch instead of making it the default. :)

One thing to consider. If there are conflicts, I don't think we should
allow this "ignorant" mode. That would mess up work tree in a bad way.
And because it would leave worktree in a dirty state, maybe
--dirty-worktree is suggestive.
-- 
Duy
