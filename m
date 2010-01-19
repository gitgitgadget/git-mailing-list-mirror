From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: "warning: Updating the currently checked out branch may cause
	confusion" on bare repositories
Date: Tue, 19 Jan 2010 10:59:06 -0800
Message-ID: <20100119185906.GF23466@spearce.org>
References: <xuu2ska3doix.fsf@nowhere.com> <20100119062904.GB23212@spearce.org> <xuu2my093owy.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Megacz <adam@megacz.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:59:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXJIO-00083T-Ho
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 19:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab0ASS7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 13:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754395Ab0ASS7O
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 13:59:14 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:46281 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab0ASS7L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 13:59:11 -0500
Received: by iwn35 with SMTP id 35so3113931iwn.4
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 10:59:10 -0800 (PST)
Received: by 10.231.148.201 with SMTP id q9mr675113ibv.85.1263927549341;
        Tue, 19 Jan 2010 10:59:09 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm3323383iwn.3.2010.01.19.10.59.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Jan 2010 10:59:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xuu2my093owy.fsf@nowhere.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137484>

Adam Megacz <adam@megacz.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > That should already be the case.  Did you create the bare repository
> > by taking a copy of a non-bare's .git directory?  Check your bare
> > repository's config file and see if core.bare = false, if so set
> > it to true to signal it really is bare.
> 
> Hrm, is there a reason why this is explicitly configured rather than
> detected?

I don't know why we do this.  I think its because the guessing
logic can guess wrong sometimes.
 
> I was under the impression that you could create a bare repository by
> simply throwing away the working tree and renaming ".git" to any other
> name, but I guess I was wrong.

If you delete the setting from the configuration file, Git usually
almost always guesses correctly.  :-)

Its rare to see it fail.  But I think it can fail if you create
a file called HEAD in the top level of your source code tree.
(For example.)

-- 
Shawn.
