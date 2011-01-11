From: Shawn Pearce <spearce@spearce.org>
Subject: Re: JGIT newbie question
Date: Tue, 11 Jan 2011 11:30:29 -0800
Message-ID: <AANLkTin=bZAgYeKHN2NUjYjZU5NBC_bs3bpCNNhijppq@mail.gmail.com>
References: <1294771910028-5911913.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, jgit-dev <jgit-dev@eclipse.org>
To: sundarbun <sundarbun@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 20:30:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcjvk-0006rw-6f
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511Ab1AKTav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 14:30:51 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54651 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191Ab1AKTat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 14:30:49 -0500
Received: by iyj18 with SMTP id 18so2182927iyj.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 11:30:49 -0800 (PST)
Received: by 10.231.36.12 with SMTP id r12mr21033ibd.69.1294774249281; Tue, 11
 Jan 2011 11:30:49 -0800 (PST)
Received: by 10.231.168.3 with HTTP; Tue, 11 Jan 2011 11:30:29 -0800 (PST)
In-Reply-To: <1294771910028-5911913.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164979>

On Tue, Jan 11, 2011 at 10:51, sundarbun <sundarbun@yahoo.com> wrote:
> I am looking into using JGit from Java

JGit related questions are probably better directed to the
jgit-dev@eclipse.org mailing list, as that is the list most of the
JGit contributors monitor and answer questions on.  The project is
hosted at http://www.eclipse.org/jgit/ so you may find more resources
there too, including the latest 0.10.1 release.

> to get some files from source control
> for an application that runs on AWS.
> We currently use SVNKit and it seems to work fine. We recently made the
> switch to git and I am having a hard time finding a sample that allows one
> to
> (a) init or create a ocal repo with my credentials and path to the tree that
> I am interested in...

Use the Git object in the org.eclipse.jgit.api package.  There is an
init method that can create a new repository at the given directory.

> (a) get a bunch of files from my remote repo

Try the checkout() method on the Git object.

> (b) commit any changes back in...

Try the commit() method on the Git object.

But if you want to avoid using the working directory, you'll need to
go through a much lower-level API, setting up your own DirCache, and
using an ObjectReader and ObjectInserter to interact with the
Repository class.  Doing this requires some knowledge of the basic Git
data model (commits, trees, blobs).

-- 
Shawn.
