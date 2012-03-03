From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv2 1/5] t7004 (tag): modernize style
Date: Sat, 03 Mar 2012 22:31:52 +0100
Message-ID: <4F528DC8.7010102@kdbg.org>
References: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com> <1330740942-25130-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 22:32:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3wYc-0003zV-FT
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 22:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab2CCVb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 16:31:58 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:14561 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752476Ab2CCVb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 16:31:57 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F1370130054;
	Sat,  3 Mar 2012 22:29:05 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A96F419F399;
	Sat,  3 Mar 2012 22:31:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <1330740942-25130-2-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192135>

Am 03.03.2012 03:15, schrieb Tom Grennan:
> -test_expect_success 'trying to delete an already deleted tag should fail' \
> -	'test_must_fail git tag -d mytag'
> +test_expect_success \
> +	'trying to delete an already deleted tag should fail' '
> +	test_must_fail git tag -d mytag
> +'

Personally, I prefer lines with 80+ chars over lines broken with a
backslash. So, while I can understand that you do not always remove a
backslash to avoid churn, I think it is not warranted to *introduce* one
to shorten a line below 80 chars. But that's really just a matter of taste.

>  test_expect_success GPG \
>  	'creating a signed tag with -F messagefile should succeed' '
> +	cat >sigmsgfile <<-EOF
> +		Another signed tag
> +		message in a file.
> +	EOF
> +	get_tag_header file-signed-tag $commit commit $time >expect <sigmsgfile
> +	echo "-----BEGIN PGP SIGNATURE-----" >>expect


Several && missing here and later in the file.

I stopped reading here. This is too much to read in one go. This should
really be broken into several parts. For example, you changed
get_tag_header and added several <emptyfile redirections (which should
be /dev/null IMO); that has not a lot to do with "modernize style".

>  	git tag -s -F sigmsgfile file-signed-tag &&
>  	get_tag_msg file-signed-tag >actual &&
>  	test_cmp expect actual
>  '

-- Hannes
