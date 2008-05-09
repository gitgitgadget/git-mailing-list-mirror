From: "James Sadler" <freshtonic@gmail.com>
Subject: git filter-branch --subdirectory-filter
Date: Fri, 9 May 2008 11:01:47 +1000
Message-ID: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:02:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuH0S-0007xG-7Y
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 03:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903AbYEIBBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 21:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760369AbYEIBBt
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 21:01:49 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:65354 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbYEIBBt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 21:01:49 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1092266wxd.4
        for <git@vger.kernel.org>; Thu, 08 May 2008 18:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=CtG83k4RA0XKVEr2rWhI6oVZvp6+CH2HVXsZTIAjDvo=;
        b=cQWXGyEyRdue6KcP0C2Nt5oWVUQas54MQd+23V5h/9LTQ2ll+lfo6NQyD4Byxnj8cMLVwe0lyxfRruf8CI2dR0KawJ/Xf3EUXmbZ4MKj3Ap0M2KVbyz2sp92VYgT3k8fHmImEpSQQLU6+k4xHnMUTZyUTfNWDhjrRY5cSdHGUMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=o75mypXWj0giw69uZFxhHN6y5pfEiDR2B0hdc9usNnF3cMPAC3ajbsO43DvD7TA0TxeuCasi4HQTTiySdlbSG3xKESqFWzCWFFDUPKdUjJ1lG/9tox47ihK3slUYRH33BMogXTCaJnvufBGVSPAiqDO8U+jeXyiSp2bd+XQ382Q=
Received: by 10.90.68.20 with SMTP id q20mr5592394aga.115.1210294908127;
        Thu, 08 May 2008 18:01:48 -0700 (PDT)
Received: by 10.90.114.9 with HTTP; Thu, 8 May 2008 18:01:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81582>

Hi All,

I have some issues with git filter-branch.

I have a git repository that I wish to split into multiple seperate
repositories for each logical
module that it contains. Each logical module is already in its own
directory at the root of the repo.

My experiments with 'git filter-branch' have been *partially* successful.

To extract a module into its own repo, I first copied the original
repo (this was a simple cp -r,
as it seemed to be the simplest way as git clone doesn't get all the branches)
and ran filter-branch with a --commit-filter to skip commits that were
irrelevant to th subdir.

That step worked just fine.

The next pass was to 'hoist' the contents of the subdir in the new
repo into the root dir.
I thought I could do this with a --subdirectory-filter argument to
filter-branch, except when I do
this, I loose tons of commits.  (The working tree is correct, i.e. the
same as the original repo
working tree, but the history is screwed).

Anybody have any idea what I am doing wrong?  If it can't be done with
--subdirectory-filter can
it be done with the 'subtree' merge strategy somehow?

Cheers,
-- 
James
