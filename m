Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2E3DD861
	for <git@vger.kernel.org>; Tue, 12 May 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608506; cv=none; b=UB1H1+6RGrUl1vr7/D7pR1I8+X1pNJ8zt/vPkNLm+Wc8lLBMubNnOidwxP0ljOpAOXidBcj7ssg5ChY3WWd8x3igQTnat6hySG/cgHBOucQsiL/i6Wmrgk0z6TGtx0lOkmIkh3fRHtGdr9yocJkF4sSP9A+c80sIFXZ6++Yj2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608506; c=relaxed/simple;
	bh=QBCXJDEXD0uRmKhzufSYQ/rFKKdAEnztZBIsM3g9FBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRU4lC1FkVHivGTFfQggDwPUhRSf7OA/NMSZDwcMEEsvyx7aralzQSLtOjz/FkCN8EHGPqhsTtMsnPb23iJ0bSLF+ShpwkA3VgamtXHNKVGLU35pySgpup84oBListR5Z6ZWmtdL6mGOI/kXhUiFUz6/WxeYq1X4rnKP3aUaejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4pQTcOp; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4pQTcOp"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51306c9f2e1so58307291cf.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778608504; x=1779213304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cspBvsqpkJ0qTViMT6OGIXEBanXKE97LMiL71MHJ7g=;
        b=l4pQTcOpq6SbLZQ3dsprygwXpLJ5c0Y2bdSYM8uCzNAy9/hXDEvVn4ProGgGLYrJVG
         XcSddnjbu1DXwqwnSU1s0yBOoswA9kejhcsOuYAzNMb3asCjp7v5uFfPUHaezRIOHB+i
         9kyn0bmqI2rkM9VjRElsP4i9llBTRcvZSIls3zemwKbsA2RbcLm49SVaXZP9Z3KMVmXU
         qJoiiUMgXURzkon7lQWlfY7Np21bS/99XSbx1sMuUz38KsyCDhIzW8wCeFnbxPhbAAz7
         kLJaDGDCuvVQaEwoULG4aY6UiIYOIJdwkvVqbfPBBtkxDlVL1dg1RQXE9FKd1UTHk/K+
         Ld3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608504; x=1779213304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cspBvsqpkJ0qTViMT6OGIXEBanXKE97LMiL71MHJ7g=;
        b=Byw+42yUbtN/9sdUC6tN8vSznRizRxfR7DKEqt8MTJ9DQHlo1m3TAJuFQHebsvZl6E
         EV3hOxXeqpbesn0WG5hlQShClWWAUx9Gj3nR/1aEUyi3pUMTjZNQSeVbZk9b3Oc4U56T
         4ctPtK+A/D0/qAm3V/MBVIl5+C3Ysx9BWhs5UZ1PWT2pY1QZHG48StUEXPovkVHP2EBc
         4NKyPRcRPOYvzi2ILUgRtW3DhJZ08R6gp6Gp5rS0eVBJ6+e1FRmz4GcGINeQQpzWj4SA
         1Q3pSE+MsJtTP0HvSfcacctqtqvYRTHptZPTCBpLWJsI4vUu0QLpL78KpiscAMk3IUcn
         owFg==
X-Forwarded-Encrypted: i=1; AFNElJ+jNsOiRjm69lyFRabirq1jndL8lsREzNklDSmL2q4mPRrHsLJoExuv0oAXnzO0890yCPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcJvI6lnKY0QQLtNcUSX+0vCesEXYkgsZOyneEwXgOHKn8lgy
	LCcu88zCLQfqMOLgr3OHqyjqGDavSCQs3bg3R32hpjmi/9OHeAuG6PoF1WdbT9xf
X-Gm-Gg: Acq92OGpu4fDWX6nPD+yBAal1Oi5Ojj/gR7ENzqTXF/DslGyF3L8z8wr09i0oMkjL/0
	7uoE8Sx/dTH8trD6SrtppvuUBsWekJ931QywsexQc0sgW42GejwbWTQIhmkLnq7k87oC7pAgIpt
	xjFAA7mdDwlUVYWrIfhVZqu+lzsf9Mth2C1U46F4CLKbH0EGzA3kmk5jHpQAxRipIgiRErtTPB3
	GzbuvqlQxOkH3QGtVJ7ey41k75Lz2xdQnqTwWwjKIzWmZRh7TTRYr2Fjw/SKTVV7iRRK8EDHCaM
	o01WiGnHchEFILDqNF2nvNi+nFiDDW4gdIBY1nuqaj/npgDQlaAqR/WwY6sQVfTxhoi4J2HGvoK
	XPolcaqsct83w01NFrOyNS3KoKjeiI+kDoSEY6ZZKlXVSalPkoKRbRhg3dcTTDTfKZ2jVD3d7Rx
	+ZF3CMIhl9SZmE1+PL98wJRPj3atO8WJfnlkzGTMHh8oAdU+zzu9Uv0lgOouPnl7lOJz6ORDS5D
	sy4eJqsEjQ55Yg+jIFR9qXvgUwVtRcA6q7LxGiMRE6Q8pVrwps=
