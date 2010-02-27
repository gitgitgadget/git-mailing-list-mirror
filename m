From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Sat, 27 Feb 2010 12:53:00 +0100
Message-ID: <4B89079C.8030206@lsrfire.ath.cx>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com> <1267246670-19118-5-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 12:53:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlLEf-00014W-Mr
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 12:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966166Ab0B0LxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 06:53:22 -0500
Received: from india601.server4you.de ([85.25.151.105]:39305 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966055Ab0B0LxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 06:53:21 -0500
Received: from [10.0.1.100] (p57B7EFC1.dip.t-dialin.net [87.183.239.193])
	by india601.server4you.de (Postfix) with ESMTPSA id CC72E2F80BF;
	Sat, 27 Feb 2010 12:53:19 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100216 Thunderbird/3.0.2
In-Reply-To: <1267246670-19118-5-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141196>

Forgot one thing in my earlier reply:

Am 27.02.2010 05:57, schrieb Mark Lodato:
> @@ -548,12 +565,9 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
>  				break;
>  
>  			opt->output(opt, bol, match.rm_so);
> -			opt->output(opt, opt->color_match,
> -				    strlen(opt->color_match));
> -			opt->output(opt, bol + match.rm_so,
> -				    (int)(match.rm_eo - match.rm_so));
> -			opt->output(opt, GIT_COLOR_RESET,
> -				    strlen(GIT_COLOR_RESET));
> +			output_color(opt, bol + match.rm_so,
> +				     (int)(match.rm_eo - match.rm_so),
> +				     opt->color_match);

The third parameter of output_color() (and of ->output(), so you didn't
introduce this, of course) is a size_t, so why cast to int?  Is a cast
needed at all?
