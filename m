From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Fri, 14 Jun 2013 15:36:42 -0700
Message-ID: <7v7ghwmi9x.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-6-git-send-email-artagnon@gmail.com>
	<7vvc5hubox.fsf@alter.siamese.dyndns.org>
	<CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
	<7vd2rpu3kf.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
	<7vppvosstl.fsf@alter.siamese.dyndns.org>
	<CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
	<7v38sksq14.fsf@alter.siamese.dyndns.org>
	<CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
	<7vsj0kpsb0.fsf@alter.siamese.dyndns.org>
	<CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 00:36:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uncby-0001ra-0I
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 00:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602Ab3FNWgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 18:36:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab3FNWgp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 18:36:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1037D27BB8;
	Fri, 14 Jun 2013 22:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UfAnnz8kGeKQSNDQ6kNbv6VIm2A=; b=FD4Oc3
	yzl9IVp6ldAUcjpSuMw2K7Bp6msJ/gIk4vSMh2KUAXQrcGnXyr7v2r/xY/fWXpV+
	afluvO4kyn39wmsI5GYUV85/xNjC/n9emxTXtP09hkBHrAmui/iBbEM7lAOlVYw1
	woWD+pbgM2voC8GWJJ/KlAJEz0QBb8Y1VjIyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M2zKTpQigOgtWUlQf2ts8ch/v9nX+PJk
	AyoyiiuCRDJa19FfYZ3jtrJc9HyMI/hKvGQbtTrscXn9OnhjfllvKIcPuSamy1GO
	GNMKW4bUFlyYNpJrjo3p/l8O4LOAAHk3jvb+zZsQ2cK/Rl3uwby/nnkyXPMH91HL
	AiFxmfIg2sc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05E5427BB7;
	Fri, 14 Jun 2013 22:36:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 656C627BB6;
	Fri, 14 Jun 2013 22:36:44 +0000 (UTC)
In-Reply-To: <CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 15 Jun 2013 03:06:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3FF7C94-D542-11E2-BDD0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227931>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Since you have made it clear that you will defend every bit of b397ea

You are misreading me.  I am not defending every bit at all.

We both agree that what b397ea4863a1 (status: show more info than
"currently not on any branch", 2013-03-13) expects from "git status"
during an interrupted "git rebase" is _not_ sacred, especially when
we are about to fix what "git rebase" records in the reflog.

I am only saying that the last test the commit adds must be kept
unbroken.  I am also saying that, even though that commit did not
add a test for "detached from" case, we should add something like
the attached to protect the behaviour.  These two are sacred.

What happens to be shown during a stopped "git rebase" is not.

I have been assuming the "main" thing Duy wanted to do was the last
test (and the one below), but was this meant as an improvement for
"git status" output during that state?  Showing $ONTO certainly
makes some sense, and from that point of view, the change we are
discussing _will_ be a regression if it just shows a random thing.
If you want to avoid regression, the codepath in wt-status.c should
compensate for the change to "rebase" so that it checks $dotest/onto
and show what is recorded in there.

But in practice, as far as we know other people are working on it in
the near-by thread, I do not think this particular regression (if it
was) matters that much.  At the worst, we can queue that on top of
this topic to fix "rebase ; checkout -" and have them graduate at
the same time to avoid it.

 t/t7512-status-help.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index bf08d4e..e07185e 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -675,6 +675,14 @@ test_expect_success 'status showing detached from a tag' '
 	nothing to commit (use -u to show untracked files)
 	EOF
 	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual &&
+
+	git reset --hard HEAD^ &&
+	cat >expected <<-\EOF
+	# HEAD detached from atag
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
 
