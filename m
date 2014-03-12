From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [RFC PATCH 2/1] Make request-pull able to take a refspec of form local:remote
Date: Wed, 12 Mar 2014 11:04:11 -0700
Message-ID: <xmqqvbvjmgys.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	<xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
	<CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
	<xmqqsises3u0.fsf@gitster.dls.corp.google.com>
	<CA+55aFyN7WWAF6pGfP+0j29nf6ETao0J5sUu+5UDaXUYC9_Geg@mail.gmail.com>
	<xmqqvbx9qgo7.fsf@gitster.dls.corp.google.com>
	<xmqqfvo6icqf.fsf_-_@gitster.dls.corp.google.com>
	<CA+55aFyWM+VDa4mdqseNy3tSnp23x=2sPtHf5KpxsfROeHbVGw@mail.gmail.com>
	<xmqqob1u6f5d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 19:04:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNnVt-0004wf-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867AbaCLSER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:04:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755426AbaCLSEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:04:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6A5B7113D;
	Wed, 12 Mar 2014 14:04:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RDXvIcPIAAEfB4t4N0exQ12KtmU=; b=wJCcix
	4tekCPfgBDaTBLqTztbeyGeXhO1JimbRPYOEbQXlm5Kn0Iq+KAg4crgWH0CDC1gO
	VttBgV0XUFjHJR2Qdrqf9VhMYskRCtYsf28O4nQr6cnRyBQE3ax+M0AZ0eTHtVfT
	D+S2Mj+rxQY2bLX4E/pV7xsN0tp6GQzGGLPoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iprBkMxWHAZQ9UiSK57+DPzBjgwaG8yi
	Ondn9ELZHZNXKWLat7qFUN7/LFOAZRt5piHkQRtXlUqC67A78d5gCI7caJlfFLpg
	Pl6KZsk21H8KfH8CPkK5jLWzPZDBvBTIhJ/ZbT72hRz8XwC0ei5+gX6fmFHOKdsd
	+K9hmJBhjxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90F717113C;
	Wed, 12 Mar 2014 14:04:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5A597113A;
	Wed, 12 Mar 2014 14:04:14 -0400 (EDT)
In-Reply-To: <xmqqob1u6f5d.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 25 Feb 2014 13:44:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B8BE082C-AA10-11E3-A8CD-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243951>

Junio C Hamano <gitster@pobox.com> writes:

> Sorry for back-burnering this topic so long.
>
> I think the following does what you suggested in the message I am
> responding to.
>
> Now, hopefully the only thing we need is a documentation update and
> the series should be ready to go.

... and here it is, to be sanity checked before I queue the whole
thing in 'next'.

-- >8 --
Subject: [PATCH] request-pull: documentation updates

The original description talked only about what it does.  Instead,
start it with the purpose of the command, i.e. what it is used for,
and then mention what it does to achieve that goal.

Clarify what <start>, <url> and <end> means in the context of the
overall purpose of the command.

Describe the extended syntax of <end> parameter that is used when
the local branch name is different from the branch name at the
repository the changes are published.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-request-pull.txt | 55 +++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index b99681c..57bc1f5 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -13,22 +13,65 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Summarizes the changes between two commits to the standard output, and includes
-the given URL in the generated summary.
+Prepare a request to your upstream project to pull your changes to
+their tree to the standard output, by summarizing your changes and
+showing where your changes can be pulled from.
+
+The upstream project is expected to have the commit named by
+`<start>` and the output asks it to integrate the changes you made
+since that commit, up to the commit named by `<end>`, by visiting
+the repository named by `<url>`.
+
 
 OPTIONS
 -------
 -p::
-	Show patch text
+	Include patch text in the output.
 
 <start>::
-	Commit to start at.
+	Commit to start at.  This names a commit that is already in
+	the upstream history.
 
 <url>::
-	URL to include in the summary.
+	The repository URL to be pulled from.
 
 <end>::
-	Commit to end at; defaults to HEAD.
+	Commit to end at (defaults to HEAD).  This names the commit
+	at the tip of the history you are asking to be pulled.
++
+When the repository named by `<url>` has the commit at a tip of a
+ref that is different from the ref you have it locally, you can use
+the `<local>:<remote>` syntax, to have its local name, a colon `:`,
+and its remote name.
+
+
+EXAMPLE
+-------
+
+Imagine that you built your work on your `master` branch on top of
+the `v1.0` release, and want it to be integrated to the project.
+First you push that change to your public repository for others to
+see:
+
+	git push https://git.ko.xz/project master
+
+Then, you run this command:
+
+	git request-pull v1.0 https://git.ko.xz/project master
+
+which will produce a request to the upstream, summarizing the
+changes between the `v1.0` release and your `master`, to pull it
+from your public repository.
+
+If you pushed your change to a branch whose name is different from
+the one you have locally, e.g.
+
+	git push https://git.ko.xz/project master:for-linus
+
+then you can ask that to be pulled with
+
+	git request-pull v1.0 https://git.ko.xz/project master:for-linus
+
 
 GIT
 ---
-- 
1.9.0-293-gd838d6f
