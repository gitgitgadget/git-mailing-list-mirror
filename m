From: Fabio Augusto Dal Castel <fdcastel@gmail.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Wed, 11 Feb 2009 18:40:15 -0200
Message-ID: <38cfbb550902111240v6e593bfw5c8347d92fe8f767@mail.gmail.com>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
	 <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil>
	 <38cfbb550902101240x1202c592ra7eb01d66e22da43@mail.gmail.com>
	 <20090210230054.GD26954@coredump.intra.peff.net>
	 <vpq3aelcpjk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Feb 11 21:42:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXLuC-0002hU-V8
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 21:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757653AbZBKUkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 15:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757616AbZBKUkT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 15:40:19 -0500
Received: from qb-out-0506.google.com ([72.14.204.229]:28657 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457AbZBKUkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 15:40:17 -0500
Received: by qb-out-0506.google.com with SMTP id q18so275508qba.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 12:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AoNJPsn4zPmOLqaRIi7ezm+h5tMuyI6XMLuH3MXaME8=;
        b=B5Jss290C7W/zYBsruiPFmJZZ8pa0Bpw2JfLyZyko8Khbdhx1tmvo9cb4bQycykuhq
         eEDRYs4fQJ9U5jttkAt6wMHP9XaU5xTnUAu3DX+rNN4PJU+Z+vnBThXCVkGrDRXLoxI+
         hFLKmPTkpuxUMNDfgcwCUrDSGSez2ijbWjpcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EbCk7I0S/wn2/7PJ8envSfdmiTJdDXw65F0p5dXgcbavg9Y4jKygPtjlj+l6rcCWE+
         VjCGpI2kU/dCnjiZFvZdVIxcQdWNt0C4N6xGOPnyNFbV3zACK7cgGnVkyib15mH7Wzxi
         0WqyZ/M+XtOAWlqP+I0biHh+qI1B4yUW1M0nY=
Received: by 10.231.19.72 with SMTP id z8mr15180iba.6.1234384815426; Wed, 11 
	Feb 2009 12:40:15 -0800 (PST)
In-Reply-To: <vpq3aelcpjk.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109523>

> Doesn't that argue for "git stash --no-reset" or similar instead of a
> separate command?

Yes. And also for an "--untracked" (as already suggested).

Since stashes does not expire anymore (as correctly pointed by
Brandon), a snapshot could be reduced to an alias for:

git stash --no-reset --untracked

(except for the branch storage)


However, the rationale behind a new command was also to avoid the
'loss of identity' of stash (as currently implemented). I always saw
stash as a way to allow a temporary hack or a pull. If we start adding
a lot of switches into stash that ultimately would change its main
purpose, should it yet be called 'stash'? (something like a 'git
commit --no-commit' ?)

(Please, don't get me wrong: I'm just raising food for thoughts, here)

Maybe the 'stash' command and multiples switches would be more
appropriate if 'reset' was NOT the default behavior. Something like:

git stash [--untracked] [--reset]

where the current 'git stash' would be 'git stash --reset'.Of course,
this would be a significant breaking change.

I know... I know...  "Heresy!" You'd say... <g>

But... what about it? Why, after all, stash MUST do a reset?

"Do one thing. Do it well"?

Regards!
Fabio.
