From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Mon, 30 Apr 2012 09:04:33 -0700
Message-ID: <7vipghgq9a.fsf@alter.siamese.dyndns.org>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
 <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
 <20120427082118.GA7257@dcvr.yhbt.net>
 <20120427082559.GC4023@login.drsnuggles.stderr.nl>
 <20120429082341.GA32664@dcvr.yhbt.net>
 <7vvckihyqm.fsf@alter.siamese.dyndns.org>
 <7vk40yhv5q.fsf@alter.siamese.dyndns.org>
 <20120430081939.GA27715@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 18:04:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOt5e-0006eC-F9
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 18:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab2D3QEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 12:04:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54456 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126Ab2D3QEg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 12:04:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C1867956;
	Mon, 30 Apr 2012 12:04:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DLE2hxrnZax/IX9TOA0uLj5rR/4=; b=j75rvy
	ql+tphLoqjoPFe445c/V15DQJHTK0CCcpViaeUkShV0SeaaVl7938UGoLPcgOcdO
	ZTTIktwQ09pjzm4iMsqvwRhZa0pzkXWbSLdFpsA862gAxSprhWKbdXdF6xLB0vVN
	c4Sdi9w6fenhL4x5HKf5ycCBVYy21mOuyAzrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TouOILi7qJc6SolN53nY5GjOCax5pW8F
	K5H037eLqQIwpCXmn5ROiPBNvSYO3L5wM1ajhEMrMNqVMZuOsly2vbJ2H8xXZcbV
	tOBR6VPgLHxDfNc0iO6zXbR4jWm2PsAdY3+r4mBI2nyMtlPkvwPVC+Xc6cGqrrh7
	Hc+HTym0Kbs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31F1C7955;
	Mon, 30 Apr 2012 12:04:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A2007954; Mon, 30 Apr 2012
 12:04:34 -0400 (EDT)
In-Reply-To: <20120430081939.GA27715@dcvr.yhbt.net> (Eric Wong's message of
 "Mon, 30 Apr 2012 08:19:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DBFFBF4-92DE-11E1-A44C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196573>

Eric Wong <normalperson@yhbt.net> writes:

> Which version of SVN is that?  (git svn --version)
> http://packages.ubuntu.com/lucid/libsvn-perl says 1.6.6
> (+distro patches), which shouldn't be affected by this patch...

: a00 git.git/master; git version
git version 1.7.10.405.g10d433
: a00 git.git/master; git svn --version
git-svn version 1.7.10.405.g10d433 (svn 1.6.6)
: a00 git.git/master; dpkg -l libsvn-perl
Desired=Unknown/Install/Remove/Purge/Hold
|
Status=Not/Inst/Cfg-files/Unpacked/Failed-cfg/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name              Version           Description
+++-=================-=================-==================================================
ii  libsvn-perl       1.6.6dfsg-2ubuntu Perl bindings for Subversion
: a00 git.git/master; cd t
: a00 t/master; sh t9100-git-svn-basic.sh -i -v
Initialized empty Git repository in /scratch/buildfarm/git.git/t/trash
directory.t9100-git-svn-basic/.git/
define NO_SVN_TESTS to skip git svn tests
expecting success:
        mkdir import &&
        (
                cd import &&
                echo foo >foo &&
                ln -s foo foo.link
                mkdir -p dir/a/b/c/d/e &&
                echo "deep dir" >dir/a/b/c/d/e/file &&
                mkdir bar &&
                echo "zzz" >bar/zzz &&
                echo "#!/bin/sh" >exec.sh &&
                chmod +x exec.sh &&
                svn_cmd import -m "import for git svn" . "$svnrepo"
                >/dev/null
        ) &&
        rm -rf import &&
        git svn init "$svnrepo"
ok 1 - initialize git svn

expecting success: git svn fetch
ValueError svn_auth_get_platform_specific_client_providers is not
implemented yet

not ok - 2 import an SVN revision into git
#       git svn fetch
