Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111447;
	b=ukgg5gE0bE4RUUPHYRGZ1kZn/vG8oGINaF3MHpT5Ln4sWai1q5CyRSTEUSKsvw24YNL0
	 q7Syvj2pu7+oP6NYcIsXJQ7OxEBGUmBsMCh+F49Za8+SBTbh9haSiDU4oW+5utusl8ksn
	 ZiX7Q2n/mwh0jf22e72pLGp4UTwq/7C/czDP44mXWKZ6j+cEz/3mdbF2M2Ba9AO19dZuA
	 slHGG5thfK5tuW+jK0gajMuRZJ3ey9LZuMPR4PUnPoKPD8PC4tSGe07F7gXaZzdIVKYY1
	 T8H95Mp+J/GS6Gb+KMuVW8peyGE/qscCLNRs7jG5Hy+jvLWeg3lY8cBIURIu28FnN5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111447;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=7+3nnoXDmrDM9YKKjvKLFrkbjqgF0Bk62jcKRLIo2cU=;
	b=GkqVdx/o36Z6VaMU4Q64OuzRb3HbrrahfCEvLPOGLwtaIpGwi+PLnLphl1fxtEduntn6
	 4SjxWCkyVvfWf2xDsDdXNxc26BR2aiw6OASIhdFi9GUmK1x4cpXhGmICc4ZltlHrNtNvO
	 Gr/NxcHLUSr26w819YgkaPZMBn3C0f0j7+HxM3IYnSE8CxmSHAs9TUNzX/RqeVdBClO0B
	 jiqxl/ywVxYandnOniL1UXo5C97DX3p7eQh+Qe4nUOAzyNYIDFMmwr6dXwelQkdUwcsGV
	 +3s3LQgejVJr36kZJ66j+V9z0uqn1y1fLgnV2sFQuwtFRKGKFGKsgOKvptazoMX2Q3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=WWD+6X7F;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LBJkMHvf;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8FB60A5BD0
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D8FB60A5BD0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=WWD+6X7F;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LBJkMHvf
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A41071D00193
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:30:45 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 27 Oct 2026 10:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793111445;
	 x=1793197845; bh=7+3nnoXDmrDM9YKKjvKLFrkbjqgF0Bk62jcKRLIo2cU=; b=
	WWD+6X7FadhWSucSiSN0rRagrDiDv7jeJOo37wZ1XMJE+OAX+6DbfrvGtcJw2Uy1
	UuEsjEZXOv74FHd9xucLo5y2C8/aV8vVAevphGQF5itemjJbNiNc0n57kN8zGLTS
	DtrtOY6eWxi/6Q+kgyvhxYETyXw4efNWOD+yPNeHHoo6/9AkRjtYMS1HBKvhXOPF
	QcRisPPcVFSLlCdXQJ4rLsVM4F3TAjwAVYuet7nyFpYw+/d0iFfuwNkr5OHth1Rx
	XjCGJxskcedi7nSxtDdxpJizSgE7y6W7+hZF3ifhEzQBYFns6SD855pBNrSZB3N6
	z4wnqQr6s6683tuvD1QL/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793111445; x=
	1793197845; bh=7+3nnoXDmrDM9YKKjvKLFrkbjqgF0Bk62jcKRLIo2cU=; b=L
	BJkMHvfzpto+XMtO9jkSsKqqBwuALHGBRUpOukRISD1EtZcRWDcoDn0myik3C5Hq
	SxlkEe1P+PhbUC3VS+iP94+U+WKgXkauIy9FA4RU4tBU1rxhm9kxGLMBjklXZgzE
	dyELA5GJXTvwBsDnvBwLJSsBf6CyKhyglUq3rcYb4M9AHBIxZPDVRq5jBJ2Kpx2J
	oa/8BcTsOrLqNGPB6LWjFWSJBuzz8e0S/+1L3FJyJ4Ri28YgZ8KzoLGAuaYONmgy
	xC0R3dPklkUJ++YeSQsYx1y4I5GRWQC70Vc+8Ejhu8Su6Os82QwnhBG16Nk1WLYl
	JwezBW3wA7IKMN8n85NtQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793111445; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ruUar+seGgnKal5sXjnfSmlQfGD+kceXpiqM8yEo4andPjA
	AsFSPBs2/mK+LBPjXQMd+AYVbDhiZmct7+fVn6dtt9kfgCjmV+xcYLKF3upbeLUn
	f7tljGlx5ZqfgcJHwJiupMTzxv9Eol501f/lcXzcghPjBhvqtrIHRcmuKE5t3tI9
	2Jg25HXvSvzrWzZX1LqLVgAztXxlAoHu6eSqL/nvWAOEfvQHt8dfFPnxwedhAxDt
	xRc6XEXd60TiBVdVGUVVQljdEcNFooJiXMarN04mAOKHsHDNZLbeIF9eocnnV6xA
	kMlc/vw+b2OEgj3H12MZ9Eb3uqyAZKykocR6aZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:n/C+JczA6F62ddN9yDAGaecQB8aiEw/ym3m6qudiJAw=:l5RbRfwa6lnaCO2xMfBsjm2dGbh4iSBqZWuT2/qbUmw=;
