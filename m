From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 02/16] Add git-remote-testsvn to Makefile
Date: Tue, 28 Aug 2012 09:55:23 -0700
Message-ID: <7v4nnn5538.fsf@alter.siamese.dyndns.org>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Aug 28 18:55:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6P4g-0002vZ-9O
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 18:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab2H1Qz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 12:55:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162Ab2H1Qz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 12:55:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDC349CED;
	Tue, 28 Aug 2012 12:55:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G/xorUa097O/3cSS62Whq8/15q0=; b=LW2R7m
	zmapWNfv2RslIBbC3M7ZA+89BSrOrKVkt4TGdDQewSYZjtbUi4Ky2/VqhwoaqKmu
	6VbDcKgQ1ExMK07LcRo6Hl6eX7ZYnI8GJ5NDqppfTaMW5pOD8/YhVykqzsEMf273
	h8wVJS6fToScHO9tkKW2jAWi724JjWWq0XZ7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S76wgAXp3CtZl81X22V/dQbKtzhVp+rt
	nrKTSB213VsJeKJ2im+LokbLQevfoI4EGAV8ebV291qDB+ubunO4e/sbgbqlWWTS
	oKVjFFlJnkpkavgH7wx5opkonih9yj9m+EHV9qBz2PMhsT/ebEz1zceVTetSyFq2
	56AYAlsMiDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA4269CEC;
	Tue, 28 Aug 2012 12:55:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FFD39CE7; Tue, 28 Aug 2012
 12:55:25 -0400 (EDT)
In-Reply-To: <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Tue, 28 Aug 2012 10:49:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 299E3B92-F131-11E1-B877-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204431>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> The link-rule is a copy of the standard git$X rule but adds VCSSVN_LIB.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 66e8216..1b09454 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -477,6 +477,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
>  PROGRAM_OBJS += shell.o
>  PROGRAM_OBJS += show-index.o
>  PROGRAM_OBJS += upload-pack.o
> +PROGRAM_OBJS += remote-testsvn.o
>  
>  # Binary suffix, set to .exe for Windows builds
>  X =
> @@ -2352,6 +2353,10 @@ git-http-push$X: revision.o http.o http-push.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
>  
> +git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
> +	$(VCSSVN_LIB)
> +
>  $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
>  	$(QUIET_LNCP)$(RM) $@ && \
>  	ln $< $@ 2>/dev/null || \

I'd squash in a change to add this executable to .gitignore
(attached) to this patch.  Unless you have objections to it, or
suggestions to do it better, there is no need to resend.

Thanks.

 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git i/.gitignore w/.gitignore
index bb5c91e..51294d6 100644
--- i/.gitignore
+++ w/.gitignore
@@ -125,6 +125,7 @@
 /git-remote-fd
 /git-remote-ext
 /git-remote-testgit
+/git-remote-testsvn
 /git-repack
 /git-replace
 /git-repo-config
