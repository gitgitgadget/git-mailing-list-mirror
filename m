From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: git push failed
Date: Sun, 24 Jan 2010 18:52:04 +0100
Organization: 
Message-ID: <6672d0161001240952s7f7629a6v48f5756c083b95b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 18:52:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ6dC-0004vR-4e
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 18:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab0AXRwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2010 12:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649Ab0AXRwJ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 12:52:09 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:56163 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab0AXRwG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2010 12:52:06 -0500
Received: by ey-out-2122.google.com with SMTP id d26so735899eyd.19
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 09:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=2AeubjHIoAqwwDdhXLPHrn4inpLxwnQ2b4UuXJXJtns=;
        b=Y3RFjvt0Sxetw5+ksP39MVGJbFzLVReLTCFn2UnWWzWzGtHi9SeOEFM8vD2SXTJzX7
         yz6wYTTqibZm+QB0gUHxVmN0gI3y5+Y0+omffxAUnaDl8fmR/pUWVU3pQXbIDKTQfmbX
         ZNQwNQt7ZUzap/a9sQrZQ8SLfpHWRVsx0Dxh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=NXfYjvA3mx9+RIUhwcPxAaNrv9oA9wy9FkwpJoCoZaS7nKgyaYSngLenzwtnsptViJ
         5IJSdsmIwvmZd8JiRdZwyCRKS+31kevelQrmf7wNkp4Y4Af9cpUZ8PfMyLRQwRDkgRys
         aTgB45EMU4W+t43lUo7YXgaaLBZbOP7P4CdF4=
Received: by 10.216.88.202 with SMTP id a52mr2205560wef.101.1264355524949; 
	Sun, 24 Jan 2010 09:52:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137905>

With git built from master (v1.6.6.1-436-gaba7dea),
the following commands (run in a script):

  git commit --amend -m "Update index.html" index.html
  git push erlang +gh-pages

failed like this:

Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 3.85 KiB, done.
Total 3 (delta 0), reused 0 (delta 0)
error: Ref refs/heads/gh-pages is at
db10c045e068f12aa2f78377fab31e35a8443ca4 but expected
054136d96494979b42524a4dc08ef643bb54cc0e
error: failed to lock refs/heads/gh-pages
To git@erlang_github.com:erlang/otp.git
 ! [remote rejected] gh-pages -> gh-pages (failed to lock)
error: failed to push some refs to 'git@erlang_github.com:erlang/otp.gi=
t'

Unfortunately (from the point of view of finding the bug), the
problem is not reproducible. When I ran my script two more times,
it worked fine.

We all know how difficult it is to investigate non-reproducible bugs,
but perhaps someone familiar with the code might have some idea
about what it could be.

Info about my system:

Mac OS X 10.2.6 (8 cores)
gcc-4.2.1

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
