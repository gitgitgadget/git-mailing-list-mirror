From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/20] [CONTINUE] Add gettext support to Git
Date: Wed, 08 Sep 2010 09:43:44 -0700
Message-ID: <7vd3sonq2n.fsf@alter.siamese.dyndns.org>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 18:44:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtNki-0003WL-7y
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 18:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756413Ab0IHQny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 12:43:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab0IHQnw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 12:43:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE279D40BC;
	Wed,  8 Sep 2010 12:43:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tuIvnYL3G6Wp4Gr7BiMIa3h3JjM=; b=xjqJdW
	QyaWlGxIzvbZ3Qp8Ad2ktDMTVs6h/9yioJOEGt3/PFIluD19s21nFuq1mNyY9IDB
	Y5okY6eKXgLaZlFT7dThvF2eOwOutrPV7z0dt1Zm66kygArLtugEKkIV0froaXnw
	J9xgw72MWglcr7thlQG5eqWlnJZ6rFBr+I2DA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V3ev2hDuvmjB2GaztgJ3DSzTOOVAPrke
	MtvTA8cSkv+h5yssj67rnZM/kZODJZExHKGUGTKvr4Sr1s8Lx90oAfT1Rnb4HvPx
	HD0Y4OZ8vSTP+/3x97l6lZLL3hOvEhR2jF2T4nGaRsS5B8DEObdbtGI5ssq/DjPj
	FII7ClHNakg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CAE0ED40BB;
	Wed,  8 Sep 2010 12:43:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFA1ED40B1; Wed,  8 Sep
 2010 12:43:45 -0400 (EDT)
Importance: high
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue\,  7 Sep
 2010 16\:45\:35 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 412066EC-BB68-11DF-BD73-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155799>

I've done

    git fetch git://github.com/avar/git +ab/i18n-all-continue:ab/i18n

and rebuilt 'pu' with it (I am not quite ready to push the results out,
though).

Please squash in the following to appropriate patches in the series.
Thanks.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 8 Sep 2010 09:33:18 -0700
Subject: [PATCH] Style fixups: explicitly disambiguate nested if/if/else correspondence

Write {} to let the compiler know that we know what we are doing, like
this, when writing a nested if/if/else:

    if (...) {
        if (...)
	    ...
	else
	    ...
    }

The programmer who writes the code like the above without the outermost {}
may know that "else" corresponds to the innermost "if", but it will keep
things easier and safer while reviewing patches that build on top of code
like this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c |    3 ++-
 builtin/clone.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 642d767..e1694c0 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -77,13 +77,14 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
 
-	if (!show_only && !force)
+	if (!show_only && !force) {
 		if (config_set)
 			die(_("clean.requireForce set to true and neither -n nor -f given; "
 				  "refusing to clean"));
 		else
 			die(_("clean.requireForce defaults to true and neither -n nor -f given; "
 				  "refusing to clean"));
+	}
 
 	if (force > 1)
 		rm_flags = 0;
diff --git a/builtin/clone.c b/builtin/clone.c
index 7b0d104..1f10f3f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -465,11 +465,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die(_("could not create leading directories of '%s'"), git_dir);
 	set_git_dir(make_absolute_path(git_dir));
 
-	if (0 <= option_verbosity)
+	if (0 <= option_verbosity) {
 		if (option_bare)
 			printf(_("Cloning into bare repository %s"), dir);
 		else
 			printf(_("Cloning into %s"), dir);
+	}
 	init_db(option_template, INIT_DB_QUIET);
 
 	/*
-- 
1.7.3.rc0.183.gb0497
