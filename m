From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Black smoke from git rebase -i exec
Date: Tue, 10 Aug 2010 13:08:02 +0000
Message-ID: <AANLkTikCgSNRipTbjiL+uPOqCL3WXwn08_QV=UJ7EwvT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 10 15:08:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OioZ0-0004Yg-OG
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 15:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605Ab0HJNII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 09:08:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45936 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620Ab0HJNIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 09:08:05 -0400
Received: by fxm13 with SMTP id 13so626748fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=MQXVbls3QpRVFyInpWlTdujZ/LdoK3q0MxJD+SneW70=;
        b=b8GYP2XqYIX7+5HEXgxLDxHsmQ5Z25OSQreJeiDyD9+vc3WL1TYjlPoD9ODS73MSqX
         1kOuc+A4RgTD/Ttlwauhidm6nB795kIm832wt05cPKkfVXyADnwZFyb86UNDaFvEEn5V
         pzfeK8Z7ChpBTzZmDx/uPJF5kqLT1Z9kl/0vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=fNYaQjXe0vKDFkfw+R7NdSdRaYUZ6fMbDI9l7zsh9rQAPfSBm7hrD+PmVqZMFQDcoW
         AwL12LurYPbevkZeyH5ZYfk0Uo84bFsUCiMULLnv8KJg2uuk2B8hxLX/087giWL8QR9N
         E7VhS0ZOb2cNQFAVKmysbAcG4FRNg/Whcbss8=
Received: by 10.103.191.11 with SMTP id t11mr1207646mup.117.1281445682988; 
	Tue, 10 Aug 2010 06:08:02 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 10 Aug 2010 06:08:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153102>

There's some black smoke in pu after the git rebase -i series was
applied: http://smoke.git.nix.is/app/projects/report_details/14

Note: just the t3404-rebase-interactive.sh failure, not
t6040-tracking-info.sh, that's something else.

Here's the --verbose output from the test, hopefully that helps, if
not I can supply some additional info:

    Initialized empty Git repository in
/tmp/build-and-install-git-olpK/t/trash
directory.t3404-rebase-interactive/.git/
    expecting success:
    	test_commit A file1 &&
    	test_commit B file1 &&
    	test_commit C file2 &&
    	test_commit D file1 &&
    	test_commit E file3 &&
    	git checkout -b branch1 A &&
    	test_commit F file4 &&
    	test_commit G file1 &&
    	test_commit H file5 &&
    	git checkout -b branch2 F &&
    	test_commit I file6
    	git checkout -b conflict-branch A &&
    	for n in one two three four
    	do
    		test_commit $n conflict
    	done &&
    	git checkout -b no-conflict-branch A &&
    	for n in J K L M
    	do
    		test_commit $n file$n
    	done &&
    	git checkout -b no-ff-branch A &&
    	for n in N O P
    	do
    		test_commit $n file$n
    	done

    [master (root-commit) 6e62bf8] A
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 file1
    [master 313fe96] B
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 1 deletions(-)
    [master d0f65f2] C
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 file2
    [master 0547e3f] D
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 1 deletions(-)
    [master 8f99a4f] E
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 file3
    Switched to a new branch 'branch1'
    [branch1 cfefd94] F
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 file4
    [branch1 83751a6] G
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 1 deletions(-)
    [branch1 4373208] H
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 file5
    Switched to a new branch 'branch2'
    [branch2 615be62] I
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 file6
    Switched to a new branch 'conflict-branch'
    [conflict-branch b895952] one
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 conflict
    [conflict-branch 766a798] two
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 1 deletions(-)
    [conflict-branch 1eadf03] three
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 1 deletions(-)
    [conflict-branch f91a2b3] four
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 1 deletions(-)
    Switched to a new branch 'no-conflict-branch'
    [no-conflict-branch 808874f] J
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 fileJ
    [no-conflict-branch 265b89e] K
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 fileK
    [no-conflict-branch 6b0f5e6] L
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 fileL
    [no-conflict-branch 3389558] M
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 fileM
    Switched to a new branch 'no-ff-branch'
    [no-ff-branch 53b4423] N
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 fileN
    [no-ff-branch cc47714] O
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 fileO
    [no-ff-branch faef1a5] P
     Author: A U Thor <author@example.com>
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 fileP
    ok 1 - setup

    expecting success:
    	git checkout master &&
    	FAKE_LINES="1 exec_touch_touch-one 2 exec_touch_touch-two
