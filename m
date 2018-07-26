Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 802251F597
	for <e@80x24.org>; Thu, 26 Jul 2018 14:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeGZPb0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 11:31:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:58841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbeGZPbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 11:31:25 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRGPP-1fZ2GL26E3-00UdJs; Thu, 26
 Jul 2018 16:14:18 +0200
Date:   Thu, 26 Jul 2018 16:14:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] negotiator/skipping: skip commits during fetch
In-Reply-To: <nycvar.QRO.7.76.6.1807261233300.71@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1807261613420.71@tvgsbejvaqbjf.bet>
References: <20180716184401.168576-1-jonathantanmy@google.com> <nycvar.QRO.7.76.6.1807261233300.71@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RXxiBDGpa9PKoaMr6Oz1n4vTRDoZGIZWXPK3mjX2DKkHlqZXyiM
 d5Bmm0//UmmwEGjPtlhG75PeMlFoGMH9CAI+6oU6afn3euHfAWvKJenI0hXweYFhYGMtZ25
 nAWQMHNqqH6Vl8SQec6H0gh7p8PjYDcSHytfJKZZTAq3bXz+qCu5ut/HPMOoEz2QYBFZ8aL
 PgYCZK3kL36+ippVLrwbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XaeC6Cdc0wg=:UcqNKYRvZDhIwakKR4nvke
 D1adNAYyNOojWvG1yf7UqGAYHSU0nga9yQywwSprzpUit/nn3Cp2MPkuk6/aIz43xeeMJEwY0
 LCJ0mpjrdhbGj8va+YZ5VbMdzxy/lofGAfqHXMGw8YCImSpE1WX6XPWr+7fLxwM+p14X8gNM8
 +hu7in4iDBnmvTfAr3cKPyGdQbgZUF5aZpkVoCcYzVNP6DxkDvi0QaECopOZFfZdON3tIKNM4
 UigteikqZkZNYnz3W4ACTuMJ8YoBsB2hxUrG1VnqUqNrfzThsnAFybPiqMmFO/Ij6NDdkuOaH
 d8+yUgoBOZzKgcrCaDAGMSoZz4XgKWxRq82p1oqjjXLsWfJqIC8QEt/DIyob1cF5oCR86TbxN
 mypIvAWRq3Kv248G6pLtmWv9WhZaJL9FI/45glZ9foJdDAN2ZFLARolJU7kzN8FYk+DlbOPe+
 6RhfMCBqa28al5GKZaM9fjEkNpzAmRHD5E0cjGFLmVcan1KTeu+/hd0ESl3fCRzC3rxGclid2
 RmWQy3l+Jznl2zS4JJeQYI42PhJmWFd5c8VMAM/0MKnJJuXvBv56muv8zC14AVDv6r+B0MABX
 yI30smJ52ZdrfJpycFbqePfFAwFVoMveYN3P/5tTWF4eqbke8h1VgbXrNn46TbLOBaRlBxQP/
 h9in8oe2N9hDDVWVfZOGTkpGKSzYZ0XwdW+J0ch34Tg10UV0SEw5qbPFjuA3+81KhpYnrgBsB
 yVR8E6XT/17NNMCrR5JMK+hxVorjVPOBGmUU/s5yw9iW5UcF3Y+c37pilbgKpZTUHmNMokmPG
 QNsjWCj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, 26 Jul 2018, Johannes Schindelin wrote:

> On Mon, 16 Jul 2018, Jonathan Tan wrote:
> 
> >  t/t5552-skipping-fetch-negotiator.sh | 179 +++++++++++++++++++
> 
> This test seems to be failing consistently in the recent `pu` builds:
> 
> https://git-for-windows.visualstudio.com/git/_build/results?buildId=14337&view=logs

It now also causes `next` builds to fail:

https://git-for-windows.visualstudio.com/git/_build/results?buildId=14345&view=logs

Please have a look,
Dscho

