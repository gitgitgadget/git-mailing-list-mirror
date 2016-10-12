Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C324207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 14:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933300AbcJLOXg (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 10:23:36 -0400
Received: from mout-xforward.gmx.net ([82.165.159.13]:59062 "EHLO
        mout-xforward.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbcJLOXf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 10:23:35 -0400
X-Greylist: delayed 1857 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Oct 2016 10:23:34 EDT
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LfBX6-1b5nSU45FY-00olmv; Wed, 12 Oct 2016 15:30:51
 +0200
Date:   Wed, 12 Oct 2016 15:30:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org, venv21@gmail.com,
        dennis@kaarsemaker.net
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject
 URL
In-Reply-To: <20161010175611.1058-1-sbeller@google.com>
Message-ID: <alpine.DEB.2.20.1610121501390.3492@virtualbox>
References: <20161010175611.1058-1-sbeller@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8+/+wbCX9lV+AIghsxqizmE3lqfUpvu4aEyr0RH6aALEs9vvzhg
 p1jx4xp6IzhjGtmZY0cJcmhPnuhVv6Tv3w4yCvgazyAlsMKpVZ9Z81PtLwxT41XcbBnnoA5
 uzMkpTG277dHjWhFlMCR1bHeWepBzGyHVTvxHyhqOFTFBlBYJK5a1mQKk3Jdsq0xzOBNvZ2
 dTS6YWmtLNx8lORrFT3pw==
X-UI-Out-Filterresults: junk:10;V01:K0:G1WWUQaBI3s=:Y8e4Lq5kfcTnXvygNJfARMpD
 Ewufej35uJ2kwSBBjyaoh9TTk+GtAdbnCPnFX5yI2CRumdrfxFrfjYK163AG14NzqUSb44aOW
 d/jTATsuPsHuMCqe3uP12kax3XGP8AJ/ObRoGKB/PA+3NNdqKL0itHecDNVX7+XUfqC2gWXcc
 OFLRoPWcsTLlDhbfkDN6eVtYSgHYEJIg2ddywQt6lliwGbC9dDE3w/yhbJ6XBWG6pUH/XAQi2
 tyzn4B8cw63HtsBwj/XZy/1TUKVJ+davzPOhWv7+A2VormcOXWllHs7xpz4Sgc3kDnkrfF74M
 kGH6Os5JeRC4BSfG3OU4qYa9DAGqXmQp/dLlsyCg4LsCZwtBjgauQYzr7q+s0z93GlYd6m+Fe
 Gz0k1YyRMjFe3tX0Nd6ByK9p9cAq4jI65lGyX6TKAquTn9d5x/vwVTGtD3suUa1NCY48Z9AGU
 CiLWFaIDWFBJU0rWKHOuBIGXsc0a5YbeT411ayNBf2cDktybRUysd+fu6X1fE100jjvQh5HoJ
 usvj1Uy43xvk8oVa28vQUezDfCxLqfktkA5DJfvpSovBH5ql+jXYchYwA2axMVJYR807pcPAC
 Pl7FJPErNy89htUCLErVClqMvjIHt/zIccmsDmPeeoDr51bvIgtR6i6dp8q5bE1ZVW6wPik/b
 3uSp2iNImCdrp+AOO3U0U8K7ARMhv/bI4v7+9aXStvszYTxvSxSHK0yWWshGTOAs9A/q6s/Fn
 KfcocpGzzCd3x72gw7QL861/Afd+100lol/QxMH5llJhOYz65D42R287H2bZCUSzVZyES8ff5
 wuEhX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 10 Oct 2016, Stefan Beller wrote:

> Before 63e95beb0 (2016-04-15, submodule: port resolve_relative_url from
> shell to C), it did not matter if the superprojects URL had a trailing
> slash or not. It was just chopped off as one of the first steps
> (The "remoteurl=${remoteurl%/}" near the beginning of
> resolve_relative_url(), which was removed in said commit).
> 
> When porting this to the C version, an off-by-one error was introduced
> and we did not check the actual last character to be a slash, but the
> NULL delimiter.

It is a NUL delimiter, not a NULL delimiter.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 444ec06..a7841a5 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -95,6 +95,8 @@ static int chop_last_dir(char **remoteurl, int is_relative)
>   * NEEDSWORK: This works incorrectly on the domain and protocol part.
>   * remote_url      url              outcome          expectation
>   * http://a.com/b  ../c             http://a.com/c   as is
> + * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
> + *                                                   ignore trailing slash in url
>   * http://a.com/b  ../../c          http://c         error out
>   * http://a.com/b  ../../../c       http:/c          error out
>   * http://a.com/b  ../../../../c    http:c           error out
> @@ -113,8 +115,8 @@ static char *relative_url(const char *remote_url,
>  	struct strbuf sb = STRBUF_INIT;
>  	size_t len = strlen(remoteurl);
>  
> -	if (is_dir_sep(remoteurl[len]))
> -		remoteurl[len] = '\0';
> +	if (is_dir_sep(remoteurl[len-1]))
> +		remoteurl[len-1] = '\0';
>  
>  	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
>  		is_relative = 0;
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index bf2deee..82b98f8 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -319,6 +319,7 @@ test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
>  test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
>  
>  test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../foo/sub/a/b/c"
> +test_submodule_relative_url "(null)" "../foo/bar/" "../sub/a/b/c" "../foo/sub/a/b/c"
>  test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "../foo/submodule"
>  test_submodule_relative_url "(null)" "../foo/submodule" "../submodule" "../foo/submodule"
>  test_submodule_relative_url "(null)" "../foo" "../submodule" "../submodule"

I see that this already made it to `next`. I saw that because it breaks
the build of Git for Windows (this was not noticed earlier because other
compile failures prevented the tests from running), as now the test cases
173 and 177 of t0060 fail (*not* the newly introduced 163).

Here is the output with -v -x:

-- snip --
[...]
expecting success:
                actual=$(git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' '../.') &&
                test "$actual" = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.'

+++ git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' ../.
++ actual=C:/git-sdk-64/usr/src/git/wip/t/.
++ test C:/git-sdk-64/usr/src/git/wip/t/. = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.'
error: last command exited with $?=1
not ok 172 - test_submodule_relative_url: (null) /usr/src/git/wip/t/trash directory.t0060-path-utils/. ../. => C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.
#
#                       actual=$(git submodule--helper
#                       resolve-relative-url-test '(null)'
#                       '/usr/src/git/wip/t/trash
#                       directory.t0060-path-utils/.' '../.') &&
#                       test "$actual" =
#                       'C:/git-sdk-64/usr/src/git/wip/t/trash
#                       directory.t0060-path-utils/.'
#
[...]
expecting success:
                actual=$(git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' '../submodule') &&
                test "$actual" = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/submodule'

+++ git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' ../submodule
++ actual=C:/git-sdk-64/usr/src/git/wip/t/submodule
++ test C:/git-sdk-64/usr/src/git/wip/t/submodule = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/submodule'
error: last command exited with $?=1
not ok 176 - test_submodule_relative_url: (null) /usr/src/git/wip/t/trash directory.t0060-path-utils/. ../submodule => C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/submodule
#
#                       actual=$(git submodule--helper
#                       resolve-relative-url-test '(null)'
#                       '/usr/src/git/wip/t/trash
#                       directory.t0060-path-utils/.' '../submodule') &&
#                       test "$actual" =
#                       'C:/git-sdk-64/usr/src/git/wip/t/trash
#                       directory.t0060-path-utils/submodule'
#
[...]
-- snap --

For comparison, this is how it succeeds in an Ubuntu VM:

-- snap --
expecting success:
                actual=$(git submodule--helper resolve-relative-url-test '(null)' '/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.' '../.') &&
                test "$actual" = '/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.'

+++ git submodule--helper resolve-relative-url-test '(null)' '/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.' ../.
++ actual='/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.'
++ test '/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.' = '/home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 173 - test_submodule_relative_url: (null) /home/virtualbox/git/wip/t/trash directory.t0060-path-utils/. ../. => /home/virtualbox/git/wip/t/trash directory.t0060-path-utils/.
-- snap --

The reason that this fails on Windows is that the POSIX->Windows path
mangling of the MSYS2 shell strips the trailing . from "/some/directory/."
when converting it to "C:/git-sdk-64/some/directory", and for a good
reason: most Windows programs do not handle the trailing "." very well.

One very, very ugly workaround for this newly-introduced breakage would be
this:

-- snip --
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 82b98f8..abd82e9 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -328,11 +328,11 @@ test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule"
 test_submodule_relative_url "(null)" "//somewhere else/repo" "../subrepo" "//somewhere else/subrepo"
 test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
 test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
-test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
+test_submodule_relative_url "(null)" "$(pwd)/." "../." "$(pwd)/."
 test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
 test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)/repo"
 test_submodule_relative_url "(null)" "$PWD" "./ " "$(pwd)/ "
-test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$(pwd)/." "../submodule" "$(pwd)/submodule"
 test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "$(pwd)/submodule"
 test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle1" "$(pwd)/home2/../bundle1"
 test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./." "$(pwd)/submodule_update_repo/."
-- snap --

The reasons this is ugly: we specifically test for *Unixy* paths when we
use $PWD, as opposed to *Windowsy* paths when using $(pwd). We do this to
ensure a certain level of confidence that running things such as

	git clone --recurse-submodules /z/project/.

work. And now that does not work anymore.

So where to go from here?

Ciao,
Dscho
