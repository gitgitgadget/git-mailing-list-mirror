From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push.txt: mention about remote.*.push when no
 refspec is given
Date: Fri, 08 Mar 2013 09:59:15 -0800
Message-ID: <7v38w5hix8.fsf@alter.siamese.dyndns.org>
References: <1362573848-21793-1-git-send-email-pclouds@gmail.com>
 <7v8v60qu2i.fsf@alter.siamese.dyndns.org>
 <CACsJy8BNpMN3-Y1eZrJXpZp3-KU=kDN_4eM=87OD9d7yYYrHCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 18:59:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE1a5-00013V-MQ
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 18:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759805Ab3CHR7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 12:59:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759223Ab3CHR7S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 12:59:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E98E4A884;
	Fri,  8 Mar 2013 12:59:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EKzwGX+OUgJd5raAsxpcC90BzOc=; b=WuvKeN
	Qr+0GlEOu9ayaoQjbOiFCg9mamy9ytDNVc5JbpudjIt36vQSyloQrfwoDIRJv7Xi
	GcwctQC7lD2zQiwgo8inLZlebkGHMIjipYeG3gZ6dT1ui2SUhopjvZykToaYjfno
	s3dM3tU9z+rmKcxBWE6padsvYdfAFfDotj3n8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mRymWIo/85HCiTzQ/ZP/CdhUNBrcYeLv
	tCG3apLIjj1g0NQh6z5+2er45y7VCEbcMi7FJmHUrlx2848oNu2QsltUaWNY3W4l
	iVNkIWQQkZp+uoGb8XZAk6zMdj2u4ew6S2ZkoM6CtRISyngoC9tlzud877m2Cqis
	GY14t72P4Rs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB5ADA883;
	Fri,  8 Mar 2013 12:59:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 214DDA880; Fri,  8 Mar 2013
 12:59:17 -0500 (EST)
In-Reply-To: <CACsJy8BNpMN3-Y1eZrJXpZp3-KU=kDN_4eM=87OD9d7yYYrHCg@mail.gmail.com> (Duy
 Nguyen's message of "Fri, 8 Mar 2013 17:58:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4F65184-8819-11E2-B27D-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217674>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Mar 7, 2013 at 1:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I agree that saying what it is, what it does or what it is for
>> upfront (i.e. "Specifies what are pushed") before how it is spelled
>> is an improvement.  I however think describing "If not specified"
>> here was a mistake, and you are making it worse by burying the
>> description of what happens when <refspec>... are missing in the
>> middle of the description for <refspec>...
>>
>> I would rather see this done in the direction the attached "how
>> about doing it this way" patch illustrates.  The way how "where" and
>> "what" are determined when the command line does not specify is the
>> proparty of the entire command, not of an individual parameter.
>
> I agree your patch looks better than mine. Put it on 'pu', perhaps?

Heh, that's not my itch ;-)

-- >8 --
Subject: [PATCH] Documentation/git-push: clarify the description of defaults

We describe what gets pushed by default when the command line does
not give any <refspec> under the bullet point of <refspec>.

It is a bit unfriendly to expect users to read on <refspec> when
they are not giving any in the first place.  "What gets pushed" is
determined by taking many factors (<refspec> argument being only one
of them) into account, and is a property of the entire command, not
an individual argument.  Also we do not describe "Where the push
goes" when the command line does not say.

Give the description on "what gets pushed to where" upfront before
explaining individual arguments and options.

Also update the description of <refspec> to say what it is, what it
is used for, before explaining what shape it takes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-push.txt | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 8b637d3..3b41e72 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -23,6 +23,17 @@ You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
 documentation for linkgit:git-receive-pack[1].
 
+When the command line does not specify where to push with the
+`<repository>` argument, `branch.*.remote` configuration for the
+current branch is consulted to determine where to push.  If the
+configuration is missing, it defaults to 'origin'.
+
+When the command line does not specify what to push with `<refspec>...`
+arguments or `--all`, `--mirror`, `--tags` options, the command finds
+the default `<refspec>` by consulting `remote.*.push` configuration,
+and if it is not found, honors `push.default` configuration to decide
+what to push (See gitlink:git-config[1] for the meaning of `push.default`).
+
 
 OPTIONS[[OPTIONS]]
 ------------------
@@ -33,13 +44,10 @@ OPTIONS[[OPTIONS]]
 	of a remote (see the section <<REMOTES,REMOTES>> below).
 
 <refspec>...::
+	Specify what destination ref to update with what source object.
 	The format of a <refspec> parameter is an optional plus
-	`+`, followed by the source ref <src>, followed
+	`+`, followed by the source object <src>, followed
 	by a colon `:`, followed by the destination ref <dst>.
-	It is used to specify with what <src> object the <dst> ref
-	in the remote repository is to be updated.  If not specified,
-	the behavior of the command is controlled by the `push.default`
-	configuration variable.
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
@@ -65,10 +73,7 @@ the remote repository.
 The special refspec `:` (or `+:` to allow non-fast-forward updates)
 directs git to push "matching" branches: for every branch that exists on
 the local side, the remote side is updated if a branch of the same name
-already exists on the remote side.  This is the default operation mode
-if no explicit refspec is found (that is neither on the command line
-nor in any Push line of the corresponding remotes file---see below) and
-no `push.default` configuration variable is set.
+already exists on the remote side.
 
 --all::
 	Instead of naming each ref to push, specifies that all
-- 
1.8.2-rc3-243-g6506aa2
