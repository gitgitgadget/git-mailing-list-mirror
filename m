From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Fri, 21 Sep 2012 12:09:42 -0700
Message-ID: <7v7grn5h1l.fsf_-_@alter.siamese.dyndns.org>
References: <20120906151317.GB7407@sigill.intra.peff.net>
 <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
 <7v627aiq47.fsf@alter.siamese.dyndns.org>
 <20120919182715.GF11699@sigill.intra.peff.net>
 <7vzk4lg5yf.fsf@alter.siamese.dyndns.org>
 <20120919194213.GB21950@sigill.intra.peff.net>
 <C07F05AC-8FBF-4F09-AF13-A291181A06D9@sb.org>
 <20120919203738.GA24383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, Drew Northup <n1xim.email@gmail.com>,
	gitList <git@vger.kernel.org>, Matthieu.Moy@imag.fr,
	andy@aeruder.net, chriscool@tuxfamily.org,
	dmellor@whistlingcat.com, dpmcgee@gmail.com, fonseca@diku.dk,
	freku045@student.liu.se, marius@trolltech.com, namhyung@gmail.com,
	rene.scharfe@lsrfire.ath.cx, s-beyer@gmx.net, trast@inf.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 21:10:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF8br-0005Jv-EM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 21:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358Ab2IUTJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 15:09:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754399Ab2IUTJp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 15:09:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3E9C960C;
	Fri, 21 Sep 2012 15:09:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WOGQHBpjDjcpcTreFUs2pkgUtXc=; b=HIV10+
	taelwNdCvWxKKYbF7ik93SpX4cZxauhcgmMYpSJJWlYSHuqyju29lqGSSTYZv3UN
	/Q8PA9Ea7mJkeIvRknlMkulXC5FQ96EVo/FzEj7YJwcfg7iymdp+8A/OL+l3tpyo
	zwS0rslXDCF/pMGFUQ4/nSF9oJSuvBMex5LT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nmoExSUa5vF9uTxg2juuY9shqEf7JOP5
	FK593YojWX2IK3FilJviq+zw8v2Qx+WsSzLZwsk7b2hw39J5oaecQuHP3RR932wb
	TIkkreP3xQEfkz5D+XlAGpLhWh7MCre9YRxBJ6CdlQA2W7c6pGGVPR5CnPkcHSvV
	MdUsAk1p8Wg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86F71960B;
	Fri, 21 Sep 2012 15:09:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCBED960A; Fri, 21 Sep 2012
 15:09:43 -0400 (EDT)
In-Reply-To: <20120919203738.GA24383@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Sep 2012 16:37:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6E4D7BE-041F-11E2-88E7-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206151>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 19, 2012 at 01:31:50PM -0700, Kevin Ballard wrote:
>
>> > I am a little lukewarm on my patch if only because of the precedent it
>> > sets.  There are a trillion options that revision.c parses that are not
>> > necessarily meaningful or implemented for sub-commands that piggy-back
>> > on its option parser. I'm not sure we want to get into manually
>> > detecting and disallowing each one in every caller.
>> 
>> I tend to agree with your final sentiment there. But the point that
>> users may not realize that blame already follows is also valid. Perhaps
>> we should catch --follow, as in your patch, but instead of saying that
>> it's an unknown argument, just print out a helpful message saying blame
>> already follows renames (and then continue with the blame anyway, so
>> as to not set a precedent to abort on unknown-but-currently-accepted
>> flags).
>
> Sure, that would probably make sense. Care to roll a patch with
> suggested wording?

Let's do this for now instead.  That would make it clear to people
who (rightly or wrongly) think the "--follow" option should do
something that we already do so, and explain the output that they
see when they do give the "--follow" option to the command.

I may do a "--no-follow" patch as a follow-up, or I may not,
depending on the mood and workload.


 Documentation/git-blame.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git c/Documentation/git-blame.txt w/Documentation/git-blame.txt
index 7ee9236..809823e 100644
--- c/Documentation/git-blame.txt
+++ w/Documentation/git-blame.txt
@@ -20,6 +20,12 @@ last modified the line. Optionally, start annotating from the given revision.
 
 The command can also limit the range of lines annotated.
 
+The origin of lines is automatically followed across whole-file
+renames (currently there is no option to turn the rename-following
+off). To follow lines moved from one file to another, or to follow
+lines that were copied and pasted from another file, etc., see the
+`-C` and `-M` options.
+
 The report does not tell you anything about lines which have been deleted or
 replaced; you need to use a tool such as 'git diff' or the "pickaxe"
 interface briefly mentioned in the following paragraph.
