From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Clean up use of ANSI color sequences
Date: Fri, 13 Feb 2009 18:02:51 -0800
Message-ID: <7v4oyx4vxw.fsf@gitster.siamese.dyndns.org>
References: <7vy6wbi7gm.fsf@gitster.siamese.dyndns.org>
 <1234562021-2397-1-git-send-email-arjen@yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Sat Feb 14 03:04:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY9tJ-0002Qi-Em
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbZBNCC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbZBNCC5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:02:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbZBNCC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:02:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A9BC2B155;
	Fri, 13 Feb 2009 21:02:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 832702AB4E; Fri,
 13 Feb 2009 21:02:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 98B38154-FA3B-11DD-8FC0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109798>

Arjen Laarhoven <arjen@yaph.org> writes:

> diff --git a/pretty.c b/pretty.c
> index cc460b5..a8595f6 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -567,16 +567,16 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
>  			return end - placeholder + 1;
>  		}
>  		if (!prefixcmp(placeholder + 1, "red")) {
> -			strbuf_addstr(sb, "\033[31m");
> +			strbuf_addstr(sb, COLOR_RED);
>  			return 4;
>  		} else if (!prefixcmp(placeholder + 1, "green")) {
> -			strbuf_addstr(sb, "\033[32m");
> +			strbuf_addstr(sb, COLOR_GREEN);
>  			return 6;
>  		} else if (!prefixcmp(placeholder + 1, "blue")) {
> -			strbuf_addstr(sb, "\033[34m");
> +			strbuf_addstr(sb, COLOR_BLUE);
>  			return 5;
>  		} else if (!prefixcmp(placeholder + 1, "reset")) {
> -			strbuf_addstr(sb, "\033[m");
> +			strbuf_addstr(sb, COLOR_RESET);

These four are obviously bad and not even compile tested.

I'll fix them up when queuing.
