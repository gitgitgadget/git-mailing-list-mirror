Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792663276;
	b=bN1zT443D9LABUQkajLPMTdQVTdegPOmnbG9XmsnBmV3vA01mw89S0OUdWErI2KKj/SL
	 2frwFb6BscaERqanomDCtwlhN8swVCkavk2RPWDyCtAICicS7vUjAeaYPcBp1Qw8yqGRq
	 tcfWPlNSYOFLmv4IIHdGffDSzbbg0Sl/s7n9cLtq9Fnxek2uVl8y7WW0xjcsmO8RbC2un
	 oS0ONpGzQ6sIPhrS2eL4DLuyr97QywYilRnvDiggx5vlPxRs0bUKAsR/Hq8Nq0WhEZtAQ
	 vvyyY2qEck066rBtFippoQgqd+3tEmYv2cgq8aHKz1xf5/2TUUCbfZDEmpFUl91CPGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=XW7eZf8erD7ZPDIUuGl3ge8ip8/75PvO/1gG8y4ddUc=;
	b=m/Ek2iFIDRdevuDfuB7df1aEyBj9WZOXruac8vhAolP5Dm4YT3CHMeKSifCiGX3jzkoW
	 8Q4beVklr3Klolax/N8JFkJRjChmCMMpFf6UgQyTBw1WTn0dERJ/IZT9V38gAKj9chnHp
	 r5/cQKyQtg1e03p2d+VEoz84vcXINRh0ovWLe/Kwf3TKsW9PH2wAe3LLBvmn9/Ae2rQzj
	 TE4Vwxaiue059aZPILhLKY/+mFkrYCNlXK9XbmlzWlDxWf4OEXoldf05Z2Uon9YNMeBjB
	 VJAB0Q9wdMBUrV2fWWXefgNJGpWWz1u+e9IXCTJObWapzSNzC/lStfHoVjfZjgiSC2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aKdxO79P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45211606A31E
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45211606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aKdxO79P
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c43373ae89aso246301166b.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 03:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792663274; cv=none;
        d=google.com; s=arc-20260327;
        b=AYzP0odkj4Oq/ogT3cRNyOxH8kg/RkkvMciBYDxr3DGo8vFBUSxHzol3yeocCmojmF
         k3BMEll8zNIIkFRukvGB3Uo9AZn5ba6ogh+LfGIhcDCHb0TjHVEdlBzY9gofzMomfvVq
         h5l/YFSCoN9k13grncS5Qzv7Mmf13xG7K+w5v3MXSEJAGkc5ozMvN2Vghein+n3pxgFp
         +WPiOsI2JE9Q+TroXwcMA/kryto/SCJPHz4AE+TIlgz6MtigKPtl+BdSVPHCiVSAVQGM
         6ReDyxyQE4PHDtKb0tO2/ieFwWEbQxvpH18+3inTmw5JsPiDxumLR3Ar2WRZpmz7nbzG
         a5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XW7eZf8erD7ZPDIUuGl3ge8ip8/75PvO/1gG8y4ddUc=;
        fh=7LTVhODO4x1UgiBvNt+E6q9bH1nrQvelQgKwyt2fwv0=;
        b=rXQoS5klECkRJjCacuOrlMzU80ik4G1PfkaOhYfvku5FGf7W21JEqnGQUZIwCVbBvn
         fdBf7TrrTvV4X9s2/lzzT7ATKdoMBQ1pcdSKn1u8ufuOqAI28V8fNttuFZhxLpFAlAxC
         OpMjdmOPGmfCLmHhD/HcqacDHvetxmV1Ny3qfFelDQ+kHLpgkMzjwITqJ+cYSQaUqQie
         tOoxwKtumVCm9vVGcoeU0l+I5wAzpEx7fF5Osw4VDiEiQludv5D0prKNuMTegpBZhdhB
         U3cnuCujx9h58NJ7NvCajv+L54mXsF2e6gmKb5L0mNoxGC9YUVkB/zeLiHlkWPF9VUaG
         91Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792663274; x=1793268074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XW7eZf8erD7ZPDIUuGl3ge8ip8/75PvO/1gG8y4ddUc=;
        b=aKdxO79PAdHFuNDngj1ceWypdCEYkdwgpumzT31uCSZ8KrpjYxSA0eej0mLy4GI0GS
         x3Gw+vW+q71301rthWZSPyQBLVKJcvxrJydXrNrl7HGbUG/z+wtAZYA9KpTYh5mWjXII
         mvzG0C/jZcbMEkl945vaqGLH/wjdcMK5uxK16BtbfIq5dcTr89r7d+E9+ezXulNzwZ7T
         kWHtPd9BMsgbDQkJknxibVi1vuJF6fKsXTnLLDd8ZHOQwYaD7h7INzJodxfJvW/Ikz5f
         REGmCAhakpllk6+U1RxX1sSAjGc3xNhuaDdfdZc3SXJWzWkVyHuNBY3pUPysQsZaDvHW
         9VNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663274; x=1793268074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XW7eZf8erD7ZPDIUuGl3ge8ip8/75PvO/1gG8y4ddUc=;
        b=SN2cyKC1vdZnF3hmorSfnB2sAUJ6ebHWHMaSY2WQHixoYDlSArzO97XXKbGL+2sB3A
         1eoqhagfaz3WE4x24bEs+KgtLp1kL+bLVuL/5iDXbbOLIQ+JlBbkmhxE0ACKHPdHIzPZ
         4f7R/K6OI2Y/HNhlupcBxMR627xTthovQsWTOSPNJ1rTBH8ERdp4OrY+Dzkg0DOKARQi
         watLnCPpnupee0ctv0tTA71Dna68BJN2+B7mdtg2Fl9mdOxHFEOlKOw63vKc1kFQ1ne8
         HbzhvHJFd20LFBzBkIrag0qQP0LfV9fxTawzRYfmXnsQ4wSWOR/lgrAEQBRc/UwfHzHC
         XZjA==
