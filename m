Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD6185A
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="QjooVZMf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L19/GM3c"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43824B7
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 12:37:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id C861C320095F;
	Sat, 14 Oct 2023 15:37:43 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sat, 14 Oct 2023 15:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697312263; x=
	1697398663; bh=8H1KP40fGhedB+FGzSG++O3FdVq1tgDeqnwdEJTLMMY=; b=Q
	jooVZMf3YXVtToiQAnWnPvXjXgezVcwrkC5E150pnBxg93z969aXiyIurFhiV6dR
	9abpnE69xnau75SK73UQlSlOWjrVxVDetRrQuCFz6MCK/IdU28q6UjrGFb1Z+NDD
	C/liYp/wyGhEm5bnkj981lXREiAM58msza1o/XLS3JWrpaw8oX3jgZ7foE6kfybp
	yKGWH0yuvK2zSHEumLeCS8XmYtC/VBGcn/or8c4zu3qQjY2xDHPCKlAJ4NTLVqfx
	oIA2yVC4xdcDTHMEQO40kD48gxg+3CL86e72SF3Rx8E0/VKsTjnZnWtiLEt44nyg
	6rv8H1kphCGHqMsuBiDHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697312263; x=1697398663; bh=8H1KP40fGhedB
	+FGzSG++O3FdVq1tgDeqnwdEJTLMMY=; b=L19/GM3cYhmle0vipCyZNDU9UPpJN
	p23573G+HbEywmL54cHXBZmbk+dQxwzxcAQ5FG48ptL3RUV45ZbmCGBTjMb32egT
	Wl997i/z9yey4ZgOEeEvQPwmgnAFcW0+fc2lvBthxiS9yhPeXBW8VmmUf2bGDV7R
	mA0/HDMkbHjnIrzMq0kocLYEp5F47Kf1WxTnsB95ayXMQmBZegIY7YiqIHbPWRVu
	XCn/5J+Q8+IIc2tLco/AnXx5i0LFDtFiwcc8SevhgdJCHVTmRwHekyVMADi1XYQW
	GVF/osmyZZCIjOktJ4dnrJkSlQgdHeOF6w+XPkYTyhWG8pQnWK6SJmHEw==
X-ME-Sender: <xms:B-4qZeEHFMlid2bKYsPXu8X650k1pQXwHkhZje_mtrmHpg_rsbpguuU>
    <xme:B-4qZfWc_UWbSIGFQoXD46q8iBUwwOdXlp_VBoLltBb54vQ5bVprZUp2mqlw77TPo
    4QOxVZFMxfApD6T_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhepof
    gfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhrihhsthhofhhf
    vghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    eqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfehleeufedtjeek
    ueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:B-4qZYJKPMeyjWtL8P2io5ayDCcGPKLb2Kd8GhZDTrd3R66JW8Avtg>
    <xmx:B-4qZYHxV7BMPKSomsPBo1bgVUj6-0UraELSeM8ntQGcPJhYGlnj3w>
    <xmx:B-4qZUV-m9WEB7V8I5TIinXygQg2dNBQXVUO6qGhVooan9nu2ymq_w>
    <xmx:B-4qZdd1I8y3zOhu6gw4JPAYJUTzLDJ6MidxQ1PKGFvpl8uc7Lf_Hw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0A8A015A0092; Sat, 14 Oct 2023 15:37:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6bb48aac-460c-4d7f-9057-40c3df0c807d@app.fastmail.com>
In-Reply-To: <2d8eca81-0415-43bf-b3c4-f1163713422b@app.fastmail.com>
References: 
 <CAKFQ_Q_P4HvCMHsg4=6ycb8r44qprhRCGSmLQf7B3_-zy28_oQ@mail.gmail.com>
 <2d8eca81-0415-43bf-b3c4-f1163713422b@app.fastmail.com>
Date: Sat, 14 Oct 2023 21:37:08 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org, "ks1322 ks1322" <ks1322@gmail.com>
Subject: Re: Bug: git grep --no-index 123 /dev/stdin crashes with SIGABRT
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023, at 20:12, Kristoffer Haugsbakk wrote:
> It looks like `setup.c:verify_filename` fails to deny paths that are not
> transitive children (or whatever the term) of the directory that git(1) is
> running in:

No, that's not it. I don't think that's the responsibility of that
function. Compare to a successful run, that is when run in a Git
repository:

    $ git grep --no-index dfddf /home
    fatal: /home: '/home' is outside repository at '/home/kristoffer/programming/git'

And that error happens at `pathspec.c:473`.

So going down into that file is not wrong.
