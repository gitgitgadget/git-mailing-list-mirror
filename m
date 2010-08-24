From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Why does git-mergetool use /dev/tty?
Date: Mon, 23 Aug 2010 21:49:57 -0400
Message-ID: <3D6C7B12-FA06-4EAD-9781-5CA74FE23057@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>,
	Charles Bailey <charles@hashpling.org>,
	"Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 24 03:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oniep-00085M-Vs
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 03:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab0HXBuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 21:50:08 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48326 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab0HXBuH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 21:50:07 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id B160B1FFC43C; Tue, 24 Aug 2010 01:49:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 542261FFC43A;
	Tue, 24 Aug 2010 01:49:49 +0000 (UTC)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154275>

git-mergetool.sh, lines 298-302:
>     if test $last_status -ne 0; then
>         prompt_after_failed_merge < /dev/tty || exit 1
>     fi
>     printf "\n"
>     merge_file "$i" < /dev/tty > /dev/tty

Why does git-mergetool ignore the provided STDIN and STDOUT when not given a path to merge?

This wasn't apparent until bb0a484: "mergetool: Skip autoresolved paths" added a test that doesn't provide a file to merge on the command line.

~~ Brian Gernhardt