From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help.c: add a compatibility comment to cmd_version()
Date: Tue, 16 Apr 2013 13:46:10 -0700
Message-ID: <7vsj2qjjal.fsf@alter.siamese.dyndns.org>
References: <1366144405-61438-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 22:46:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USCle-0006AD-PC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 22:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965325Ab3DPUqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 16:46:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39344 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964981Ab3DPUqN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 16:46:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C25717068;
	Tue, 16 Apr 2013 20:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WR5Ycxvk/AEUbbDkAr4OrD3pMPM=; b=aJfZeS
	0QsEbYp4IKewVMAACHaFRLVz8nDoiQsNo0a06odoxX8nmOHgW4DFznbO6XvCe/lp
	nsle6rdRmxH81OT/rcRiaqLYntVV/voWwTXtDJ5NLCUoAFNBHrpMK3BeXC0iM/vC
	su3ALjegC6TfaY8Q3D65pvpYuUdsz+yaPzJDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kpNTnCb78lhoFskCR5yA1h89SpMIW8T2
	pn5DVHiZHEGvIXDZjUlncRadUO8KX/jhDpv2379+suFE+plIni8UpT4/hjfEX2hZ
	DDG2tPHcs7u4WnRHdqhBReyhbH19TNPorhe1hUPpDOSwfpanGiwoID02f9fqQg0b
	fxF51YvLOwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F6E317066;
	Tue, 16 Apr 2013 20:46:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09B4617065; Tue, 16 Apr
 2013 20:46:11 +0000 (UTC)
In-Reply-To: <1366144405-61438-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Tue, 16 Apr 2013 13:33:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC6B9154-A6D6-11E2-A67A-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221469>

David Aguilar <davvid@gmail.com> writes:

> External projects have been known to parse the output of
> "git version".  Help prevent future authors from changing
> its format by adding a comment to its implementation.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  help.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/help.c b/help.c
> index 1dfa0b0..02ba043 100644
> --- a/help.c
> +++ b/help.c
> @@ -397,6 +397,10 @@ const char *help_unknown_cmd(const char *cmd)
>  
>  int cmd_version(int argc, const char **argv, const char *prefix)
>  {
> +	/*
> +	 * The format of this string should be kept stable for compatibility
> +	 * with external projects that rely on the output of "git version".
> +	 */
>  	printf("git version %s\n", git_version_string);
>  	return 0;
>  }

Will queue; thanks.
