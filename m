From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v2 1/2] Ensure consistent usage of mergetool.keepBackup in git
Date: Fri, 10 Apr 2009 16:48:43 +0200
Message-ID: <200904101648.44593.markus.heidelberg@web.de>
References: <20090409153033.GN23604@spearce.org> <20090410074327.GA9369@gmail.com> <20090410081843.GB9369@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 16:50:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsI3z-0007Lc-N7
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 16:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763390AbZDJOsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 10:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759884AbZDJOsQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 10:48:16 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45936 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763205AbZDJOsP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 10:48:15 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4ED2CFA40FB8;
	Fri, 10 Apr 2009 16:48:13 +0200 (CEST)
Received: from [89.59.65.40] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LsI1c-0003xy-00; Fri, 10 Apr 2009 16:48:12 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090410081843.GB9369@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/z5DtqbS6wQODwUXlAOKFdJ13J+3xOPE5vSx9t
	vAD5SXe1Vu9cWDwvVEyTtPQTeOhgmBY4F55X1CS7CNtDJ6KvNM
	8JDoevjWsAs2zOIB3AjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116260>

David Aguilar, 10.04.2009:
> On  0, David Aguilar <davvid@gmail.com> wrote:
> > 
> > It /seems/ like the docs and completion should be updated.
> 
> Though my guess is as good as any....
> I'd rather hear someone else's opinion.

And I've waited for a response from the difftool/mergetool maintainers
at first, so I waited with my reply till now.

> $ git log -p 44c36d1c
> commit 44c36d1ccc9a40bfb31910dfd7e18d59fa8be502
> Author: Charles Bailey <charles@hashpling.org>
> Date:   Thu Feb 21 23:30:02 2008 +0000
> 
>     Tidy up git mergetool's backup file behaviour
>     
>     Currently a backup pre-merge file with conflict markers is sometimes
>     kept with a .orig extenstion and sometimes removed depending on the
>     particular merge tool used.
>     
>     This patch makes the handling consistent across all merge tools and
>     configurable via a new mergetool.keepBackup config variable
>     
>     Signed-off-by: Charles Bailey <charles@hashpling.org>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> 
> The commit comment says mergetool.keepBackup, even though the code always
> had it as merge.keepBackup.

Yes, merge.keepbackup was never documented, we shouldn't have to keep
backwards compatibility for such undocumented behaviour.

> Right now more people have merge.keepbackup already set since git-gui
> has had it that way for the last 7 months or so.

People which noticed that the documented mergetool.keepBackup didn't
work, had to look into the source to find out that merge.keepBackup did
it, so I see no problem with changing it. They rather should have
reported it anyway.

Ferry did it right with fixing this inconsistency.

> Nevertheless,
> Shawn's already applied the git-gui patch which hints that maybe
> we should just make the code match the docs.

Yes.

Markus
