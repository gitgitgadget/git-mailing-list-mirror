From: Ed Avis <eda@waniasset.com>
Subject: 'git show' with multiple revisions
Date: Tue, 28 Apr 2015 10:10:52 +0000 (UTC)
Message-ID: <loom.20150428T120412-982@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 12:11:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn2U1-0006MN-66
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 12:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933203AbbD1KLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 06:11:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:46991 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933017AbbD1KLM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 06:11:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Yn2Tn-0006Ex-5W
	for git@vger.kernel.org; Tue, 28 Apr 2015 12:11:03 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 12:11:03 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 12:11:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:36.0) Gecko/20100101 Firefox/36.0 Cyberfox/36.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267919>

I would like to see the content of a file in multiple revisions.
I can get them with 'git show' as follows:

    % git show REV1:FILE
    % git show REV2:FILE

and so on.  But that launches a new process for each revision.  Now, there is
the option to pass multiple arguments to 'git show':

    % git show REV1:FILE REV2:FILE

This gets both revisions in a single process and so is faster.  But it
concatenates the content so there isn't a way to separate them out again.

Could 'git show' sprout an option to get multiple things programmatically
so that they can be separated out again?  One way would be to quote or escape
the contents somehow so that the result can be parsed:

    % git show --porcelain REV1:FILE REV2:FILE

The question is what format should be used to output many strings to stdout.

An alternative would be to specify an output file:

    % git show --output foo REV1:FILE                        # writes foo
    % git show --output foo REV1:FILE --output bar REV2:FILE # writes foo, bar

Note that here I am only getting the file content, not log messages or any of
the other things which 'git show' can produce.  So perhaps what I really want
is some kind of 'git cat'.  Or is there another more appropriate tool?

Thanks,

-- 
Ed Avis <eda@waniasset.com>
