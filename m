From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] convert: legitimately disable clean/smudge filter with an
 empty override
Date: Sun, 24 Jan 2016 16:06:19 +0100
Message-ID: <56A4E86B.1010909@web.de>
References: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, jehan@orb.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 16:06:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMFZ-0005Yf-G7
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbcAXPGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:06:42 -0500
Received: from mout.web.de ([212.227.17.12]:64450 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbcAXPGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:06:40 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MHGaV-1aJljo349D-00E3cG; Sun, 24 Jan 2016 16:06:23
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
X-Provags-ID: V03:K0:AOqfxjCqAEwytqy1R1Ea9lJqoJo8s6KORIXBNKIHJcB1IyM7Rnd
 PUh37+c9r2pXTH+LK3teWbKV2ImWC5SczwLuAWH4uC8RCfZy0yw/sv6wEaQ4O4zxYbRRcZ5
 o5GcsN/u76a6QUbADIb8FmjcfbLbmADbsDj4f6YmSksFV44hS5pVB9LsEiF/PBhet+dSwz4
 IAW3+RBaEbW9wxLJMgg6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uTRFX0iOzW8=:CnH6PrJZxeaCuNQcl+yenG
 craNCHv93sOgqrRmNl6oSoSEpifPu75hrOq9gcoXQptRDMWDKzHZ6Wgn6vzvxA6zK+nu+R8SP
 Gd5fGWDRVM8/eiUtcP/w3/e/aFps/qJMPA18Vn6CSySbf3z3i1AJGEYuYjKt2fDWjbMGmYEyZ
 xwmVe4GmV/n0lqRAN7P/JYeURHdbCgity5y5mC0x1rWWlMX5n0FnRbPRxciHaDT23v2X1ioK2
 i0OoWF0Omo6+nm4yHE0xU+ClcB45V+XLtNBXtd/U6cwFSK3bPU5uMTLxrjJ2OkUe4pdwpECcv
 oW3cUBSG8uJtBCo3yvkDrcZ9IeRGDk1YJ+b8m6F8rHFV+uaCp+CNdA4jt9iIpymJls/yS31yC
 jENezjqN7d+229GFLZiCTZ/IC+czwID954L6MHsNEFfZpdxpSnoYzhob0HUiFcJ5Ol/Oi49eD
 Kn0p9JF9a1Egi70AM+D6D//5GxBE67TTtgu3ZDFODDd8Pj5jL/shEPqey1hibMbCmxKOHv+64
 QG7he8RK8OdwKmSkrg93Mr6P9Eu1Of8R0jlHA8i0Njt8uMkkstukiAk8GKWCJv1OIGBYdB3wG
 dLRPx51SL2AZlBWURTEcnvhk9ba00fVt2E4P9OdROj35JukgBOeKqD57tlKT0XlV9BgFtVGXI
 tRqWtvdULC1HKj1PVIfelxL+YGH95EuDnHGW8BD+cqReZMlBTl37NMVEtfVAJzfgG0LFJ830z
 F3NRRhMWlNFoxruyr54BF6y2pSiZ/SHn7WFWNowboH7o55dmw2FLZaakoJb7pfva261VQvAX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284650>

On 24.01.16 13:22, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
Some minor nits inside: 
> 
> A clean/smudge filter can be disabled if set to an empty string. 
"set to an empty string" refers to "git config" (in opposite to the
filter as such, which is specified in .gitattributes.
Does it make sense to write 
"git config filter.XXX.smudge ''" or so ?

> However,
> Git will try to run the empty string as command which results in a error
> message per processed file.
> 
> Teach Git to consider an empty clean/smudge filter as legitimately disabled
> and do not print an error message.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  convert.c             |  4 ++--
>  t/t0021-conversion.sh | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/convert.c b/convert.c
> index 814e814..58af965 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -786,7 +786,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
>  	struct conv_attrs ca;
> 
>  	convert_attrs(&ca, path);
> -	if (ca.drv) {
> +	if (ca.drv && ca.drv->clean && strlen(ca.drv->clean)) {
>  		filter = ca.drv->clean;
>  		required = ca.drv->required;
>  	}
> @@ -835,7 +835,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>  	struct conv_attrs ca;
> 
>  	convert_attrs(&ca, path);
> -	if (ca.drv) {
> +	if (ca.drv && ca.drv->smudge && strlen(ca.drv->smudge)) {
>  		filter = ca.drv->smudge;
>  		required = ca.drv->required;
>  	}
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 718efa0..56e385c 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -252,4 +252,18 @@ test_expect_success "filter: smudge empty file" '
>  	test_cmp expected filtered-empty-in-repo
>  '
> 
> +test_expect_success 'disable filter with empty override' '
> +	git config filter.disable.smudge false &&
> +	git config filter.disable.clean false &&
> +
> +	echo "*.disable filter=disable" >.gitattributes &&
> +
> +	echo test >test.disable &&
> +	git -c filter.disable.clean= add test.disable 2>err &&
> +	! test -s err &&
How about 
test_cmp /dev/null err
to make debugging easier ?
> +	rm -f test.disable &&
> +	git -c filter.disable.smudge= checkout -- test.disable 2>err &&
> +	! test -s err
> +'
> +
>  test_done
> --
> 2.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
