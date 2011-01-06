From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Repeatable test t9010-svn-fe.sh failure w/ master (685e9d9,
 1.7.4.rc1)
Date: Thu, 06 Jan 2011 10:15:04 -0800
Message-ID: <7vipy1c313.fsf@alter.siamese.dyndns.org>
References: <4D25E818.5050909@gmail.com> <20110106165958.GA11190@burratino>
 <4D25F9C5.6030503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 06 19:15:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PauNB-0008RU-PY
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 19:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab1AFSPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 13:15:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab1AFSPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 13:15:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D93593193;
	Thu,  6 Jan 2011 13:15:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nV0FyTteqBrj3r3v2RN72f7Ufuc=; b=GWPs/D
	EGEITdSu89i43+1OpJxq3aTuwKekPG1UWoKAZejWL++Qp/ga+vp7BmeeQQi9hCkw
	f7/DJpF7ugHRnR7ftM4fRbsoe5SRhAs1vybZhalWTfbZHzSK0gRjwNJNP47464Ym
	Lrkkf4ZajrXWRUzKjHWA4nr0AoCKImYe8S/Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X40M+PzyImsJs9QocaagtxZztd8t8VoZ
	lrYBHYVo94DbO8DIT2/MS680cFU/mK9mSETAzS3mPx1Zf+TtIXAA2kQg3nLyS4Be
	ANCrp3/CPpoyjQWa6EqkDQmmtf5GJJF+z+dstalEChivLMM4VKYWEI/ti+n88tqy
	o6anagyAang=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8BEA3191;
	Thu,  6 Jan 2011 13:15:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 80333318F; Thu,  6 Jan 2011
 13:15:44 -0500 (EST)
In-Reply-To: <4D25F9C5.6030503@gmail.com> (A. Large Angry's message of "Thu\,
 06 Jan 2011 12\:20\:05 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FCC85F4C-19C0-11E0-AD28-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164651>

A Large Angry SCM <gitzilla@gmail.com> writes:

> + svnadmin load simple-svn
> <<< Started new transaction, based on original revision 1
>      * adding path : branches ... done.
>      * adding path : trunk ... done.
> svnadmin: Couldn't perform atomic initialization
> svnadmin: Couldn't perform atomic initialization
> svnadmin: SQLite compiled for 3.7.4, but running with 3.7.3
> + eval_ret=1

Hmm.  Do any other svn related tests that use "svnadmin load" work in your
environment?

    $ cd t/
    $ git grep -l 'svnadmin load'
    t9010-svn-fe.sh
    t9110-git-svn-use-svm-props.sh
    t9111-git-svn-use-svnsync-props.sh
    t9112-git-svn-md5less-file.sh
    t9115-git-svn-dcommit-funky-renames.sh
    t9121-git-svn-fetch-renamed-dir.sh
    t9126-git-svn-follow-deleted-readded-directory.sh
    t9131-git-svn-empty-symlink.sh
    t9132-git-svn-broken-symlink.sh
    t9135-git-svn-moved-branch-empty-file.sh
    t9136-git-svn-recreated-branch-empty-file.sh
    t9150-svk-mergetickets.sh
    t9151-svn-mergeinfo.sh
    t9153-git-svn-rewrite-uuid.sh
    t9154-git-svn-fancy-glob.sh

Web searching for "svnadmin: SQLite compiled for" seems to give a handful
of hits, even though I don't see anything from Debian offhand.
