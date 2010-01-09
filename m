From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Problem Using Git with Subversion Repository
Date: Sat, 9 Jan 2010 06:31:30 +0000
Message-ID: <20100109063130.GA2668@dcvr.yhbt.net>
References: <3f81a4241001071453g24297atc1caab4a0a4ad176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bryan Richardson <btricha@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 07:32:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTUrn-0001Sf-EO
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 07:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252Ab0AIGbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 01:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205Ab0AIGbc
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 01:31:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:41692 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab0AIGbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 01:31:32 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 941881F500;
	Sat,  9 Jan 2010 06:31:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <3f81a4241001071453g24297atc1caab4a0a4ad176@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136518>

Bryan Richardson <btricha@gmail.com> wrote:
> Hello all,
> 
> Has anyone come across a similar problem as this?
> 
> Item already exists in filesystem: File already exists: filesystem
> '/usr/local/svn/repos/my-apps/db', transaction '96-2v', path
> '/app/trunk/vendor/rails/actionpack/test/fixtures/layout_tests/layouts/symlinked'
> at /usr/lib/git-core/git-svn line 508
> 
> I *think* what happened is in a previous git-svn dcommit I removed the
> vendor/rails directory (unfroze rails from my app) and now I'm trying
> to freeze it again, in which case git-svn thinks a file needs to be
> added (instead of modified) and the Subversion repository says the
> file already exists.

Hi Bryan,

Which version of git svn are you using?  Any chance we can take a look
at the SVN/git history to know what's going on?

Thanks.

> Anyone know a way around it?!

Can you try manually removing that file with "svn rm" and then
doing "git svn rebase" to rebase your working HEAD before trying
to dcommit?

-- 
Eric Wong
