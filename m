From: "Wink Saville" <wink@saville.com>
Subject: How-to setup an empty remote repository?
Date: Sat, 25 Aug 2007 14:00:33 -0700
Message-ID: <d4cf37a60708251400t17b0a097t91f77cbb4e996810@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 23:00:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP2ka-0007kG-GV
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 23:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbXHYVAo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759538AbXHYVAm
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 17:00:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:7875 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759422AbXHYVAf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 17:00:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1464097wah
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 14:00:33 -0700 (PDT)
Received: by 10.114.156.1 with SMTP id d1mr2752115wae.1188075633362;
        Sat, 25 Aug 2007 14:00:33 -0700 (PDT)
Received: by 10.114.149.15 with HTTP; Sat, 25 Aug 2007 14:00:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56650>

Hello,

I thought I'd try to setup a shared "empty" remote repository and then
clone it and then push the initial commit from another maching.
This failed as shown below:

 $ cd ~/git-repos
 $ mkdir test.git
 $ cd test.git
 $ git --bare init --shared
 Initialized empty shared Git repository in /home/wink/git-repos/test.git/
 $ git-daemon --reuseaddr --verbose --base-path=/home/wink/git-repos \
    --export-all --enable=receive-pack

On my other machine:

$ git clone git://192.168.0.8/test.git
Initialized empty Git repository in /home/wink/prgs/test/.git/
fatal: no matching remote head
fetch-pack from 'git://192.168.0.8/test.git' failed.
$

And the remote machine responded:

[27299] Connection from 192.168.0.133:56710
[27299] Extended attributes (18 bytes) exist <host=192.168.0.8>
[27299] Request upload-pack for '/test.git'
[27299] Disconnected

In the instructions I followed for setting up a remote repository,
http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html,
it uses an existing repository. So is it true you can't clone an
empty remote repository, or did I do something wrong?

I'm using :
$ git --version
git version 1.5.3.rc6.23.g0058

Note, my reason for using the shared remote repository is to make it
simple and easy to backup my repository on a second machine and
it seemed reasonable to try a an empty repository.

Cheers,

Wink Saville