exec_false exec_touch_touch-three 3 4
    		exec_touch_\"touch-file__name_with_spaces\";_touch_touch-after-semicolon
5" \
    		test_must_fail git rebase -i A &&
    	test -f touch-one &&
    	test -f touch-two &&
    	! test -f touch-three &&
    	test $(git rev-parse C) = $(git rev-parse HEAD) || {
    		echo "Stopped at wrong revision:"
    		echo "($(git describe --tags HEAD) instead of C)"
    		false
    	} &&
    	git rebase --continue &&
    	test -f touch-three &&
    	test -f "touch-file  name with spaces" &&
    	test -f touch-after-semicolon &&
    	test $(git rev-parse master) = $(git rev-parse HEAD) || {
    		echo "Stopped at wrong revision:"
    		echo "($(git describe --tags HEAD) instead of master)"
    		false
    	} &&
    	rm -f touch-*

    Switched to a new branch 'master'
    Rebasing (4/4)
Successfully rebased and updated refs/heads/master.
    Stopped at wrong revision:
    (E instead of C)
    Stopped at wrong revision:
    (E instead of master)
    not ok - 2 rebase -i with the exec command
    #	
    #		git checkout master &&
    #		FAKE_LINES="1 exec_touch_touch-one 2 exec_touch_touch-two
exec_false exec_touch_touch-three 3 4
    #			exec_touch_\"touch-file__name_with_spaces\";_touch_touch-after-semicolon
5" \
    #			test_must_fail git rebase -i A &&
    #		test -f touch-one &&
    #		test -f touch-two &&
    #		! test -f touch-three &&
    #		test $(git rev-parse C) = $(git rev-parse HEAD) || {
    #			echo "Stopped at wrong revision:"
    #			echo "($(git describe --tags HEAD) instead of C)"
    #			false
    #		} &&
    #		git rebase --continue &&
    #		test -f touch-three &&
    #		test -f "touch-file  name with spaces" &&
    #		test -f touch-after-semicolon &&
    #		test $(git rev-parse master) = $(git rev-parse HEAD) || {
    #			echo "Stopped at wrong revision:"
    #			echo "($(git describe --tags HEAD) instead of master)"
    #			false
    #		} &&
    #		rm -f touch-*
    #	

    expecting success:
    	git checkout master &&
    	mkdir subdir && cd subdir &&
    	FAKE_LINES="1 exec_touch_touch-subdir" \
    		git rebase -i HEAD^ &&
    	cd .. &&
    	test -f touch-subdir &&
    	rm -fr subdir

    Already on 'master'
    rebase -i script before editing:
    pick 8f99a4f E

    rebase -i script after editing:
    pick 8f99a4f E
    exec touch touch-subdir
    Rebasing (2/2)
Executing: touch touch-subdir
    Successfully rebased and updated refs/heads/master.
    ok 3 - rebase -i with the exec command runs from tree root

    expecting success:
    	git checkout master &&
    	FAKE_LINES="exec_echo_foo_>file1 1" \
    		test_must_fail git rebase -i HEAD^ &&
    	test $(git rev-parse master^) = $(git rev-parse HEAD) || {
    		echo "Stopped at wrong revision:"
    		echo "($(git describe --tags HEAD) instead of master^)"
    		false
    	} &&
    	git reset --hard &&
    	git rebase --continue

    Already on 'master'
    Rebasing (1/1)
Successfully rebased and updated refs/heads/master.
    Stopped at wrong revision:
    (E instead of master^)
    not ok - 4 rebase -i with the exec command checks tree cleanness
    #	
    #		git checkout master &&
    #		FAKE_LINES="exec_echo_foo_>file1 1" \
    #			test_must_fail git rebase -i HEAD^ &&
    #		test $(git rev-parse master^) = $(git rev-parse HEAD) || {
    #			echo "Stopped at wrong revision:"
    #			echo "($(git describe --tags HEAD) instead of master^)"
    #			false
    #		} &&
    #		git reset --hard &&
    #		git rebase --continue
    #	

    # failed 2 among 4 test(s)
    1..4

(I modified the test to only run the failing tests)
