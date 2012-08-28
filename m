From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 16/16] Add a test script for remote-svn
Date: Tue, 28 Aug 2012 11:01:56 -0700
Message-ID: <7vk3wi28tn.fsf@alter.siamese.dyndns.org>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:03:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Q89-0003i1-1m
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab2H1SDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:03:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260Ab2H1SDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:03:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA72D9234;
	Tue, 28 Aug 2012 14:03:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=GBgCANZvZMDMc9wq2DOJdPcNSxo=; b=fIF7pSmKUks48kOmAzlW
	2aAmDrHkTp8IHcHvcz6vIldLT9W/t+sAuc+zGmb/0MJ2Tx4QMroXyDrVkTh8+vcU
	VeuduCUA42kOgpQM7GRXknvcQwhky3+Txbn64+hVqJ0wo7pktHUUkgECPUl5iJVa
	pd8Cnwo/bxUL4ulP21MGcXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=B99xjWrvjaqtZy6X9w+CAbnA5vXlAOF1HavE5jwplHPM4J
	AaG3ec9BldfuBOBVrIFTLQN81bWiZZsEyvFZzbF7Kex78xqAy6mwSSFpQ0r2/wk6
	9GhOFwh0YXccwe54h7kfkk2RQgWYF6Dnv8UsXLl2rafLix6hGt3aZ9GUWZKKw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C526D9233;
	Tue, 28 Aug 2012 14:03:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 072DA9230; Tue, 28 Aug 2012
 14:03:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BB632A8-F13A-11E1-A63D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204441>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> Use svnrdump_sim.py to emulate svnrdump without an svn server.
> Tests fetching, incremental fetching, fetching from file://,
> and the regeneration of fast-import's marks file.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t9020-remote-svn.sh |   82 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100755 t/t9020-remote-svn.sh
>
> diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
> new file mode 100755
> index 0000000..e6ed4ca
> --- /dev/null
> +++ b/t/t9020-remote-svn.sh
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +
> +test_description='tests remote-svn'
> +
> +. ./test-lib.sh
> +
> +if ! test_have_prereq PYTHON
> +then
> +	skip_all='skipping remote-svn tests, python not available'
> +	test_done
> +fi
> +
> +# We override svnrdump by placing a symlink to the svnrdump-emulator in .
> +export PATH="$HOME:$PATH"
> +ln -sf $GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py "$HOME/svnrdump"
> +
> +init_git () {
> +	rm -fr .git &&
> +	git init &&
> +	#git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9020/example.svnrdump
> +	# let's reuse an exisiting dump file!?
> +	git remote add svnsim testsvn::sim://$TEST_DIRECTORY/t9154/svn.dump
> +	git remote add svnfile testsvn::file://$TEST_DIRECTORY/t9154/svn.dump
> +}
> +
> +if test -e "$GIT_BUILD_DIR/git-remote-testsvn"
> +then
> +	test_set_prereq REMOTE_SVN
> +fi
> +
> +test_debug '
> +	git --version
> +	which git
> +	which svnrdump
> +'
> +
> +test_expect_success REMOTE_SVN 'simple fetch' '
> +	init_git &&
> +	git fetch svnsim &&
> +	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master  &&
> +	cp .git/refs/remotes/svnsim/master master.good
> +'
> +
> +test_debug '
> +	cat .git/refs/svn/svnsim/master
> +	cat .git/refs/remotes/svnsim/master
> +'
> +
> +test_expect_success REMOTE_SVN 'repeated fetch, nothing shall change' '
> +	git fetch svnsim &&
> +	test_cmp master.good .git/refs/remotes/svnsim/master
> +'
> +
> +test_expect_success REMOTE_SVN 'fetch from a file:// url gives the same result' '
> +	git fetch svnfile
> +'
> +
> +test_expect_failure REMOTE_SVN 'the sha1 differ because the git-svn-id line in the commit msg contains the url' '
> +	test_cmp .git/refs/remotes/svnfile/master .git/refs/remotes/svnsim/master
> +'
> +
> +test_expect_success REMOTE_SVN 'mark-file regeneration' '
> +	# filter out any other marks, that can not be regenerated. Only up to 3 digit revisions are allowed here
> +	grep ":[0-9]\{1,3\} " .git/info/fast-import/remote-svn/svnsim.marks > .git/info/fast-import/remote-svn/svnsim.marks.old &&
> +	rm .git/info/fast-import/remote-svn/svnsim.marks &&
> +	git fetch svnsim &&
> +	test_cmp .git/info/fast-import/remote-svn/svnsim.marks.old .git/info/fast-import/remote-svn/svnsim.marks
> +'

Could these loooooong lines be made a bit more manageable?  It is
getting extremely hard to follow.


> +test_expect_success REMOTE_SVN 'incremental imports must lead to the same head' '
> +	export SVNRMAX=3 &&
> +	init_git &&
> +	git fetch svnsim &&
> +	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master  &&
> +	unset SVNRMAX &&
> +	git fetch svnsim &&
> +	test_cmp master.good .git/refs/remotes/svnsim/master
> +'
> +
> +test_debug 'git branch -a'
> +
> +test_done
 
