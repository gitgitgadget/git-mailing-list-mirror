From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [PATCH 03/24] t9300 (fast-import): guard "export large marks" test setup
Date: Fri, 24 Sep 2010 16:26:46 +0530
Message-ID: <87aan7e7f5.fsf@hariville.hurrynot.org>
References: <20100701031819.GA12524@burratino>
	<20100701054849.GA14972@burratino> <20100817170216.GA14491@kytes>
	<20100905031528.GA2344@burratino> <20100905032253.GB2344@burratino>
	<20100924065900.GA4666@burratino> <20100924070950.GD4666@burratino>
	<20100924093847.GE22658@kytes>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 13:38:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz6c2-0004ZW-Ol
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 13:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab0IXLil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 07:38:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:56015 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596Ab0IXLik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 07:38:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Oz6bs-0004Ui-1r
	for git@vger.kernel.org; Fri, 24 Sep 2010 13:38:36 +0200
Received: from 117.192.130.161 ([117.192.130.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 13:38:36 +0200
Received: from harinath by 117.192.130.161 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 13:38:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 117.192.130.161
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:B9GtbNydxKEn5yKJgvQiosQkONc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156977>

Hi,

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Jonathan Nieder writes:
[snip]
>> +	cat >input.commit <<-EOF &&
>> +	commit refs/heads/verify--dump-marks
>> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
>> +	data <<COMMIT
>> +	test the sparse array dumping routines with exponentially growing marks
>
> Ok, so we want marks to grow exponentially.

Just to clarify, this code is already in the tree.  Jonathan is only
re-indenting it and moving it inside a test_expect_success.

[snip]
>> +		i=0 &&
>> +		l=4 &&
>> +		m=6 &&
>> +		n=7 &&
>
> Maybe use slightly less cryptic variable names?

I expect these are fairly idiomatic, except maybe for 'n', which could
be replaced by 'u', I guess.

[snip]
>> +			l=$(($l + $l)) &&
>> +			m=$(($m + $m)) &&
>> +			n=$(($l + $n)) &&
>
> Maybe l=$(($l * 2)) and similarly for m to emphasize that they're
> doubling in every loop iteration?

Hmm, $l appears twice, that's literally doubling, isn't it ;-)

- Hari
