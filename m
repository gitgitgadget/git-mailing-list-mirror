From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 0/5] gitweb: git_patchset_body fixes
Date: Tue, 9 Jan 2007 13:38:25 -0800 (PST)
Message-ID: <734286.71437.qm@web31814.mail.mud.yahoo.com>
References: <200701091744.46729.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 22:38:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Ofu-0006PK-08
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbXAIVi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbXAIVi1
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:38:27 -0500
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:40037 "HELO
	web31814.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932382AbXAIVi0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 16:38:26 -0500
Received: (qmail 71786 invoked by uid 60001); 9 Jan 2007 21:38:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=18Ol65WhAyodj4wJ4gj3JNeBjxMcgz1oZgEGq567MhVOZol2DrON0M9ywzkBh6Aeubrio+gcXTovCpLXc4NRT4uNh3QJV1u8CjzyAy40oGIOzwsyo7Hr8uPhACZ9njt6dpq4yllcUZup8WkoN/W33gFxB3SnQO34QZgP3vv5+4o=;
X-YMail-OSG: U.jFTXoVM1mFAgDQcwRcbXExchT2Htmh3ghkcKxYTn2sh3tHkY972AV4kHlHvz3Nbw--
Received: from [64.215.88.90] by web31814.mail.mud.yahoo.com via HTTP; Tue, 09 Jan 2007 13:38:25 PST
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200701091744.46729.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36407>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Jakub Narebski wrote:
> > Luben Tuikov wrote:
> > 
> >> Ok, I see that Junio has committed the fixes to "next" -- thanks!
> >> That saved me time having to manually apply them.
> >> 
> >> Now, the results are that I see the same bug.
> >  
> > (The same bug = no closing div).
> > 
> > I'll try to reproduce this.
> 
> I failed to reproduce this error.
> 
> Could you apply the following patch, and report the result of
>   grep "</div>\|<div" | grep -v "<div.*</div>
> (find all opening and closing <div> elements, but omitting
> those which are opened and closed in the same line)?

<div class="page_header">
<div class="search">
</div><!-- search -->
</div><!-- page_header -->
<div class="page_nav">
</div><!-- page_nav -->
<div class="header">
</div><!-- header -->
<div class="page_body">
<div class="log">
</div><!-- log -->
<div class="list_head">
</div><!-- list_head -->
<div class="patchset">
<div class="patch" id="patch1">
<div class="diff extended_header">
</div><!-- diff extended_header -->
</div><!-- patch 0 -->
<div class="patch" id="patch2">
<div class="diff extended_header">
</div><!-- diff extended_header -->
</div><!-- patchset -->
</div><!-- page_body -->
<div class="page_footer">
</div><!-- page_footer -->

The bug is clear.

     Luben
