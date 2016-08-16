Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1850A1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 21:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbcHPVPm (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 17:15:42 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53064 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752588AbcHPVPk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2016 17:15:40 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id AC398204DB
	for <git@vger.kernel.org>; Tue, 16 Aug 2016 17:14:04 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 16 Aug 2016 17:14:04 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=fUZ0XIQc7csW2cA
	KNiNBwOfeYu8=; b=g4K0GtdSa+0AqRcxRIjdZtODnxj8RV56NFXLMrRgsmnx74U
	kYei+lXWUrSoJe3QRyKsW3cg+Ej2YAjS8FfBDKn9hjyZCrzpcrgo3T5cNFiRxlqi
	MbNDG37A3igTTvx+94sf1ghbYUZsO3eBJjDyRhjmhA20X7y8eweTQecOwNl4=
X-Sasl-enc: 0x4VQlsjBgyOv6ZtBMNFMOZJUCh12irOtLwn4k3xyuH2 1471382044
Received: from ebox.rath.org (ebox.rath.org [45.79.69.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5DE32CCDC0
	for <git@vger.kernel.org>; Tue, 16 Aug 2016 17:14:04 -0400 (EDT)
Received: from thinkpad.rath.org (thinkpad [192.168.12.2])
	by ebox.rath.org (Postfix) with ESMTPS id 7C56C388DFA
	for <git@vger.kernel.org>; Tue, 16 Aug 2016 21:14:03 +0000 (UTC)
Received: by thinkpad.rath.org (Postfix, from userid 1000)
	id 37AA2BFFAB; Tue, 16 Aug 2016 14:14:03 -0700 (PDT)
From:	Nikolaus Rath <Nikolaus@rath.org>
To:	git@vger.kernel.org
Subject: Re: Working with zip files
References: <87y43wwujd.fsf@thinkpad.rath.org>
	<alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz>
Mail-Copies-To:	never
Mail-Followup-To: git@vger.kernel.org
Date:	Tue, 16 Aug 2016 14:14:03 -0700
In-Reply-To: <alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz> (David
	Lang's message of "Tue, 16 Aug 2016 09:27:55 -0700 (PDT)")
Message-ID: <87pop8wh5w.fsf@thinkpad.rath.org>
User-Agent: Gnus/5.130014 (Ma Gnus v0.14) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Aug 16 2016, David Lang <david@lang.hm> wrote:
> On Tue, 16 Aug 2016, Nikolaus Rath wrote:
>
>> I would like to store Simulink models in a Git
>> repository. Unfortunately, the file format is binary. But luckily, the
>> binary format happens to be a zipfile containing nicely formatted XML
>> files.
>>
>> Is there a way to teach Git to take advantage of this when storing,
>> diff-ing and merging these files?
>
> you should be able to use clean/smudge to have git store the files
> uncompressed, which will help a lot.

Having looked at that, I'm not sure if this really helps:

As I understand, the smudge command is run on checkout to convert the
blob in the repository to the format that is desired in the working
tree. But this is the opposite of what I need: on checkout, I need to
convert the text data in the repository to a blob in the working tree.

Furthermore, I need to convert multiple text files into one blob, will
smudge/clean seem to do just 1:1 conversions.

Am I missing something? Are there any other options?

Best,
Nikolaus
--=20
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