X-Gm-Message-State: AFq9FYKALZpLSjIDMscaRrnpPLlvNqH2uk/GwvstuZdfivZ8ri4Cqb+Y
	Of8xWnF2bIlwDoOVY4Z6Q6zHw++fMvEkfjkF+nrM1dFdGX/GsMLC7ki/b1aEOWbRr+FtjM50p4Z
	eXXLYRYfW+Uvl0mcNwWrND+YTs4kfC9w=
X-Gm-Gg: AYBFou2kmnSK7WvvIOh4W7idf7Fjwc+d65WtKP3mLNpoHX3Py6or258v/L4xcB+wCqE
	F4cNSGQhBj8s93WJAN+Kf1v3T3EQpkU8x9kqedLxVaw3yq6aZ7FXtnS40vSG1tRKAtwZiNdwsu5
	eVl3wQjBPm0IFMoWs7GIW4oyje3ItdyX4dcnYZFOerYrA72v4K4yy+riyX/mgKNbsKzOweYFfC0
	X8GeJOSkfXHdiXYOO9iJxb4viMTdk1iQl5YR98f7vtBfGoHS1xWJT8V5XbF9pzxF0Pn18YxfRRV
	mEMaCXhNXiP2hbgqHO4Fap9S9HTs4zwIVuecJKAdtS3nJZIWqqKbzt6SXD9LDmhLFnfIzoIjkRZ
	wb09Kn7M3hqlhxU6S0V7ZRRyXM2Cz6qbrHMV1ahbq2Vj+UMI7D2h69WCyI2/DvZ2AqaWB
X-Received: by 2002:a17:907:1c84:b0:c40:aa04:18d0 with SMTP id
 a640c23a62f3a-c46795f1c0amr412177266b.17.1792663273889; Thu, 22 Oct 2026
 03:01:13 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKrRMNruH+eN9CVrdwfg563ceQp8bQwCDBkV7ex0h_=X3eOBdg@mail.gmail.com>
In-Reply-To: <CAKrRMNruH+eN9CVrdwfg563ceQp8bQwCDBkV7ex0h_=X3eOBdg@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 22 Oct 2026 11:01:01 +0100
X-Gm-Features: AclHuK8MtHUzNfLb4c_3NizN8LWQGebT0PiWYCFpigtgmEL8LjxqcdfncyMNrYE
Message-ID: <CAPSxiM_eZ62ExDaqjehSEm37c1EhU=P4kL_kpobWj_RAD5zewg@mail.gmail.com>
Subject: Re: [Outreachy] Introduction: Tanga Joris, option parsing project
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 11:15=E2=80=AFPM Tanga Joris <tangajoris@gmail.com>=
 wrote:
>
> Resending in Plain text
>
> Hi everyone,
>
> My name is Tanga Joris. I'm a software engineer based in
> Nairobi, Kenya and I am about to graduate from university:)
Welcome Tanga,
>
> I'm an Outreachy applicant for the December 2026 round, and I'd like
> to work on the project "Improve how command arguments and options
> are scanned and parsed". I am really sorry for starting late; I hope
> you are okay with that.
>
Thanks for your interest at Git project. There is no problem with that at a=
ll.
Git is open to contribution everytime.
> I've been interested in version control for a long time, and I've run
> into parsing problems in my own projects. In a CLI tool I built, a
> global --addr flag only works before the subcommand: "kiln run --addr
> x" fails because the subcommand's flag set doesn't know about it. I
> later noticed Git has the same rule, for example "git remote -v" has
> to come before the subcommand, and that got me curious about how Git
> scans and parses its arguments.
>
> For my microproject, I'd like to convert the " ... and %d more."
> message in builtin/checkout.c (suggest_reattach()) from _() to Q_().
> So far I haven't found anyone working on it in the archive, but please
> let me know if someone already is.
You can work on it if you already noticed that no one is working on it.
>
> Thanks,
> Tanga
Thanks.
Usman.
>
