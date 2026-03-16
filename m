Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE9355F47
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693994; cv=pass; b=UY4an4EkFp9gMUsoFeTXPh/A50TOXg3yUp5kRiB2Hr7ie1xbphqSNISC+sq6qkyMW20+0Qzv46uY4g0Ybhbx9/N8AcO1OX147rQuCH6J46dPBMrc1SYEM+Sw3BuwzWvGOsPP5Vz6B3D9crllhyKI4kffZLEocb2o1/q2uMzqXUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693994; c=relaxed/simple;
	bh=ZlByZCkFPvy/hygRhvvSeiIepecxcHuOOGtlCAVpDE4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC+Dxiz5D6mH24pWsWuDb0Kf+GSmdHJxih9JX+FDAZxyaSlDWc2LpaolCcprbwXyDfeFYrbA7EBcQJ2ad3uvuoVxeKYBfS+NIdc9WjdYCZJwFfniYF3LvZg6eej0gJhyeBBd1ddIy5ZTMeO3QzaI9mc4GcfMv46zPrcJwAN0olE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAsvqd0W; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAsvqd0W"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ffbcfbcec4so1117059137.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 13:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773693990; cv=none;
        d=google.com; s=arc-20240605;
        b=HebQQnkD/DyuFkRcMFPnOjS1onw5V+fLoVNIeW868nOCL4uIfDFUmh+sN9Xc31SqVC
         nkWYzzpp3Roz5iI48R/cZq+dUXKN1EckdUvQeCARalerkvtgnNhuy7sDv7T/KgOIAlbX
         gr76MZcNCb6bkpDThkb+mJCTqVT+vbhqL4O6RlgyDjCr6XvHQKNlm1oHGHLc9S1wTbTE
         JND+VmrCzH8QVl86WTe4xAPuXSppKJeg223dcEmly7HQjOg97anZEqTo2lxinLPeWQDM
         oUw3CpTRJ4NmiPM2qVAFODa+Bh8FdfTANzbtAWdGeQxR7uOMkIjjO3czN9YlOSU81MIa
         er4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=EBRMtQDaBrVKLNFoDdZF4FMeh3P+4uMFxbhY564kg74=;
        fh=M2dWxBZ4Ld/qqfhMnmHZN071TO8NzP0A3DdaJsR0lQA=;
        b=W20NusDDwplQ5dqsz3CmRedeVjoLfZ4CJtYGiREuZz9EgAq8S50UWxAwJ8yjGyvPEI
         cIhJnCuIygSB4C25f54WlFUIpoLv3OQQzaX6ftAMpQxJDW+ltQVu1kpHj9rxSZAcBM4F
         eNDd8za0X35ueye9So5VsUifX4BXwws9N2DdRe7xFnVeCA+b81y73r2lhZ1fl/1SVyFH
         JuWNJ2LpmlN9uv8wm1MlOn8h+F1SifNSJUFfnWPbsSSTZp4PtyE/FKAZ1tYWKusE3ph6
         BWrWsyLgqBez1dQp3nhPiTlM6XRAYuWIa/TNB3U162dbA0saedNAsIUxfx+wG7n6WBoa
         yZQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773693990; x=1774298790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EBRMtQDaBrVKLNFoDdZF4FMeh3P+4uMFxbhY564kg74=;
        b=fAsvqd0Wr0O4lfJtRB6B8yCxD+v0/L2xMFSd2AKOPIGGN9gcWqVXQ0mqOH736sbH63
         SOyKZT6+ayblumXiBgqL7ZVS73jZaeaLz2nzvkh3+YKM/R6NYAPfuIQGW56hTc7G6Vx/
         PH7tYzFtwhueYj/y30zk2zkZtn8UyHwsrczT6oEajqrAxiA7UmwWMG5HMNaKN0erPAYt
         edwCvqFHbzWa0oZL4IRJNr/8Hlpcwn/Zvmy+pwzjf3bh7eREn740GyaVyf1zMiHX0nxt
         MgUaYOxopTMGMO+SvmCYOVsNaGqKgKgZ1NR7dnyVtiy03XUv1xr67m1GAQssTDYqLT3i
         jCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773693990; x=1774298790;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBRMtQDaBrVKLNFoDdZF4FMeh3P+4uMFxbhY564kg74=;
        b=aOyHsRuH7eIEnXg+IlN0GPZmcHd8EO9T+RK+ZjzUfH82Men4EYyhXOnUjZFQLAWjre
         9juTHhPd4cCbxI/Va/oERMTeOCAgmvrSNic9riBgri2nRtiPFxorM7QkgLwJObGQpB6n
         +DkB2qv7a82YtbCeeV2pUn0euOllMUEZsWIcw/BUWODMrd9zNh8bxcej2wcxlmHQO2Qx
         KMtPwqes9pDOnkLzG6jCcyDu2RvZBtuZm48FGkYNP8NATUrfzfZkMB6u5gXVrJVth6bK
         NSZKRlgvZUZnbCdUVU3/Z5L50HUbEplpUXowXz8EwaGZ57gT2e+dgF3CkCiIQq2P5uQj
         E0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVHsCcYWxm93PmqZ75TXDnYkf6+LFPd2CtOZuikjhtFnv+4VxDD+iuSI09/tFWbl8v4fmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbR7aXqbO54SCXfWvchZxskfPdy7zkDyuR6W2VgwEMK1gsz9IV
	d/1aKChekwCx8tkwp1E793o+NX/taZab1kF+HUuHiFVA8FsEjysrhL2MnSx28CquhAetiHWDofi
	xHU2TowbrJa2YUmhRGp+UTLwM/tYRTsv8zlMz
