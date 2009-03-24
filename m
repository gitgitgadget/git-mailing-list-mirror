From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git repository
Date: Tue, 24 Mar 2009 16:37:36 +0000
Message-ID: <e2b179460903240937p58dff7e8u238fbe06785cdb77@mail.gmail.com>
References: <49C8B159.2040600@gmail.com>
	 <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>
	 <49C8E074.4030808@gmail.com>
	 <20090324135906.GA10644@coredump.intra.peff.net>
	 <e2b179460903240738x272c884q62a666931ce99c2f@mail.gmail.com>
	 <alpine.DEB.1.00.0903241555360.7493@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Roel Kluin <roel.kluin@gmail.com>,
	git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>,
	Steven Tweed <orthochronous@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:39:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm9en-0006y2-Tj
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 17:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763447AbZCXQhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 12:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763444AbZCXQhn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 12:37:43 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:50023 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763442AbZCXQhj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 12:37:39 -0400
Received: by qyk16 with SMTP id 16so3421161qyk.33
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GE80QnsnS3I8NcMoChc2Swk7Qwkbc2lIfmL9ObVxbrM=;
        b=uDxfHknLZqmNH65IqkftBYItS7JjoYXt32YCYaDy1saR9ZNz6hvyZgckH1qU+8hfpD
         soQJ/JKX/gz2zpN9+aKRgMU7kJycUTMwGJnOcpY1NL18tOimkVpkCU2OB2e3xjtEFK2Y
         uUCpWAxTmEW71K1U/8NdgzvM0xm9nOVySkwTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vfd7nFJFeayGE0uheTRJX98Ai+W7CcTdQGwMrSSCzN+FVThFUVXvhnH13512Q05dMR
         Jkz+WI2CPwQrtXGPUssct3WWEJZ/O9bI6nDrQJNPJxx+/fQ4npRj2iUZSvApV2El3UKY
         +ZgOcajLaDbJi7r9YBdlhMeOkHvT9XkonOwIM=
Received: by 10.224.89.76 with SMTP id d12mr10916087qam.382.1237912656283; 
	Tue, 24 Mar 2009 09:37:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903241555360.7493@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114472>

2009/3/24 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> This kind of pipeline has the benefit that it can actually work on the
>> *repository*, and not just the working copy (as per the posted script).
>
> Did I miss something?  git ls-files pipes only the names to xargs, not the
> full contents, right?

See where I wrote "this kind of pipeline" vs "git ls-files" which was
just quoting Peff? 8-)

I dunno, maybe C folk using git would only be interested in the
index/working copy, but that tells me this script is even more
tenuously linked to git. We don't bundle a compiler just because it
can use git ls-files to work out what to compile...

The script might be best as a standalone tool which just happened to
take advantage of the VCS in use by reacting to its surroundings. Then
it would also be useful by hg, svn, cvs people etc.

If it actually used the information in the repository to be able to
run git blame on the definitions, or show a git log -p style list of
changes in the definition, that might be different.

Mike
