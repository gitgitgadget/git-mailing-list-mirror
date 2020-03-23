Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360BC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC32F20719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GI4jHS77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCWU4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:56:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:57175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgCWU4M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584996968;
        bh=554nEp4LFlf5Tmdc5fn3Q3gEMf6iVP2Q7EyItRm7tjs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GI4jHS77kOsvtXE3DAIreojC3FwvrhqjgTdbS5lYehqJvTmi2FUANhWKb7IMiEnEs
         90hmdNaqaaWwRqmX0ANqxMJB88DZTbpSsghdx082QMpMuUMZ/RXr7A/xzV9YSvNHOe
         ear9IeEWYCI5gdoWXIlHaHifOvX64DXbUrNeuJ9I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MoO24-1jaPex3hLE-00oqVA; Mon, 23 Mar 2020 21:56:08 +0100
Date:   Mon, 23 Mar 2020 21:56:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests(junit-xml): avoid invalid XML
In-Reply-To: <xmqqlfnr5945.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003232153350.46@tvgsbejvaqbjf.bet>
References: <pull.732.git.git.1584967475669.gitgitgadget@gmail.com> <xmqqlfnr5945.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0JmtH915P7jeWDE0zkG9eQcDAiUj1xocWnZBHFoJD3nhhxu5DKg
 cs7kVnBIcipzcfnPV+ZB2P8NWqb6Aqz0UlGdVYCMEe1NmCXaMsCMsk3syEN+cyO1/mi6zI1
 Oi4k4FovWl8sEmQEQSe5AD66NBnAbVQmliNBg2Iae7ex5H2PEuHVTw1Re2VNnTXOAHcVWYX
 5n9VRzneCTM9lz/dwYKYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bCdsd4qURx4=:E0aR7tru8L99xP5vSNaTot
 uCPZtMumLCxjN1V06CjGlHtz83s2lK10uxHmVMhBVfMWk4NCs60ahPWmkutCXY+w8eljlxCGI
 PUPSglgzHFqRCA+JHo8mVZS1Xi7JPN7JhMY3OV8fa/zPsaM+dylQdEgFFeBWyjpwLC+hrv13M
 f4BM2wocrRaaoadly9P5879mHxH1jg9gxUkVtXGNMR+pPQ84WbrwkVbVHgzgqQRz3xMxJMXWc
 nP/MUk6lV9dOKwWrM9RZJ7N9OkcQQmYhdhd76q6eyrclQKP9sQ2d8vvBA672jVP6PWZeSSekU
 NsgJLz1fXUQ5on/TyeBPbsm/vbGL4KxT5ca9qwlu+xiRSyZXPIYJv4qlJiA4jisJ9PyqiUmbI
 vkxc6Yb0rzbPiocCrSKJjG/BSvhkpJ0h0hmaXVoAzQ1MlDeeE+B5YLBpPknqp3N1zjiDFGkiG
 axrjREAAiDHs/G4qt05kVmuVGHVEKcwjHg+DbGpUIKvYM6ZWnOtjbVg0Nkjwzv0VYWLW9AiAW
 AyVcpWy4kJSgbpovMLs9Zk0yDcupAe/u3NEz3ZGa9tc1uqXM8T/7h/wD7Aysn+vCZlZzOPqGO
 sm1eVA4Ojm3a4CHGHF8H4/9I3b/WYixKgS3dS9IvAVh27Om8KAfQs5n3TPoZsGS+jAiPAsl/9
 FxrQzIs8LS3KGnnBFX5GMbB2JGNNWrCfLZKPIEOeFvoiGPOnG0cpID4RUaZQiaIcOuk17nscp
 aEDxDub7ySHQ3gs2DM52eczbNRh9b5gfCiZhtPTFAQLMsV5OvB9pC2jPlCtFp7RofW+3Ov6gt
 lmqo7aUK99NW1XqOo3xjV129XSYn6JaH2A3mwzjMBOSotpLUoMj3Z6W0gmnkahyUYY2Jjk9ed
 zdKpg4D+K99LWvwVAg/zPHqLiWwabiIK9+e3FBIbroHRAn1XdZzLInrm9MAFM1JHPyqN9065n
 3dC+ro1dYMJp+fmEY02gIPYgB08AwabuYIxvqxAkfkXlcDCsaKB2lJHHpqqnnn2eSi+fZWynx
 4GhzYWFb948jXDxhrSW6CKRXtBGTqvFJWvvTRzrO+oULbYWFbgVJbgryx358YX5q08tzuRqYF
 f8hyqU/QuCdt9PYILQiLujHNC2YSmTGsQDY6I/MyQgRObjGqtv0oMoayF8ZiyGZU/MDIzjaet
 4HUyj1PycYtTiKkcFldR/Vqmv7KBZ2Qf5AF/1QrL9BY/Q6G2ZeB4SR/XBP1NnHW+3jCis3IM+
 zQA4iEw+4DlR60EFD
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 Mar 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When a test case is run in a subshell, we finalize the JUnit-style XML
> > when said subshell exits. But then we continue to write into that XML =
as
> > if nothing had happened.
> >
> > This leads to Azure Pipelines' Publish Test Results task complaining:
> >
> > 	Failed to read /home/vsts/work/1/s/t/out/TEST-t0000-basic.xml.
> > 	Error : Unexpected end tag. Line 110, position 5.
> >
> > And indeed, the resulting XML is incorrect.
> >
> > Let's "re-open" the XML in such a case, i.e. remove the previously add=
ed
> > closing tags.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     Fix Azure Pipelines for t0000
> >
> >     When running t0000 in our Azure Pipeline, the "Publish Test Result=
s"
> >     step complains about an invalid JUnit-style XML, and it is correct=
.
> >     Let's fix that.
>
> Hmph, I have a vague recollection that I've seen this one, looked at
> the patch and even understood the issue.  Did I then forget to apply
> it back then?  If so, apologies for failing to do so before the
> release.

I suspect that you think of 076ee3e8a2a6 (tests: fix --write-junit-xml
with subshells, 2020-02-12) which you indeed applied. This patch addresses
a different issue that I had not noticed until two weeks ago. I
purposefully held back on contributing it during the feature freeze phase.

> Will queue.

Thanks,
Dscho

>
> Thanks.
>
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-=
732%2Fdscho%2Fci-xml-error-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-732=
/dscho/ci-xml-error-v1
> > Pull-Request: https://github.com/git/git/pull/732
> >
> >  t/test-lib.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 0ea1e5a05ed..7f0c02c016b 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1085,6 +1085,7 @@ finalize_junit_xml () {
> >  		junit_time=3D$(test-tool date getnanos $junit_suite_start)
> >  		sed -e "s/\(<testsuite.*\) time=3D\"[^\"]*\"/\1/" \
> >  			-e "s/<testsuite [^>]*/& time=3D\"$junit_time\"/" \
> > +			-e '/^ *<\/testsuite/d' \
> >  			<"$junit_xml_path" >"$junit_xml_path.new"
> >  		mv "$junit_xml_path.new" "$junit_xml_path"
> >
> >
> > base-commit: be8661a3286c67a5d4088f4226cbd7f8b76544b0
>
>
