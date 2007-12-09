From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 0/2] [RFT] git-svn: more efficient revision -> commit
	mapping
Date: Sun, 09 Dec 2007 12:56:08 -0800
Message-ID: <1197233768.7185.6.camel@brick>
References: <1197185262-16765-1-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Dec 09 21:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1TCS-0004hx-OK
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 21:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXLIU4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 15:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbXLIU4F
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 15:56:05 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:57178 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbXLIU4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 15:56:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1365131rvb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=uXpBwftzR1gVqDuESDVEElxYlPTuBbiAEx+TbNizvsg=;
        b=Sg9kLpzzn3fHCSjKfUlw6TtXKNhdNZ9WdcOlproYr6V9VvgICRwjy4JXbqci0m+8M1Io0L5hqQCkPJvgFLd04PF7W1zXNk0PJv2H20nGq7BYP7ien2SVwv3KoCBCwBBWPvW4/REDe52XqiKvHwRCVMD8/cmxkJrYHbEKWsuJqf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=qk57sx1L1NfBAZqUfW+Aj8k/KirhSiK6Dj0Ijhdq7Yxdo/h8Q/cS95wPM8cLf8SzoUiYXFu/jX9XIKeInxu2QaxAM3G9y1U4IwoqHtrdmicDAuuQF+3RpP4Fe10HBGtDQhT2XGBAgl+DS6nuOlRao3c+3Bw4sDSg2rt8YoZ9dzo=
Received: by 10.141.107.13 with SMTP id j13mr201547rvm.1197233764135;
        Sun, 09 Dec 2007 12:56:04 -0800 (PST)
Received: from ?192.168.1.124? ( [216.19.190.48])
        by mx.google.com with ESMTPS id b21sm4927933rvf.2007.12.09.12.56.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Dec 2007 12:56:03 -0800 (PST)
In-Reply-To: <1197185262-16765-1-git-send-email-normalperson@yhbt.net>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67660>

On Sat, 2007-12-08 at 23:27 -0800, Eric Wong wrote:
> This is very lightly tested, but describes the format I described in:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/67126
> 
>   (more in the commit messages)
> 
> I'll be out of town the next few days and I'm not sure how much I'll be
> able to follow up on it while I'm gone.  Please test, especially if
> you're dealing with a repository where large .rev_db files are a
> problem.
> 
> Junio: not intended for master just yet, but if you hear nothing but
> good things about it, feel free :)


Preliminary tests against the gcc repo are going swimmingly.

Successful git svn rebase against trunk, doing a full git svn fetch
now to build rev_maps for all svn branches/tags.  At halfway through
space has decreased from ~2GB to 17MB for about half of the needed
metadata.

Cheers,

Harvey