X-ME-Sender: <xms:lLXgarv5fvbF_313pTEgnLxmAQEBcegfwZgCp27XqyZ6SQq8LcWXyw>
    <xme:lLXganQqYUbtI7PZV1sbWNNYwiSVwALxByanNzVDUqlY6GfMFMx1fE4tgetZVmP65
    4Z84SP44YnftG5orkfPtvHnPE58IcybqoiltW0FHmkXOolSG5zN4Bo>
X-ME-Proxy-Cause: dmFkZTEIU7J/AHbGvF7wry01hWh9MegCPoxPjaBrQ/CoUEUCmGfmQFPu7OpB+egV0qJPCm
    v+vxjqMfsjwY4n3tMtiBpSsu16N7heuA6vgiJLesxKWOXtacOU1h2LOMwi3flap7ODoS/X
    wrkIIHbNMh0mTVWNODUnb34mKU86zVD99TkMh72lRaSoCVqgfbh8leJS1ziLnzfVqXvvjZ
    yT101gJWD1XGCEzbX7/HI5UVwOAqOWfPd5BjEbhSFRW+503n5jVHiW53CSNO1XZPsWCICH
    H2J7aHVL7fo+sFjcgKuRahvnxNwkIB96zDCjsrSmsBJCkMs/5l3Yo5vNFlq0z/TY+ZTsbd
    z8257veQfATaO2laVmB5cJb8aW0CDjevlhglfQZR+P1HUohUXbk1vKtqbJvi/O7WaCq9Ea
    pH4jfE1fm1mQltYwtKy4rETKPxOBwD/svrDHqY/IoAXY9p1CzACEBbuppiD7YfQMDPo7hV
    Fuxs6MHlYvv4sAUtvCF6XsVlBUW+GphvYl0ZA0dWmauKS8C3VUgxuwuJfFpw6zc9Mvu8jN
    acY9SGDusm+Q0UDFkGIec3tynAwm9L24YIoONfK28Bcda4zlB8XcayXt9agJlN+zIQ1bRd
    /uqXurCxG/Efede+04Ca4cA4H6LNQAYrdedyJ0v8N7Mz1TkOxOTcMsNPL91A
X-ME-Proxy: <xmx:lLXgajVbBkbaVMMISGk4RUN4H6mfjorbeEVGG-WDKByg_btGm6Ofug>
    <xmx:lLXgapaBomqo_BTbkU6q_BLyT-oFQxgvR4-UiJ5-9T8F-pA2Uke4MQ>
    <xmx:lLXgap0mJ59E4vTvNQ4u7ahwOuwXdP_vhWDNJnWXY6ihxRtdkBF7og>
    <xmx:lLXgarjMrv0HuJaVKtwAL9nC8OnOPQmFWxIJAtDLlyyt3u_EHDmalg>
    <xmx:lbXgahatsHbEYiX1PwEiOPzfZlt5YSRX7ep5c3FIH_sNanHuMsVn8Z4V>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AC52378273B; Tue, 27 Oct 2026 10:30:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AJEn36qy8-Bg
