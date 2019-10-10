Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012D71F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 12:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbfJJMDM (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 08:03:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:56821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfJJMDL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 08:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570708983;
        bh=GK06HUHXyiGKt5KswFmFFBkuQf6fZncF/eX3D/6ATAw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SJB/A+K35X4Nqozpf2BPCjRN2t77CxX01rJWCxjTXri+NS7mFwsvs3k43efrWBcFy
         PaG4pp/+UBQnkssX1jd8E0VPnQ/GyFRJwrhXPEgAvRTpSZa+30RUpCPRuHHttSDemd
         MdWKRq388yV2+px5Ge3Td/dqeJ0ifGdiWHtVVxe0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1ih6g53Kg3-00SNeB; Thu, 10
 Oct 2019 14:03:02 +0200
Date:   Thu, 10 Oct 2019 14:02:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com
Subject: Re: [PATCH v2 0/1] fsmonitor: don't fill bitmap with entries to be
 removed
In-Reply-To: <xmqq1rvll5w8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910101401310.46@tvgsbejvaqbjf.bet>
References: <pull.372.git.gitgitgadget@gmail.com> <pull.372.v2.git.gitgitgadget@gmail.com> <xmqq1rvll5w8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zOqY7ByDujNuBAWiW77MIHLwudX80AqXwisrwIc4IfKhuBTpjMz
 iLNg5q+zqACvoNkXNYB4tYk0MAO/F/L2rFaQJGYEohjK2SxLYwiFOykQWfq+yM6HPw4dVTE
 usd7mrvA/u0vw7yW9SHOz/Auk+4G7fs/w/CIB7Y/MXuwCQbeSshICwQMrRjT7X/OIscHD6c
 HIOQZmOkM+18dEnA50apA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F+elyZYi3XA=:7luV/oi3f3MB6XTaOWM8b5
 LfKZrIg/dUF26bSIFfHgaNLUieCRDSmLK6ZY95d4klnatgzv/HqftdGUTkHLxe5P9EOtp9RYD
 /JuTPExIGCRuwM95RsyW/C8AMa3LwHgyzWNIdycdmf7PJ12WsoupPnUQFLEXkTAMiYZ9vTSpq
 cVjrk4IidMz3gd1oZ2nSerpI/1CCQ8nRPY2BTBOXipf1LCBhCpckJ2Qchyzq06wYI+PDSvmrd
 OBDRmkHubzM4HdZ7tuqRqkIIQl0pQh8OG2030fYBUaNZIaxJNhURp5oJrswppEvdYyDPDhwo1
 bLsBgxdscSJBoY6mFbRE5D3tvgpn2OJOATApZMMQWdcDPtlOI7CDvzMQunPD63RTWtuvATFMZ
 sDQ90MU//uYuAQJ8zCfNtN9o+MHPhlAZ4a++d9VcnLbmJEI844eBGo5fpqAUNfxBRQD0gUXsu
 Yibk5/6Cl5K6oxskpZF6cUVo6HDfF8WIVoUSBa0ZXkykdRx7qzV1+MkFZqVEOBBsyIc+h+tW8
 6fbocRmqj9/LMwHW5qtY+yYJ1lLV5aN9IgJkk2rxwhPPrBJljzgJGOh5F4OeTx87GKiMdTbL/
 OhEXWo9Cv22aB0+ef2W/je0kSw9XzgRbp10q7IaSRs0tiQQ7YrGO4xDv/VGw+aQTgvtu/O0Nx
 v6WoDTue0y1tjaoCcdbp6judpUst7J1MbnHZwdtVfLSvxVWbhh4OxYyUaYM3cHH7dfTIvSZZ9
 387ierFxHnR5oPN+ltdPEP1nmsnn3sVBcuonm8YXQIpDnltsqN9UPOLwJhdnThvEHSP2dITO+
 HSPpVbGqfsFYSpHPMjYJDigvXeyJ842RM68wVUvDpoFhU4NJmXKtAF76L1U0oIl4PO1VeEclL
 e/zwFwOvc/vAH4jwq+INweCksCU74s0ebEagjiO10rSo8D3V1CiTP929I410fU4/pRq4RFjYW
 SyMIh1EU8x/2rKVv2/vTT/H5cZXZlWcNlQzhRN23q1rP2djtwe7m53JZuZJ8zKhQvqa7COKFX
 uLG4dBPRdPGXJXkHCkoHF37obQoL/nZM0vP/SStJ6fVTFumF4WuzpvZU4tAysqrA3nSGvdBoA
 fEs6HsuhxrPk0fn3dvq5ibRZpTUmDvDdj84dgY2jXiAWroTMZiuYq/15A+1KOJiFuf0GlskpH
 FgRTvwRRDxfDbqYztfg1qFso2e/r3YltxoZz660iV9evvZhugNPsUL7LlBJcipw5x+ixEGdwm
 KchoXFEhvwKCi+Wa6dUHBvCd6p3E3Q2z5lMh4UoU07EsXdn/yrybUmo9T1Is=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 10 Oct 2019, Junio C Hamano wrote:

> "William Baker via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This is the second iteration of changes to fix the segfault that I
> > encountered while testing fsmonitor. This iteration includes the follo=
wing
> > updates for feedback I received on v1:
> >
> >  * Use %u instead of %"PRIuMAX" for unsigned ints in BUG format string=
s
> >  * Updated the new test's comment to be more descriptive
> >
> > Thanks,
> >
> > William
> >
> > William Baker (1):
> >   fsmonitor: don't fill bitmap with entries to be removed
>
> Thanks.  Dscho, is this still Reviewed-by: you?

Yes!

Thanks,
Dscho

P.S.: I guess we could even go and make this a `Co-Authored-by:` because
the test case is actually by me, at least originally... ;-)

