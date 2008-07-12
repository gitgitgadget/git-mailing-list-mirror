From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 FIXED] help (Windows): Display HTML in default
 browser using Windows' shell API
Date: Fri, 11 Jul 2008 20:26:35 -0700
Message-ID: <7vtzevhjf8.fsf@gitster.siamese.dyndns.org>
References: <228FC26D-D318-487A-9BF3-B473096CB0C9@zib.de>
 <1215761822-21356-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 05:27:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHVlw-0003b3-Ue
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 05:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbYGLD0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 23:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYGLD0o
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 23:26:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbYGLD0o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 23:26:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A9F391B718;
	Fri, 11 Jul 2008 23:26:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 103811B717; Fri, 11 Jul 2008 23:26:37 -0400 (EDT)
In-Reply-To: <1215761822-21356-1-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Fri, 11 Jul 2008 09:37:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59069E02-4FC2-11DD-B9E8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88217>

Steffen Prohaska <prohaska@zib.de> writes:

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 3a05fe7..0ca73f7 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1017,3 +1017,24 @@ sig_handler_t mingw_signal(int sig, sig_handler_t handler)
> ...
> +void mingw_open_html(const char *unixpath)
> +{
> +	const char *htmlpath = make_backslash_path(unixpath);
> +	printf("Launching default browser to display HTML ...\n");
> +	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
> +}

Do you mean to have that printf() or is it a leftover debugging statement?
