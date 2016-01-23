From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] convert: add a helper to determine the correct EOL
 for a given path
Date: Sat, 23 Jan 2016 07:12:09 +0100
Message-ID: <56A319B9.50900@web.de>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
 <c4e6707b53d82cdeeb16c83bddf9c4870a53d9df.1453482052.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 07:13:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMrRa-0000MC-Gn
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 07:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbcAWGMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2016 01:12:31 -0500
Received: from mout.web.de ([212.227.15.14]:52274 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbcAWGM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2016 01:12:29 -0500
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MUEsc-1aVDPz2DDO-00R3FA; Sat, 23 Jan 2016 07:12:21
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <c4e6707b53d82cdeeb16c83bddf9c4870a53d9df.1453482052.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K0:2gk5eEXS4IQ62gL9mBlXUXiQGGzgdsv6C1IYYCVrDYdtANfjuOR
 76M6970hgC1hiTXfUUNjMOICohIlCSmsnqCDIaHIWw0X59FEGsg1XhyIowZuy9kZOZ+Mqqq
 zWuixCP4sAFBwosLjaiE6xIdgzpku+bOtgkFmOl/b75DN1excEVIcs8YcJgiR1LvZ9qQDUO
 PnEt4qAIvHMcbVHLyHZDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DEwAXQnEQh8=:Pst00bVFjxWbYqsLCSxMDh
 ZDDmDtUnCH4M0IVHbTZ0fveTnkQGe4PXFUAA1rlVR5wxP7Qece3Moye2YW1xpMTyQ6Xq3OzkP
 hQkHEDwojyXe3XRpBUzjbSScUz5mIRqCfqFKbpFwVltnUciJjzdIevxZAnoZnJe6kxQS7mUTg
 ZtoU3bXBD2wFMLrNg3RJbpumn7ZQ6G7lD3jwRHo7xxrNd6lZjao749bXv5RVNab9vbOtQUUoT
 x2lguWb5jySi6thaUjU245EEgXiTOueHuYUajjed4B9LWJ5v11HbphdXh+mAsOVufEKeVBRul
 eFUagRKVCWhPCi8QGWZVis62DfhaSWBUAkTBBwJ+epRysT8zCNcV9uvnliU/PlUlP2BZpOq0T
 X+Go3XX9wcpkgDHwMHjG6adqfSKz5G/O7624j0jhe9wF7h2oRwsMFnmByf5weP4H6SGwecqD7
 d+jwrk9EXeUgCHE/ZXt+zJ+711sS4szECJTA/7QkCv9rTSrZ3K1wdebJ0PHPTwUFxrfk1lqjW
 bLjfnTcKnlmiythahctVjEGtq9AOmaO/BaiGyiFmg9yxAxlBpphMj5OmvEWCTnpGwXwqNrNe5
 Ri4iviwC+Xpx1sHPxEyHCmfnxNMQicZZzGGx57ZDcBL3qIOMvUMrrHPRPddyajvMlksjtk7X7
 weh2wif6rcHonpQnwag4MMvuVnaNXAo5tKu2TvWZE19typPJn6TwMhtV3VLtcpCK4KvYHrPML
 isFPObX9ZE4ROibFz49UhCnguoJGUBoxkTv1xUF4O127HQSW3f2SA+/89ltoNgQO8606OjWv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284623>

On 2016-01-22 18.01, Johannes Schindelin wrote:
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  convert.c | 29 +++++++++++++++++++++++++++++
>  convert.h |  2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/convert.c b/convert.c
> index 814e814..b458734 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -758,6 +758,35 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  	}
>  }
>  
> +enum eol eol_for_path(const char *path, const char *src, size_t len)
> +{
> +	struct conv_attrs ca;
> +	struct text_stat stats;
> +
> +	if (!path) {
I don't think this is ideal.
When path is NULL, can we set it to "*" to catch .gitattributes like
"* text=auto"
?
> +		memset(&ca, 0, sizeof(ca));
> +		ca.crlf_action = CRLF_AUTO;
> +		ca.eol_attr = EOL_UNSET;
> +	} else {
> +		convert_attrs(&ca, path);
> +		if (ca.eol_attr == EOL_UNSET)
> +			ca.eol_attr = output_eol(ca.crlf_action);
> +		if (ca.eol_attr != EOL_UNSET)
> +			return ca.eol_attr;
This doesn't seem to be correct.
When "File -text" is set, no CRLF needs to be added.
> +	}
> +	if (!len || (ca.crlf_action != CRLF_AUTO &&
> +				ca.crlf_action != CRLF_GUESS))
Currently core.autocrlf = true overrules "core.eol".

See the line in t0027:
#              core.eol  core.autocrlf
checkout_files    lf      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_mix_CR
LF_nul

Letting core.autocrlf overrule core.eol is not documented very well,
I have it on my todo-list. But I think it makes sense to keep the behavour.

I'm currently working on simplification of convert.c, so a funtion like this
is really a step forward.
Does it makes sense to add a comment, that some corner cases may
need additional tweaking ?
