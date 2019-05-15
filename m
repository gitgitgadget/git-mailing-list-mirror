Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47AA1F461
	for <e@80x24.org>; Wed, 15 May 2019 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfEOPAS (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 11:00:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:42433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfEOPAR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 11:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557932411;
        bh=IOlMHGT9XfsTmyk+24bAI/5+iOs/Y6K16w6pA5YW5ZI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PT31hHrvTeeB3q24dhLFGIUex6O7oEExzENCxO7owejCyDbuhkc96c1Q84g7eEK/s
         YIUuM9sh/o5C6pJMXaNROQhyAofBNkx5c5ow2PI65p4I6iACoXZnPWTyAI1sXPs/WC
         miRcFLOT8yDfQc0P+Lr4gNKjAUskQcroFy7suPpk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.190.205] ([95.208.59.243]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M70Td-1gV88N41GH-00wp54; Wed, 15
 May 2019 17:00:11 +0200
Date:   Wed, 15 May 2019 17:00:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] merge: add --quit
In-Reply-To: <xmqqlfz877ba.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905151658090.46@tvgsbejvaqbjf.bet>
References: <20190509101028.24656-1-pclouds@gmail.com> <20190514091322.12427-1-pclouds@gmail.com> <20190514091322.12427-3-pclouds@gmail.com> <nycvar.QRO.7.76.6.1905141540300.44@tvgsbejvaqbjf.bet> <xmqqlfz877ba.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OTib8kkGxpWgCzwpjbTuHIXOL0Y7Mj5EpzXFYbi8Y0/zZpXSyd7
 pmXCC6/pJTJf+VMi3GU3MpV2WBJSQaNIfhvIU3smFkJpSC2QDCq3WYULPd7lpc0dxY8L3Ck
 3hdXiU6s4JHih5roi/RYhhgr0KIb3OsKxQCPsxg7qnJ2TksKGMxKBaoW7GUjFLLbAJjizA8
 4a4uHfQn4xmsStx195WEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hvKZXnJMygY=:QA/7gU1AMUEMtcMZDcfpo3
 +meZPKlGTIO5FsliEm9y1A9drDgsDCnO9lWHHSpaQA5Yf1VCDN9wnwwaDG0ZQCi7Z7Qb1pKtQ
 Ds6HM++9+xAWrIiBA4Eef04CzdnCzuLotafTb0VFwvhQYupHksVCzdex5EsLy6GktdwJwX50Z
 QQpd96B/bXCAFftm3+kemv4E+fqzI9Fzi9UX3/1eEru10KbPACydM0mq+eJzE3kiX++YTBgnQ
 d762VtI9eiUVH2jUOoqyvsGANlhNS8EnjS4EpAqgxa/o/e7t/Z7abVmlyq89Bc/uTAe+CRVBz
 6zbYlGbreCajCnOVIrN21enSe5Yey+cmtu47gNJABHVbdIWDUzJ3mp3a1GUCyH23IPe4aVYLV
 k2qcO83Hyg81hQarufwj3yW8Vwd75pOVsPQ/wFrY8g+NjcGl4BGhcWuoMYSRzZ2Tc7RnoJ5M1
 BxUmVrr5CHjv9t4dDsAhz0N/ZWhiDMfDwW7dcuNJF1qGWMEWK6K3VofCa4oNm9QyM+M3ekDST
 9dsJRUEzO15aK0/yriahJrdQZ+bmIVoZnABtAtfuK+fVYbfmtS7dYOoBspXmIuDGcD2YEEVb9
 ed6JuoAJJfmGx7H1sNsu8Lp7Psqg7Ee1ZFjJGLjEpSeQAe0P7YEQ0F8772qoyWB12zB8DCf9W
 Z89SRSRT78gqGaWKIpYBFoi3+wufMRoI4kW0jOQGoVZEbMLJqtUHWqieN/LOf2BQ2zecORIgd
 lKC+3B+HtrNRjushqZiYIj1oD9RAHadyTCFh+ATIPMbThhiZbpRMgqLaytD/vuWMjpO2CNDZa
 Z7pv3/Vzgkib6fBAP/QsoCdynfcdnmGqQlUIgXtK++TNnlql1NARhaWV27qkkvKeSzmGY66qO
 RqAb3vpevWbE2GXHBdOYe3iRQmdAkFGe4Y7HGu4okZ+L1jGjAc4Ulp+QFrep/qlZKoE+W+04q
 SkmIb7q9IDA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 15 May 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> +	test_path_is_file .git/MERGE_HEAD &&
> >> +	test_path_is_file .git/MERGE_MODE &&
> >> +	test_path_is_file .git/MERGE_MSG &&
> >> +	test_path_is_file .git/MERGE_RR &&
> >
> > Isn't this a clear implementation details of `git rerere` that you jus=
t
> > taught `git merge`'s regression test?
> > ...
> > It would probably make a ton more sense to look at the output of `git
> > rerere status` instead.
>
> While I understand your concern, it is not the business of this test
> to detect a bug in "git rerere status", either.  The safest thing to
> do would be to test both ;-)
>
> t4151 that tests "am --abort" already looks at MERGE_RR for the same
> "we want to make sure that the rerere state is cleared" purpose, so
> I'd not be worried too much about this particular test.

I spend *way* too much time chasing regression test failures that turn out
not to show any bugs in the code they want to safeguard, but instead the
bugs are found in the *assumptions* of the regression tests. So much time,
in fact, that I have to disagree with you here. t4151 is just as wrong.

Ciao,
Dscho
