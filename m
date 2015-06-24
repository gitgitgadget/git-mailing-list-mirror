From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Repository Code Scope (Plan Text)
Date: Wed, 24 Jun 2015 21:52:46 +0300
Message-ID: <20150624215246.55e60abab6afb139589c2765@domain007.com>
References: <BLUPR0701MB1969F347A7CA0ABBEE901242D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: BGaudreault Brian <BGaudreault@edrnet.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 20:53:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7pn9-0001Gn-PJ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 20:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbbFXSwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 14:52:55 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:33008 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbbFXSwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 14:52:54 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t5OIqkoC032194;
	Wed, 24 Jun 2015 21:52:47 +0300
In-Reply-To: <BLUPR0701MB1969F347A7CA0ABBEE901242D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272576>

On Wed, 24 Jun 2015 18:19:42 +0000
BGaudreault Brian <BGaudreault@edrnet.com> wrote:

> What type of code scope should a repository contain?  Can it be one
> large program with many elements or should it just be part of a
> program or can it be a project with multiple programs?  What are the
> recommendations?

There are no recommendations because the structure of a
repositories depends on the use case.

If you're developing a library which might be used by more than a
single other project, host it in a separate repository, and in the
projects which use that library, refer to it using submodules.

If you have a project which contains internal submodules (say,
for .NET projects, it's common to have many so-called assemblies in a
single project to provide modularity), there's little point in messing
with separate repositories and it's simpler to keep everything in one
place.

Note that there are tools which allow you to split from a repository the
history touching only the contents of a particular directory, and then
glue such history back into some other repository.  Using these are not
exactly a walk in the park but at least this sort of things is doable.
This means you might start with a simple solution and then shape it
into a more appropriate form when you'll see the need for this.

I should also warn you that your question appear to be a bit too broad
which, IMO, suggests that you did not do much research on what's
offerred by Git and its ecosystem, what's in a Git repo, how is it
hosted, what are the best practices of managing complicated Git
projects etc.  And all this information is abundant in the internets...
