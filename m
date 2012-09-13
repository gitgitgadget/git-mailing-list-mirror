From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
 test suite for detecting heap corruption
Date: Thu, 13 Sep 2012 18:36:53 +0200
Message-ID: <CA+EOSBmjwUA_Sogo5ZixnAE5_6C97wjEOzO6PnDgjw_BYzVz-w@mail.gmail.com>
References: <1347452248-12222-1-git-send-email-gitter.spiros@gmail.com>
	<7vy5kfceod.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 18:37:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCCPg-0006Fb-SG
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 18:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112Ab2IMQgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 12:36:55 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49286 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758253Ab2IMQgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 12:36:54 -0400
Received: by ieje11 with SMTP id e11so5239439iej.19
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=edcdwBQTW5zlTJBkisujIdJMT7XnjVwNdzb/jW+mbSM=;
        b=E+nUHOFgXBuDptT9ARStuHL0NOwuHlVyp2lMZiTRIYcHrOVPPKniKN5lJi2Qw7Uf2X
         ESdxoJixSl2v9AT7Z7V1fvuM0by5C9LcHoOJSDr2BBs5QfnLFhSJfCw7WzVKBNQUO5PZ
         Q/qvhN4KpbMnwxZl/0kVheJ0dFLwxTHtikwQOROC2NUWPGzvRoUSkliKwvLLEHMMZP9Q
         iJFf6U4oKRRnSECrR1pFJmPullHiKepDseLOlc1oRTOE5GaK3ufUpqvrIBIrqOfRmLXY
         rmF5C+6ztsRH0S2FMZI2S2OQEtZbYp+hLDfbx2bK02QGgWRzBTnvoWa3RRa/aetzXH36
         wxGw==
Received: by 10.50.159.133 with SMTP id xc5mr25004966igb.34.1347554213910;
 Thu, 13 Sep 2012 09:36:53 -0700 (PDT)
Received: by 10.64.82.194 with HTTP; Thu, 13 Sep 2012 09:36:53 -0700 (PDT)
In-Reply-To: <7vy5kfceod.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205391>

2012/9/12 Junio C Hamano <gitster@pobox.com>:
>
> Interesting, but it bothers me to make it enabled unconditionally.
> At least, this shouldn't be enabled under GIT_TEST_OPTS=--valgrind, no?
Sorry for the late response and thanks.

No, setting MALLOC_CHECK don't require
valgrind and it considered a best QA to have the test suite with it
defined always. If the test suite fail with MALLOC_CHECK, well, there
is some problem, no ?
Some distro do it already in building packages (fedora for example)
http://emacs.1067599.n5.nabble.com/please-set-both-MALLOC-PERTURB-and-MALLOC-CHECK-envvars-td150144.html

At @rpm5.org we do the same for popt, for example, from years

http://rpm5.org/community/rpm-devel/4156.html
>
> By the way, "export VAR=VAL" all on the same line, even though it is
> in POSIX.1, is reported to be unsupported by some shells people care
> about, and needs to be corrected to "VAR=VAL" and "export VAR" as
> separate commands.  I think we saw a patch to fix an instance or two
> that snuck in recently.
Yes, right, my bad. I will reroll.

Thank you
