From: Pete Harlan <pgit@pcharlan.com>
Subject: Archiving tags/branches?
Date: Fri, 17 Oct 2008 18:43:46 -0700
Message-ID: <48F93F52.4070506@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 03:46:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr0tR-0006il-8O
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 03:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbYJRBns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 21:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbYJRBns
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 21:43:48 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:50689 "EHLO
	swarthymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751010AbYJRBns (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Oct 2008 21:43:48 -0400
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a4.g.dreamhost.com (Postfix) with ESMTP id D7365129A84
	for <git@vger.kernel.org>; Fri, 17 Oct 2008 18:43:46 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98513>

Hi,

I'm looking for a way to manage an ever-growing list of tags.  I've read
some git docs, but am new to git and wonder if the below method doesn't
work or if there's a standard practice I haven't run into.

Most of the tags in my repo are uninteresting to look at, but can't be
deleted.  (Code releases for the most part, or stalled topic branches.)
 If I wanted to archive those, it looks like this would work:

mkdir .git/refs/archived-tags
cp -a .git/refs/tags/* .git/refs/archived-tags
git tag -d <tag-to-hide> # repeat as necessary

I can then maintain a short list of tags that currently interest me, but
am guaranteed not to lose old branches (say) referenced by those tags.

Is there a reason this won't work?

The immediate downsides I see are:

1. The name "archived-tags" might clash someday with a git directory.

2. I have to manually copy this to clones if I want it there too, and
can't manage it from them remotely.

In general, I'm thinking flat tag and branch namespaces must get
unweildy, and short of implementing directory-style namespace management
within git (e.g., hide tags beginning with "." by default, allow tag
subdirectories) I'm looking for a workaround.

Thanks,

--Pete
