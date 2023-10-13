Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505581A266
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC46gz3g"
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0664C2
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:30:58 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ae450158ffso162151b6e.0
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697211058; x=1697815858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I2wYXiK+mHnHu0Ddc1ScN+D8oaLco/AQiermjDgeNM=;
        b=TC46gz3gzwrdY4M7LSQs1uxESIbTW6D4nKuS6i6cHqkdjr99OWNBbzqdqzC8AIf21g
         zYzFo46wnooaFkKVYu9hfyYjawSjwOQHg2d2HNS3XuoQTrPh0pIPZq8CcPvfVln1qMS4
         /xgN1qwV/cJ7Re6A4Y86VQRtb0pkwy0mTu4juOxGzyUiAD1uCHCBM4gk4HNC+dBMZ6OT
         xnlZG1yukvRxmmJeUK+ispqN13CoXqj9W8N9csF2g1WkmBFdfFSFkfopqYfkL2Cy8Z85
         +xLOjviA5VJQL9JkuxcF0zWuKHeNCzOdhbH9xkjvgtTdTtenaMSOQ0H0X3oVIIqttMUZ
         +dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211058; x=1697815858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I2wYXiK+mHnHu0Ddc1ScN+D8oaLco/AQiermjDgeNM=;
        b=shICi+8mOfRi0CF3FMoawzrvzWjwARAyDNkNvKbheEV4MUVXPAuWM0NVvKWs3OZQsM
         sv2bsEbLn28o1ffdggi6xnXFKAWiKK1OqlAbhug5o2RBJrweVQpImtTcuilVrjQqI+mL
         g59nRU7k9CRIGtl3viCTcRlyF9ZnvCcFD9nLpK64NwihkZjdgJz2jcPy1sW0aKRsIhAE
         wHecjbeRm3xewWrqLSPYrrcAOEh7dR88AVf4wXJLOmOeMSMNVujVyquOUlLoBCsNdIV5
         sEEjdq56CZC5oTby94BdLYMyji1876fguQONNwtq4eFVDmjDOMuyl/mTVCCeGn1Csz0K
         h+RA==
X-Gm-Message-State: AOJu0YwEOGtzXDVbphsKAjPLsJrDwF+2YZAZM1MNlN2Nt5anY6wep/bR
	e6sZnZj/cCJimhubFvD9KMI=
X-Google-Smtp-Source: AGHT+IGYq3pIywb0MpCGmd4RZcTjznUt589s2Xu6jRS5R0qmRWmZv1aJVV51FPyE40LstR4myeTtpg==
X-Received: by 2002:a05:6808:2094:b0:3ae:5650:c6ae with SMTP id s20-20020a056808209400b003ae5650c6aemr34305576oiw.0.1697211057927;
        Fri, 13 Oct 2023 08:30:57 -0700 (PDT)
Received: from [192.168.1.199] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id dn8-20020a056214094800b0065b0e724f83sm741530qvb.6.2023.10.13.08.30.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:30:57 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/2] attr: add attr.tree config
Date: Fri, 13 Oct 2023 11:30:56 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <DFC5DF88-B832-44DC-A0EF-7FFB26B8730C@gmail.com>
In-Reply-To: <xmqqjzrskdzq.fsf@gitster.g>
References: <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
 <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
 <xmqqjzrskdzq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Junio,

On 11 Oct 2023, at 18:09, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> 44451a2e5e (attr: teach "--attr-source=3D" global option to "git", 202=
3-05-06)
>> provided the ability to pass in a treeish as the attr source. When a
>> revision does not resolve to a valid tree is passed, Git will die. At
>> GitLab, we server repositories as bare repos and would like to always =
read
>> attributes from the default branch, so we'd like to pass in HEAD as th=
e
>> treeish to read gitattributes from on every command. In this context w=
e
>> would not want Git to die if HEAD is unborn, like in the case of empty=

>> repositories.
>>
>> Instead of modifying the default behavior of --attr-source, create a n=
ew
>> config attr.tree with which an admin can configure a ref for all comma=
nds to
>> read gitattributes from. Also make the default tree to read from HEAD =
on
>> bare repositories.
>>
>> Changes since v2:
>>
>>  * relax the restrictions around attr.tree so that if it does not reso=
lve to
>>    a valid treeish, ignore it.
>>  * add a commit to default to HEAD in bare repositories
>>
>> Changes since v1:
>>
>>  * Added a commit to add attr.tree config
>
> THis is v4 so there must be some changes since v3 that we are missing?

Oops I messed up the ordering of changes here. I'll fix in the (hopefully=
) final
re-roll

>
>> Range-diff vs v3:
>>
>>  1:  cef206d47c7 ! 1:  eaa27c47810 attr: read attributes from HEAD whe=
n bare repo
>>      @@ t/t0003-attributes.sh: test_expect_success 'bare repository: c=
heck that .gitattr
>>       +test_expect_success 'bare repo defaults to reading .gitattribut=
es from HEAD' '
>>       +	test_when_finished rm -rf test bare_with_gitattribute &&
>>       +	git init test &&
>>      -+	(
>>      -+		cd test &&
>>      -+		test_commit gitattributes .gitattributes "f/path test=3Dval"
>>      -+	) &&
>>      ++	test_commit -C test gitattributes .gitattributes "f/path test=3D=
val" &&
>
> OK.
>
>>  2:  dadb822da99 ! 2:  749d8a8082e attr: add attr.tree for setting the=
 treeish to read attributes from
