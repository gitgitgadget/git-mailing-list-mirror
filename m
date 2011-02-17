From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to git checkout a orgin(unstage) version file in another
 directoy?
Date: Thu, 17 Feb 2011 04:34:31 -0600
Message-ID: <20110217103431.GA8308@elie>
References: <loom.20110217T074533-358@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 11:34:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq1CC-0001RA-Lk
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 11:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab1BQKeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 05:34:44 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42865 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab1BQKem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 05:34:42 -0500
Received: by iyj8 with SMTP id 8so2206987iyj.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8ZFAti35NH9D+N//EtBSk79XT/PooSE6cc2vzVrYDf4=;
        b=qQ0cOnxY3fJCdoVAJyMLkeYmhk0fvvX7NYxzCkmAXAVn7vUJkAkS1DyJJHb9omE7Zk
         xxTii0KlGVjkj3ZRCqmrQCF9dqiUkZ03JTB+NETKv2hAPsKEHI8PKd00vW64h1PPUPQq
         8WEGYHaryYRJZCgtnBOG+W3qZ9VAoOJgv1iNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=o7ITBtNCqpDrfHJkJUSWGd5juNNg5dAhHqok4P1ScJvUL1xoA523lfWbFncjHnQca/
         CV9ms1klvqBqWJ2xM7eWj25s3R4kQ68GDU3ZTb1xicfb/1zgXc4aVMExndgP8nKJJS0Z
         Jc+mo1VhpUhvMoQruKzWxx9YJ7WPXqSdtxdd8=
Received: by 10.42.221.68 with SMTP id ib4mr2352212icb.386.1297938882086;
        Thu, 17 Feb 2011 02:34:42 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id z4sm657288ibg.7.2011.02.17.02.34.39
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 02:34:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20110217T074533-358@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167064>

Chunlin Zhang wrote:

> I am writing a script for git-gui's "Tools" menu to diff a file.
> I want to checkout an origin file in a tmp directory and use the diff tool.

Because you are writing a script, I'd suggest using one of the
"low-level commands (plumbing)" listed in git(1).  Because you are
retrieving a file, it would be one of the "interrogation commands".
And because it is a single file, I suppose this should be git
cat-file, git unpack-file, or git archive.

For example,

	git cat-file blob HEAD:README

will print the contents of README in the HEAD commit.

Because I am curious: what exactly would your script be used to do?
Can the git diff-tree or git diff-files command help?
