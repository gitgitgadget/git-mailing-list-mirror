From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2008, #09; Sun, 31)
Date: Mon, 01 Sep 2008 12:33:48 -0700
Message-ID: <7vprnnvexv.fsf@gitster.siamese.dyndns.org>
References: <7vd4jo1jc6.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0809010116p68a638dck4f8e31d49e51c3fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 21:35:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaFAz-0000Bz-Gl
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 21:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbYIATd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 15:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbYIATd4
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 15:33:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbYIATdz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 15:33:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DE7335DBB8;
	Mon,  1 Sep 2008 15:33:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2F27C5DBB4; Mon,  1 Sep 2008 15:33:51 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E9FCEE94-785C-11DD-87B9-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94603>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 9/1/08, Junio C Hamano <gitster@pobox.com> wrote:
>>  * nd/worktree (Sat Aug 30 16:15:32 2008 +0700) 5 commits
>>   - setup_git_directory(): fix move to worktree toplevel directory
>>   - update-index: fix worktree setup
>>   + read-tree: setup worktree if merge is required
>>   + grep: fix worktree setup
>>   + diff*: fix worktree setup
>>
>>  The last two fail test suite.
>
> "make test" on pu did not fail on my machine. What tests failed?

*** t1006-read-tree-m-i.sh ***
* FAIL 1: setup
	
	
		mkdir it.git &&
		(
			GIT_DIR=. &&
			export GIT_DIR &&
			cd it.git &&
			git init &&
			M="1 2 3 4 5 6 7 8" &&
			for i in $M 9; do echo $i; done >file &&
			cat file >elif &&
			git update-index --add file elif &&
		...

which is part of my private test suite.

While it is a change in behaviour, after looking at what the test does
again, I do not think this use case is worth supporting.
