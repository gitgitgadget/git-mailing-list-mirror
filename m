From: "Jonas Fonseca" <fonseca@diku.dk>
Subject: Re: [TopGit PATCH] tg patch: disable pager and colors for git-diff
Date: Thu, 20 Nov 2008 15:55:47 +0100
Message-ID: <2c6b72b30811200655o770efd63u4101f44683f2bc0d@mail.gmail.com>
References: <1227189062-11951-1-git-send-email-fonseca@diku.dk>
	 <20081120135710.GA16303@diku.dk>
	 <20081120143455.GH10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: madduck@debian.org, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Nov 20 15:57:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Ay1-0001WU-Ux
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758356AbYKTOzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 09:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758347AbYKTOzw
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 09:55:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:9726 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758334AbYKTOzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 09:55:50 -0500
Received: by fg-out-1718.google.com with SMTP id 19so385135fgg.17
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=V3RWLYwOOEIj0BArnMbyS7TN8oJE6ocyUXTgqbyDXNg=;
        b=qeAtcrw78GPZ7ELWE6ButXTZ2t3fRd6/LBTG2bWJcmc5yBZf9cReVAuQF8xCAZ+EoR
         nnN0jPLZaxQy1Q2ZjGmKfMJNQQBYz2YwJZkaKNHNX+XgluPMRZte1iRPu+rr2y/G6RYB
         YyeIok3UvNT9KARtwpyvcw0kvCi+9j/N1c7Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=G07tU/HZYpD5LERxhqSz0cjWZs3AqPWu50J+2+7wUM7h1BShil/ya7Jp9+iRzntSz0
         bwuMN/SJL0FwGLRS/OfFYbYh1kQ58IAI/uwPi6BSM8Uh2blNrIKaLblAZ/FuLGT75XI4
         JhyrDAArdOlQicNeoJqeUVS27iZv1OBbVtEdQ=
Received: by 10.181.58.9 with SMTP id l9mr754085bkk.98.1227192947773;
        Thu, 20 Nov 2008 06:55:47 -0800 (PST)
Received: by 10.181.195.3 with HTTP; Thu, 20 Nov 2008 06:55:47 -0800 (PST)
In-Reply-To: <20081120143455.GH10544@machine.or.cz>
Content-Disposition: inline
X-Google-Sender-Auth: 347e06cd1d9216df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101446>

On Thu, Nov 20, 2008 at 15:34, Petr Baudis <pasky@suse.cz> wrote:
> On Thu, Nov 20, 2008 at 02:57:10PM +0100, Jonas Fonseca wrote:
>> When output is not redirected to a file, git brings up the pager for
>> only the diff, which can be confusing, so disable with --no-pager.
>> git-diff is a porcelain command and thus subject to color options. Use
>> --no-color, to avoid the patch being corrupted with terminal escape
>> characters when color.diff=always.
>>
>> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>
> I still don't understand how did that color thing happen - shouldn't
> git diff avoid spewing out colors when the output is not a tty? And when
> it is, I want the colors myself, too.

As I wrote in the commit message, git diff always spews out colors
with color.diff=always. This was what I for experimental reasons had
in my .git/config (and forgotten all about) before sending the README
update patch. Topgit could check the git color configuration but that
seems more hacky.

> Good point with the --no-pager, but in that case, tg patch itself should
> by default invoke the pager, since it really is very desirable.

Yes, probably.

-- 
Jonas Fonseca
