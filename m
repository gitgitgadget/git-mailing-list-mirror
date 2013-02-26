From: Tim Chase <git@tim.thechases.com>
Subject: clean/smudge filters on .zip/.tgz files
Date: Tue, 26 Feb 2013 16:38:00 -0600
Message-ID: <20130226163800.454cd093@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 23:37:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAT8t-0007g6-6o
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 23:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402Ab3BZWge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 17:36:34 -0500
Received: from boston.accountservergroup.com ([50.22.11.22]:42739 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754884Ab3BZWgd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2013 17:36:33 -0500
Received: from [108.230.25.240] (port=58248 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1UAT8S-0008jp-Pc
	for git@vger.kernel.org; Tue, 26 Feb 2013 16:36:32 -0600
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217188>

Various programs that I use ([Open|Libre]Office, Vym, etc) use a
zipped/.tgz'ed file format, usually containing multiple
(usually) plain-text files within.

I'm trying to figure out a way for git to treat these as virtual
directories for purposes of merging/diffing.  

Reading up on clean/smudge filters, it looks like they expect one
file coming in and one file going out, rather than one file
on one side and a directory-tree of files on the other side.

I tried creating my own pair of clean/smudge filters that would
uncompress the files, but there's no good way put multiple files on
stdout.

Has anybody else played with such a scheme for uncompressing files as
they go into git and recompressing them as they come back out?

-tkc
