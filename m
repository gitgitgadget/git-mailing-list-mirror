From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Changing two defaults in the upcoming Git for Windows 2.8.0
Date: Mon, 21 Mar 2016 13:30:46 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603211240070.4690@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-119059464-1458563447=:4690"
Cc: git@vger.kernel.org
To: git-for-windows@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Mar 21 13:31:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahyz2-0004Gu-8F
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 13:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbcCUMav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 08:30:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:57457 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755833AbcCUMau (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 08:30:50 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlXnX-1a6jDc0MXn-00bHgv; Mon, 21 Mar 2016 13:30:47
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:cVLEpDl27797st7pRVD6yFnWsaP8gbGHdwr0Srl2OrRj99m8aKq
 JkIdQrAp8xFSjrGcPPwZ0KKdtVF/HC/o+/XauURvy0ZZKtxRCrdyAxcGY7u4ZyFWOs0ygmN
 mWjHYtOICltJYQbMbYwD5j6KJ6oZQ3vhrEkFoNjwYuZJ4NUdJmHapc3Iw/H5X6cth4sxMZz
 GcLLjfZDoAqZhV8QfACUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sqz79UGwbsk=:rfyAzrZYJ6PazCJb+WP0bs
 RGlNafUu3x77+HOEZEeKsjRwampc4nvA+5dqtVpNfgWQWZUjGkNYJwidvqDhVL4XMwcszikKZ
 K9cm6Cj26wlrQszG8DJu+1Ar88ypdpqBnJI7SVtQmBiiy7Xy/TXJAnFwi9VWAGeJBClRu08NP
 eauEguWzywlJGY+RAPZjttBTgqpSJAXq+FnYnDy+scf2zQJlB22eIgAql6aPCQytUjkHeUFaG
 +0L0rgB2NGPEyN3jWmf+jkVX6KbGwSiyKSQbJllfwAyczDJIY6fDiGguCaWrdmzQ7PHs6tTkf
 qVebBBz171aBcf/qVmxuAMZRhvKcsDvYn0bm4QXPlGP2CzuvqGwjn4jOVFy+OU71dAJeB0jpu
 Dtt8QqKuJW6fLCGIm8phbv63EcRSgN+TVClYzq5ae2nciZzT02bXaz/Y6OVlrQrAZsAcwphNz
 guAiBvjkCtUv1RVWB8lZEw7xlwZNXMjh/F9q7jMeJ+RuQZyZiETBdxRzbhfrf3XfTP0ePk3Qg
 5h5rP6EgLjpUMoa+zBrWR9gi5/lGbFDpFI+GGBvSzIP9XgFRa9X2tRVp8AiLBx5ExBRyyPRIE
 +Qonc/qkRdQK1UYbXfELVvi199KIy/BCW4+JA8aq6vHZU0wo4PDjGi7z9QnIZagTqkEQRIzsj
 1xG7J+kJYN/SZGInuN0mE4s9MJcTPnanpVO7HrNlsnhSHYKN4Xyh4fDOYf6pd0Y2RWJJxdlR6
 oG7xsXtAE77/eBfoprXRR/5GzdJ6R30A42C0sNcH91aL4tp+KJBV4NboRjnVI0/fdUvBMzqI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289416>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-119059464-1458563447=:4690
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

even if 2.8.0 got delayed a little bit, it is pretty imminent now. And it
also poses an excellent excuse for me to make some more visible changes in
the Git for Windows installer.

In particular, I would like to enable fscache by default:

=09https://github.com/git-for-windows/build-extra/pull/101

The fscache feature lets us read the stat() information much more
efficiently on Windows, by using a fast, whole-directory method (read: it
will actually slow down things if only one or two files=E2=80=99 stat()
information is required, but that is not typically the case).

Many power users use this feature for quite some time already, so it is
safe to say that it stood the test of time.

Another option I plan to change is whether/what to add to the PATH:

=09https://github.com/git-for-windows/build-extra/pull/102

Previously, we did not add anything to the system-wide PATH by default at
all. So installing Git for Windows would not result in users being able to
use Git, except from the Git Bash. This is not helpful for most Windows
users (who are much more familiar with cmd.exe than with the Bash).

Thanks for your feedback!
Johannes
--8323329-119059464-1458563447=:4690--
