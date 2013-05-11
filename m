From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/2] t5004: resurrect original empty tar archive test
Date: Fri, 10 May 2013 23:03:32 -0700
Message-ID: <20130511060332.GA3394@elie>
References: <518BA058.6050300@lsrfire.ath.cx>
 <518BA10B.2080003@lsrfire.ath.cx>
 <518BA64A.5020302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, BJ Hargrave <bj@bjhargrave.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat May 11 08:03:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub2uI-0007LO-Td
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 08:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab3EKGDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 02:03:42 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:37650 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab3EKGDl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 May 2013 02:03:41 -0400
Received: by mail-ee0-f43.google.com with SMTP id b15so2678966eek.2
        for <git@vger.kernel.org>; Fri, 10 May 2013 23:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2f3d37XoXHYFr0w6hjht5r/wB9ljGZxcE6BsZaDGL3M=;
        b=NZvW/xhNmxxkofcvyc+zGJ0xpd/pdt/mtkk5rN1eTxI/wvEhGZrmAsvL8/YVV+l1K8
         dPHzp3gZT7jrOz8pH1G9IDgauq/38KjG/VXRwkhld90sUbsPCweiNBBk+AaI+OBj2Idg
         K1UoFv+zhRjRwplBLy0/kLVSoqUfYL2XxQRSxO9YjgduJewTz7UnW/aC2yNn5qRKdMKG
         4br+0zTSZxak9argeuYevzGPxSI8Nj69xEcZ3QWYYuCfQRlJDcT2VT3rsSiBXr7YzLWm
         PmN1GVpjZTme0BmWkzpVUjz+D9tg3uC63+JA4UxcrhVf9Hlw5EeavVWJpO+tMfki8zbp
         Bb4w==
X-Received: by 10.14.127.5 with SMTP id c5mr49795906eei.45.1368252220207;
        Fri, 10 May 2013 23:03:40 -0700 (PDT)
Received: from elie ([213.221.117.228])
        by mx.google.com with ESMTPSA id w43sm7837271eeg.14.2013.05.10.23.03.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 23:03:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <518BA64A.5020302@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223930>

Hi,

Ren=C3=A9 Scharfe wrote:

> [Subject: t5004: resurrect original empty tar archive test]
[...]
> The different approaches test different things: The existing one is
> for empty trees, for which we know the exact expected output and thus
> we can simply check it without extracting; the new one is for commits
> with empty trees, whose archives include stamps and so the more
> "natural" check by extraction is a better fit because it focuses on
> the interesting aspect, namely the absence of any archive entries.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

When first reading I was a little confused: does this patch resurrect
the original, existing test for empty tree handling in the form it had
before patch 2/3, or is it adding a new, distinct test that
complements the existing one that patch 2/3 modified?

A quick glance back at v1.8.2.2~7^2 (t5004: fix issue with empty
archive test and bsdtar, 2013-04-10) cleared matters up.  The original
test that is being resurrected is the one from before that commit.

Maybe a reminder in the commit message would help.  E.g.,

	The earlier version of the same check (before 24676f02, "t5004: fix
	issue with empty archive test and bsdtar") revived by this patch tests
	a different thing: The modified check is for empty trees, for which we
	know the exact expected output and thus we can simply check it without
	extracting; the original one is for commits with empty trees, whose
	archives include stamps and so the more "natural" check by extraction
	is a better fit because it focuses on the interesting aspect, namely
	the absence of any archive entries.

With or without such a change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Would it make sense to define HEADER_ONLY_TAR_OK as a lazy prereq in
the same file (even though it is only used once), so the code that
checks "tar" is not run if this test is being skipped (e.g.,
using GIT_TEST_SKIP) for some other reason?

Thanks,
Jonathan
