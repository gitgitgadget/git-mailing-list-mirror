From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v3 0/3] config: add '--sources' option to print the source
 of a config value
Date: Sat, 13 Feb 2016 09:43:34 -0500
Message-ID: <CANoM8SWj08qKvDXhyfRXLV2iuYJ7Vjdutzjt0Q2ZNOcProqy=Q@mail.gmail.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	ramsay@ramsayjones.plus.com,
	Eric Sunshine <sunshine@sunshineco.com>, hvoigt@hvoigt.net,
	sbeller@google.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 13 15:43:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUbQU-00033X-G6
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 15:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbcBMOnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 09:43:55 -0500
Received: from mail-ob0-f193.google.com ([209.85.214.193]:34223 "EHLO
	mail-ob0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbcBMOny (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 09:43:54 -0500
Received: by mail-ob0-f193.google.com with SMTP id x5so11804702obg.1
        for <git@vger.kernel.org>; Sat, 13 Feb 2016 06:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZCXLma5VjId5lgo2GWXH7De9AWO928F719Pys7FvKdQ=;
        b=W7qHItyMrhVJCujBXuFFGS0DcBWyV82j2cCcUGDGonspkESKY1jTiZ8O+BM/ifQg5P
         OwVmY6VlRJ6lnfdNNFxwqV86Lu2Tkq1/rtMypVOiIjDcf7sGANWftYvgFXjURELmHxc4
         Uki2BSnmw503Nk5FdPYVWlmSRoCheFZrNaXwhGmocc5AQZ3lrx6Kuas68jUXTQGCeyBS
         MsEkZInwCOwhJa8NE3LF0J9foFAKxyEpWrTmHeThY4m2L9yLMXXHTZShcdfWreRxXaov
         5bVbGSl7IgPRCWVwVSVHzTL7a6AUS3iApehWJAuJeH0P0pg8+wcdFEW8uFa4hpXS710s
         yQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZCXLma5VjId5lgo2GWXH7De9AWO928F719Pys7FvKdQ=;
        b=TAGasjBnsrH53hjHUxfTmP6fRi9019riOsJMrURUzedkLuIb/V/upe2Svf1VEBoKHd
         j/DGFptZ3/Yj2Q/C5zyQgs6SCBjf7gzBgwAN+gCj0H4HCUrJKD59z6lK5yTro4q4w1CA
         YH2Agq/KvQ8uVclk9GXEP9UU5tIlPGIAHcujFIfz1jXgknFUr4lX891CPM1Op/5vSdGT
         /lkCEhMkNn0/GGNRUxOwP5w+lobxu8wHGtHgLMv+oAd9erhvOzmaefyw99M74H42VXK2
         cjrNoEGomXzjd96j4dBnJsMWaPGW3AgbCG8ZLu20N5C7zPnYtY0aoQnVKnjnt8UaMpoZ
         uViA==
X-Gm-Message-State: AG10YOSWvu3w4qEKYn/Eyno9TW5dnrfRd0mwlEdtBImSjMi2pRfkbJo0iaqOQBOb0fDYWiNvqSRNQhJxmUBwLg==
X-Received: by 10.182.130.162 with SMTP id of2mr5496570obb.57.1455374633569;
 Sat, 13 Feb 2016 06:43:53 -0800 (PST)
Received: by 10.76.108.167 with HTTP; Sat, 13 Feb 2016 06:43:34 -0800 (PST)
In-Reply-To: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286114>

On Sat, Feb 13, 2016 at 9:24 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> diff to v2:
> * rename cmd to cmdline
> * rename function current_config_name to current_config_type_name
> * add 'type' to config_source struct that identifies config type
> * fix config stdin error output and add test case "invalid stdin config"
> * change delimiter between type and name from tab to colon
> * remove is_query_action variable
> * rename "--sources" to "--show-origin"
> * add pathological test case "--show-origin stdin with file include"
> * enumerate all valid commandline cases for "--show-origin"
> * removed TODOs as there are no config include bugs
> * describe '--includes' default behavior in git-config.txt
> * split test cases
> * use non-interpolated here-docs where possible
> * improve readablity of 'show_config_origin' function by removing duality
>
> I renamed the flag from "--source" to "--show-origin" as I got the impression
> that Sebastian, Peff and Ramsay seem to be all OK with "--show-origin".

I know that I am late to the party here, but why not make the option
`--verbose` or `-v`?  `git config` doesn't have that now, and this
seems like a logical thing to include as verbose data.  I would
venture to guess that `--verbose` is more likely to be the first thing
that someone who is looking for this information will guess at before
they run `git config --help`.

>
> Thanks Eric for the hint to simplify the 'show_config_origin' function.
> I took your suggestion but modfied one line. Instead of "fputs" I used
> "fwrite" to write the content. This was necssary as the last char of the
> string could be \0 due to the "--null" flag. "fputs" would ignore that.
>
> In 959b545 Heiko introduced a config API to lookup .gitmodules values and
> in "submodule-config.c" he uses the "git_config_from_buf" function [1]. I
> wonder if my modifications to this function could trigger any unwanted side
> effects in his implementation? (I can't imagine any but I want to make you
> aware of this connection)
>
>
> Thanks a lot Peff, Sebastian, Ramsey, and Eric for the review.
>
>
> [1] https://github.com/git/git/blob/494398473714dcbedb38b1ac79b531c7384b3bc4/submodule-config.c#L430-L431
>
>
> Lars Schneider (3):
>   git-config.txt: describe '--includes' default behavior
>   config: add 'type' to config_source struct that identifies config type
>   config: add '--show-origin' option to print the origin of a config
>     value
>
>  Documentation/git-config.txt |  19 ++++--
>  builtin/config.c             |  35 +++++++++++
>  cache.h                      |   1 +
>  config.c                     |  23 +++++---
>  t/t1300-repo-config.sh       | 136 ++++++++++++++++++++++++++++++++++++++++++-
>  t/t1308-config-set.sh        |   4 +-
>  6 files changed, 202 insertions(+), 16 deletions(-)
>
> --
> 2.5.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
