Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAE52021E
	for <e@80x24.org>; Sun, 20 Nov 2016 20:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbcKTUPG (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 15:15:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:51154 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751392AbcKTUPF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 15:15:05 -0500
Received: from [192.168.178.43] ([88.71.227.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Llm5o-1chtKf3RLM-00ZMyT; Sun, 20
 Nov 2016 21:15:01 +0100
Subject: Re: [PATCH v15 18/27] bisect--helper: `bisect_autostart` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b1a-067117ef-cd0d-469b-ba80-ea1a1169f694-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <723476f6-2c8c-38df-1771-9a525196d9de@gmx.net>
Date:   Sun, 20 Nov 2016 21:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1b1a-067117ef-cd0d-469b-ba80-ea1a1169f694-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:SClwto9yCdiusjZ/0GyAfmRvM9x3sblLBCH3zwciA1N9lZ4kB8B
 mQ60keRj2xh0juanQ7CWQFNMvrqyo5WwCKR+YWQ0D5VsxP/tiPbE+H1ep35OKmGomfDykyY
 il6xohFaJI97q3tpA6IUQgLn/jEDTmAGWMByU9sjJ7fmaVBvV7CowqMN4Q6tYiX/JqMGkEp
 LiBxcryxHbw7SKPhTO4gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5X0Vu4krp4M=:Ux9U7xaL269oumUMk9BXvN
 A21UUEtFSWVzxqacHh6MwKa4KXnptKo5alHgIjO+gP3JYLT4AKdoWkwYfizWsSLXkwQ7uqh97
 KpU0FEfQGWeB8Vc0nthkYnlScaUBCbfRhe2MAIphtMSWP4HHGoajfdsxJJ7OtcNZ7weKz41JV
 UKYQjxoNhdEWB2dYX+U51sL31feLe4mbbReGW1KEXwfOCbOfBx0T5UpyGAsU0P78W9326mqk7
 js+8940WwbMKdp72zjFGclEkVwhDsoSpaynhJ0/MSrL8tqd7GB1te4Y7+4JrgRE3ZsYBQIUXf
 d4wWeX3DZS2eehRdQBMjE+CSp2ba+iheMUPvIb92a2+aH8wMoaXI70c7N96Qs8NZnnm9nNB1q
 knxlpvMEawd0PcvfP6fT/btFDBePC9EY9O4j93WJFGjfJdBIQjxj04i+eyyOebupVJdsGLuX9
 96z/gdoE4dpQyq6Jt6ssvaJjkqL9nqpMoMK+f4LDJbjflRO94EqYAnjLxD498YdF36MaFCyJp
 Yl1SYEicGWG6fnZ7vO2RrKiUb8WXVG5X4ou/Sj1KwSzEXAetCTunF9ig1wY6sKIHZWRsQ7SrH
 Fm0iXKCc4/bfFWzRl2LwaAKmddA0tx1wGE8GgSlBp1Ng4fDSljf550q2C4KWHR14etop5XTfO
 qNgzTIia2G13fNZluoRhke+xULSZ8TrgsQIACzaJ9LrhcU9bdNcoK2NK/xlh90nY6vV7xPVpJ
 H9gaTpCrGCIGNHE1tdqMBWlsJooBDLigPeoxD9Kzw7YH8rNE/qBk2iB+2micFCNwyoCwyFyEd
 yarOgMN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 502bf18..1767916 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -422,6 +425,7 @@ static int bisect_next(...)
>  {
>  	int res, no_checkout;
>
> +	bisect_autostart(terms);

You are not checking for return values here. (The shell code simply
exited if there is no tty, but you don't.)

> @@ -754,6 +758,32 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
>  	return retval || bisect_auto_next(terms, NULL);
>  }
>  
> +static int bisect_autostart(struct bisect_terms *terms)
> +{
> +	if (is_empty_or_missing_file(git_path_bisect_start())) {
> +		const char *yesno;
> +		const char *argv[] = {NULL};
> +		fprintf(stderr, _("You need to start by \"git bisect "
> +				  "start\"\n"));
> +
> +		if (!isatty(0))

isatty(STDIN_FILENO)?

> +			return 1;
> +
> +		/*
> +		 * TRANSLATORS: Make sure to include [Y] and [n] in your
> +		 * translation. THe program will only accept English input

Typo "THe"

> +		 * at this point.
> +		 */

Taking "at this point" into consideration, I think the Y and n can be
easily translated now that it is in C. I guess, by using...

> +		yesno = git_prompt(_("Do you want me to do it for you "
> +				     "[Y/n]? "), PROMPT_ECHO);
> +		if (starts_with(yesno, "n") || starts_with(yesno, "N"))

... starts_with(yesno, _("n")) || starts_with(yesno, _("N"))
here (but not sure). However, this would be an extra patch on top of
this series.

> +			exit(0);

Shouldn't this also be "return 1;"? Saying "no" is the same outcome as
not having a tty to ask for yes or no.

>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -790,6 +821,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  			 N_("find the next bisection commit"), BISECT_NEXT),
>  		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
>  			 N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
> +		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
> +			 N_("start the bisection if BISECT_START empty or missing"), BISECT_AUTOSTART),

The word "is" is missing.

~Stephan
