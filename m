From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] mergetool--lib: specialize diff options for emerge and ecmerge
Date: Sun, 3 May 2009 21:12:30 +0200
Message-ID: <200905032112.31156.markus.heidelberg@web.de>
References: <1241254641-54338-1-git-send-email-davvid@gmail.com> <200905030827.56932.markus.heidelberg@web.de> <20090503182137.GC50640@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, marcin.zalewski@gmail.com,
	charles@hashpling.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 21:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0h70-0005lm-OJ
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 21:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbZECTMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 15:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbZECTMW
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 15:12:22 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:42392 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbZECTMW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 15:12:22 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9FFE3FBB29F4;
	Sun,  3 May 2009 21:12:21 +0200 (CEST)
Received: from [89.59.70.225] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M0h6p-0005lz-00; Sun, 03 May 2009 21:12:19 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090503182137.GC50640@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/TMm/hNHn3+Z7QATD0t5+VKXUDxiVL2EMzK4vP
	oM8MqPDOV5K5aviyVvoKsaYFjMv/pDYAkNfvFSHxHPUg15Tsv3
	ZyIWllsxS6cepXvLbqRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118185>

David Aguilar, 03.05.2009:
> Markus Heidelberg <markus.heidelberg@web.de> wrote:
> > David Aguilar, 02.05.2009:
> > > I installed ecmerge on a mac today and gave this a try.
> > > ecmerge is indeed better with this patch.
> > > 
> > > After configuring the path it all "just works":
> > > 
> > > $ git config --global mergetool.ecmerge.path \
> > > 	/Applications/ECMerge.app/Contents/MacOS/guimerge
> > 
> > Would it make sense to set merge_tool_path to guimerge by default then?
> > 
> > Markus
> 
> On Linux, ecmerge is "ecmerge".
> Macs are weird.  Windows--even worse.

And the ecmerge developers are even more worse or is there a reason to
have different names for the binaries?

> We could test $(uname) = "Darwin" and do the user-friendly thing by default,
> but that might not be a good idea.

Or use "type" there already to test whether guimerge exists, else
default to ecmerge.

> The user-friendly thing is actually
> "/Applications/...lots.of.stuff.../guimerge", and that's a lot more
> platform-specific than just "guimerge".

Why is the whole path more user friendly, because of guimerge not being
in PATH? Is the /Applications/... directory always the same for ecmerge
for each Mac user? But we don't care in other diff/merge tools about the
exact location and I think we shouldn't begin it here.

> The usability fairy says we should be nice to users and turn
> translate_merge_tool_path() into a massive platform-specific 
> hack.  The lazy person in me would rather list the tweaks
> on the git wiki and silently reward linux users since
> the defaults work fine there as-is.
> 
> What do you think?

Not sure, leaving it as is is still an option.
