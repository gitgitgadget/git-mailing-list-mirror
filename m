Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49277E
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="B0rm1bUu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2OCVIU+"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F48ABF
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 23:00:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D4BCB3200A6B;
	Sat, 14 Oct 2023 01:59:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 14 Oct 2023 01:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1697263198; x=1697349598; bh=HO9Jj/5jkFSjMJuZ6UfvcC1LkyIcJssrxO+
	UuN6McV4=; b=B0rm1bUu8TCqCEg88dI1wkkn5gNtCx8ujgi7aRDjLYReQ6uDhpE
	uKZJg9s+qJ2ZhpuEnsbjsDbWda6IvWEtICdvBu05UEzQ4qUDMhrmXo9BxrGPAD2K
	5sHlUx3LadpVJJk5Q7tfupmY8DXdZhlTI2z8ofl1UFl6UV3NkFmyQ3rWfcRBLKpX
	C8a40O51Rt26kOKK7DVQD7QZp6xeNH0+O5/7OcdPJ41sIpyk4reDxk4lUf+RuPZE
	X6a+/h0p8kJNv+0JiiMe/Y3UFAz2+S7MazJ0XMs5xEwJoWF65qGJ1js0Q6gPD0FQ
	mQO00T4I4VMfTK6YruIdISIHr4Aq50arrIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697263198; x=1697349598; bh=HO9Jj/5jkFSjM
	JuZ6UfvcC1LkyIcJssrxO+UuN6McV4=; b=P2OCVIU+eP+929FNs+Lbb/W90RuW5
	RLan9BNpqZBvHOs+iqebc5TvJdNsRCkqaO9RiTT9PlWOihaYx8hyRbkfQsO2iMJx
	+M4v6JF4X/gmZKTriRx7NDUf6RQvQwrD1mXUKJ90EISMXC3c54YQTaCGxLsscRU3
	5CYBfvGgif/T/zwBs/5GVFP2inLqlNUbQ3TwLYJoSzBGUlTcVVXE3Z1bA+1rLkYt
	PTd2vJlhP2Soxb7BZhasYdAAHZBYjNJJ4aef0XiGrL41oK7+LEt7SNSbvyiuCvHJ
	jph8/vueuSdIC/pDKvJR95BEDPOSZCWeAEip99sy3Q+B+3I1YH8NBzeQg==
X-ME-Sender: <xms:Xi4qZUaHCZt7qEbf9VnC8H5i0FkvXYUuOFh0_Z0cH_S1J2a5b7QWJg>
    <xme:Xi4qZfaYFUNdXB3WK4xHI0C5Ty9CzDZvTE-Tz1EBA_0CWH2PFODf47Y_SAloL9Jlo
    ZP8n0rGbs4ZOtsvGkU>
X-ME-Received: <xmr:Xi4qZe98x0VQatF6pJmmUxstRy2wW2jqPtM0OTRCfkFCAK86L_skLP99X7_jig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvkeelfffgteefieejtdeihedtuefhgeeujeekveeuieelfffg
    udelffejffduvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhi
    phhlvghtthdrohhrgh
X-ME-Proxy: <xmx:Xi4qZepXZqPm2iz3u-2qEWmg1R1aWPA-699WAh-VVTVaCiafmFRXlg>
    <xmx:Xi4qZfpui7k0KANV5142wZxXv9EfKljxLUex_SYW9KTMVMHt6mH7jw>
    <xmx:Xi4qZcR4ceE61HDykmGKSk7hQ_JP8fXToDu6Hm45fwkllMAmnM30pg>
    <xmx:Xi4qZYC29MZ4FAuiTronSPEmwqT3R5-jOrxwYeyy9iDJ6QnNtTw7uw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 01:59:52 -0400 (EDT)
Date: Sat, 14 Oct 2023 13:59:36 +0800
From: Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sebastian Thiel <sebastian.thiel@icloud.com>, git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Message-ID: <ZSouSI_zPusOefsv@localhost>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttqytnqb.fsf@gitster.g>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 10:02:20AM -0700, Junio C Hamano wrote:
> Sebastian Thiel <sebastian.thiel@icloud.com> writes:
> 
> > I'd like to propose adding a new standard gitattribute "precious".
> 
> ;-).
> 
> Over the years, I've seen many times scenarios that would have been
> helped if we had not just "tracked? ignored? unignored?" but also
> the fourth kind [*].  The word "ignored" (or "excluded") has always
> meant "not tracked, not to be tracked, and expendable" to Git, and
> "ignored but unexpendable" class was missing.  I even used the term
> "precious" myself in those discussions.  At the concept level, I
> support the effort 100%, but as always, the devil will be in the
> details.

"I've already wanted this for years" is, honestly, the best response we
could *possibly* have hoped for.

> Scenarios that people wished for "precious" traditionally have been
> 
>  * You are working on 'master'.  You have in your .gitignore or
>    .git/info/exclude a line to ignore path A, and have random
>    scribbles in a throw-away file there.  There is another branch
>    'seen', where they added some tracked contents at path A/B.  You
>    do "git checkout seen" and your file A that is an expendable file,
>    because it is listed as ignored in .git/info/exclude, is removed
>    to make room for creating A/B.

Ouch, I hadn't even thought about the issue of branch-switching
overwriting a file like that, but that's another great reason to have
"precious". (I've been thinking about "precious" as primarily to protect
files like `.config`, where they'd be unlikely to be checked in on any
branch because they have an established purpose in the project. Though,
of course, people *do* sometimes check in `.config` files in
special-purpose branches that aren't meant for upstreaming.)

>  * Similar situation, but this time, 'seen' branch added a tracked
>    contents at path A.  Again, "git checkout seen" will discard the
>    expendable file A and replace it with tracked contents.
> 
>  * Instead of "git checkout", you decide to merge the branch 'seen'
>    to the checkout of 'master', where you have an ignored path A.
>    Because merging 'seen' would need to bring the tracked contents
>    of either A/B (in the first scenario above) or A (in the second
>    scenario), your "expendable" A will be removed to make room.

+1

> In previous discussions, nobody was disturbed that "git clean" was
> unaware of the "precious" class, but if we were to have the
> "precious" class in addition to "ignored" aka "expendable", I would
> not oppose to teach "git clean" about it, too.
> 
> There was an early and rough design draft there in
> 
> https://lore.kernel.org/git/7vipsnar23.fsf@alter.siamese.dyndns.org/
> 
> which probably is worth a read, too.
> 
> Even though I referred to the precious _attribute_ in some of these
> discussions, between the attribute mechanism and the ignore
> mechanism, I am actually leaning toward suggesting to extend the
> exclude/ignore mechanism to introduce the "precious" class.  That
> way, we can avoid possible snafu arising from marking a path in
> .gitignore as ignored, and in .gitattrbutes as precious, and have to
> figure out how these two settings are to work together.

Sounds reasonable.

> In any case, the "precious" paths are expected to be small minority
> of what people never want to "git add" or "git commit", so coming up
> with a special syntax to be used in .gitignore, even if that special
> syntax is ugly and cumbersome to type, would be perfectly OK.

[Following up both to this and to Sebastian's response.]

One potentially important question: should the behavior of old git be to
treat precious files as ignored, or as not-ignored? If the syntax were
something like

$.config

then old git would treat the file as not-ignored. If the syntax were
something like

$precious
.config

then old git would treat the file as ignored.

Seems like it would be obtrusive if `git status` in old git showed the
file, and `git add .` in old git added it.
