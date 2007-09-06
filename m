From: "Nikodemus Siivola" <nikodemus@random-state.net>
Subject: git stash usage
Date: Thu, 6 Sep 2007 17:20:13 +0300
Message-ID: <6bcc356f0709060720x257aff95x783463c5b23f0b7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 16:20:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITIDV-0000Ub-AU
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbXIFOUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 10:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbXIFOUQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:20:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:64154 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbXIFOUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 10:20:15 -0400
Received: by nf-out-0910.google.com with SMTP id f5so143997nfh
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=0kZHwiSriIUQOfryjUsv21BLJR72qXk2Iorc9scWF3Q=;
        b=JAPKHfoEGCRykmIZpzR8gATmjpS85UVHuyS+ylZyUE3HzF69bj4SyuWHOqYAK57ZFFXtzVdcUE8SGWfEbj4bEKCB1rz9Ua0U5MKQtyAbdFCD5W/Qz0o1T0ULJ1X4+8fXogT9318XBflldvHYv4zYpQ9ts4jcYeZUs/INoTg3En0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=k/TbaQbfBwglTpyc4PuIqXtKeMj4zfTdRkMesC7XwkL6FRQcRJbEUuwbMZJCusCFJH2+WmjrWdrkcRnAQgWjfTzN+BWoJnFDua9YOT4UhoBj/AbRre6atK1dKq6taf4vmpYgFgoOo2gyqPHv24iMDzwacmiecZmnlKHvKysRBOQ=
Received: by 10.78.185.15 with SMTP id i15mr326237huf.1189088413291;
        Thu, 06 Sep 2007 07:20:13 -0700 (PDT)
Received: by 10.78.170.2 with HTTP; Thu, 6 Sep 2007 07:20:10 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: e53707a0f8315a26
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57881>

I'm not sure if I understand git-stash correctly.

 ...work...
 git stash
 ...quick fix & commit...
 git stash apply
 ...more work...

is my understanding of the normal workflow. If this is
correct, why does "apply" leave the stash in the list
of stashes?

  mkdir git-stash-test
  cd git-stash-test
  git init
  echo foo > save-apply-test.txt
  git add save-apply-test.txt
  git commit -m "foo"
  echo bar > save-apply-test.txt
  git stash
  echo quux > save-apply-test.txt
  git commit -a -m "quux"
  git stash apply
  git commit -a -m "bar"
  # I would expect the list to be empty now, but it isn't.
  git stash list

Is this intentional?

It's a bit inconvenient, especially considering that
"clear" removes all the stashes.

I can easily accumulate several stashes, some of which
are applied and some of which are not -- but have no
way to easily know which are which.

Cheers,

 -- Nikodemus