>
> >
> >  fsmonitor.c                 | 29 ++++++++++++++++++++++++-----
> >  t/t7519-status-fsmonitor.sh | 13 +++++++++++++
> >  t/t7519/fsmonitor-env       | 24 ++++++++++++++++++++++++
> >  3 files changed, 61 insertions(+), 5 deletions(-)
> >  create mode 100755 t/t7519/fsmonitor-env
> >
> >
> > base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-372%=
2Fwilbaker%2Ffix_git_fsmonitor_crash-v2
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-372/wil=
baker/fix_git_fsmonitor_crash-v2
> > Pull-Request: https://github.com/gitgitgadget/git/pull/372
> >
> > Range-diff vs v1:
> >
> >  1:  ce9bf4237e ! 1:  08741d986c fsmonitor: don't fill bitmap with ent=
ries to be removed
> >      @@ -44,8 +44,8 @@
> >       +	struct cache_entry *ce;
> >       +
> >       +	if (pos >=3D istate->cache_nr)
> >      -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuM=
AX" >=3D %"PRIuMAX")",
> >      -+		    (uintmax_t)pos, (uintmax_t)istate->cache_nr);
> >      ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuM=
AX" >=3D %u)",
> >      ++		    (uintmax_t)pos, istate->cache_nr);
> >
> >       +	ce =3D istate->cache[pos];
> >        	ce->ce_flags &=3D ~CE_FSMONITOR_VALID;
> >      @@ -56,8 +56,8 @@
> >        	istate->fsmonitor_dirty =3D fsmonitor_dirty;
> >
> >       +	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> >      -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuM=
AX" > %"PRIuMAX")",
> >      -+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)=
istate->cache_nr);
> >      ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuM=
AX" > %u)",
> >      ++		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cac=
he_nr);
> >       +
> >        	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension s=
uccessful");
> >        	return 0;
> >      @@ -85,8 +85,8 @@
> >        	int fixup =3D 0;
> >
> >       +	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> >      -+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuM=
AX" > %"PRIuMAX")",
> >      -+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)=
istate->cache_nr);
> >      ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuM=
AX" > %u)",
> >      ++		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cac=
he_nr);
> >       +
> >        	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
> >        	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
> >      @@ -96,8 +96,8 @@
> >
> >        			/* Mark all previously saved entries as dirty */
> >       +			if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> >      -+				BUG("fsmonitor_dirty has more entries than the index (%"PRI=
uMAX" > %"PRIuMAX")",
> >      -+				    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_=
t)istate->cache_nr);
> >      ++				BUG("fsmonitor_dirty has more entries than the index (%"PRI=
uMAX" > %u)",
> >      ++				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->c=
ache_nr);
> >        			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callba=
ck, istate);
> >
> >        			/* Now mark the untracked cache for fsmonitor usage */
> >      @@ -109,8 +109,9 @@
> >        	test_cmp expect actual
> >        '
> >
> >      -+# Use test files that start with 'z' so that the entries being =
added
> >      -+# and removed appear at the end of the index.
> >      ++# This test covers staging/unstaging files that appear at the e=
nd of the index.
> >      ++# Test files with names beginning with 'z' are used under the a=
ssumption that
> >      ++# earlier tests do not add/leave index entries that sort below =
them.
> >       +test_expect_success 'status succeeds after staging/unstaging ' =
'
> >       +	test_commit initial &&
> >       +	removed=3D$(test_seq 1 100 | sed "s/^/z/") &&
>
