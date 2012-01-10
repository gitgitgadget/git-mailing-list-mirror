From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: rerere.enabled overrides [ -d rr-cache ]
Date: Tue, 10 Jan 2012 15:57:27 +0100
Message-ID: <87aa5vd2qw.fsf@thomas.inf.ethz.ch>
References: <f697b8eff63a8cdd1207c6bfd6b88c532832c6b5.1325855112.git.trast@student.ethz.ch> <7vfwfsk24y.fsf@alter.siamese.dyndns.org> <87boqge19s.fsf@thomas.inf.ethz.ch> <7vk454gkh3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 15:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkd8q-0007CL-5e
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 15:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068Ab2AJO5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 09:57:31 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:16300 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078Ab2AJO5a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 09:57:30 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 15:57:27 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 15:57:27 +0100
In-Reply-To: <7vk454gkh3.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.3.1-59-g676d251 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-suse-linux-gnu)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188252>

Sorry I'm late, but...

On Fri, 6 Jan 2012 21:17:12 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Running "unset" is how to return the _variable_ to the previous state, but
> that is _not_ how to return to the previous state of the _repository_.
> 
> Perhaps something like this in addition?
[...]
>  	encountered again.  By default, linkgit:git-rerere[1] is
>  	enabled if there is an `rr-cache` directory under the
> -	`$GIT_DIR`.
> +	`$GIT_DIR`, e.g. if "rerere" was previously used in the
> +	repository.

I don't feel strongly about it, but this is a really neat and concise
way to put it, so why not.  Here's hoping I can save you some work:

---- 8< ---- 8< ----
From: Junio C Hamano <gitster@pobox.com>
Subject: Documentation: rerere's rr-cache auto-creation and rerere.enabled

The description of rerere.enabled left the user in the dark as to who
might create an rr-cache directory.  Add a note that simply invoking
rerere does this.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04f5e19..c523c67 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1786,7 +1786,8 @@ rerere.enabled::
 	conflict hunks can be resolved automatically, should they be
 	encountered again.  By default, linkgit:git-rerere[1] is
 	enabled if there is an `rr-cache` directory under the
-	`$GIT_DIR`.
+	`$GIT_DIR`, e.g. if "rerere" was previously used in the
+	repository.
 
 sendemail.identity::
 	A configuration identity. When given, causes values in the


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
