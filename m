From: "Timo Sigurdsson" <public_timo.s@silentcreek.de>
Subject: Re: Gitweb: Persistant download URLs for snapshots?
Date: Tue, 31 May 2016 22:22:50 +0200 (CEST)
Message-ID: <20160531202250.6CB686C8011E@dd34104.kasserver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 22:23:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7qBm-00018x-22
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 22:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbcEaUWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 16:22:54 -0400
Received: from dd34104.kasserver.com ([85.13.151.79]:56177 "EHLO
	dd34104.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbcEaUWx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 16:22:53 -0400
Received: from dd34104.kasserver.com (dd0802.kasserver.com [85.13.143.1])
	by dd34104.kasserver.com (Postfix) with ESMTPSA id 6CB686C8011E
	for <git@vger.kernel.org>; Tue, 31 May 2016 22:22:50 +0200 (CEST)
X-SenderIP: 37.49.25.128
User-Agent: ALL-INKL Webmail 2.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296013>

Hi again,

Timo Sigurdsson schrieb am 30.05.2016 16:12:

> Hi,
> 
> I hope this is the right place to ask this, but I wanted to know whether it is
> possible to have a persistant URL to obtain a snapshot of the latest master of
> a repository through Gitweb.
> 
> I set up a gitweb instance and it works nicely. I can click on the snapshot
> link to get a tgz archive of a specific commit hash to quickly receive or
> distribute files of a repository exposed by Gitweb. However, I have two
> problems with these links:
> 
> 1) The link seems to depend on a commit hash. I haven't found a shorter or
> persitant link that would e.g. always give me the latest master snapshot.
> 
> 2) Another issue which is actually more problematic: The links only seem to
> work interactively in my desktop browser. If I right click the link "snapshot",
> copy the URL and then try to download that link from another (headless) machine
> using wget, I end up getting a html file instead of a tgz archive.
> 
> Is it possible to generate such links that conssitantly work for the latest
> commit of a repository and that work non-interactively from a command line? Am
> I doing something wrong (well aside fromt he possibility that I'm trying to use
> gitweb for something which it might not have been designed for...)?
> 
> Thank you!
> 
> Kind regards,
> 
> Timo

so, in the meantime I found the answers to my questions and therefore I'm stating my findings here as a reference for anyone who might stumble over a similar question in the future:

Regarging 1)
It's possible to use other identifiers than commit hashes in URLs. If you open a projects summary view and then click on 'tree' in the navigation bar, you will get a snapshot link in the navigation bar that points to an URL like this:
https://myserver.url/gitweb/?p=myproject.git;a=snapshot;h=HEAD;sf=tgz
Another example that works:
https://myserver.url/gitweb/?p=myproject.git;a=snapshot;h=refs/heads/master;sf=tgz

Regarding 2)
Well the second issue was just stupid. I forgot to properly quote the URL on the command line. If you actually do that, you can download the archive with wget just fine (or probably any other tool you may like).


Sorry for the noise,

Timo
