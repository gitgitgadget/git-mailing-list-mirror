From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Fri, 14 Jun 2013 16:07:43 -0700
Message-ID: <7v38skmgu8.fsf@alter.siamese.dyndns.org>
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
	<7v7ghwmi9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 01:07:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Und5z-0002Ja-0N
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 01:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab3FNXHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 19:07:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58287 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784Ab3FNXHq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 19:07:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E1FA283FB;
	Fri, 14 Jun 2013 23:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kUr5oCxvki1gpLVpEMEVypwPkfE=; b=IDY/rg
	OELAilF654fZVThfDQI0k3OEymeTV2l2GqC5HsjVy380rD6s4DlNx5BRuBnRJkij
	i9Vp3kIMoimhWkwmGG6z8OeD7n0q0LPx/WTmg5m8JfC/Go7fYPlldV1Elg08ZMol
	jY6baFmcQReSrlswqadPKDKNOcMJ8G2W5c7ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t4A4ht78TmK+2VxCfZ2ezdaaou4DanFQ
	bQ4Eriv+gVHOXwAJj10u7k7PT2cbHcQ9r6rVrds0sMGevEk+zpnUN2o2eRmTdAEP
	j9CXby2Ua+6rnsfpPGpI3lkLEf+fuimM3zLQMNSYpsq7oXwNF0jFGBRiiNC9ozlQ
	GNKaNlYuDrw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9553D283FA;
	Fri, 14 Jun 2013 23:07:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1BA2283F8;
	Fri, 14 Jun 2013 23:07:44 +0000 (UTC)
In-Reply-To: <7v7ghwmi9x.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 14 Jun 2013 15:36:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38FC45FC-D547-11E2-BB80-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227932>

Junio C Hamano <gitster@pobox.com> writes:

> I have been assuming the "main" thing Duy wanted to do was the last
> test (and the one below), but was this meant as an improvement for
> "git status" output during that state?  Showing $ONTO certainly
> makes some sense, and from that point of view, the change we are
> discussing _will_ be a regression if it just shows a random thing.
>
> If you want to avoid regression, the codepath in wt-status.c should
> compensate for the change to "rebase" so that it checks $dotest/onto
> and show what is recorded in there.

And it might be just the matter of doing something like this
(totally untested, of course).  Then the people who want to improve
"status" to give more detailed state during "rebase" can further
enhance the logic in this part to give more detailed information.

I have a feeling that without changing anything in t7512 but
applying the change to commit.c in your [6/6], most tests in there
would still pass, and you may even uncover latent *bug* that
expected to show a wrong $ONTO value in "# HEAD detached from/at"
line.

 wt-status.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index bf84a86..403d48d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1176,7 +1176,11 @@ void wt_status_print(struct wt_status *s)
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
-			if (state.detached_from) {
+
+			if (state.rebase_in_progress) {
+				on_what = _("HEAD detached at ");
+				branch_name = state.onto;
+			} else if (state.detached_from) {
 				unsigned char sha1[20];
 				branch_name = state.detached_from;
 				if (!get_sha1("HEAD", sha1) &&
