From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
Date: Wed, 4 May 2016 13:02:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605041259180.9313@virtualbox>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com> <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com> <1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, chriscool@tuxfamily.org,
	christain.couder@gmail.com, larsxschneider@gmail.com
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 13:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axua4-0002qM-HM
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757596AbcEDLC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:02:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:55868 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbcEDLC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:02:56 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MCggg-1aph7J06bK-009P2R; Wed, 04 May 2016 13:02:51
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0z0LhfrJ6zKQIW+IEd3SwxYszGbpqBRmBpq7UN5xwPhvtyZJb/d
 z6nZFbvtDTbXC56igUwGRsxGL+8k6bO5J0KNTk7QvDpE6dU708/9DjSMOnM4E7uf65zmYFo
 3qzEztU+wkeuvnzEg+prcrjgWWUnp3ZC2AKZJ5BJmspVpaNpiYYgIqj+BOuoBZW7bfbSPvS
 AXj2mRldKUJUcrisC3qqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X2GUzoKBdHc=:HFw0aC0Nm9dGFq7wcTXNDO
 WdGq11YDnHWkD59R7b3iz/EG0DiEO9m/SdANVvPfbk+P9Fgfi5nJGBi7/LBC8iV4ceCLCMpya
 5GdNkk0xLkwMid6hVbg0G7HQleFxk2Tfo2QgGkWmSlX+xPaEHbaDBweY3z6mt6s69C4t9BP+i
 iEPH6eU0FIGow65HHVHUFT3lQ0KQhfo6Jirx5v382g6erngM8DzuoEF9QqC7NP9deGmaZZtUR
 oEJptwBj1W2ftn7MTK1mnmyAnxQEHRtYqcCtQD4bPQjMTO7bRtH0AOpFXO1DDw/f4lu7cRGfs
 ARm707mf+kfg3qQ6feyvbI/8XsrUoNvcEOU0DvzVZd4XqtGfVTz0kbqWPp2fb8X0H+e0FgWXJ
 OURRlhBeqMV+PXnD8QbXmnjBZtfSnEGW4SfUTaqRT3XJbQhohpQ2xfxR6bhOAnisi0w7eWt00
 GAT2F7kzbGMBAgFwdR7D68JUhkvcPcf42D9hWflyxnD20CKWph+U/6DeBmlaW0FZTeIKZn+UR
 8DrGecbl6HoDeZ5JzAtV/1dtfwdSrLGhE3wElqLRDlu7Fx28DOyTznErLus4/XF4QMHS03xNn
 ZVH3l02Xil8VvFVW60y0jgEVFp0bkTUdMvFHgVQUUoICs+c8AIUppPPLFERHDre6JA5TSyzkq
 0u8RGIq2Lwrnwv52bcDaXEILx54fHNTCI0E6VP8csBMMV9OsYjxzXtMgd164+DpHs5GLiNvd9
 bD9bA7S49GicrAV/drlQTGIW4qpiuMZWfwl3LvueOpzEamb3MoUO7SmnIWsckx6HeCX8+yt/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293531>

Hi Pranit,

On Wed, 4 May 2016, Pranit Bauva wrote:

> `--next-all` is meant to be used as a sub command to support multiple
> "operation mode" though the current implementation does not contain any
> other sub command along side with `--next-all` but further commits will
> include some more subcommands.

That is a good explanation.

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3324229..5f6ef8c 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
>  	NULL
>  };
>  
> +enum sub_commands {

Instead of "sub_commands" and ...

> +	NEXT_ALL = 1
> +};
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
> -	int next_all = 0;
> +	int sub_command = 0;

... sub_command, seeing as you convert things into ...

>  	int no_checkout = 0;
>  	struct option options[] = {
> -		OPT_BOOL(0, "next-all", &next_all,
> -			 N_("perform 'git bisect next'")),
> +		OPT_CMDMODE(0, "next-all", &sub_command,
> +			 N_("perform 'git bisect next'"), NEXT_ALL),

... using CMDMODE, how about using `enum mode` and `int mode`? And
actually `enum mode mode` instead of `int mode`. Or...

Actually, it could be even more concise by writing

	enum { NEXT_ALL = 1 } mode = 0;

There is not really a need for that enum to be in a different scope than
cmd_bisect__helper(), and neither does it need to be named...

Ciao,
Dscho
