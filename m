Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB10208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 14:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbdHOORi (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 10:17:38 -0400
Received: from mout.web.de ([212.227.15.4]:61741 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbdHOORh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 10:17:37 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6UmJ-1dNEJx3wCZ-00yPII; Tue, 15
 Aug 2017 16:17:35 +0200
Date:   Tue, 15 Aug 2017 16:17:34 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] convert: initialize attr_action in convert_attrs
Message-ID: <20170815141734.GA4916@tor.lan>
References: <cover.1502780343.git.martin.agren@gmail.com>
 <0fd7f3184d285df8867ea44dd1adf418ebfc5ef3.1502780344.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fd7f3184d285df8867ea44dd1adf418ebfc5ef3.1502780344.git.martin.agren@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:RqJGoyzKa6XgQJ/FaQWZ9z9cyy2JxjUJ7FHuwAGzZb9ueooNmR+
 rsUzdEHuwUjg1CugIZng24pR4Sf/Yhi9nVtM/YxYqdGKxhf50uLwlQk06xSQehLtv5EH86Q
 G9vuC34rfVsEzlN0wlKlNPSx8gq3bY+ljuPouYP30QthyDnAG1tWoEpbjGyait4EnHdWlVO
 CtRvJaIXoA+rgYepAH9XA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i6b/YBU+44w=:PGduncuDSenVgc0hkCl6R5
 O8a4PLDsDk5odBcORIGvRw600U6OJRK9xolnQjkrmfbGoOCpWenSt1SHPmZ4q7lo01XerxmtT
 HH7B/sMAQOBDmZ3g94GvfhwUVeDdNziXLipwzTRhU5GgBsvEkDvIyejSAZ9bwIW+H8iHNG4tv
 /Y6N2UlVoN35qroAs9vf743T9p44n41lehDemnytwWKpwrtZg0w7RX2g2rnkP7+UTl3isGz07
 +Q0k+VGLBpOP6RMNSxH0okmnzBW/d1QTW25UqIxNhafDYKNtj6GHT4SgBLSIfa563XusIjHLL
 cCFwTwferfaUqmPUy5TqBUnPQztD0hp0vy2hLOIDwHP9xNUJpUWdC9FU3XShCAF0+qeSxkhlZ
 hoKm1k9x/dXWzIsgunVPIz3YRPGpey/9C4DcYUzqMyuO7Ayor1GSSbnRfDZYX+eWW/qReTew3
 lvT9Pehv/+u7dNvnBSsjuzFQxf/eoSOZQ05OjetxdAbYTOBBNS9AeAvGTjQoJiHujrRi8hpES
 M7l7Hx+Jr98k+cTVfixJsaaNzud2lznw9vWO8vy1oC1G1eQNMqVGLm2Nc9kemQz/sHCNBs/GP
 PNS05X5VXvKjd/S7Bpi5NUXU036FKmCE5pUNFN0Ab70WU3VeWvCblCED7MDM7Zr8nc84q8Hft
 5mWqHTHhxH3C1zwTgT+HVoOkNI5zxoA30atGVx7aXJVmUm64Aj3orWf7JGRzoYi8Bp5MCwG5o
 kwuO0zeNL5A89mgVormKvg1I/3fLUaf8xUfCnD6NbO940Bf4AAKfFAySMtG1aHMmhnIn2fmuy
 GUSkl+zFnek+bZ/QxX8vIrK/lIh7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 02:53:01PM +0200, Martin Ågren wrote:
> convert_attrs populates a struct conv_attrs. The field attr_action is
> not set in all code paths, but still one caller unconditionally reads
> it. Since git_check_attr always returns the same value, we'll always end
> up in the same code path and there is no problem right now. But
> convert_attrs is obviously trying not to rely on such an
> implementation-detail of another component.
> 
> Initialize attr_action to CRLF_UNDEFINED in the dead code path.
> 
> Actually, in the code path that /is/ taken, the variable is assigned to
> twice and the first assignment has no effect. That's not wrong, but
> let's remove that first assignment while we're here.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> I hit a warning about attr_action possibly being uninitialized when
> building with SANITIZE=thread. I guess it's some random interaction
> between code added by tsan, the optimizer (-O3) and the warning
> machinery. (This was with gcc 5.4.0.)
> 
>  convert.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/convert.c b/convert.c
> index 1012462e3..943d957b4 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1040,7 +1040,6 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  		ca->crlf_action = git_path_check_crlf(ccheck + 4);
>  		if (ca->crlf_action == CRLF_UNDEFINED)
>  			ca->crlf_action = git_path_check_crlf(ccheck + 0);
> -		ca->attr_action = ca->crlf_action;

I don't think the removal of that line is correct.

>  		ca->ident = git_path_check_ident(ccheck + 1);
>  		ca->drv = git_path_check_convert(ccheck + 2);
>  		if (ca->crlf_action != CRLF_BINARY) {
> @@ -1058,6 +1057,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  	} else {
>  		ca->drv = NULL;
>  		ca->crlf_action = CRLF_UNDEFINED;
> +		ca->attr_action = CRLF_UNDEFINED;

But this one can be avoided, when the line
ca->attr_action = ca->crlf_action;
would move completely out of the "if/else" block.

>  		ca->ident = 0;
>  	}
>  	if (ca->crlf_action == CRLF_TEXT)
> -- 
> 2.14.1.151.gdfeca7a7e
> 

Thanks for spotting my mess.
What do you think about the following:


diff --git a/convert.c b/convert.c
index 1012462e3c..fd91b91ada 100644
--- a/convert.c
+++ b/convert.c
@@ -1040,7 +1040,6 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		ca->crlf_action = git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action == CRLF_UNDEFINED)
 			ca->crlf_action = git_path_check_crlf(ccheck + 0);
-		ca->attr_action = ca->crlf_action;
 		ca->ident = git_path_check_ident(ccheck + 1);
 		ca->drv = git_path_check_convert(ccheck + 2);
 		if (ca->crlf_action != CRLF_BINARY) {
@@ -1060,6 +1059,8 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		ca->crlf_action = CRLF_UNDEFINED;
 		ca->ident = 0;
 	}
+	/* Save attr and make a decision for action */
+	ca->attr_action = ca->crlf_action;
 	if (ca->crlf_action == CRLF_TEXT)
 		ca->crlf_action = text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
 	if (ca->crlf_action == CRLF_UNDEFINED && auto_crlf == AUTO_CRLF_FALSE)
