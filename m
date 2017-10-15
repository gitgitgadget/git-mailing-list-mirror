Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3EC20437
	for <e@80x24.org>; Sun, 15 Oct 2017 10:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbdJOKCq (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 06:02:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:61579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbdJOKCp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 06:02:45 -0400
Received: from [192.168.58.45] ([88.69.19.41]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MLEXd-1e3Olu0LVh-000ITd for <git@vger.kernel.org>; Sun, 15 Oct 2017 12:02:43
 +0200
To:     git@vger.kernel.org
From:   Thomas Rikl <trikl@online.de>
Subject: Bug: git ls-remote -h / --head results differ in output
Message-ID: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
Date:   Sun, 15 Oct 2017 12:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de_DE
X-Provags-ID: V03:K0:Ns5eO8VxVeS5SexQpHjHOKnwcKbBo66t5FpcuEDmfQALNoYVaCk
 pL5uxcutn1gnVb37vRFNxZNHotfeV64couGyioHr7MUB+lXII+Gx5ZsLd/G4PwdRivoECHR
 vDNSGM3zP5hFFtddxPjFaLc0GKJkZlK6Gx28EoIhfUc6bd+sqUP2SeUoTNx2S8G+RaAxxcq
 rozBGHaSfyPL0UB/Si24A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZjyJ9I+tDiI=:4SCbPuFmLhpuKGUqoH2JBO
 lwDeEStQzFh26QCHTVaiiKjgZDLIzaepn/8mptnJUuMTTDfuWVVf3mXdiUaWKcE1OZ4XQOnGF
 C9kQSEUv15G/3xZMu4Gv+AZcXy+meJQemhqlCDTPyxvaYwQK7UWE7mo9vWqhD7XtxmXwxgsE+
 qziQ/kZYq7EoIhGnpkxC+QDEAp2EuGR7/QZNQkjGZF1Z4N3mhZ5g1HtBcXocaO7ut0MlnFjjo
 +2izuItJDmiSz02F1Qvx/M0UHXK6pjqoEr0r4cJ5qVz7AZ7wC5DPgms6qo804Q0M2/pssmWEI
 aQ6fIV/B1GvJfiBuwMLi3gOaGRZ7NCcx/hy+RMspbFCb7fgNgiIVmY7Imv9tp4gOAcvfPK5Tn
 Zhg5OUpB2C7RQ00rdbQKxupXFUlkSPO9HNDAtOHX9IAVcNFWqD8BIP95+ksgdFnv590nNrt6w
 PHG2RQbweBa5NxrcKcnfmCGPpZbtpoRv3B81p5VxhJyfsCEWjYgdo/wyQyNwGHN9s4GgFZSHb
 a/1nvAHcBq2b8iO6d+81HPVOUc6+xcMw2J+oZ8tln2D6Xst7zAfSy5muAdU3FQFg3PMZ0M+6w
 WyGU0MXW7kUioIZFwh4cDF2L+sGzSMggHEmkKLsZv1mmFWfARSKmC/GGUn0DUB7p/8uehrECn
 8ZOYEU1HSIdsAwRH5s0FiS6QN68ybhIfxwy7O9p21P4VOMRIuSWvUWdoIhNB+Se3r0Tu3NAB2
 RCjkTBvLpJP9tjFnaAP2ucWGWnoIXkZRR1JQH8LnSeXgmaPQm1beyjbR3Es=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Example:

tom1 ~/emacs/spacemacs/.emacs.d $ export LANG=en_US.utf8

tom1 ~/emacs/spacemacs/.emacs.d $ git ls-remote -h
usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]
                      [-q | --quiet] [--exit-code] [--get-url]
                      [--symref] [<repository> [<refs>...]]

     -q, --quiet           do not print remote URL
     --upload-pack <exec>  path of git-upload-pack on the remote host
     -t, --tags            limit to tags
     -h, --heads           limit to heads
     --refs                do not show peeled tags
     --get-url             take url.<base>.insteadOf into account
     --exit-code           exit with exit code 2 if no matching refs are 
found
     --symref              show underlying ref in addition to the object 
pointed by it

tom1 ~/emacs/spacemacs/.emacs.d $ git ls-remote --head
 From https://github.com/syl20bnr/spacemacs
07014deead544c51fa6a826e91fe2ef05bf04323 refs/heads/develop
8e1af145480d53e8d32cdff2c83291889903164b refs/heads/master
2450b7e276634ece07b6b7ec6ca6c287af86caf3 refs/heads/release-0.101
8dadfc1494544bb152e80c2a436e43bc3713b389 refs/heads/release-0.102
d993a021847cde2c42865bab6afa8adbb2edda0b refs/heads/release-0.103
44d4525543b1f2a385142721d0cb16cd3b0be580 refs/heads/release-0.104
9f9faa404e3dec3e08cc73cf7b5a0439fc309800 refs/heads/release-0.105
8e1af145480d53e8d32cdff2c83291889903164b refs/heads/release-0.200
tom1 ~/emacs/spacemacs/.emacs.d $ git --version
git version 2.14.2

on archlinux: Linux achse 4.13.5-1-ARCH #1 SMP PREEMPT Fri Oct 6 
09:58:47 CEST 2017 x86_64 GNU/Linux