> Could you have a look, please?
> 
> Ciao,
> Dscho
> 
> P.S.: For your convenience, I will paste the last part of the output with
> `-i -v -x` here:
> 
> -- snipsnap --
> 2018-07-26T08:18:39.7864833Z expecting success: 
> 2018-07-26T08:18:39.7868553Z 	rm -rf server client trace &&
> 2018-07-26T08:18:39.7869403Z 	git init server &&
> 2018-07-26T08:18:39.7869606Z 	test_commit -C server to_fetch &&
> 2018-07-26T08:18:39.7870066Z 
> 2018-07-26T08:18:39.7870281Z 	git init client &&
> 2018-07-26T08:18:39.7870403Z 
> 2018-07-26T08:18:39.7870579Z 	# 2 regular commits
> 2018-07-26T08:18:39.7870779Z 	test_tick=2000000000 &&
> 2018-07-26T08:18:39.7870943Z 	test_commit -C client c1 &&
> 2018-07-26T08:18:39.7871103Z 	test_commit -C client c2 &&
> 2018-07-26T08:18:39.7871228Z 
> 2018-07-26T08:18:39.7871419Z 	# 4 old commits
> 2018-07-26T08:18:39.7871575Z 	test_tick=1000000000 &&
> 2018-07-26T08:18:39.7871734Z 	git -C client checkout c1 &&
> 2018-07-26T08:18:39.7871916Z 	test_commit -C client old1 &&
> 2018-07-26T08:18:39.7872081Z 	test_commit -C client old2 &&
> 2018-07-26T08:18:39.7872396Z 	test_commit -C client old3 &&
> 2018-07-26T08:18:39.7872598Z 	test_commit -C client old4 &&
> 2018-07-26T08:18:39.7872743Z 
> 2018-07-26T08:18:39.7872918Z 	# "c2" and "c1" are popped first, then "old4" to "old1". "old1" would
> 2018-07-26T08:18:39.7873114Z 	# normally be skipped, but is treated as a commit without a parent here
> 2018-07-26T08:18:39.7873329Z 	# and sent, because (due to clock skew) its only parent has already been
> 2018-07-26T08:18:39.7873524Z 	# popped off the priority queue.
> 2018-07-26T08:18:39.7873700Z 	test_config -C client fetch.negotiationalgorithm skipping &&
> 2018-07-26T08:18:39.7873908Z 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
> 2018-07-26T08:18:39.7874091Z 	have_sent c2 c1 old4 old2 old1 &&
> 2018-07-26T08:18:39.7874262Z 	have_not_sent old3
> 2018-07-26T08:18:39.7874383Z 
> 2018-07-26T08:18:39.8353323Z ++ rm -rf server client trace
> 2018-07-26T08:18:40.3404166Z ++ git init server
> 2018-07-26T08:18:40.3756394Z Initialized empty Git repository in D:/a/1/s/t/trash directory.t5552-skipping-fetch-negotiator/server/.git/
> 2018-07-26T08:18:40.3769512Z ++ test_commit -C server to_fetch
> 2018-07-26T08:18:40.3776271Z ++ notick=
> 2018-07-26T08:18:40.3777103Z ++ signoff=
> 2018-07-26T08:18:40.3777282Z ++ indir=
> 2018-07-26T08:18:40.3777465Z ++ test 3 '!=' 0
> 2018-07-26T08:18:40.3777648Z ++ case "$1" in
> 2018-07-26T08:18:40.3777801Z ++ indir=server
> 2018-07-26T08:18:40.3777948Z ++ shift
> 2018-07-26T08:18:40.3778093Z ++ shift
> 2018-07-26T08:18:40.3778493Z ++ test 1 '!=' 0
> 2018-07-26T08:18:40.3778921Z ++ case "$1" in
> 2018-07-26T08:18:40.3779072Z ++ break
> 2018-07-26T08:18:40.3779241Z ++ indir=server/
> 2018-07-26T08:18:40.3779431Z ++ file=to_fetch.t
> 2018-07-26T08:18:40.3779603Z ++ echo to_fetch
> 2018-07-26T08:18:40.3779923Z ++ git -C server/ add to_fetch.t
> 2018-07-26T08:18:40.4072248Z ++ test -z ''
> 2018-07-26T08:18:40.4072727Z ++ test_tick
> 2018-07-26T08:18:40.4072948Z ++ test -z set
> 2018-07-26T08:18:40.4073113Z ++ test_tick=1112913673
> 2018-07-26T08:18:40.4073758Z ++ GIT_COMMITTER_DATE='1112913673 -0700'
> 2018-07-26T08:18:40.4074001Z ++ GIT_AUTHOR_DATE='1112913673 -0700'
> 2018-07-26T08:18:40.4074178Z ++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 2018-07-26T08:18:40.4074357Z ++ git -C server/ commit -m to_fetch
> 2018-07-26T08:18:40.4485364Z [master (root-commit) ff85695] to_fetch
> 2018-07-26T08:18:40.4485997Z  Author: A U Thor <author@example.com>
> 2018-07-26T08:18:40.4486201Z  1 file changed, 1 insertion(+)
> 2018-07-26T08:18:40.4486414Z  create mode 100644 to_fetch.t
> 2018-07-26T08:18:40.4499970Z ++ git -C server/ tag to_fetch
> 2018-07-26T08:18:40.4809208Z ++ git init client
> 2018-07-26T08:18:40.5139949Z Initialized empty Git repository in D:/a/1/s/t/trash directory.t5552-skipping-fetch-negotiator/client/.git/
> 2018-07-26T08:18:40.5158270Z ++ test_tick=2000000000
> 2018-07-26T08:18:40.5158466Z ++ test_commit -C client c1
> 2018-07-26T08:18:40.5159077Z ++ notick=
> 2018-07-26T08:18:40.5159492Z ++ signoff=
> 2018-07-26T08:18:40.5159697Z ++ indir=
> 2018-07-26T08:18:40.5159855Z ++ test 3 '!=' 0
> 2018-07-26T08:18:40.5160010Z ++ case "$1" in
> 2018-07-26T08:18:40.5160209Z ++ indir=client
> 2018-07-26T08:18:40.5160362Z ++ shift
> 2018-07-26T08:18:40.5160507Z ++ shift
> 2018-07-26T08:18:40.5160657Z ++ test 1 '!=' 0
> 2018-07-26T08:18:40.5160831Z ++ case "$1" in
> 2018-07-26T08:18:40.5161289Z ++ break
> 2018-07-26T08:18:40.5161582Z ++ indir=client/
> 2018-07-26T08:18:40.5161764Z ++ file=c1.t
> 2018-07-26T08:18:40.5161916Z ++ echo c1
> 2018-07-26T08:18:40.5162231Z ++ git -C client/ add c1.t
> 2018-07-26T08:18:40.5456318Z ++ test -z ''
> 2018-07-26T08:18:40.5460548Z ++ test_tick
> 2018-07-26T08:18:40.5461417Z ++ test -z set
> 2018-07-26T08:18:40.5463657Z ++ test_tick=2000000060
> 2018-07-26T08:18:40.5464369Z ++ GIT_COMMITTER_DATE='2000000060 -0700'
> 2018-07-26T08:18:40.5464617Z ++ GIT_AUTHOR_DATE='2000000060 -0700'
> 2018-07-26T08:18:40.5464805Z ++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 2018-07-26T08:18:40.5464988Z ++ git -C client/ commit -m c1
> 2018-07-26T08:18:40.5857440Z [master (root-commit) dc824fa] c1
> 2018-07-26T08:18:40.5858031Z  Author: A U Thor <author@example.com>
> 2018-07-26T08:18:40.5858251Z  1 file changed, 1 insertion(+)
> 2018-07-26T08:18:40.5858451Z  create mode 100644 c1.t
> 2018-07-26T08:18:40.5872839Z ++ git -C client/ tag c1
> 2018-07-26T08:18:40.6174770Z ++ test_commit -C client c2
> 2018-07-26T08:18:40.6175120Z ++ notick=
> 2018-07-26T08:18:40.6175398Z ++ signoff=
> 2018-07-26T08:18:40.6175583Z ++ indir=
> 2018-07-26T08:18:40.6175737Z ++ test 3 '!=' 0
> 2018-07-26T08:18:40.6175925Z ++ case "$1" in
> 2018-07-26T08:18:40.6176079Z ++ indir=client
> 2018-07-26T08:18:40.6176246Z ++ shift
> 2018-07-26T08:18:40.6176415Z ++ shift
> 2018-07-26T08:18:40.6176569Z ++ test 1 '!=' 0
> 2018-07-26T08:18:40.6176738Z ++ case "$1" in
> 2018-07-26T08:18:40.6176905Z ++ break
> 2018-07-26T08:18:40.6177052Z ++ indir=client/
> 2018-07-26T08:18:40.6177200Z ++ file=c2.t
> 2018-07-26T08:18:40.6177369Z ++ echo c2
> 2018-07-26T08:18:40.6177525Z ++ git -C client/ add c2.t
> 2018-07-26T08:18:40.6474943Z ++ test -z ''
> 2018-07-26T08:18:40.6479175Z ++ test_tick
> 2018-07-26T08:18:40.6479861Z ++ test -z set
> 2018-07-26T08:18:40.6482344Z ++ test_tick=2000000120
> 2018-07-26T08:18:40.6483064Z ++ GIT_COMMITTER_DATE='2000000120 -0700'
> 2018-07-26T08:18:40.6483243Z ++ GIT_AUTHOR_DATE='2000000120 -0700'
> 2018-07-26T08:18:40.6483412Z ++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 2018-07-26T08:18:40.6483597Z ++ git -C client/ commit -m c2
> 2018-07-26T08:18:40.6883597Z [master 9ab4692] c2
> 2018-07-26T08:18:40.6884552Z  Author: A U Thor <author@example.com>
> 2018-07-26T08:18:40.6884902Z  1 file changed, 1 insertion(+)
> 2018-07-26T08:18:40.6885078Z  create mode 100644 c2.t
> 2018-07-26T08:18:40.6898418Z ++ git -C client/ tag c2
> 2018-07-26T08:18:40.7214970Z ++ test_tick=1000000000
> 2018-07-26T08:18:40.7215737Z ++ git -C client checkout c1
> 2018-07-26T08:18:40.7537971Z Note: checking out 'c1'.
> 2018-07-26T08:18:40.7538294Z 
> 2018-07-26T08:18:40.7538485Z You are in 'detached HEAD' state. You can look around, make experimental
> 2018-07-26T08:18:40.7538901Z changes and commit them, and you can discard any commits you make in this
> 2018-07-26T08:18:40.7539153Z state without impacting any branches by performing another checkout.
> 2018-07-26T08:18:40.7539288Z 
> 2018-07-26T08:18:40.7539455Z If you want to create a new branch to retain commits you create, you may
> 2018-07-26T08:18:40.7539646Z do so (now or later) by using -b with the checkout command again. Example:
> 2018-07-26T08:18:40.7539799Z 
> 2018-07-26T08:18:40.7539979Z   git checkout -b <new-branch-name>
> 2018-07-26T08:18:40.7540099Z 
> 2018-07-26T08:18:40.7540264Z HEAD is now at dc824fa c1
> 2018-07-26T08:18:40.7552832Z ++ test_commit -C client old1
> 2018-07-26T08:18:40.7559118Z ++ notick=
> 2018-07-26T08:18:40.7559789Z ++ signoff=
> 2018-07-26T08:18:40.7559966Z ++ indir=
> 2018-07-26T08:18:40.7560066Z ++ test 3 '!=' 0
> 2018-07-26T08:18:40.7565193Z ++ case "$1" in
> 2018-07-26T08:18:40.7565286Z ++ indir=client
> 2018-07-26T08:18:40.7565373Z ++ shift
> 2018-07-26T08:18:40.7565456Z ++ shift
> 2018-07-26T08:18:40.7566662Z ++ test 1 '!=' 0
> 2018-07-26T08:18:40.7566796Z ++ case "$1" in
> 2018-07-26T08:18:40.7566879Z ++ break
> 2018-07-26T08:18:40.7566961Z ++ indir=client/
> 2018-07-26T08:18:40.7567066Z ++ file=old1.t
> 2018-07-26T08:18:40.7567150Z ++ echo old1
> 2018-07-26T08:18:40.7567238Z ++ git -C client/ add old1.t
> 2018-07-26T08:18:40.7962371Z ++ test -z ''
> 2018-07-26T08:18:40.7962668Z ++ test_tick
> 2018-07-26T08:18:40.7963247Z ++ test -z set
> 2018-07-26T08:18:40.7963453Z ++ test_tick=1000000060
> 2018-07-26T08:18:40.7963649Z ++ GIT_COMMITTER_DATE='1000000060 -0700'
> 2018-07-26T08:18:40.7963832Z ++ GIT_AUTHOR_DATE='1000000060 -0700'
> 2018-07-26T08:18:40.7964000Z ++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 2018-07-26T08:18:40.7964164Z ++ git -C client/ commit -m old1
> 2018-07-26T08:18:40.8356576Z [detached HEAD e9a2c09] old1
> 2018-07-26T08:18:40.8357378Z  Author: A U Thor <author@example.com>
> 2018-07-26T08:18:40.8357554Z  1 file changed, 1 insertion(+)
> 2018-07-26T08:18:40.8357652Z  create mode 100644 old1.t
> 2018-07-26T08:18:40.8372002Z ++ git -C client/ tag old1
> 2018-07-26T08:18:40.8671359Z ++ test_commit -C client old2
> 2018-07-26T08:18:40.8676749Z ++ notick=
> 2018-07-26T08:18:40.8677398Z ++ signoff=
> 2018-07-26T08:18:40.8679262Z ++ indir=
> 2018-07-26T08:18:40.8679957Z ++ test 3 '!=' 0
> 2018-07-26T08:18:40.8680150Z ++ case "$1" in
> 2018-07-26T08:18:40.8680305Z ++ indir=client
> 2018-07-26T08:18:40.8680447Z ++ shift
> 2018-07-26T08:18:40.8680587Z ++ shift
> 2018-07-26T08:18:40.8680798Z ++ test 1 '!=' 0
> 2018-07-26T08:18:40.8680949Z ++ case "$1" in
> 2018-07-26T08:18:40.8681143Z ++ break
> 2018-07-26T08:18:40.8681311Z ++ indir=client/
> 2018-07-26T08:18:40.8681458Z ++ file=old2.t
> 2018-07-26T08:18:40.8681604Z ++ echo old2
> 2018-07-26T08:18:40.8681789Z ++ git -C client/ add old2.t
> 2018-07-26T08:18:40.8990053Z ++ test -z ''
> 2018-07-26T08:18:40.8990392Z ++ test_tick
> 2018-07-26T08:18:40.8990953Z ++ test -z set
> 2018-07-26T08:18:40.8991246Z ++ test_tick=1000000120
> 2018-07-26T08:18:40.8991421Z ++ GIT_COMMITTER_DATE='1000000120 -0700'
> 2018-07-26T08:18:40.8991585Z ++ GIT_AUTHOR_DATE='1000000120 -0700'
> 2018-07-26T08:18:40.8991771Z ++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 2018-07-26T08:18:40.8991936Z ++ git -C client/ commit -m old2
> 2018-07-26T08:18:40.9402744Z [detached HEAD 41bd8dc] old2
> 2018-07-26T08:18:40.9403286Z  Author: A U Thor <author@example.com>
> 2018-07-26T08:18:40.9403510Z  1 file changed, 1 insertion(+)
> 2018-07-26T08:18:40.9403678Z  create mode 100644 old2.t
> 2018-07-26T08:18:40.9418122Z ++ git -C client/ tag old2
> 2018-07-26T08:18:40.9736807Z ++ test_commit -C client old3
> 2018-07-26T08:18:40.9737058Z ++ notick=
> 2018-07-26T08:18:40.9737152Z ++ signoff=
> 2018-07-26T08:18:40.9737238Z ++ indir=
> 2018-07-26T08:18:40.9737327Z ++ test 3 '!=' 0
> 2018-07-26T08:18:40.9737600Z ++ case "$1" in
> 2018-07-26T08:18:40.9737690Z ++ indir=client
> 2018-07-26T08:18:40.9737776Z ++ shift
> 2018-07-26T08:18:40.9737860Z ++ shift
> 2018-07-26T08:18:40.9737964Z ++ test 1 '!=' 0
> 2018-07-26T08:18:40.9738054Z ++ case "$1" in
> 2018-07-26T08:18:40.9738140Z ++ break
> 2018-07-26T08:18:40.9738248Z ++ indir=client/
> 2018-07-26T08:18:40.9738338Z ++ file=old3.t
> 2018-07-26T08:18:40.9738445Z ++ echo old3
> 2018-07-26T08:18:40.9738540Z ++ git -C client/ add old3.t
> 2018-07-26T08:18:41.0035565Z ++ test -z ''
> 2018-07-26T08:18:41.0036056Z ++ test_tick
> 2018-07-26T08:18:41.0036299Z ++ test -z set
> 2018-07-26T08:18:41.0036467Z ++ test_tick=1000000180
> 2018-07-26T08:18:41.0036638Z ++ GIT_COMMITTER_DATE='1000000180 -0700'
> 2018-07-26T08:18:41.0037189Z ++ GIT_AUTHOR_DATE='1000000180 -0700'
> 2018-07-26T08:18:41.0037403Z ++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 2018-07-26T08:18:41.0037574Z ++ git -C client/ commit -m old3
> 2018-07-26T08:18:41.0429238Z [detached HEAD 4ff0db5] old3
> 2018-07-26T08:18:41.0429619Z  Author: A U Thor <author@example.com>
> 2018-07-26T08:18:41.0429799Z  1 file changed, 1 insertion(+)
> 2018-07-26T08:18:41.0429965Z  create mode 100644 old3.t
> 2018-07-26T08:18:41.0443795Z ++ git -C client/ tag old3
> 2018-07-26T08:18:41.0752553Z ++ test_commit -C client old4
> 2018-07-26T08:18:41.0752824Z ++ notick=
> 2018-07-26T08:18:41.0752936Z ++ signoff=
> 2018-07-26T08:18:41.0753905Z ++ indir=
> 2018-07-26T08:18:41.0754193Z ++ test 3 '!=' 0
> 2018-07-26T08:18:41.0754374Z ++ case "$1" in
> 2018-07-26T08:18:41.0754531Z ++ indir=client
> 2018-07-26T08:18:41.0754682Z ++ shift
> 2018-07-26T08:18:41.0754828Z ++ shift
> 2018-07-26T08:18:41.0755007Z ++ test 1 '!=' 0
> 2018-07-26T08:18:41.0755162Z ++ case "$1" in
> 2018-07-26T08:18:41.0755340Z ++ break
> 2018-07-26T08:18:41.0755491Z ++ indir=client/
> 2018-07-26T08:18:41.0755664Z ++ file=old4.t
> 2018-07-26T08:18:41.0755814Z ++ echo old4
> 2018-07-26T08:18:41.0755971Z ++ git -C client/ add old4.t
> 2018-07-26T08:18:41.1064316Z ++ test -z ''
> 2018-07-26T08:18:41.1064885Z ++ test_tick
> 2018-07-26T08:18:41.1065169Z ++ test -z set
> 2018-07-26T08:18:41.1065432Z ++ test_tick=1000000240
> 2018-07-26T08:18:41.1065637Z ++ GIT_COMMITTER_DATE='1000000240 -0700'
> 2018-07-26T08:18:41.1065820Z ++ GIT_AUTHOR_DATE='1000000240 -0700'
> 2018-07-26T08:18:41.1066008Z ++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 2018-07-26T08:18:41.1066212Z ++ git -C client/ commit -m old4
> 2018-07-26T08:18:41.1488203Z [detached HEAD caef059] old4
> 2018-07-26T08:18:41.1488670Z  Author: A U Thor <author@example.com>
> 2018-07-26T08:18:41.1489153Z  1 file changed, 1 insertion(+)
> 2018-07-26T08:18:41.1489370Z  create mode 100644 old4.t
> 2018-07-26T08:18:41.1502887Z ++ git -C client/ tag old4
> 2018-07-26T08:18:41.1824546Z ++ test_config -C client fetch.negotiationalgorithm skipping
> 2018-07-26T08:18:41.1825670Z ++ config_dir=
> 2018-07-26T08:18:41.1826072Z ++ test -C = -C
> 2018-07-26T08:18:41.1826299Z ++ shift
> 2018-07-26T08:18:41.1826528Z ++ config_dir=client
> 2018-07-26T08:18:41.1826809Z ++ shift
> 2018-07-26T08:18:41.1827079Z ++ test_when_finished 'test_unconfig -C '\''client'\'' '\''fetch.negotiationalgorithm'\'''
> 2018-07-26T08:18:41.1827289Z ++ test 0 = 0
> 2018-07-26T08:18:41.1827561Z ++ test_cleanup='{ test_unconfig -C '\''client'\'' '\''fetch.negotiationalgorithm'\''
> 2018-07-26T08:18:41.1827751Z 		} && (exit "$eval_ret"); eval_ret=$?; :'
> 2018-07-26T08:18:41.1827930Z ++ git -C client config fetch.negotiationalgorithm skipping
> 2018-07-26T08:18:41.2196451Z +++ pwd
> 2018-07-26T08:18:41.2196831Z +++ builtin pwd -W
> 2018-07-26T08:18:41.2274040Z +++ pwd
> 2018-07-26T08:18:41.2274458Z +++ builtin pwd -W
> 2018-07-26T08:18:41.2285081Z ++ GIT_TRACE_PACKET='D:/a/1/s/t/trash directory.t5552-skipping-fetch-negotiator/trace'
> 2018-07-26T08:18:41.2285515Z ++ git -C client fetch 'D:/a/1/s/t/trash directory.t5552-skipping-fetch-negotiator/server'
> 2018-07-26T08:18:41.3054360Z warning: no common commits
> 2018-07-26T08:18:41.3264762Z From D:/a/1/s/t/trash directory.t5552-skipping-fetch-negotiator/server
> 2018-07-26T08:18:41.3265204Z  * branch            HEAD       -> FETCH_HEAD
> 2018-07-26T08:18:41.3362819Z ++ have_sent c2 c1 old4 old2 old1
> 2018-07-26T08:18:41.3370525Z ++ test 5 -ne 0
> 2018-07-26T08:18:41.3423124Z +++ git -C client rev-parse c2
> 2018-07-26T08:18:41.3756643Z ++ grep 'fetch> have 9ab46928dc282aa09f4dbf96893a252e058e7e8e' trace
> 2018-07-26T08:18:41.3878403Z packet:        fetch> have 9ab46928dc282aa09f4dbf96893a252e058e7e8e
> 2018-07-26T08:18:41.3883984Z ++ test 0 -ne 0
> 2018-07-26T08:18:41.3884900Z ++ shift
> 2018-07-26T08:18:41.3885199Z ++ test 4 -ne 0
> 2018-07-26T08:18:41.3938298Z +++ git -C client rev-parse c1
> 2018-07-26T08:18:41.4243782Z ++ grep 'fetch> have dc824fafb05f3229aedf1f320bbe572e35364dfe' trace
> 2018-07-26T08:18:41.4375402Z packet:        fetch> have dc824fafb05f3229aedf1f320bbe572e35364dfe
> 2018-07-26T08:18:41.4383803Z ++ test 0 -ne 0
> 2018-07-26T08:18:41.4384733Z ++ shift
> 2018-07-26T08:18:41.4385018Z ++ test 3 -ne 0
> 2018-07-26T08:18:41.4436622Z +++ git -C client rev-parse old4
> 2018-07-26T08:18:41.4749084Z ++ grep 'fetch> have caef059de69917b9119176a11b88afcef769331d' trace
> 2018-07-26T08:18:41.4888266Z ++ test 1 -ne 0
> 2018-07-26T08:18:41.4941092Z +++ git -C client rev-parse old4
> 2018-07-26T08:18:41.5253206Z ++ echo 'No have caef059de69917b9119176a11b88afcef769331d (old4)'
> 2018-07-26T08:18:41.5253602Z ++ return 1
> 2018-07-26T08:18:41.5254746Z error: last command exited with $?=1
> 2018-07-26T08:18:41.5254865Z No have caef059de69917b9119176a11b88afcef769331d (old4)
> 2018-07-26T08:18:41.5260970Z not ok 4 - handle clock skew
> 2018-07-26T08:18:41.5441990Z #	
> 2018-07-26T08:18:41.5442184Z #		rm -rf server client trace &&
> 2018-07-26T08:18:41.5442422Z #		git init server &&
> 2018-07-26T08:18:41.5448007Z #		test_commit -C server to_fetch &&
> 2018-07-26T08:18:41.5448223Z #	
> 2018-07-26T08:18:41.5448357Z #		git init client &&
> 2018-07-26T08:18:41.5448466Z #	
> 2018-07-26T08:18:41.5448661Z #		# 2 regular commits
> 2018-07-26T08:18:41.5448810Z #		test_tick=2000000000 &&
> 2018-07-26T08:18:41.5449231Z #		test_commit -C client c1 &&
> 2018-07-26T08:18:41.5449393Z #		test_commit -C client c2 &&
> 2018-07-26T08:18:41.5449509Z #	
> 2018-07-26T08:18:41.5449679Z #		# 4 old commits
> 2018-07-26T08:18:41.5449859Z #		test_tick=1000000000 &&
> 2018-07-26T08:18:41.5450017Z #		git -C client checkout c1 &&
> 2018-07-26T08:18:41.5450220Z #		test_commit -C client old1 &&
> 2018-07-26T08:18:41.5450343Z #		test_commit -C client old2 &&
> 2018-07-26T08:18:41.5450449Z #		test_commit -C client old3 &&
> 2018-07-26T08:18:41.5450667Z #		test_commit -C client old4 &&
> 2018-07-26T08:18:41.5450821Z #	
> 2018-07-26T08:18:41.5450954Z #		# "c2" and "c1" are popped first, then "old4" to "old1". "old1" would
> 2018-07-26T08:18:41.5451133Z #		# normally be skipped, but is treated as a commit without a parent here
> 2018-07-26T08:18:41.5451392Z #		# and sent, because (due to clock skew) its only parent has already been
> 2018-07-26T08:18:41.5451547Z #		# popped off the priority queue.
> 2018-07-26T08:18:41.5451675Z #		test_config -C client fetch.negotiationalgorithm skipping &&
> 2018-07-26T08:18:41.5451829Z #		GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
> 2018-07-26T08:18:41.5451961Z #		have_sent c2 c1 old4 old2 old1 &&
> 2018-07-26T08:18:41.5452091Z #		have_not_sent old3
> 2018-07-26T08:18:41.5452186Z #	
> 
