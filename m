Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793419;
	b=RMhM4iDcJJEomhI09veWSmK+gIhKmoap+1fG88vyBbt+RGR5xd3d3Zmxem53ObGzEaNa
	 Uyz2lbAaTJRd6rd4+T+neDunX722z3cjUuO/g1dzfDSiecWjt7p8Xj/+o6kZnSge6IKg4
	 bNb4bBv3ORQFsnZtuvwBCPk+CaHa4cx4OLAgjGBXlmNBlBIyklmaI3uH0MYkkxx0qAc/P
	 aGINf+YaKlsmw3eaej84F1YWxBHHmjJVdlRKqF/bJgfCRbdvg+zbPBSgXX8+EullZDJse
	 Nqx6MIdY+RSPRug9vtW0AkYnYlI5dLnX2MQl0TWO4hCq/LbxGN7UPyUd//eallqNNFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793419;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=+esR+pMJsTH81PZ6vClKqm+DbChFD42i2sRQKXWc25k=;
	b=WtTBnHRcaDhw1xyntd7vSE8FaJOQOxccqNge+o4i6S//ad9C5cPt6OyLxjaejxT0ze3A
	 bacB6ITGm1zgy86rysh0xgYZ0c5N5sSsFSBEeEOtkw8DByQtrydWxQNyKLsDzX4nedquk
	 V/TnM99Rqt8Ed4FKnjPv+uyIaOMt4IU/0MLax67UaVJHTWrpL1lMtIrSFrol2GoiuXZpX
	 9umrCjSwTEO8W9xKoaN7tTlFD1BfaYcoLOO/KRj6cyEDnheNo7fkoW4mlOvwVXUFg1OH/
	 8qGIwmBQwXsMVPvUTpPqpxCCkfBNezA/a8ireaKW0KVs61Q6U0up9ee8R3PRFtpJQ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="dc/lFyc+";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9218606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 11:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9218606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dc/lFyc+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793793418; x=1825329418;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=I16ISl0Bm/HhZXoW/jTdZ4k5b9OVxLUHBMaiu9KO0lw=;
  b=dc/lFyc+cA2UnEiMRJtpEoifhwVT4JTZur2WlocSosAH+NyDFiFiyLqB
   5Cb08sezO37p6mK2soAVFnw/KfK46+CIXVuMCsZaa/uOoc7rSjkLtBFdy
   0L1suQ0OParFb1YsFxIa3LPZxbvyiduhXnm/AqVhc6/RBX3VhZwGQPAxY
   SR7pBv9VPl6NaAgdSDrc6Vb6ayTJD+94X4bPeuCCE2Mxl+ca0knsCP602
   xisgH4Q6FTeaPg+52C811wwnaGwQvPNRVyHxmp1Lw2teRmlWvUlPlKMtf
   fedP+dvCL5lsvI9GQgsACJxQb8gtqxlD7UmbYAy1geTJaZAeqpAU8QKYA
   A==;
X-CSE-ConnectionGUID: 0T8ePxamSxmycxx+WXw1Rw==
X-CSE-MsgGUID: Iv5BtGKBRWaLO4hznemyfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2572891"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2572891"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:56:58 -0800
X-CSE-ConnectionGUID: pnHAAB2OQzWENF2sg7wQFw==
X-CSE-MsgGUID: ugn/N1SjTLaPmYKvpLVc1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6526460"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:56:56 -0800
From: "Patrick Ohly" <patrick.ohly@intel.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano
 <gitster@pobox.com>
Subject: Re: [BUG] Lazy fetch in partial clone fails with "not our ref"
 since 5946a564 (odb/source: make read_object_info() pluggable)
In-Reply-To: <CAL71e4MqMdGk5ryhNxvVNN6Z02+45B933ZfUuvj4hM92N5a6hA@mail.gmail.com>
Organization: Intel Deutschland GmbH, Dornacher Strasse 1, D-85622
 Feldkirchen/Munich
References: <yrjh1p92qc7w.fsf@pohly-mobl1.fritz.box>
 <CAL71e4MqMdGk5ryhNxvVNN6Z02+45B933ZfUuvj4hM92N5a6hA@mail.gmail.com>
Date: Wed, 04 Nov 2026 12:56:53 +0100
Message-ID: <yrjhld78q06y.fsf@pohly-mobl1.fritz.box>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> On Tue, 3 Nov 2026 at 14:31, Patrick Ohly <patrick.ohly@intel.com> wrote:
>>
>> Hello,
>>
>> "git merge" in a blobless partial clone fails with "not our ref" while
>> lazily fetching a missing object. This started to occur today in the
>> Kubernetes CI, completely breaking the merging of PRs. We should have
>> been using git 2.54.0, the affected version, for a few days at least
>> without issues, so it can't be ruled out that this is at least partly
>> caused by a change on the GitHub side. We are about to revert to git
>> 2.52.0 to unblock the Kubernetes project.
>>
>> [...]
>>
>> I bisected v2.52.0 (good) to v2.54.0 (bad). The first bad commit is:
>>
>> 5946a564cddc0bf471f27ae4c3fe205441e3ef65
>> odb/source: make `read_object_info()` function pluggable
>>
>> The parent, 3bc3177ad7 ( 2.53.0.185.g3bc3177ad7 ), is good.
>
> Thanks for the detailed report.  I think I have found the cause: I
> can reproduce the failure with your steps and make it go away with a
> small change to the loose object cache.

Any idea why this suddenly started to occur?

We were using 2.54.0 for several days without issues prior to the
failure. For example,
https://storage.googleapis.com/kubernetes-ci-logs/pr-logs/pull/batch/pull-kubernetes-cmd/2117551425255903232/clone-log.txt
merged several different PRs for
https://prow.k8s.io/view/gs/kubernetes-ci-logs/pr-logs/pull/batch/pull-kubernetes-cmd/2117551425255903232
using
us-docker.pkg.dev/k8s-infra-prow/images/clonerefs:v20261028-c06373a3e
as environment. It contains 2.54.0.

-- 
Best Regards

Patrick Ohly
Cloud Software Architect
