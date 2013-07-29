From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 2/4] log, format-patch: accept short parameter 'q' for
 quiet
Date: Tue, 30 Jul 2013 00:05:14 +0200
Message-ID: <51F6E71A.8050109@web.de>
References: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com> <1375127398-31904-3-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 00:05:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3vZC-0001ER-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 00:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005Ab3G2WFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 18:05:17 -0400
Received: from mout.web.de ([212.227.17.12]:51930 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613Ab3G2WFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 18:05:16 -0400
Received: from [192.168.2.102] ([79.253.131.78]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LhQWG-1UHNP83w7k-00mc2V for <git@vger.kernel.org>;
 Tue, 30 Jul 2013 00:05:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1375127398-31904-3-git-send-email-stefanbeller@googlemail.com>
X-Provags-ID: V03:K0:OxUoL45B5PDWAymAvBJH9nLP23vp73gHqiRsDhFQq1W/mNk7B27
 K9rgjn/YKSqIQ3Oz7MI4o5UQRIgyQl3+2cUdgI6i+Cep3RqrmtM4WyJAMjeH9eemv92pI2R
 l02hBhruCo3sZX2cQIB3PBUZvQDMt7XXxkAtPCBmv/sUiCbKGGxrblPsuvN7kP0dy4Mduv4
 rrinxWMSVNON0HUO0EM0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231332>

Am 29.07.2013 21:49, schrieb Stefan Beller:
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>   builtin/log.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 9b6c910..5cb968b 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -121,7 +121,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>   	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
>
>   	const struct option builtin_log_options[] = {
> -		OPT_BOOL(0, "quiet", &quiet, N_("suppress diff output")),
> +		OPT_BOOL('q', "quiet", &quiet, N_("suppress diff output")),

You can shorten it using OPT__QUIET.  But that macro should be converted 
to OPT_BOOL first, in turn.  Unless --verbose, for which it sometimes 
makes sense to print ever more output the more often it is specified, I 
wouldn't expect there to be a command with different levels of 
quietness, but didn't check.

>   		OPT_BOOL(0, "source", &source, N_("show source")),
>   		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
>   		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
> @@ -1210,7 +1210,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   			    PARSE_OPT_OPTARG, thread_callback },
>   		OPT_STRING(0, "signature", &signature, N_("signature"),
>   			    N_("add a signature")),
> -		OPT_BOOL(0, "quiet", &quiet,
> +		OPT_BOOL('q', "quiet", &quiet,
>   			 N_("don't print the patch filenames")),
>   		OPT_END()
>   	};
>
