Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0374400
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405458; cv=none; b=hg3Ro3hqOLdNwE35iGE0hLfa6Ak0LF9xJUNNdpzb8jgYoXt7/dikcLUsIOaapQFOI1VaXL25eBOM0qCW3k19J7vsPCgMl7Lbj8TGPW9qIK9eZ7lNmvnsc5yvEjg+CocifIGD4KFDQD2NKZHQP1BzWFmVzMHbEXYhdlb1QB7+DrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405458; c=relaxed/simple;
	bh=aKBrHCnN0iRUrSUGJhyadFbXgeU8baLJAczbh9Anovc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=AjkD6x+6l0K4mePNDeSPXwds+hCbbgG2il+fBlvFCx39PWxS7lgE3CPeUaPi0wPw9LdY20AELKNjlt3gc0vtc3HrOxMBXuNMzogm6IOgYFlXiJ7bj48We+I5hShIH4PdPlMiH0YRqtKXVIcjz9WSOBoVY9m4hz+QN4zG5tL604g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3ycE6X2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3ycE6X2"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5171a529224so5863352e87.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714405455; x=1715010255; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0m/F/nW5ci8m+zgnd9MxjpImoW3HGaj8FB0ThrcjpY=;
        b=T3ycE6X2jVtSBpchqgMf3WVuJ2GChcL3KNgG7Z0PS8gU8FEJIqfUA2s6/dmN7sRqL4
         JjmE0N7R1BUrZEYJ7wBYQSuRr6QiJmpglvZ5sxXBCGNc3QxZoZJ90nn2jcya8fXd7Upl
         8Qd5d6CIjHymetnbAsRwvRkWTKODXQ6RX+vunR5DXenadXr1FYcQyf2G8JLMPUGsGy58
         z+DHQ8zOxtExU4upOL3Rf58Mkcgw/ehso/+nYwu1NT8S3h5ZmRw0Dtu2ucy6n+UKkGdN
         15oU5FfAoAfF3IynJceIKpWO97FnzOfoVIGmWL0JNw4//enKtEPcNbkdwvSeNn6H9Z7r
         D5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405455; x=1715010255;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0m/F/nW5ci8m+zgnd9MxjpImoW3HGaj8FB0ThrcjpY=;
        b=alatI9XHK4ft7x2lM1oe++T2JoRyEXNv5WxepLK7kzlt0EGDkQ1GPDzB1z2e453bve
         cFSTQNdUbc67WFxYZLdxduG8wWU9XlZaPbTMHrVFl517zouC1Q1wjndqnsHfK6B7KTar
         XsvmYs0jezzdTxdQnVbuc97btzxVzrD0vL9bOjaASdBBh6sX2p6CfRbgTJ3K9wBS0mLh
         mRoxiSSjZ/gexdLJ6arc8JkN9Zn8NKlh1FarS0FHHX7qlqLcST+84k4MSCSdeW0Dy48B
         Oo7wbHn9rs5uBgIMAwzHEXtc/vxMlatTRXsU/3EgCoK8qWEikyRVlFDEWw+zLBi1FJgN
         zO9A==
X-Gm-Message-State: AOJu0YwgaEta8dYRDq5axoSoS2lpUOOgzXzkwm0KxPDQyVX2tC/kOAMx
	VWeY11ecEw10jBYydoNPcJCffOUBOrthQh7RjO/4MrV+p7ZoE380
X-Google-Smtp-Source: AGHT+IFDD0HFI2AfimhKbO+3k6O3rIWtGgBK7J56yxUIQCH2Vypao6thOFRevUd+7SPpvZXL+4sCjw==
X-Received: by 2002:a05:6512:1196:b0:51a:c913:a9ce with SMTP id g22-20020a056512119600b0051ac913a9cemr1719lfr.50.1714405454475;
        Mon, 29 Apr 2024 08:44:14 -0700 (PDT)
Received: from FBUtveckling ([128.127.105.200])
        by smtp.gmail.com with ESMTPSA id q10-20020ac246ea000000b0051c4fdbff30sm1575703lfo.87.2024.04.29.08.44.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:44:13 -0700 (PDT)
From: "Felipe Bustamante" <fisadmaster@gmail.com>
To: "'Beat Bolli'" <dev+git@drbeat.li>,
	"'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>,
	"'Karthik Nayak'" <karthik.188@gmail.com>
