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
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E361F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 20:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfKRUPg (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 15:15:36 -0500
Received: from mout.gmx.net ([212.227.17.21]:35671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfKRUPg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 15:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574108129;
        bh=FpOXgabotMRnJVHRaAnONIwTmWyoCQN3uOGWILspxxg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VWNfQ0Bkcmdb6qFKnHRpy36lqKmi5rAMlS9YylL7bstP3ZVo+cVVtuJD9j0zWktNf
         CBRH0PmncHkA8cVfZnm42W2jQD9+0aTBSn43N1IKzQ3GnCf62wOVmJ8bG26JE6NqV4
         OgnwZC9ypnE1cJ7YWpwRGSrVafJidEn0pn5gGj80=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacSY-1hz6F905IQ-00cBl2; Mon, 18
 Nov 2019 21:15:29 +0100
Date:   Mon, 18 Nov 2019 21:15:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] sequencer: handle rebase-merges for "onto" message
In-Reply-To: <20191118115747.31533-1-congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911182114030.46@tvgsbejvaqbjf.bet>
References: <20191118112357.GA29922@danh.dev> <20191118115747.31533-1-congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cwACO/UHA1QYdesknVHLD8EwVuG1ekjxYWMVEYU37TztIiMBj2J
 bxmLqTHU8es7LK+OXw3h63kKsl0GRqTFI5p9wyXhN3spXZQtnGAGva/kena3LHQJ4WrHZTt
 ksrbd1CJoVk508lOro24t+/Xq+dRV+71B98C2uMI70VWSjSMklhL1a2zKX2CRXQEgIntNjQ
 gMVyJEygvgnbNJjDNB25g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Nq+dEt6v64=:a7RgKEkdyA9YVjs2piq5VT
 DG5fa+B6aMDsPqqWkDcVdbc+TdiHEmluCBhEktZsWTM8QV+PyjzpOUTT2bH3JdwbLrPO4P2qw
 JIasCEiM8Y1ONJOOSZ8Qou+Hc9aBMB7qtt5eEm56XoOsOFTjZhlPkOi/mUlT8wF2AzWyrv/BH
 I0XazjohjEHYVBX1nOWbVYVa2Ep3qf+oPyrDu60Wm9JcRs7otblBGRLhNheEXtUfnAdCZmc+D
 lneqh4imez3QDR24qGLxawEm1eH+kqOS0rgGTGjOp4t13TN1SZj2HI30JSms6oZTq0H7h0yEu
 Fr37T5SyWseLByIVn6pev6SgM2mXjpYkMIA1OYkfKuRll67fR07gfyQA9nzRBsL+eaaLK5utV
 cPjJfaFm18PvkCVky6m3MmU3W2ctQgYcr5ZW2hBu64ruwdwjmVQ3zBA/ig2qGARn+sRax/m+J
 2+HMlvi/YvSA8BPbmFIAzSlsKuZI8YsZsoT2O2j7OIJPTf4kK/TAC0rx8nViGx4L6x51U22vd
 oO6nVf0WoUy0DC/TtFuhx97LDWB2itVbE8IGZ6XKBvbg+XWX2eEpKIznhZV5l01QCwIf85hOS
 CF/d7TItS2AhbxP/DL4/n/eZZoudSjtH9GTVW9J129pai4CwBKYYqTE5oxT4Y20iJcpwtusww
 xCLESVbltpCudgbgSiheBg71gbbXgY5Z35VV+7dF3owHqQcZNDBqBUU7IMhq+vSj5su6hayiC
 w2WkuTQZqqn92P6YaIpTVa8TtutumSrM+LGPD/Z4DFvaIiIIaMj4FPCyiUw0UsGE7gEFenH1A
 0sg++lXB/amFUdo3BlEsJWI99mbmc4NDlnWcALTSyErJVDPFi65MbHJIR4l93WDl5y42FhqPv
 UiyjjtEcQ2ZOOZIzTrk3JIKFg9kqrxMiz7swxVNBCdlv7xXBRVWXhuYy/GaOVaiz6p33ML0iZ
 RuTMoDz+x4pGhlT9KkdM3yHqACL4ADASfXovI4G5nnsyuXg+4QXqjiacXcPr9oNoOxHZrsRk1
 rcxu1thYpsm7ilYEo0XUbrlARDfTs3Hdfg5p+qc4jVcOVuaKbYKFqeMfYvXhXwgnx6b9Y5l4s
 KG8GqivcYpXnP/1OxWoOMruaolSr4IQx8avjeHzF4x29sAwMbfGlPWGAvABP3TRcSHHBRrGxN
 OmUXCeWc+ktCf4bD3z2x074kPROWKBKYB8PxYwakq+X9y9gE/RxyufjXGo66N0bMp5jCDDoI5
 nQkCbNEtDyjJe1ZIgT9RULRr6/7srUOVMRT1LqH/xZsVeHiOE4TJcpWI7YZs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 18 Nov 2019, Doan Tran Cong Danh wrote:

> In order to work correctly, git-rebase --rebase-merges needs to make
> initial todo list with unique labels.
>
> Those unique labels is being handled by employing a hashmap and
> appending an unique number if any duplicate is found.
>
> But, we forget that beside those labels for side branches,
> we also have a special label `onto' for our so-called new-base.
>
> In a special case that any of those labels for side branches named
> `onto', git will run into trouble.
>
> Correct it.
>
> Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
> ---

Looks obviously correct to me. ACK!

Thank you,
Dscho

> Sorry for the noise, I forgot to check spelling for v1
>
> And I forgot to delete From line when append to my MUA.
>
> Range-diff against v1:
> 1:  48205889b4 ! 1:  9246beacf2 sequencer: handle rebase-merge for "onto=
" message
>     @@ Metadata
>      Author: Doan Tran Cong Danh <congdanhqx@gmail.com>
>
>       ## Commit message ##
>     -    sequencer: handle rebase-merge for "onto" message
>     +    sequencer: handle rebase-merges for "onto" message
>
>          In order to work correctly, git-rebase --rebase-merges needs to=
 make
>          initial todo list with unique labels.
>
>          Those unique labels is being handled by employing a hashmap and
>     -    suffixing an unique number if any duplicate is found.
>     +    appending an unique number if any duplicate is found.
>
>     -    But we forgat that beside of those labels for side branches,
>     -    we also make a special label `onto' for our so-called new-base.
>     +    But, we forget that beside those labels for side branches,
>     +    we also have a special label `onto' for our so-called new-base.
>
>          In a special case that any of those labels for side branches na=
med
>          `onto', git will run into trouble.
>
>  sequencer.c              |  5 +++++
>  t/t3430-rebase-merges.sh | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 350045b1b4..fc81e43f0f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4569,10 +4569,15 @@ static int make_script_with_merges(struct pretty=
_print_context *pp,
>  	strbuf_init(&state.buf, 32);
>
>  	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
> +		struct labels_entry *onto_label_entry;
>  		struct object_id *oid =3D &revs->cmdline.rev[0].item->oid;
>  		FLEX_ALLOC_STR(entry, string, "onto");
>  		oidcpy(&entry->entry.oid, oid);
>  		oidmap_put(&state.commit2label, entry);
> +
> +		FLEX_ALLOC_STR(onto_label_entry, label, "onto");
> +		hashmap_entry_init(&onto_label_entry->entry, strihash("onto"));
> +		hashmap_add(&state.labels, &onto_label_entry->entry);
>  	}
>
>  	/*
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index f728aba995..4e2c0ede51 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -474,4 +474,25 @@ test_expect_success '--rebase-merges with commit th=
at can generate bad character
>  	git rebase --rebase-merges --force-rebase E
>  '
>
> +test_expect_success '--rebase-merges with message matched with onto lab=
el' '
> +	git checkout -b onto-label E &&
> +	git merge -m onto G &&
> +	git rebase --rebase-merges --force-rebase E &&
> +	test_cmp_graph <<-\EOF
> +	*   onto
> +	|\
> +	| * G
> +	| * F
> +	* |   E
> +	|\ \
> +	| * | B
> +	* | | D
> +	| |/
> +	|/|
> +	* | C
> +	|/
> +	* A
> +	EOF
> +'
> +
>  test_done
> --
> 2.24.0.10.gc61c3b979f.dirty
>
>