X-Gm-Gg: ATEYQzxMEVwLQxlmeHzZA3KJcLtt0O6gjT+SaCs5NfeE99bnf45wgMUVKAB2Faak0So
	//ZRoSXufVAS+9rwGsJkY+1JwMyzex1Z9kHWE4cvjxzB25vJhJvX5bVcAfupPSVWzLeb0Hcpd48
	1ExbfRwFoQ5HCHzj86Ea1WrWI1yBSARM48b2T5d9yJZnnGjQp9CTixf7eCSiFim33rPpQMNKl9T
	VvAvzAFwFg1Lc1gKBx4BpcfJeweymlPwF+DytqHJkUW1MixAcfhoYHV10sroaa678AeUc6W1qvH
	6xiUTdwtTM5/xLFL4Ub3Lg5nqUpOoWZSQLvKmQUd
X-Received: by 2002:a05:6102:c0d:b0:5db:cc69:739c with SMTP id
 ada2fe7eead31-6020e2f522fmr4572605137.17.1773693990307; Mon, 16 Mar 2026
 13:46:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 13:46:29 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 13:46:29 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260305204809.54927-1-valusoutrik@gmail.com>
References: <20260305204809.54927-1-valusoutrik@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 13:46:29 -0700
X-Gm-Features: AaiRm53TF943pyH0JxBkVsrrV0GDiUSMdIK6E_OQT4B9d15hxhXeOjhJ2pPWbK4
Message-ID: <CAOLa=ZQhzvgA2bpmUgx2qMTrxFaR5_6GET8e1y+A=m2nboDAiw@mail.gmail.com>
Subject: Re: [GSOC Proposal] Complete and extend the remote-object-info
 command for git cat-file
To: SoutrikDas <valusoutrik@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, chandrapratap3519@gmail.com
Content-Type: multipart/mixed; boundary="0000000000003bb2e9064d2a5069"

--0000000000003bb2e9064d2a5069
Content-Type: text/plain; charset="UTF-8"

SoutrikDas <valusoutrik@gmail.com> writes:

Hello,

[snip]

