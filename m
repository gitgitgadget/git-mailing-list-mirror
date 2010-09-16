From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-ls-files.txt: clarify -x/--exclude option
Date: Wed, 15 Sep 2010 17:41:52 -0700
Message-ID: <7v1v8u5xkf.fsf@alter.siamese.dyndns.org>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
 <1284595008-36464-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 02:42:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow2YF-0007NN-Ox
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 02:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085Ab0IPAmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 20:42:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab0IPAmE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 20:42:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3AB6D6757;
	Wed, 15 Sep 2010 20:42:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GWkc9wJm4obWKitJ5ZthcXzImbQ=; b=oA7wim
	1hPtQKGo9b0lhftaU/YsnoX52i6qB/ZFrKkx+1jYiEfsHKKRc6uJWaXn6K8FjPzA
	/zxyN8KSnOdnH5dfDkVlAX/kiXDEQGsb6kGESUCmX1fwsJZ+aM+SCGH/3LWFds8/
	m2myLPdvYjrFWF/Ch1EHfHApQqvX5yeXDu1XY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U+SGeaYOosUEbw/WOyVvtuDikttbFeIm
	TEn0l9FBhJXzMdElSSIJER6k6g9Iqc8WjuXiiGy7YtLgFNMlxVP9Wr/JVaIgxSXk
	LlhEUTXe32Q6VMXe7ApQl3RMRhrwSmjCvvhwJ8og9lOoNBQAVhXWAHA6LHuiKRxm
	2oPMM1almMQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 85993D6754;
	Wed, 15 Sep 2010 20:41:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CC72D6750; Wed, 15 Sep
 2010 20:41:54 -0400 (EDT)
In-Reply-To: <1284595008-36464-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Wed\, 15 Sep 2010 19\:56\:48 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 36678690-C12B-11DF-82D1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156285>

Jay Soffian <jaysoffian@gmail.com> writes:

> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 15aee2f..f52b06a 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -79,8 +79,9 @@ OPTIONS
>  
>  -x <pattern>::
>  --exclude=<pattern>::
> -	Skips files matching pattern.
> -	Note that pattern is a shell wildcard pattern.
> +	Skips untracked files matching pattern.
> +	Note that pattern is a shell wildcard pattern. See EXCLUDE PATTERNS
> +	below for more information.

Would be helpful; will queue directly on top of 500348a.

Thanks

By the way, I think the language in that file needs a bit of tweaking for
readability.  Perhaps this on top of your patch...

-- >8 --
Subject: [PATCH] ls-files documentation: reword for consistency

Similar to descriptions of other options, state what -x does in imperative
mood.  Start sentences for -X and --exclude-per-directory options in
capital letters.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-files.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index c05e7a5..44b6480 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -79,16 +79,16 @@ OPTIONS
 
 -x <pattern>::
 --exclude=<pattern>::
-	Skips untracked files matching pattern.
+	Skip untracked files matching pattern.
 	Note that pattern is a shell wildcard pattern. See EXCLUDE PATTERNS
 	below for more information.
 
 -X <file>::
 --exclude-from=<file>::
-	exclude patterns are read from <file>; 1 per line.
+	Read exclude patterns from <file>; 1 per line.
 
 --exclude-per-directory=<file>::
-	read additional exclude patterns that apply only to the
+	Read additional exclude patterns that apply only to the
 	directory and its subdirectories in <file>.
 
 --exclude-standard::
@@ -178,7 +178,7 @@ These exclude patterns come from these places, in order:
      file containing a list of patterns.  Patterns are ordered
      in the same order they appear in the file.
 
-  3. command line flag --exclude-per-directory=<name> specifies
+  3. The command line flag --exclude-per-directory=<name> specifies
      a name of the file in each directory 'git-ls-files'
      examines, normally `.gitignore`.  Files in deeper
      directories take precedence.  Patterns are ordered in the
-- 
1.7.3.rc2.221.gbf93f
