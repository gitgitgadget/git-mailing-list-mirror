Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC64E20954
	for <e@80x24.org>; Sat, 25 Nov 2017 15:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbdKYPwj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 25 Nov 2017 10:52:39 -0500
Received: from elephants.elehost.com ([216.66.27.132]:40746 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdKYPwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 10:52:38 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.136.74])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vAPFqaQp067259
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 25 Nov 2017 10:52:36 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Roberto Garcia'" <eltitorober1985@gmail.com>,
        <git@vger.kernel.org>
References: <CAOeKBwpUDD_C5mQ54Aa2pj72aVkp9F2rkmGrSVMC81d6gJQRew@mail.gmail.com>
In-Reply-To: <CAOeKBwpUDD_C5mQ54Aa2pj72aVkp9F2rkmGrSVMC81d6gJQRew@mail.gmail.com>
Subject: RE: Clone repository computer A to remote B doenst work
Date:   Sat, 25 Nov 2017 10:52:30 -0500
Message-ID: <003d01d36605$69bfe650$3d3fb2f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJyk4axk6nN5o+atRiRi+NPoJ3t2aHm4hDA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 25, 2017 4:31 AM Roberto Garcia wrote:

>I'm trying clone in windows a git repository to other remote machine (NAS Linux based).
>I have installed git for windows but i didn't installed nothing in the other remote machine (NAS Linux based).

You have two choices:
1. Install git on your LINYX machine, which you probably can't do if it's a pure NAS outside of your control.
2. Run everything off Windows as git in local mode. Mount the NAS as a windows drive. In a command terminal:
	a. cd X:\Share\repo.git #you'll have to mkdir this
	b. git init --bare #creates a new empty repo on your NAS
	c. cd C:\MyStuff #where you keep your clones
	d. git clone -l X:\Share\repo.git #clone the bare repository
	e. Start adding stuff (git add, git commit)
	f. git push   # to move commits to your NAS repo.

Then you have your relationship and can push/pull from your NAS entirely from within Windows executing objects. Change directories and drive letters accordingly. -l means local, so git won't be starting any git-upload-pack processes remotely. Variations on this should work.

Good luck.

Randall