> ## Pre GSOC
>
> I started exploring Git's codebase around February 2026 and sent my first patch
> as a docfix, followed by a microproject of modernizing tests
>
> - [PATCH] doc: fix repo_config documentation reference [1]
>     status: merged to master
>     Merge Commit: 94336d77bcbf4360b67a9454d8bf2e84b3d88ae7
>     Description: Replace the path for the repo_config() documentation
>     from 'Documentation/technical/api-config.h' to 'config.h'.
>
> - [GSOC PATCH] t7003: modernize path existence checks using test helpers [2]
>     status: merged to master
>     Merge Commit: 11294bb0fa540d214d071b32cf74b1ed37b3bbbd
>     Description: Replace direct uses of 'test -f' and 'test -d' with
>     git's helper functions 'test_path_is_file' ,'test_path_is_missing'
>      and 'test_path_is_dir'
>
>
> I have read through most of Eric Ju's [4] work and some of Calvin Wan's [5]
> work. I am still finding more things to understand from each thread, but
> I feel I have grasped the basics.
>
> My work in this project would be focused on implementing the changes
> suggested at the end of Eric Ju's [Patch v11].
>
> I wouldn't say I understand every bit of discussion from that thread,
> but in general my understanding is :
>

I do agree that there is a lot to unpack there.

> Calvin Wan and Eric Ju has already implemented a client side command
> called get_remote_info but its designed for being batched to reduce
> multiple network trips to get a single object's data.
>

As far as I can recall, the command allowed users to enter multiple OIDs
in a single line to reduce the to-fro with the server. But you could
still fetch single OID info.

> I have added Eric Ju's patch series to an old master commit (2d2a71ce85)
> since I could not find a base commit for Eric's patch series. The patch
> was properly applied and I also played around and added a very rough
> but workin "%(objecttype)" code , ie now it prints like this :
>
> 29658341f39210201ff7f72a4be83937cf2288c5 14 blob
>

Nice, have you tried with a more recent 'master'? I assume there are
merge conflicts?

>
> ## Project : Complete and extend the remote-object-info command for git cat-file
>
> Currently in the case of a partial clone, the user cannot retrieve all
> object data without fetching the object beforehand. To solve this problem
> Calvin Wan and Eric Ju had designed a patch sreies that can solve that,
> by utilising protocolv2 servers capabilities.
>
> This was done in the form of "remote-object-info".
>
> But only the %(objectsize) was implemented, and that patch was not merged.
> This project has two goals
>
> 1: To Rebase and finalize Calvin Wan and Eric Ju's Work by addressing
>     the feedback on Eric Ju's Patch v11
>

Any idea how much work is left post v11?

> 2: To add support for objecttype in remote-object-info
>
> 3: To discuss other information type like objectsize:disk and deltabase.
>
> Project Duration : 12 week approx
>
> ## Timeline
>
> Mar 6-31 : Refine Proposal
>
>     If possible I would like to submit small patches... but first I will
>     have to rebase Eric Ju's Patches ... I am not sure if I can do this
>     before GSOC...
>

As per the guidelines, it says

  Any work done on the Project prior to acceptance of the Project
  Proposal will not be considered for Evaluations.

>     If not, I plan to contribute to git in other areas.
>
> May 1-24 : Community Bonding
>     1-7  : Understand relevant underlying/ helper functions
>     8-24 : Ask about any design related problems/decisions
>
> May 25 - Jun 14 : Start a Patch Series to rebase Calvin Wan and Eric Ju's work
>     and keep refining
>
> Jun 15 - Aug 15 : Start and keep refining Patch Series to add support for
>     object type information
>
> Aug 16 - Aug 24 : Discuss and Implement other object information if possible
>     Concurrently I shall make a report for all the work done.

How will you manage reviews, considering generally they take a long
time?

