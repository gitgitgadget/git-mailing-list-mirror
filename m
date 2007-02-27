From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 13:49:42 +0100
Message-ID: <81b0412b0702270449r7aced195xa0a24af78d94243a@mail.gmail.com>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 27 13:49:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1m9-0007K4-9b
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030611AbXB0Mtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030614AbXB0Mtp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:49:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:12048 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030611AbXB0Mtp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:49:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1093189uga
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 04:49:44 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XM1hXnlD0bM+FdtRLAcs93xqrpjPrHgFmXgnUGKFJW+T+A8/F+sHNI1wGEUJKggMc4zspistdkq/jxQUgm2PSi4BXPzppuxYlXHWK0hB5MXEmW1isfhjvUP4PGTLQMxJLVrk77CR370wld2NkOkQJ0MaMDKF7DRDy1liYI5gP68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H+3enU/3OIo9lmz/Sw8oq2A8Tp9EYCTzMDn17Rsvx4Q9hMGJN+ODnuCfUwn1UmE55aN0qAKbYv4u57tfvSYLGCBt6esndJlG9GHWe1DNe3y2PvaZ2vjQZCXvfNOrspCDMi9eSpH/QnsqL00UwvxWkx/IZKEurzj6/Wwr52BzOHw=
Received: by 10.78.47.15 with SMTP id u15mr566681huu.1172580583067;
        Tue, 27 Feb 2007 04:49:43 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 27 Feb 2007 04:49:42 -0800 (PST)
In-Reply-To: <E1HM1XL-00071C-N5@candygram.thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40725>

On 2/27/07, Theodore Ts'o <tytso@mit.edu> wrote:
>
> So given a particular tree-ish and a pathname, I'd like get the contents
> of that particular file as of a particular revision.  i.e., the
> equivalent of:
>
>         cvs -r v1.37 -p e2fsck/pass1.c
> or
>         bk cat -r 2345 e2fsck/pass1.c
>
> The closest I've been able to come is to use
>
>         git archive --format=zip v1.37 e2fsck/pass1.c | gunzip
>

git cat-file -p <objname>:file

I.e.: git cat-file v1.37:e2fsck/pass1.c