X-Received: by 2002:a05:622a:5c12:b0:50d:8903:ae6e with SMTP id d75a77b69052e-514a0a1d3d8mr224151041cf.5.1778608503799;
        Tue, 12 May 2026 10:55:03 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c? ([2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bf7e4sm125315021cf.17.2026.05.12.10.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 10:55:03 -0700 (PDT)
Message-ID: <019912f6-0dd7-4224-8c4d-3dc26b1b85c6@gmail.com>
Date: Tue, 12 May 2026 13:55:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] remote: add remote.*.negotiationInclude config
To: Matthew John Cheetham <mjcheetham@outlook.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <a2d15fa12af70367ac6b289f69228cd33dd97d5e.1776871546.git.gitgitgadget@gmail.com>
 <VI0PR03MB11634F3D6B345482BD992FDC9C0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <VI0PR03MB11634F3D6B345482BD992FDC9C0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/26 10:54 AM, Matthew John Cheetham wrote:
> On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:

> This patch is a mirror of patch 4 that added the remote config for
> negotiateRestrict. Some of the same comments apply here too:
> 
> - reusing `parse_transport_option()` vs inline resetting the list
> 
> - values could be commit SHAs as well as refs/globs

Will do. Thanks.

>> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
>> index f1d889d03e..44de6d3c1f 100644
>> --- a/Documentation/config/remote.adoc
>> +++ b/Documentation/config/remote.adoc
>> @@ -126,6 +126,33 @@ values are not used.
>>   Blank values signal to ignore all previous values, allowing a reset of
>>   the list from broader config scenarios.
>> +remote.<name>.negotiationInclude::
>> +    When negotiating with this remote during `git fetch` and `git push`,
>> +    the client advertises a list of commits that exist locally.  In
>> +    repos with many references, this list of "haves" can be truncated.
>> +    Depending on data shape, dropping certain references may be
>> +    expensive.  This multi-valued config option specifies ref patterns
>> +    whose tips should always be sent as "have" commits during fetch
>> +    negotiation with this remote.
>> ++
>> +Each value is either an exact ref name (e.g. `refs/heads/release`) or a
>> +glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the same
>> +as for `--negotiation-restrict`.
> 
> Should this say "..same as for `--negotiation-include`"?
> 
> This way each `remote.<name>.negotiationX` doc cross-references the
> corresponding `--negotiation-X` command line option.

Good find. The rest of the description uses *-include.

>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index 4316f8d4ea..db73ed5379 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -1577,6 +1577,55 @@ test_expect_success '--negotiation-include avoids 
>> duplicates with negotiator' '
>>       test_line_count = 1 matches
>>   '
>> +test_expect_success 'remote.<name>.negotiationInclude used as default for -- 
>> negotiation-include' '
>> +    test_when_finished rm -f trace &&
>> +    setup_negotiation_tip server server 0 &&
>> +
>> +    # test the reset of the list on an empty value
>> +    git -C client config --add remote.origin.negotiationInclude refs/tags/ 
>> alpha_1 &&
>> +    git -C client config --add remote.origin.negotiationInclude "" &&
>> +    git -C client config --add remote.origin.negotiationInclude refs/tags/ 
>> beta_1 &&
>> +    GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
>> +        --negotiation-restrict=alpha_1 \
>> +        origin alpha_s beta_s &&
>> +
>> +    ALPHA_1=$(git -C client rev-parse alpha_1) &&
>> +    test_grep "fetch> have $ALPHA_1" trace &&
>> +    BETA_1=$(git -C client rev-parse beta_1) &&
>> +    test_grep "fetch> have $BETA_1" trace
>> +'
> 
> This test sets up the include list as [alpha_1, "", beta_1] which after
> the reset should become [beta_1], but the assertions in the test only
> check that alpha_1 (sent via the --negotiation-restrict option) and
> beta_1 (sent via the include) appear. If the reset of the list didn't
> work then the test still passes because alpha_1 is sent via the CLI
> option.

Good point. the negotiation-restrict option is making this less clear.
If I point the restrict option at alpha_2, then I think it exercises
things correctly.

Thanks,
-Stolee

