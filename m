From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] Help.c use OPT_COUNTUP
Date: Sun, 03 Mar 2013 15:38:22 -0800
Message-ID: <7vwqtoyryp.fsf@alter.siamese.dyndns.org>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
 <1362342072-1412-3-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 04 00:39:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIUj-0000qu-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 00:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab3CCXi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 18:38:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab3CCXiY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 18:38:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E9CAB62A;
	Sun,  3 Mar 2013 18:38:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=1B1pLy6WU5sqjWtwl2Sny6au6EQ=; b=yWlpMXfNMH4oWNDIN7nb
	65i7ZR/L3u6JkIU50NJrbiAKpVWTlNOuLPyyd2vpVK8S0zkU88Kp6FyqwidhjdzZ
	UFuNP7oeok5NtS2IuXz+dYSRRNV8B+WyMn2TRuaV8JR5Z3DoR+ga1Tm7vK09M900
	1ZHrBPNsr/5eQCFOdZ9wqzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hnfVe11HSPpSeyiX8yOtFFjkAWqpMfM0X6G/TgWXrqroGg
	QWos6pkz8f9dkP4KCYRiC7gwhhXE8urt9Dx6R9OFvOmfzhn9+VbVYhp1XBY5oTid
	YU91MOjApN6700gvDgs1LHr/Fd9SuUmVAeRT8zDdEta8M3OJvomFrQTnAuYbU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62EFDB629;
	Sun,  3 Mar 2013 18:38:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4A25B628; Sun,  3 Mar 2013
 18:38:23 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 706AAF84-845B-11E2-BF70-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217369>

Philip Oakley <philipoakley@iee.org> writes:

> rename deprecated option in preparation for 'git help --guides'.

s/rename/Rename/;

>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---

Hrm, I do not recall anybody ever declared that "--all" is deprecated.

I do not think we want --all and --all --all to be different, and we
certainly do not want --all --no-all to be not-all, so I cannot tell
what you want to achieve with this change at all, either from the
patch or the proposed log message.

>  builtin/help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index d1d7181..d10cbed 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -39,7 +39,7 @@ static int show_all = 0;
>  static unsigned int colopts;
>  static enum help_format help_format = HELP_FORMAT_NONE;
>  static struct option builtin_help_options[] = {
> -	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands")),
> +	OPT_COUNTUP('a', "all", &show_all, N_("print all available commands")),
>  	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
>  	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
>  			HELP_FORMAT_WEB),
