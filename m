From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: git and mtime
Date: Wed, 19 Nov 2008 17:18:16 +0100
Message-ID: <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com>
References: <20081119113752.GA13611@ravenclaw.codelibre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Roger Leigh" <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 17:19:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2pmA-0002lw-8n
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 17:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbYKSQST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 11:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbYKSQST
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 11:18:19 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:26235 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbYKSQSS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 11:18:18 -0500
Received: by yw-out-2324.google.com with SMTP id 9so15600ywe.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 08:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iQT/jDLp4YaCru8Xtj/fNyXidvqT+hx6vGl/PnucVQU=;
        b=NMmxvxCnTK8+qUJTJq6tsPwuBFAxEceBzePOa79SRBib/jzOBUk2OUIhlNUwqpIrM4
         XtNpCYFHeNtHRA+OvJRhkwD02dZh3wxXYWfbW8DCWYbt1UbkGycXRU82El8M3tnxL13p
         7OilEY0RaoGRIodUmurBBcHz9Hnq8E7WR0bpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DW5ka7IQ7NJhK4TpzscmcQVmob6az54zy214ypKAJdfY48RZ4bQ/J6FdQimQv7sgFo
         uSqkDowUEWSOTfCTw/D/fTI6I7vBTQLYppYI/GezMno6TJ2SE6zJWTgNZdJzzs7wwlbG
         5BKfq5U2N7L4dGc/kZ60XWBMHqb/SO4Iv+hFg=
Received: by 10.142.245.6 with SMTP id s6mr623211wfh.34.1227111496615;
        Wed, 19 Nov 2008 08:18:16 -0800 (PST)
Received: by 10.143.28.17 with HTTP; Wed, 19 Nov 2008 08:18:16 -0800 (PST)
In-Reply-To: <20081119113752.GA13611@ravenclaw.codelibre.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101359>

On Wed, Nov 19, 2008 at 12:37 PM, Roger Leigh <rleigh@codelibre.net> wrote:
> Would it be possible for git to store the mtime of files in the tree?
>
> This would make it possible to do this type of work in git, since it's
> currently a bit random as to whether it works or not.  This only
> started when I upgraded to an amd64 architecture from powerpc32,
> I guess it's maybe using high-resolution timestamps.
>

beside the obvious answer it comes back often as a request, it is
possible in theory to create a shell script which, for each file
present in the sandbox in the current branch, would find the mtime of
the last commit on that file (quite an expensive operation) and apply
it.

I had a need for this once, then lost interest since using git as it
is is so much better than trying to mimic behaviour of old scm tools
and makefiles.

You should store mostly content of source files. You should do a make
in your first cloned repo at least once before committing anything to
the repo. That's what I did and I saved days...

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