>
> ## Availability
>
> My current semester is ending in the first week of April, so I will be
> able to contribute 7-8 hours per day, totalling around 35-40 hrs a week
> on the project.
>
> Total weeks = 12 , total hours = 35*12 = 420
> It leaves with a lot more room to accomodate any unforeseen circumstances
> that may arise during the project.
>
> ## RFC
>
> I have a few ideas but do not know if they are worth pursuing, so I will
> leave them here in the first draft
>
> - Addition of a remote-object-info outside of batchmode :
>     Yes it should be optimally used in batch mode .. but if user wants
>     only one objects size or type then should they be able to just
>     `git cat-file -r origin <oid>`
>     and get the size and type ? or something similar , I am not sure if
>     the way I have depicted it conforms to git's design.
>

I do agree that something like that would be useful indeed, I'm not sure
of what that design looks like though.

> - Addition of commands for common user behaviour :
>     I dont know if its going to be a common user behaviour but what about
>     `git cat-file -r --all-absent`
>     Or inside "git cat-file --batch-command="<format> remote-object-info
>     --all-absent --type=tree <remote>"
>     which would basically fill in remote-object-info with all the blobs
>     that are currently absent from the worktree ?
>     No need to fill them if its for a common enough use case.

I do see benefits of this too. But I do wonder if 'git rev-list' is a
better command for something like this.

> - Sort according to size :
>     Maybe a user would want to check whats the largest file they dont
>     have yet.
>

Same here.

> - Get total missing blob size :
>     Use case would be when someone wants to know how much exactly there
>     is to download, before starting the download.
>

This could probably go into 'git backfill' ? Interesting ideas
nevertheless!

> Thank you for your time in revewing my proposal as well as considering
> my application. I am excited to learn everything I can from git.
>
> Thanks and Regards,
> Soutrik
>

What I missed from the proposal:
1. Where did the work from Eric and Calvin stop at, what review comments
need to be addressed.
2. How do you plan to handle reviews and iterations taking time.

Regards,
Karthik

>
> [1] : pull.2187.git.git.1770293021383.gitgitgadget@gmail.com
> [2] : 20260209172445.39536-1-valusoutrik@gmail.com
> [3] : 20260225190306.39358-1-valusoutrik@gmail.com
> [4] : 20240628190503.67389-1-eric.peijian@gmail.com
> [5] : 20220728230210.2952731-1-calvinwan@google.com

--0000000000003bb2e9064d2a5069
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1789ed53d479bc06_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tNGJDSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUZ4REFDaTJRdy9YbGpzZ3ZiaENwTWRYZ2wyVTRvdwpYU2l5bE5VSnZM
VW1nOHBhRFZDdEhKV2dIQkNOaytZam11bWxyb2ZFcHdoM1d3VXdlQXpkTCtjNkxIWkRrNGFKCmRF
Mm5QNklFbmZSSzBENXplcmZVRDZSd2F0VE01M0hxYjFUL2l6OEQwRkhmVUxaZ2Nlb2d4aGc0WFlC
MDh4ME8KL1B3ZzhPQ1o2NkJRUC9aZEREeWs3ZkRqSlorOWN6M0hCdjViZ1dqYlFld09Kd2QxWG1U
TjBiMUt0Q2NadFdxaQp1c2NZQmg4aUFMZ0FGWStYdHdwd2RNMHczbDUxMit2QkhJNTgzRlFCZjFE
ZE5zUWczVnFLK0FGYzgxbXZtckZSCml6YWhvWWhmR0hraXNGK3hrZmtvbTRyVlNvS3lGKzY5SFVj
c3p5N0tkMTVtUnJVcmM2OVZmRUh2VURkSUFrN1kKanl2Q29NTnRmTEhsSWxQMlY1OGxDMmU5U2hZ
VUhVT011N0hGK2xTcitTSGI5dFAwOFFZTmFZUm83L3RqMGNITApiYVQ2cnJaTWJDbVFTRHdzMm1v
TGE5aVpzWk4vSXhLRGRhbWdXd2pBUFpxQWp6V0dmQjFIN05FLzFjeEgzVU9WCnBMZE5iSENCOTNu
QXMzUTB5RkJGdzhiU1dQSDFDZ2ZMOUNRcHBJVT0KPVlsUUQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003bb2e9064d2a5069--
