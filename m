From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/6] Glean libexec path from argv[0] for git-upload-pack and git-receive-pack.
Date: Tue, 13 Jan 2009 20:36:05 +0100
Message-ID: <200901132036.05261.j6t@kdbg.org>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de> <1231595452-27698-2-git-send-email-prohaska@zib.de> <1231595452-27698-3-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steve Haslam <shaslam@lastminute.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jan 13 20:37:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMp4x-0006Mw-PE
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 20:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbZAMTgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 14:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbZAMTgM
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 14:36:12 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:20417 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbZAMTgL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 14:36:11 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 440CD1001F;
	Tue, 13 Jan 2009 20:36:06 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C779058275;
	Tue, 13 Jan 2009 20:36:05 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1231595452-27698-3-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105520>

On Samstag, 10. Januar 2009, Steffen Prohaska wrote:
> diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
> index db67c31..bbedcfe 100644
> --- a/builtin-receive-pack.c
> +++ b/builtin-receive-pack.c
> @@ -579,6 +579,9 @@ int cmd_receive_pack(int argc, const char **argv, const
> char *prefix) int i;
>  	char *dir = NULL;
>
> +	if (argv[0] && *argv[0])
> +		git_extract_argv0_path(argv[0]);
> +

This is not necessary because receive-pack is meanwhile a builtin.

> diff --git a/upload-pack.c b/upload-pack.c
> index e5adbc0..c469a60 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -616,6 +616,9 @@ int main(int argc, char **argv)
>  	int i;
>  	int strict = 0;
>
> +	if (argv[0] && *argv[0])
> +		git_extract_argv0_path(argv[0]);
> +
>  	for (i = 1; i < argc; i++) {
>  		char *arg = argv[i];

This hunk should be merged into 4/6.

-- Hannes
