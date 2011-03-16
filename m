From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] vcs-svn: remove spurious semicolons
Date: Wed, 16 Mar 2011 12:47:57 -0700
Message-ID: <7v4o72979u.fsf@alter.siamese.dyndns.org>
References: <20110316024959.GA24932@elie> <20110316065256.GA5988@elie>
 <20110316070242.GE5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:48:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzwhf-0008Mq-0q
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 20:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab1CPTsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 15:48:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab1CPTsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 15:48:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A27A447F;
	Wed, 16 Mar 2011 15:49:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OeWSR18lM/gbE3R6vRs4XMtrTfY=; b=MHUNKu
	MnT6WmT1L+LIPfRvb92neXbZ7X0bWSTlhhBmBCH7OMr5c7wfBDEDVepaMqE+UXW6
	lTQYK+z7Ge/lyA66QffAwHkMoE8kkjCYP+1Bgf/lLcZ/QGTqRMgnOUBJ6mYtUWj2
	7EgC4F3X8O4cQHmkY/6ryUg4fVEW1hMzfLSp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QnDAfx8s3G0q88HixVFRyHjzXICV/EHb
	hEMd37Af7/hcNbAP8HZY1xfCGnem6jXGkO+o6wLRNF7bUGDzi9vCv1h2u9k2CuX7
	7G4vf6cuMhb+UMYvvvDGwKiyuIIFn/cQ7jKP4YjaVFNg+BjpN9bIRrOmPonUY6e+
	ef8rx1NTG24=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29AEC447C;
	Wed, 16 Mar 2011 15:49:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 163B3447A; Wed, 16 Mar 2011
 15:49:32 -0400 (EDT)
In-Reply-To: <20110316070242.GE5988@elie> (Jonathan Nieder's message of "Wed,
 16 Mar 2011 02:02:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8617D82E-5006-11E0-A300-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169185>

Jonathan Nieder <jrnieder@gmail.com> writes:

> trp_gen is not a statement or function call, so it should not be
> followed with a semicolon.  Noticed by gcc -pedantic.
>
>  vcs-svn/repo_tree.c:41:81: warning: ISO C does not allow extra ';'
>   outside of a function [-pedantic]
> ...
> diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
> index 491f013..207ffc3 100644
> --- a/vcs-svn/repo_tree.c
> +++ b/vcs-svn/repo_tree.c
> @@ -38,7 +38,7 @@ static uint32_t mark;
>  static int repo_dirent_name_cmp(const void *a, const void *b);
>  
>  /* Treap for directory entries */
> -trp_gen(static, dent_, struct repo_dirent, children, dent, repo_dirent_name_cmp);
> +trp_gen(static, dent_, struct repo_dirent, children, dent, repo_dirent_name_cmp)

Yuck.  Correct but ugly.
