From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #04; Tue, 17)
Date: Wed, 18 Nov 2009 21:43:31 +0700
Message-ID: <fcaeb9bf0911180643w5e659340jd845aa202e6feca3@mail.gmail.com>
References: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 15:44:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAlm8-0008VF-4e
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 15:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515AbZKROn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 09:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757510AbZKROn1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 09:43:27 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:38780 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757389AbZKROn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 09:43:26 -0500
Received: by pwi3 with SMTP id 3so723538pwi.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 06:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=abmlUHqPcTKmDkQfYlKbz+k06jQgptimG9zH3FxZXZs=;
        b=Hu8q/TOKwM+yF09gWDTOsUEHVwcXmirUFHVOO/x1g1skWNR7NcojC0Nr4OjArcPRt0
         /uIGfEQ66SfH+Rn/tuoGb/9g09XNM7HriIZk2AE6i2NZBC5mYgEeGMfQrCRNrFZBX75r
         g71UO8h5e9h4YXc5HX5Bojm/FoJmQRKjk9Rjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=r3iMhhwdFur6Znpl3giQr7Q8WuqmFl4kMy3YtWwqAmF2Cz7hkp5ZHQzPFhkdmXdOeg
         BOEsQWDqi1QHcpBd6BVRRamsNPSflsefDqFvrO08UkIOgZbjL1BtGADaJjS1mmgYAtY8
         S3++tbzYd6k58+//BNJhG2z+B/1QMq+wr6psU=
Received: by 10.114.237.30 with SMTP id k30mr12487300wah.102.1258555411918; 
	Wed, 18 Nov 2009 06:43:31 -0800 (PST)
In-Reply-To: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133179>

On 11/18/09, Junio C Hamano <gitster@pobox.com> wrote:
>  * nd/sparse (2009-08-20) 19 commits.
>   - sparse checkout: inhibit empty worktree
>   - Add tests for sparse checkout
>   - read-tree: add --no-sparse-checkout to disable sparse checkout support
>   - unpack-trees(): ignore worktree check outside checkout area
>   - unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
>   - unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
>   - unpack-trees.c: generalize verify_* functions
>   - unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
>   - Introduce "sparse checkout"
>   - dir.c: export excluded_1() and add_excludes_from_file_1()
>   - excluded_1(): support exclude files in index
>   - unpack-trees(): carry skip-worktree bit over in merged_entry()
>   - Read .gitignore from index if it is skip-worktree
>   - Avoid writing to buffer in add_excludes_from_file_1()
>   - Teach Git to respect skip-worktree bit (writing part)
>   - Teach Git to respect skip-worktree bit (reading part)
>   - Introduce "skip-worktree" bit in index, teach Git to get/set this bit
>   - Add test-index-version
>   - update-index: refactor mark_valid() in preparation for new options
>
>  The latest update I didn't look at very closely but I had an impression
>  that it was touching very generic codepath that would affect non sparse
>  cases, iow the patch looked very scary (the entire series already is).

I wonder if there is any other approach for sparse checkout? I'll see
if I can improve it, but with a series touching unpack logic, diff
core, .gitattributes/.gitignore, it's hard to get it right and
obvious.
-- 
Duy