Date: Tue, 27 Oct 2026 10:30:23 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Tuomas Ahola" <taahol@utu.fi>
Message-Id: <e7a03372-56cb-45c7-ae32-68b3c9e6bd27@app.fastmail.com>
In-Reply-To: <F2555C10-8453-4196-9D07-02870D19199D@gmail.com>
References: <pull.2248.v3.git.1792768625.gitgitgadget@gmail.com>
 <F2555C10-8453-4196-9D07-02870D19199D@gmail.com>
Subject: Re: [PATCH v3 0/2] doc: add new git tutorial
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Oct 23, 2026, at 2:01 PM, Ben Knoble wrote:
>> Le 23 oct. 2026 =C3=A0 11:17, Julia Evans via GitGitGadget <gitgitgad=
get@gmail.com> a =C3=A9crit :
>>=20
>> =EF=BB=BFSo far we've gotten 112 comments from 30ish beta testers who=
 have tried to
>> learn Git for the first using this tutorial. Most of them were able to
>> finish it successfully. By far the most common piece of feedback was =
that
>> people want to learn more about collaboration and branching. I've wri=
tten a
>> draft of a tutorial on branching, but this is already quite a lot of =
words
>> so definitely we can't cover it in this series.
>>=20
>> I don't know if it's possible to get this merged quickly, but if it w=
ere I
>> think it would be amazing since people are so eager for a tutorial on
>> branching. If we spend a huge amount of time revising this I think th=
ere's a
>> real risk I'll run out of funding before we have time to write about
>> branching. Ideally I think it would be great if we could merge a "good
>> enough" version and then have a way on the website for users to give
>> feedback on it, so that we can later incorporate that feedback and
>> iteratively make it better over time.
>>=20
>> Thanks to Paula, Agavi, Ken Wells, Michael / Chgowiz, Ishmaeel, and a=
ll 20
>> or so other test readers.
>>=20
>> changes in v3: (v2 was the "first" real version since v1 was a WIP)
>>=20
>> * Say that the tutorial supports any version above 2.23.0, when git s=
witch
>>   was introduced, since the next part of the tutorial on branches wil=
l use
>>   git switch
>> * Mention that on Windows the tutorial will work best in Git Bash for=
 and
>>   it might need adapting for PowerShell. (thanks to Ben)
>> * Add a warning about how Git can dump you into vi, how to handle that
>>   situation, and how to write a longer commit message. I tried to str=
ike a
>>   balance between lightly suggesting that it might be good to write l=
onger
>>   commit messages, while making it clear that you can just use -m"" if
>>   you're not ready to navigate the world of editor configuration. I d=
on't
>>   think we can use Pro Git here though since it's a bit outdated. (th=
anks
>>   to Ben)
>
> I noticed some discussion in Discord about the main text being out of =
date,=20
> but while the appendix makes copious references to editors
> that have fallen out of style I think it also covers common cases
> like VS Code and so on.
>
>> * Add Helped-by: Ben ...
>> * Add output of "ls ~/.ssh/*.pub" (thanks to a test reader)
>> * Suggest cat ~/.ssh/whatever.pub to make it clearer how to copy the
>>   contents of the file. One of the test readers said this was unclear=
 as
