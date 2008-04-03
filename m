From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: merge conflict diff
Date: Thu, 3 Apr 2008 08:13:04 -0600
Message-ID: <b9fd99020804030713n3c1a2602t847e8a132f8ccd06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 16:14:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhQCR-000161-9v
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 16:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbYDCONK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 10:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755073AbYDCONK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 10:13:10 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:47456 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbYDCONJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 10:13:09 -0400
Received: by rn-out-0910.google.com with SMTP id e24so2050153rng.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=nw561g8S3WTqJ8DWCPWGZmt0NEYciC2nJfEk3cR+j3A=;
        b=TjRh5uXT5vllcmkkT20a8vLSn4cp+pF6ecAo7NCEm6UO2kIYq/i+OqJXjkGc9yV90zR8pZPn+njJRD7bOUyOjW9kGK+rgHSLFW5uctuq6HR4/aS/hlivzySELbRY9HbXOnKNL5LhdX3wTchQ55GfryE5Sa/WfuutqH0MB0z1Pf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=I4uBiptlpblCPxd1MkzCHKPSokco6ErHrG6ZxhNlXp3p2OGhx4x+zmfjOvDI7lR1h2yDXLQIZxc8Uwe6E9IPVtwug+Mv5GC+2uAig0977t2Ca6UC84KAs5CU6B/+cO70hLA5/krMv37AI8E6rcUQSmMAVOpxkViZcTrN+G6B+dI=
Received: by 10.114.124.1 with SMTP id w1mr17494356wac.45.1207231984842;
        Thu, 03 Apr 2008 07:13:04 -0700 (PDT)
Received: by 10.114.208.13 with HTTP; Thu, 3 Apr 2008 07:13:04 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78756>

Hi,
I am trying to figure out how to quickly diff two source files that
led to a merge conflict.  When a conflict occurs the command
# git diff
performs a diff -cc, but I would like to compare the files before any
merging takes place so I can decide if I should just take all the
changes from one of the sources.
 i.e. take the changes from the merging branch:
# git checkout-index -f -u --stage=3 foo
# git add foo

So far I am thinking of
# git checkout-index --stage=2 --temp foo
# git checkout-index --stage=3 --temp foo
# git diff .merge_x1 .merge_x2

Are there any built-in ways to accomplish this? I'd like to be able to
build a script that can quickly start the diff based on the file name
I provide.

Thanks!
Jeremy
