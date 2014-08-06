From: Linus Arver <linusarver@gmail.com>
Subject: Re: [PATCH 4/7] Documentation: git-init: --separate-git-dir: clarify
Date: Tue, 5 Aug 2014 22:21:30 -0700
Message-ID: <20140806052129.GC12559@k0>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407002817-29221-5-git-send-email-linusarver@gmail.com>
 <xmqqiom6oabe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 07:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEtfP-0004Nn-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 07:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215AbaHFFVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 01:21:35 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:64709 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbaHFFVe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 01:21:34 -0400
Received: by mail-yh0-f50.google.com with SMTP id v1so1401428yhn.9
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GNevdyWEDWV/2CTFfIx1kEW4ZfM8/czxpESvz7AQELA=;
        b=k+yY5I/Fsl5uvOuTZqVGqVtwqKr1nMABU2+wrldzu3mvF0+/4b81UsR5vYJQHIl/PE
         qn7bKGNBsODBX000I8a6fs0Q/St27WaO7bmyvS8GGA3WyHE7ZuJIXF9XtxyuPH91H+R6
         CNIbC59r9Wewep6J9l+i/oU/qkg+I9SXriD3+DiJHvE6Y6GON13JTn0BtzEJJnseoekD
         fR9Qva4+Uz2lM2Em2IkKsLO3IZAPMxd3xnSifhNS/lyCpHkpP0qwnGf1Vi1vwLb7q3Xy
         z63hLMg3jGpKkFgYSNeqEHlNmxUNoKWCaiQqpe2MJlJ+GblWXJ36v0ShYbP51fz3VBnM
         Hkcw==
X-Received: by 10.236.142.227 with SMTP id i63mr13078642yhj.88.1407302494431;
        Tue, 05 Aug 2014 22:21:34 -0700 (PDT)
Received: from k0 (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id o22sm6869385yha.22.2014.08.05.22.21.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Aug 2014 22:21:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqiom6oabe.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254844>

On Tue, Aug 05, 2014 at 03:12:21PM -0700, Junio C Hamano wrote:
> Linus Arver <linusarver@gmail.com> writes:
> 
> > Signed-off-by: Linus Arver <linusarver@gmail.com>
> > ---
> 
> You would need to work on your justification skills ;-) in the log
> message.  What does this change "clarify" and in what way?

Oops, sorry. I guess I should have written some more information in the
commit message, something like this:

    Use shorter sentences to describe what actually happens. We describe
    what the term "Git symbolic link" actually means.

    Also, we separate out the description of the behavioral change upon
    reinitialization into its own paragraph.

> >  Documentation/git-init.txt | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> > index f21b85b..bf0a7ae 100644
> > --- a/Documentation/git-init.txt
> > +++ b/Documentation/git-init.txt
> > @@ -57,12 +57,12 @@ DIRECTORY" section below.)
> >  
> >  --separate-git-dir=<git dir>::
> >  
> > -Instead of initializing the repository where it is supposed to be,
> > -place a filesytem-agnostic Git symbolic link there, pointing to the
> > -specified path, and initialize a Git repository at the path. The
> > -result is Git repository can be separated from working tree. If this
> > -is reinitialization, the repository will be moved to the specified
> > -path.
> > +Separate the Git repository from your working tree.  Instead of initializing the
> > +repository as a directory to either `$GIT_DIR` or `./.git/`, create a text file
> > +there containing the path to the actual repository.  This file acts as
> > +filesystem-agnostic Git symbolic link to the repository.
> > ++
> > +If this is reinitialization, the repository will be moved to the specified path.
> >  
> >  --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
