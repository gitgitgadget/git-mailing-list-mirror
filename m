From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Tue, 23 Jul 2013 12:53:25 +0530
Message-ID: <CALkWK0kmcQ1ws143H7O6q9kRmdBxMDVYBWVBKp+0Hy0acpn7VA@mail.gmail.com>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Miklos V <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 09:24:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1WxH-0002ku-Iz
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 09:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247Ab3GWHYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 03:24:07 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:39630 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab3GWHYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 03:24:06 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so9217292obc.38
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6pXi9Gf4/rtuv59BFvnys3I1+SARW3JadDFNH2mYB08=;
        b=NS4xoPRxoGTpxUopAqWJXJJdDXkjtlTikiILrI/6YIY5t4l4YLfzWwO3H7Uj01dFye
         He+QFPU5G3AEezoWZ8z3yUKwqDzYPLDzp3dMoQeurwpVf/RDrfv+BE0t7O3FjjPXq2yk
         +6VeDtW33EDQmKxr+CbdrZWOObF/+SwJwxgIdTbCTySHJfGVONWxo/5dB5ejh8Wb3dl6
         svRJ9zdWJm304UoPBqhUwwoLvADbb+ST23zpO1zx+w7GpQxqwVetemJ20jx33CUvkllS
         nwt/vGRj5LpiY1Wimp5BA1+KN+O5dIr8edUeqsQc7wpk0rRx1BVAmMpp5QddlJwG7k7/
         usrA==
X-Received: by 10.50.6.16 with SMTP id w16mr12031763igw.29.1374564245554; Tue,
 23 Jul 2013 00:24:05 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 23 Jul 2013 00:23:25 -0700 (PDT)
In-Reply-To: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231028>

Junio C Hamano wrote:
> * mv/merge-ff-tristate (2013-07-02) 1 commit
>   (merged to 'next' on 2013-07-09 at c32b95d)
>  + merge: handle --ff/--no-ff/--ff-only as a tri-state option

Sorry I didn't notice sooner, but I was confused by the second test
title this added:

test_expect_success 'option --ff-only overwrites merge.ff=only config' '
	git reset --hard c0 &&
	test_config merge.ff only &&
	git merge --no-ff c1
'

How is --ff-only overwriting merge.ff=only here?  Was it a typo?

-- 8< --
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 3ff5fb8..aea8137 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -502,7 +502,7 @@ test_expect_success 'option --ff-only overwrites --no-ff' '
 	test_must_fail git merge --no-ff --ff-only c2
 '

-test_expect_success 'option --ff-only overwrites merge.ff=only config' '
+test_expect_success 'option --no-ff overwrites merge.ff=only config' '
 	git reset --hard c0 &&
 	test_config merge.ff only &&
 	git merge --no-ff c1
