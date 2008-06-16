From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-apply doesn't handle same name patches well [V3]
Date: Mon, 16 Jun 2008 13:27:52 -0700 (PDT)
Message-ID: <m3prqhnn0b.fsf@localhost.localdomain>
References: <1213646686-31964-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8LJr-0001ng-Lq
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 22:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbYFPU15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 16:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbYFPU15
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 16:27:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:25885 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbYFPU14 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 16:27:56 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3815741rvb.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=qJpgGQeci27HLpmszd7sM8MISt12SFI35hMo0rYuRuk=;
        b=wxWlxrUO8OsyhxAMFa4csNooNH6c1xsbU188r1cZlnj1G4rPfOSG5OOyVbo/kK4GbI
         pJKjI/+VIOv+VnIVxP4hGWDFn4hYCEEARUhUwLfJU3Wr+8k460lt8/OHkw7LMoW3bq/B
         lWKBKoVdnKwtvcVevTfk2YJMeSN3OYsmxcF9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=a58/kjt9PGIqHFUsYj+giufmmtXd4nxbcnyY4xAKyFkZFl7qWO5BEabtjRbTttzD36
         aLfxrgHF7KoGzdzCDQ9Redr2yyEUhyeQiaYM5uLsPY/hH+3pgWIRkAN45lySY53mDVGq
         Zqv8LPgzWKIQL2dyw0lYw/ZLuKXdWwsZ172Ko=
Received: by 10.141.97.5 with SMTP id z5mr4116302rvl.197.1213648073377;
        Mon, 16 Jun 2008 13:27:53 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.236.117])
        by mx.google.com with ESMTPS id b39sm9584690rvf.8.2008.06.16.13.27.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 13:27:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5GKRoXs027152;
	Mon, 16 Jun 2008 22:27:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5GKRnlM027149;
	Mon, 16 Jun 2008 22:27:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213646686-31964-1-git-send-email-dzickus@redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85228>

Don Zickus <dzickus@redhat.com> writes:

> When working with a lot of people who backport patches all day long, every
> once in a while I get a patch that modifies the same file more than once
> inside the same patch.  git-apply either fails if the second change relies
> on the first change or silently drops the first change if the second change
> is independent.
> 
> The silent part is the scary scenario for us.  Also this behaviour is
> different from the patch-utils.
> 
> I have modified git-apply to cache the filenames of files it modifies such
> that if a later patch chunk modifies a file in the cache it will buffer the
> previously changed file instead of reading the original file from disk.
> 
> Logic has been put in to handle creations/deletions/renames/copies.  All the
> relevant tests of git-apply succeed.

Very nice, although most probably I would never use this.

+1

-- 
Jakub Narebski
Poland
ShadeHawk on #git