>>      @@ Documentation/config.txt: other popular tools, and describe th=
em in your documen
>>
>>        ## Documentation/config/attr.txt (new) ##
>>       @@
>>      -+attr.tree:
>>      -+	A <tree-ish> to read gitattributes from instead of the worktre=
e. See
>>      -+	linkgit:gitattributes[5]. If `attr.tree` does not resolve to a=
 valid tree,
>>      -+	treat it as an empty tree. --attr-source and GIT_ATTR_SOURCE t=
ake
>>      -+	precedence over attr.tree.
>>      ++attr.tree::
>>      ++	A reference to a tree in the repository from which to read att=
ributes,
>>      ++	instead of the `.gitattributes` file in the working tree. In a=
 bare
>>      ++	repository, this defaults to `HEAD:.gitattributes`. If the val=
ue does
>>      ++	not resolve to a valid tree object, an empty tree is used inst=
ead.
>>      ++	When the `GIT_ATTR_SOURCE` environment variable or `--attr-sou=
rce`
>>      ++	command line option are used, this configuration variable has =
no effect.
>
> OK.
>
>>      -+	if (!default_attr_source_tree_object_name) {
>>      ++	if (!default_attr_source_tree_object_name && git_attr_tree) {
>>       +		default_attr_source_tree_object_name =3D git_attr_tree;
>>       +		ignore_bad_attr_tree =3D 1;
>>       +	}
>
> Makes sense.
>
>>      @@ t/t0003-attributes.sh: test_expect_success 'bare repository: c=
heck that .gitattr
>>
>>       +bad_attr_source_err=3D"fatal: bad --attr-source or GIT_ATTR_SOU=
RCE"
>>       +
>>      ++test_expect_success '--attr-source is bad' '
>>      ++	test_when_finished rm -rf empty &&
>>      ++	git init empty &&
>>      ++	(
>>      ++		cd empty &&
>>      ++		echo "$bad_attr_source_err" >expect_err &&
>>      ++		test_must_fail git --attr-source=3DHEAD check-attr test -- f/=
path 2>err &&
>>      ++		test_cmp expect_err err
>>      ++	)
>>      ++'
>
> OK.  We fail when explicitly given a bad attr-source.
>
>>       +test_expect_success 'attr.tree when HEAD is unborn' '
>>       +	test_when_finished rm -rf empty &&
>>       +	git init empty &&
>>       +	(
>>       +		cd empty &&
>>      -+		echo $bad_attr_source_err >expect_err &&
>>       +		echo "f/path: test: unspecified" >expect &&
>>       +		git -c attr.tree=3DHEAD check-attr test -- f/path >actual 2>e=
rr &&
>>       +		test_must_be_empty err &&
>
> But we silently ignore when given via a configuration variable.
>
>>      @@ t/t0003-attributes.sh: test_expect_success 'bare repository: c=
heck that .gitattr
>>       +	git init empty &&
>>       +	(
>>       +		cd empty &&
>>      -+		echo $bad_attr_source_err >expect_err &&
>>       +		echo "f/path: test: unspecified" >expect &&
>>       +		git -c attr.tree=3Drefs/does/not/exist check-attr test -- f/p=
ath >actual 2>err &&
>>       +		test_must_be_empty err &&
>
> Ditto.  Is this any different from the above?  Both points at an
> object that does not exist.  If one were pointing at an object that
> does not exist (e.g., HEAD before the initial commit) and the other
> were pointing at an object that is not a tree-ish (e.g., a blob),
> then having two separate tests may make sense, but otherwise, I am
> not sure about the value proposition of the second test.

Yeah looking at it now, this test seems like it doesn't add much.

>
>>      @@ t/t0003-attributes.sh: test_expect_success 'bare repo defaults=
 to reading .gitat
>>        	test_cmp expect actual
>>        '
>>
>>      -+test_expect_success '--attr-source and GIT_ATTR_SOURCE take pre=
cedence over attr.tree' '
>>      ++test_expect_success 'precedence of --attr-source, GIT_ATTR_SOUR=
CE, then attr.tree' '
>>       +	test_when_finished rm -rf empty &&
>>       +	git init empty &&
>>       +	(
>>      @@ t/t0003-attributes.sh: test_expect_success 'bare repo defaults=
 to reading .gitat
>>       +		test_commit "val2" .gitattributes "f/path test=3Dval2" &&
>>       +		git checkout attr-source &&
>>       +		echo "f/path: test: val1" >expect &&
>>      -+		git -c attr.tree=3Dattr-tree --attr-source=3Dattr-source chec=
k-attr test -- f/path >actual &&
>>      ++		GIT_ATTR_SOURCE=3Dattr-source git -c attr.tree=3Dattr-tree --=
attr-source=3Dattr-source \
>>      ++		check-attr test -- f/path >actual &&
>>       +		test_cmp expect actual &&
>>      -+		GIT_ATTR_SOURCE=3Dattr-source git -c attr.tree=3Dattr-tree ch=
eck-attr test -- f/path >actual &&
>>      ++		GIT_ATTR_SOURCE=3Dattr-source git -c attr.tree=3Dattr-tree \
>>      ++		check-attr test -- f/path >actual &&
>>       +		test_cmp expect actual
>>       +	)
>>       +'
>
> Looking good.
>
> Thanks.  Queued.

thanks!
John
