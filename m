From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] import-tars: Allow per-tar author and commit message.
Date: Mon, 24 Aug 2009 06:24:38 +0900
Message-ID: <20090824062438.6117@nanako3.lavabit.com>
References: <20090823203640.B195D189B12@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sun Aug 23 23:26:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfKZs-0005oK-NI
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 23:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967AbZHWV0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 17:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755949AbZHWV0G
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 17:26:06 -0400
Received: from karen.lavabit.com ([72.249.41.33]:37082 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755943AbZHWV0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 17:26:04 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id AD89A11B85A;
	Sun, 23 Aug 2009 16:26:06 -0500 (CDT)
Received: from 6772.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id OEE8OF6QZ8JK; Sun, 23 Aug 2009 16:26:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=4ZMAUeNf0YmZIjyuek7mX/pt5yOaad+OvJ70+/qTqnNQv0dAQTs3vYOiPti9JT/BqdXkqFpi1PErVDHr4JICYpaNU8XwPVA1vWxSj4tyJEOws/DF1C0IWNtNhtGmmOQoUP5+4qqC2+ct/m6Ua7bvxE3XvO4ltooTv+tY1RHlLH0=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090823203640.B195D189B12@perkele>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126883>

Quoting Peter Krefting <peter@softwolves.pp.se>

> Instead of having each imported tar ball's commit message be "Imported
> from filename.tar", optionally take a commit message from a file
> called "filename.tar.msg".
>
> Instead of having each commit have the same author and committer
> information, optionally read the committer information from a file
> called "filename.tar.committer" and author from a file called
> "filename.tar.author".

Instead of requiring the user to have millions of separate files, how about reading a single metainfo file that may look like this?

    [file "git-1.0.0.tar"]
	message = "Commit log message for the first revision"
	author = "A U Thor <au.thor@example.xz>"

    [file "git-1.0.1.tar"]
	message = "Commit log message for the first maintenance revision"
	author = "F I Xer <fi.xer@example.xz>"

and give the name of that metainfo file from the command line? The message may be awkward to put in the metainfo file itself, and it might be easier to refer to the name of a file that is outside the metainfo file itself, but the point is that doing so will both reduce the clutter in your folders, and will give people an option to avoid accidentally reading from random files in the same folder as the tar files that unfortunately have names that ends with the suffixes you randomly chose in this patch.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
