From: "Holding, Lawrence" <Lawrence.Holding@cubic.com>
Subject: RE: Annoying absolute path for "core.worktree" to submodule
Date: Wed, 21 Mar 2012 10:39:56 +1300
Message-ID: <A5E8E180685CEF45AB9E737A010799802D9872@cdnz-ex1.corp.cubic.cub>
References: <20120320105243.2e8a489b@christian-hammerl.de> <4F6886A6.3010805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Christian Hammerl" <info@christian-hammerl.de>,
	"Antony Male" <antony.male@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 22:40:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA6mz-0005C9-Ju
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 22:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab2CTVkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 17:40:06 -0400
Received: from exprod6og104.obsmtp.com ([64.18.1.187]:34360 "HELO
	exprod6og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754942Ab2CTVkE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 17:40:04 -0400
Received: from bb-corp-outmail1.corp.cubic.com ([149.63.70.140]) (using TLSv1) by exprod6ob104.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT2j5MKS13tc2D17L4X9hRKcF8qjfPyZn@postini.com; Tue, 20 Mar 2012 14:40:04 PDT
Received: from bb-corp-ex4.corp.cubic.cub ([149.63.2.70])
	by bb-corp-outmail1.corp.cubic.com (8.13.1/8.13.1) with ESMTP id q2KLdxa3010927;
	Tue, 20 Mar 2012 14:40:00 -0700
Received: from cdnz-ex1.corp.cubic.cub ([172.19.33.136]) by bb-corp-ex4.corp.cubic.cub with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 20 Mar 2012 14:39:59 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <4F6886A6.3010805@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Annoying absolute path for "core.worktree" to submodule
Thread-Index: Ac0Gnw/sRolUZB7ATR6bwwgE9qgJ6gAQIoEg
X-OriginalArrivalTime: 20 Mar 2012 21:39:59.0894 (UTC) FILETIME=[002D0B60:01CD06E2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193543>

> Antony Male wrote:
> On 20/03/2012 9:52 am, Christian Hammerl wrote:
> > Hey folks,
> >
> > I really love the work you are doing on GIT but the last update
> > regarding submodules is a bit annoying. Although the path inside the
> > ".git" file is stored relative to the submodule's path, the path in
> > ".git/modules/path-to-submodule/config" is stored as an absolute
path
> > for "core.worktree".
> 
> What are you referring to as the "last update"? v1.7.8 introduced the
> separate git dir for submodules, and used an absolute path.
> 
> This absolute path was changed to a relative path in the patchset at
> [1], which is present in v1.7.10-rc1.
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/192173

Slightly off topic, but related, what is the recommended way for finding
the git folder from the top level project or any of the submodules? And
of finding the working tree from inside a hook script?

Context: One of the (optional) steps in our build process installs
pre-commit hooks into the git/hooks folder of the tools submodule and
into the git/hooks folder of the next level up project. Then on commit
the hook reads the config file from inside the tools submodule and
checks file formats and naming standards before permitting the commit.
The current implementation has the paths hard coded between the two
location, now with some having the old layout and some the new, we are
looking for a consistent solution without duplicating the logic in the
git executables.