>>   well. (thanks to Junio)
>> * Mention that the public key might not be called ed25519.pub (thanks=
 to
>>   Junio)
>> * Add a short section on the importance of git status
>> * Fixed the formatting around the headings. Kept it in the same style
>>   because I had issues with the docs linter when using =3D=3D DESCRIP=
TION
>>   (thanks to Junio)
>> * explain what --set-upstream does (thanks to Ben)
>> * A few other small phrasing fixes from test readers
>>=20
>> non-changes in v3:
>>=20
>> * didn't use git config set since the tutorial claims to be compatibl=
e with
>>   Git 2.23.0
>> * kept using the term "folders" since my impression is that Mac OS and
>>   Windows use the term "folder" and those operating systems are more
>>   popular than Linux. I don't think any test readers were confused by=
 this
>>   term, though "directories" might be fine too.
>> * leave git init instead of git init myproject so that folks can use =
the
>>   same process when setting up Git in an existing project
>>=20
>> Julia Evans (2):
>>  doc: remove gittutorial
>>  doc: add new Git tutorial for beginners
>>=20
>> Documentation/gittutorial.adoc | 1035 ++++++++++++++++++--------------
>> 1 file changed, 573 insertions(+), 462 deletions(-)
>>=20
>>=20
>> base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-224=
8%2Fjvns%2Fgit-tutorial-v3
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2248/j=
vns/git-tutorial-v3
>> Pull-Request: https://github.com/gitgitgadget/git/pull/2248
>
> The range-diff below looks fine to me! A few small nits, but I don=E2=80=
=99t
> want to hold things up.
>
>> Range-diff vs v2:
>>=20
>> 1:  42035aa84a =3D 1:  8c0366e996 doc: remove gittutorial
>> 2:  6532e60e30 ! 2:  d8ea142af6 doc: add new Git tutorial for beginne=
rs
>>     @@ Commit message
>>=20
>>          Some design choices:
>>=20
>>     +    - Only use commands present in 2.23.0 (when `git switch` as =
introduced),
>>     +      to support older versions of Git.
>>          - Introduce a much smaller set of commands than the old tuto=
rial, to
>>            keep the tutorial quick (doable in an hour). Some users fo=
und it to be
>>            very fast and some wanted to stop early (after step 7) so =
this seems
>>     @@ Commit message
>>            policy if applicable since the "easiest way" may not be th=
e best), and
>>            giving some instructions for how to translate an HTTPS URL=
 to an SSH
>>            URL.
>>     +    - Warn people about how `vi` is the default text editor and =
give some
>>     +      instructions for how to escape
>>=20
>>          At least 20 people have successfully completed it, and feedb=
ack was
>>          incorporated from problems the testers ran into.
>>=20
>>     +    Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
>>          Co-authored-by: Marie Claire LeBlanc Flanagan <hello@mariefl=
anagan.com>
>>          Signed-off-by: Marie Claire LeBlanc Flanagan <hello@mariefla=
nagan.com>
>>          Signed-off-by: Julia Evans <julia@jvns.ca>
>>     @@ Documentation/gittutorial.adoc (new)
>>      +1. Git to be installed. You might already have it installed,
>>      +   and if not there are directions at https://git-scm.com/insta=
ll/
>>      +2. A terminal to use. On Windows, you can use Git Bash which co=
mes
>>     -+   when you install Git.
>>     ++   when you install Git. For Windows this tutorial will assume =
you're
>>     ++   using Git Bash and if not you might need to adjust some comm=
ands like
>>     ++   `ls` and `cat`.
>>      +
>>      +You can check if Git is installed by running this in your termi=
nal:
>>      +
>>     @@ Documentation/gittutorial.adoc (new)
>>      +------------------------------------------------
>>      +
>>      +The exact version isn't too important: this tutorial is designe=
d to work
>>     -+with any version of Git after 2.0.
>>     ++with any version of Git after 2.23.0.
>>      +
>>      +[[step_2]]
>>      +Step 2: Introduce yourself to Git
>>     @@ Documentation/gittutorial.adoc (new)
>>      +but we're not covering that here.
>>      +
>>      +Step 3: Create an empty folder and 1 file
>>     -+------------------------------------------
>>     ++-----------------------------------------
>>      +
>>     -+In your terminal, create an empty folder and change directories=
 into it.
