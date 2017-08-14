Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F077F208C4
	for <e@80x24.org>; Mon, 14 Aug 2017 22:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbdHNWvG (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:51:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54549 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752601AbdHNWvF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:51:05 -0400
Received: from [192.168.178.10] ([178.5.92.189]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MF9xL-1dngnU1vgp-00GLho for <git@vger.kernel.org>; Tue, 15 Aug 2017 00:51:03
 +0200
From:   ch <cr@onlinehome.de>
Subject: Add --ignore-missing to git-pack-objects?
To:     git@vger.kernel.org
Message-ID: <7d7a5801-1418-cc03-6d88-c148a38fccec@onlinehome.de>
Date:   Tue, 15 Aug 2017 00:51:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:/nU9DGmpYfxgj5RpfGhr03hwH/9cSm54t5VEaUZ+ETIHxQq5l2V
 3S2w8asNYyv/y0AiUjpSj+4p1cq3oazHySOZQSEiIMeNnpTBRjuhfUPXe0wU8o090XovHQj
 DQRr00srP/CNtOkN873/QAh1+P0Ejcr06vQXWpngx25gNqzulHbdfsQ2TJm+w515tWn/rWC
 akoWRF5S/c9Pm/T86+R3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9KLJAiVajj0=:P2SNiQxgUuvENWptHXTJ9V
 LqcSAJlqF8NaFYz+pIfXlUehjh5etpvH7q7Y2BU16X/dCP+GpSB/q96X5PRWWlW8WKyZz6DXS
 Zb+RvF15i3MXJvsmoWnxd2SeYC9iLZx//v0Xly0wCyPG3eXYUmyS5ML5043WaqpX6Xst//P8d
 EZwlAASxweX97OwWrRWqVMn2nCF633TDNr3UJi8VnfBoGayJj0osNs9uQ23vs5i1/Ql1ggeG5
 B5rJwR4BBHny8RAgusXLUOXnZ+YxOJjhyPdLkWyGsCNmyImXGAJ5stSjxZ5gqiA6ZopPeoooE
 UGmWx23J2SvOTpG3lFHnbkmBWhBC/jj3KV2jozRGOO/yRvA5ynFSKrToEPxCzs8Nmi9jgRNmG
 strHnh+gD04Fpyppm+WH+ZkaWysh0U5P45Oz9tpg/zMfcZnph9BLuLd59GlRbq8xg8FbmzR9z
 Mu0a2GhSVlxDYri5cPFj6O5Pj22BRwTm3HEXOCYPe+QDlH5Czd9FGiRMCNnCv7NjPgPcQ3u0H
 nFr3tQxzM9/z4kLDR8Zur1USfEUofqb6PJtKqJqxoqLfFqC58qjdMP3p/QsLC43dEgYCSXU7Y
 A6S2IRPawoslDKwC4bDPBPcLRYwn+6/BZGmqIHUfqTJhce2xGd2Ye9RrrADMjl816tJHHewwJ
 OruviFc/TZxHrGOmwLTQFyZc49FixdCWeAHpJARmGg+SmVoqtHeQtSzxRWRYquZS4OmaHW+LU
 mt30qBJKeOu7NTG7USYX3fL3e+GYMHr3RViqCXBobSBroMq4qIOVcradDqg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

Is it possible to add an option akin to git-rev-list's '--ignore-missing' to
git-pack-objects?

I use git bundles to (incrementally) backup my repositories. My script inspects
all bundles in the backup and passes their contained refs as excludes to
git-pack-objects to build the pack for the new bundle. This works fine as long
as none of these refs have been garbage-collected in the source repository.
Something like '--ignore-missing' would be really handy here to ask
git-pack-objects to simply ignore any of the passed revs that are not present
(anymore).

Thanks in advance.
