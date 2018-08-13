Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D7E1F428
	for <e@80x24.org>; Mon, 13 Aug 2018 11:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbeHMOdb (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:33:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:44717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbeHMOdb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:33:31 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjrDd-1gQS4m2U0X-00bue1; Mon, 13
 Aug 2018 13:51:29 +0200
Date:   Mon, 13 Aug 2018 13:51:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 3/4] range-diff: make use of different output
 indicators
In-Reply-To: <20180810224923.143625-4-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131348120.71@tvgsbejvaqbjf.bet>
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-4-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EaASESb13Pa5C1BV7wBsupr8eb79q18ZzTsAZ18vEdyNj9y1Ehc
 LaerOVXr6U4WWfO+aKz881QHUBLA3EOsWfTBMqqHL1Q/yClq1lrFPErjhRs1JfGL/van8Um
 lPBCE+WdBzVTyXy4GoY0zkDMvnwlI5cIaUGjkoViJJe72346vt7XpIcCA8LWnd4ERjJs+p1
 Xx047SS8h5EBIfpoKK2YQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fUw5JFP+hUc=:ArDG7SjpNqXEW8CVO4V4N6
 G0NXeJv5ipKz7xymHNaHK3Ko3WapXGrypVVTILHS9mNb+Q8UxSr1KSUnROLB6QgwI9/5d4vwt
 Q9PXMsyG72NfdR8P3QqL1xbZxk12tu1GqZ01sczF7TmzFOH0k6o9A250R2yB73/7uh+uEnH+J
 9ZOpHNHcl+tFQEehVmsQHA2y4ZdFwyuYhDDPK/G2TmkFl22B/zc3ptvtrreTtQIAurYBs1YQJ
 8veI4wvNSuFzpHetHfmA5046X1aKxW59rWhaYSAe/Xr6QwFH2pNTEQ7AEpJ4mJajWd2+j6TwJ
 SwFD+Z91Kzx583Q/MTAxyXUgzZFWpfkhaWhuOLlmMoeFz81z4ur9mPz/MU7oPyNjY0PFdo52w
 VXswzoNy4WIYNR18wEfCAv1AxBgj1P0RyUxlKh/ZjVqy/oL2SBi6pZfKXCQfMfnUt9vFkLQFE
 TdXoy1Kri5plzny3zUT6RCRsCc1zxs/R0tTcUK035g9TfHZMRcCN1FGChqTuVeqlqtekINbIJ
 o6wGszdZOFgLMattBs8ZEzJuBz1rxNLAR+lMKJN4RIba9ZVqhYyES2+Dy0ITBAm5iTS+bSP73
 GtIYWhal3qvoe5v1vSB8Y4YHJnwi9KB8qmEWfGadBoWaWvjtEh/cSo0yBsqtV4iF3PYr9RIQP
 y59DA2paeYTUPKXuitnCWjQ6P5JRvMTKZUVTBhef5sCehKFqDihpNqins71jHJH+JaY9CJcG9
 Hxx5G2nv2ddo1suBM86t3XfVYRfE+bTHw0zvChGg5k8gyM1hobf0VFC8JQBY4FYBrpUULIWz3
 HNBoqgV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 10 Aug 2018, Stefan Beller wrote:

> This change itself only changes the internal communication and should
> have no visible effect to the user. We instruct the diff code that produces
> the inner diffs to use X, Y, Z instead of the usual markers for new, old
> and context lines
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  range-diff.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/range-diff.c b/range-diff.c
> index b6b9abac266..6e4192c8e79 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -38,6 +38,9 @@ static int read_patches(const char *range, struct string_list *list)
>  
>  	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
>  			"--reverse", "--date-order", "--decorate=no",
> +			"--output-indicator-new=X",
> +			"--output-indicator-old=Y",
> +			"--output-indicator-context=Z",
>  			"--no-abbrev-commit", range,
>  			NULL);
>  	cp.out = -1;
> @@ -108,8 +111,18 @@ static int read_patches(const char *range, struct string_list *list)
>  			 * we are not interested.
>  			 */
>  			continue;
> -		else
> +		else if (line.buf[0] == 'X') {
> +			strbuf_addch(&buf, '+');
> +			strbuf_add(&buf, line.buf + 1, line.len - 1);
> +		} else if (line.buf[0] == 'Y') {
> +			strbuf_addch(&buf, '-');
> +			strbuf_add(&buf, line.buf + 1, line.len - 1);
> +		} else if (line.buf[0] == 'Z') {
> +			strbuf_addch(&buf, ' ');
> +			strbuf_add(&buf, line.buf + 1, line.len - 1);
> +		} else {
>  			strbuf_addbuf(&buf, &line);
> +		}

My preliminary reading (I sadly lack the time to pull your branch and play
with it) suggests that this works, although I have to admit that X/Y/Z
would confuse me in 6 months from now, as they do not really read like
diff markers but like plain text. I could imagine that '>', '<' and '#'
would not impart that confusion on me.

Ciao,
Dscho

>  
>  		strbuf_addch(&buf, '\n');
>  		util->diffsize++;
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 