References: <000901da972c$61efc670$25cf5350$@gmail.com> <CAOLa=ZQyCwJO3QhLF+_ZkFWWoQ77o+0Mdrvz8hL0j-x3fdt-5A@mail.gmail.com> <000201da97f2$579fa110$06dee330$@gmail.com> <30c5852e-c8db-433c-871b-1ae5c87034dc@drbeat.li> <xmqqv842683i.fsf@gitster.g> <c40c7a11-6d5c-4d93-8675-93b505a38e64@drbeat.li>
In-Reply-To: <c40c7a11-6d5c-4d93-8675-93b505a38e64@drbeat.li>
Subject: RE: Use of Git with local folders
Date: Mon, 29 Apr 2024 17:44:15 +0200
Message-ID: <000001da9a4c$1744d570$45ce8050$@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCJ8UaSDHsKvOzOZ9RAt48ByJcRFADyLtmfAPz9Ag4B+9RxegJXJJVRATVQUmGz5Pi2QA==
Content-Language: sv
X-Antivirus: AVG (VPS 240429-2, 29/4/2024), Outbound message
X-Antivirus-Status: Clean

Hi Beat,

-----Original Message-----
From: Beat Bolli <dev+git@drbeat.li> 
Sent: den 28 april 2024 00:03
To: Junio C Hamano <gitster@pobox.com>
Cc: Felipe Bustamante <fisadmaster@gmail.com>; git@vger.kernel.org; 'Karthi=
k Nayak' <karthik.188@gmail.com>
Subject: Re: Use of Git with local folders

On 27.04.2024 19:14, Junio C Hamano wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> What would work in my opinion is this, if I understand you correctly:
>>
>> 1. In the Git repo of day 1, remove all files except for the .git 
>> folder. This is to make sure ...
>> 4. Continue from step 1 for each remaining day.
>>
>> This will result in one repository that has one commit per day. Going 
>> forward, you'd probably want to commit more often so that your 
>> commits comprise a meaningful unit of work instead of arbitrary day 
>> boundaries.
> 
> Hmph, perhaps I am misunderstanding things, but I didn't read in the 
> original or the follow-up from the OP any wish to "squash" a day's 
> worth of activities into a single commit each.
> 

I guess my brain just implied from those daily copies that there was just o=
ne commit at the end of the day.

Your explanation below makes more sense.

> Let me make sure what I understood from the follow-up from the OP is 
> not too far away from the reality.  I thought the day's activity is
> 
>   * The whole "repository + working tree" from day (N-1) is copied
>     into a new "repository + working tree" for day N, to let the user
>     to play in. Then the user hacks away, creating commits on top of
>     the HEAD.
> 
> So there may be a directory structure
> 
>   - FBustamante/
>     - Day-01/
>       - .git/
>       - COPYING
>       - ...
>     - Day-02/
>       - .git/
>       - COPYING
>     ...
>     - Day-10/
>       - .git/
>       - COPYING
>       - ...
> 
> but Day-10/.git has ALL the history for everything.  Day-10/.git is a 
> superset of Day-09/.git, which in turn is a superset of Day-08/.git, 
> etc. all the way down to Day-01/.git/.
> 
> If that is the case, and if the end state of each day needs to be 
> given a "label" so that it is easily discoverable, then what I would 
> do would be something like:
> 
>      $ cd FBustamante
>      $ cp -a Day-10 ALL
> 
> to first prepare an exact copy of Day-10 in ALL, and then
> 
>      $ for d in Day-??
>        do
> 	rev=3D$(git -C "$d" rev-parse HEAD)
> 	git -C ALL tag "$d" "$rev"
>        done
> 
> to go in to each day's repository to grab its HEAD, and make a tag for 
> that commit in the ALL repository.
> 
> Then doing the usual things like
> 
>      $ cd ALL
>      $ git log Day-01
>      $ git log Day-02..Day-04
> 
> should give us what happend on the first day, what happened on the 
> third and fourth day, etc., as expected.
> 
> 

The technique suggested by Junio C Hamano resulted in a resf error when exe=
cuting the for, which did not allow me to obtain the expected result.

On the other hand, the technique that you have suggested to me did give the=
 expected results and now has a master and all the commits made for two wee=
ks.

Thank you very much for the help, everyone,

Felipe Bustamante
Sverige


-- 
This email has been checked for viruses by AVG antivirus software.
www.avg.com
