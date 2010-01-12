From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 04/18] date.c: mark file-local function static
Date: Tue, 12 Jan 2010 09:37:07 +0100
Message-ID: <4B4C34B3.3010508@viscovery.net>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com> <1263282781-25596-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 09:37:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUcFc-0001G6-Ik
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 09:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab0ALIhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 03:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809Ab0ALIhN
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 03:37:13 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52564 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752479Ab0ALIhM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 03:37:12 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NUcFP-0004A3-UY; Tue, 12 Jan 2010 09:37:08 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id AC73F1660F;
	Tue, 12 Jan 2010 09:37:07 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1263282781-25596-5-git-send-email-gitster@pobox.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136706>

Junio C Hamano schrieb:
> diff --git a/date.c b/date.c
> index 5d05ef6..45f3684 100644
> --- a/date.c
> +++ b/date.c
> @@ -9,7 +9,7 @@
>  /*
>   * This is like mktime, but without normalization of tm_wday and tm_yday.
>   */
> -time_t tm_to_time_t(const struct tm *tm)
> +static time_t tm_to_time_t(const struct tm *tm)
>  {
>  	static const int mdays[] = {
>  	    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5c59687..85dea12 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -198,7 +198,6 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
>  extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
>  
>  extern int prefixcmp(const char *str, const char *prefix);
> -extern time_t tm_to_time_t(const struct tm *tm);
>  
>  static inline const char *skip_prefix(const char *str, const char *prefix)
>  {

This one is used from compat/mingw.c for the gettimeofday emulation.
Please leave it extern.

-- Hannes
