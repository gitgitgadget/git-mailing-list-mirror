Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837913D75C5
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839703; cv=none; b=qt+mke61O9DDOr+1cW8TxfmJgNlny3C4arSr/IeQrrZ8Z4WkQ9ruCelyZq7ts8yCB0CI9jrRBNwDOuG/iFZwFoaFGn6J7RQDd1WBMGOCBGdBVd5xZdgAcb817rnNKuJSz4J06jfVkfy7MfKhhjN5O3p2si+vJ+XgkNpnQiSRTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839703; c=relaxed/simple;
	bh=LvuNZgp05etT8MNmu6zmvr/dZ2KIhCojstZhxne2or4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZCIoYEmW5XI7azBDwVZKQ4LlyuGInkHsOkhXRE+XEYiYbN+zOGz3HtcNfaMOZCGSiVWKAzM0cyEEnQpOeCEOeNgiL3L9e3Ni0aCEZoBvCM5E3VbU05sHqj5Vz+PjQKjkAOIfoffTp4Joh0EQ6P4/LKY7RpvFF9rMDYvPn5pAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKD+UGbq; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKD+UGbq"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50335b926c2so60787401cf.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773839701; x=1774444501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jnl/PhPrcGjrd9yEGeKoun+bsft3dplLHwvVVrb3ac=;
        b=DKD+UGbqpWSJckmJwHZjd5anZZ2SkxGRFh2+WXNZ5nPVjmuJBRa1weyRbhafUlU9xT
         vA/PpSdUSE8Fi6Tzadbt5EriittcBHotSkmXNPJ1TKk/qUfp3i4YO3knvBXx8m6bBx09
         UDTlbXmuaSFTPRivIhaLm8LDqmOK7rrO3DiOlESM3e/GYdEgxwg7BvG/tQXmwLRNvSIj
         ICsDV2x/beK1Oe78lK7FaIBMQFfyVQT9uoH/415uUmGccdof3czuUI7r3SwizhEb7CAI
         oxHOaE9mqOdy4cyPC0ZjGblfn+6GMUj/RHBi3vUCiOQf1YKYZCqlULJb03LVPggB6j7N
         yUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773839701; x=1774444501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jnl/PhPrcGjrd9yEGeKoun+bsft3dplLHwvVVrb3ac=;
        b=HgpTO98j/pVv5qcsFVvU4x9ilQi4Y198xeprUGjD5wKeQKS+rLIgK41sPPmWo/+w5p
         2y1wryISqP7PVRwGd7iSurXJngCT2i2yGncYh/XDFn5j4DCNa8vQo6DocWiofEuyHkO6
         +3SYp+iRONf3hW8YTBX1v09fEU0626L1G16syd5rzcNBeT+n7O+5KGAsAIZywVs+tX5p
         OHCmUc2pvJekim4JL+KvWo0G2iyZIY11FsiUAdDJiVSjvpl0LiPvRfiKJsLHiY8A5yXi
         laCRm9Egpx9w1JSN/enrgtM34yJpIzCijx71nu8xZ8X3nN4PRVz8cJnW2nGT+vVKCPtT
         KaHA==
X-Gm-Message-State: AOJu0YzfggD7g3vJAt28bkLdxJmVIEXW6XtqWSznaVa0uJb+S/sRbwbF
	fiRsHbu7Aty1upzlvFxWZgUb/Hn3eLsmQGhiLmtAFpdOrmdSs/tppvV4
X-Gm-Gg: ATEYQzx3NzvJ4BuguNquKugmM2ciADpK3AlbAh/hLNDF2w+xOrzXiqh/UP5ZDfZV2H5
	a1KKSdv2LIdCy4PqzjlWD59W9YtI4RC3LJBAc/j5eJMeqLck5xvb8o1sFtb74NyQsdPK/tqzhis
	M4tmlsTtUBB4pzCBm+buwBZ8z0hmpubfRv155aeMc9XQ6lXUJAG30bpy8RtIt8pmf/Kg6ro1pkw
	3HyuDAp9fedHcvIcwUd4vl3PCnLhfH1xy2gzh9bG56oJAp8c/2MiUCtGNi8soYiQMUkGXSzwFva
	ql9EIi77EUm5qBCl9xi97p1/3drhV1HZ0FHcVvDOnBeXan9EOC518H7YgqvlHBvP2Lhnx99AhOk
	6iKNMHhCUXWiRyYDZdfzqOg4T9XfBtO1j87zTR2KoVc8OW7WPpsPPonUyhjEaQWwDGJHnXdMAeI
	fybTUPtPbBHCyHpKkgeitXr4ha3MY6y1yKYtl0f5vJZEJhKBwX6RRg/SawQe4+gAx5VsSYAQ==
X-Received: by 2002:a05:622a:58a:b0:509:20de:4adb with SMTP id d75a77b69052e-50b14888802mr39339181cf.58.1773839701409;
        Wed, 18 Mar 2026 06:15:01 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b9ec0fdsm19563066d6.40.2026.03.18.06.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 06:15:00 -0700 (PDT)
Message-ID: <5122920d-078e-46c6-a494-c6e430df7e3f@gmail.com>
Date: Wed, 18 Mar 2026 09:15:00 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] backfill: work with prefix pathspecs
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <977f62faa550ecc4ef7774b4ecf53a9a520fc62a.1773707361.git.gitgitgadget@gmail.com>
 <xmqqse9yhzu8.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqse9yhzu8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/2026 6:10 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The previous change allowed specifying revision arguments over the 'git
>> backfill' command-line. This created the opportunity for pathspecs that
>> specify a smaller set of starting commits, but otherwise did not restrict
>> the blob paths that were downloaded.
> 
> "pathspecs that specify a smaller set of starting commits" is
> puzzling, as starting commits would be coming from the revision
> arguments.  "opportunity for pathspec to further filter commits
> to those that touch only the matching paths...", or something?

You're right. I'm using "starting commits" incorrectly. My view was too
focused on how the path-walk API starts from the commits output by the
revision walk to get a list of root trees and then walks by path from
that point.

I'll reword to make this more clear.

>> Update the path-walk API to accept certain kinds of pathspecs and to
>> silently ignore anything too complex.
> 
> Hmph, "silently ignore", instead of "no, you cannot use that! and
> die", or at least "sorry, I cannot do that, so the result may not be
> what you wanted, you've been warned"?

The behavior when silently ignoring is to over-download. The revision
walk still filters commits, but the path-walk then walks paths beyond
that pathspec. This will be fixed in the next commit, so adding an
error case didn't seem worth it. I'll do a better job foreshadowing.

>> The current behavior focuses on
>> pathspecs that match paths exactly. This includes exact filenames,
>> including directory names as prefixes. Pathspecs containing wildcards
>> or magic are cleared so the path walk downloads all blobs, as before.
> 
> Ah, "we punt and lift the limitation to grab everything, so at least
> everything you wanted to have will become available to you, even
> though we may download more than what you asked"?  OK, users would
> survive that, and as we improve the pathspec support, the user
> experience would only improve.  OK.

Exactly. I can word things better.

Thanks,
-Stolee