>>     ++In your terminal, create an empty folder and move into it.
>>      +Later on you could follow the same steps in this tutorial to ta=
ke an
>>      +existing project and start managing it with Git, but we're goin=
g to use
>>      +an empty project so that everyone following this tutorial has t=
he exact
>>      +same files.
>>      +
>>     -+For example, run these commands to make a folder called `myproj=
ect`
>>     ++For example, run these commands to make a folder called `myproj=
ect`:
>>      +
>>      +------------------------------------------------
>>      +$ mkdir myproject
>>     @@ Documentation/gittutorial.adoc (new)
>>      +
>>      +You've now stored the first version of your project in Git!
>>      +
>>     ++`git status` is very important
>>     ++------------------------------
>>     ++
>>     ++`git status` shows you the current state of your Git repository.
>>     ++It can give a huge amount of different information that takes
>>     ++practice to interpret, so this tutorial has several examples of
>>     ++how to interpret the output of `git status` in different situat=
ions.
>>     ++
>>     ++It's often useful to run `git status` before and after running =
a Git
>>     ++command to see how it changed things.
>>     ++
>>      +Step 6: Make a change
>>      +---------------------
>>      +
>>     @@ -1,2 +1,2 @@
>>      +$ git add example.txt
>>      +----------
>>      +
>>     -+Then you can run `git commit` to commit it.
>>     ++Then you can run `git commit` to commit it (though see the warn=
ing in
>>     ++the next section!).
>>     ++
>>     ++Warning about terminal text editors
>>     ++-----------------------------------
>>     ++
>>     ++If you run `git commit` without any arguments, Git will open a
>>     ++text editor in the terminal for you to use to edit your commit =
message.
>>     ++This lets you write a longer commit message with more details.
>>     ++By default, Git uses the `vi` text editor, which is extremely d=
ifficult
>
> Personally, I=E2=80=99d drop =C2=AB extremely =C2=BB here to avoid cas=
ting a judgement?

The goal isn't to judge vim (I love vim!), it's to make sure people who =
aren't
familiar with it know that it's not a good idea to try to figure out how=
 to use it
in the middle of a tutorial on how to use Git.

It's almost impossible for me to imagine someone successfully learning v=
im
when they're unexpectedly put into it for the first time.

>>     ++to use if you're not used to it.
>>     ++
>>     ++Some signs that you're trapped in `vi`: suddenly typing doesn't=
 work
>>     ++anymore, and there are tilde `~` characters on the left of the =
screen.
>
> Perhaps =C2=AB bottom-left =C2=BB; they aren=E2=80=99t in the rows wit=
h text,
> for example.

Good idea, will do.

>>     ++
>>     ++If Git opens `vi` and you'd rather use a different editor, you =
can
>>     ++handle it like this:
>>     ++
>>     ++1. Quit by typing `Escape`, then `:q!` and then `Enter`
>
> I never know if I=E2=80=99m over-indexing on this, but: perhaps
> =C2=AB press the Escape key, type =E2=80=A6, and press Enter =C2=BB? O=
ne probably
> does not want to type the word Escape ;)

Good idea, will do.

> Ideally we=E2=80=99d recommend :cquit!, too, to exit with an error
> in case the user accidentally edited the buffer and managed to write i=
t,
> in which case they may create a commit and the recovery may be confusi=
ng.
> But POSIX doesn=E2=80=99t require that of vi/ex even though most distr=
os
> ship Vim as the implementation. So :q! will have to do.=20
>
>>     ++2. Run `git config --global core.editor YOUR_PREFERRED_EDITOR`
>
> This is probably ok for now. Long term I encourage folks to set
> EDITOR and/or VISUAL environment variables, so all
> programs know what to do, but shell configuration is way
> off-topic here :)

Yeah. It also depends on whether the user is planning to use a terminal
editor at all, I think some folks will choose to use their IDE integrati=
on to
work with Git and so setting EDITOR might never become relevant in
that case.
