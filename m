From: skillzero@gmail.com
Subject: Re: git commit <path> scanning entire working tree?
Date: Mon, 16 Feb 2009 19:37:57 -0800
Message-ID: <2729632a0902161937o4ac3a1aeg143dda509ba5e384@mail.gmail.com>
References: <2729632a0902161458m732af362od59e5f35af5643c3@mail.gmail.com>
	 <7vwsbpewkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 04:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZGoP-00048j-HZ
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 04:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbZBQDiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 22:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbZBQDh7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 22:37:59 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:1467 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbZBQDh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 22:37:58 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1054311yxm.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 19:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=1VM7rc7BEk1UZ3zLHwyZNu/g4rx8ZIFwEdzypQGXDYI=;
        b=Q4ogeWCA7LB962qI97iRGXaJQQ0hR+Se1XHxVvOVxGow53c7FVvDj+EP7XkIMdjmdb
         7xJv+gShAxBsbU8qzBZlEH+aYUBO4IAziVweoiV1PFNocMOxzV6j1mvdshbDpGWH+tdT
         ZmN/7yAice/F7sAhg0Dy5nwfH4E2Q7+9fx6sw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=fxJ5shv14JypcGASkKHQrhYBAkkMwt+dLd/2SybM8ehVyd7UARpcpqeVGMHaZzCoVe
         Mx9tvR7+I3zvtWJNn9vfl1JQtPAp1n8FFb4pntlgOH2cWY4Eoxxu+RHRQNsVRqK8dMo+
         6Jc6Y7T42T4vnmggv9kAos4erU6MCdGQoXe9Y=
Received: by 10.151.112.10 with SMTP id p10mr4944642ybm.191.1234841877262; 
	Mon, 16 Feb 2009 19:37:57 -0800 (PST)
In-Reply-To: <7vwsbpewkl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110305>

On Mon, Feb 16, 2009 at 4:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Do you mean you edit the commit message, starting from the message
> template "git commit" gives you?

Yes, there's a large delay from me entering 'git commit -a' and when
the editor shows up.

> The template lists "Changes to be committed" (which obviously would list
> only the path that matches the single pathspec you give to the command,
> and there is no need to scan the whole tree -- it only needs to check the
> file or a directory hierarchy if the pathspec matches a directory), but
> also "Changed but not updated" and "Untracked files".  You cannot generate
> the latter two lists without checking with your work tree.

It seems like it shouldn't scan/show things outside of the path. If
I've specified a path on the command line, I most likely only care
about things in that path. I think it would make committing specific
paths much faster when you have a large tree. However, it would
eliminate information (changed/untracked files outside that path), if
people are relying on that.
