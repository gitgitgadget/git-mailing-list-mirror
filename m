Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4E3644CB
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752325; cv=none; b=aGQKKHfqdCC6AVWrExWES5/UR3D3jwLyDn09Tq4fVJFmpc83gW+sAgRZWFxmzLzcaon+xxRYdyzqWyyAwXE5ImtXySGPk09VC3vhq+eVcH3jXTDej6na2HQ9JIlcZSOIKYxrTdKf82myRYTdaWcu/2WO9xwZbENmbTUjKbbID8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752325; c=relaxed/simple;
	bh=++m+3zWc1/pa3b/yT2WWMlMEVhQZbUXisxlxRiAm1Wc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BuApvbDljviupkQ6m+ti0DF2khaXFC18biTXiLvgTsI/Qs1g9vjazX+Xsm3aE3F+j2uTTr+43g2GGjGT2JKY8+i7uSjxvbR/vr13NGW22YRCzsqmtb16IFAuBzL6orJIb2sqz+lig8Peya2WMa6eDCWIW4CJcWPOajJmie3x5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev; spf=pass smtp.mailfrom=braithwaite.dev; dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b=wqClOeJx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJseUvj5; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b="wqClOeJx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJseUvj5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A7CE1D00247;
	Thu,  5 Mar 2026 18:12:02 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-05.internal (MEProxy); Thu, 05 Mar 2026 18:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=braithwaite.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772752322; x=1772838722; bh=oGUtGDe+UTzPSf5eph3cjRH3pgLwQnqm
	T+Gd1pPRbS4=; b=wqClOeJxw4iFXp+eSWJCTC5GDYOQreHQRLFTkgyOgkB1Pg7D
	Upk9rdeWFObL50RXbWKU3gKKz1H5M9n0yRte43r7ooFOcQkuQ+XtNQlcB/1Idnai
	UcQKHEm0c3fhQGyc+z7++ykHySsOU59bgOCUEshipG1ghREEusTJSAkpXyKIIKRx
	vYL2hLt7/hlnmk7UecZ3CPZd5RrLJ5apxgXh0xD2GsM52cwzi4UXVfPu5yY+ySwN
	5FJB23TE/6kNmrln/K1DdbcPWjvKwWGCGBxHR+5ds336jiMcG/+kZY6Z8+ZxxBdP
	qFg6DD2oY3qni517MNFHEtFz82vkkockRF3D7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772752322; x=
	1772838722; bh=oGUtGDe+UTzPSf5eph3cjRH3pgLwQnqmT+Gd1pPRbS4=; b=W
	JseUvj5nLpH1TeuphxbmZ2bJzMqqSk3h7MGZ+0bNkQc199druCsBXNfvfuJUroOX
	Lt88nFkzb6G03ruIdTkCpTq/a1GT8/guZsRIC5kguvCfemtuOA5PvmNzcjaogPFN
	XZeEF4IKf1XTQfFEiESUPOOfEVo0VMmMUgAodwRN0dJdHlHPY6Ig3ymeIO/OV9lT
	V6yhqv25mWzkGMMvITsMzd7DdrQNlGDCfkn46h6MUA5wSCa79Oy4YxwQpQfxTGMF
	N/1PdoX2H7JSr3pkPMonb2Wy+oi1J1oXNnOrisGNNMz07ubb+iAA3LVD+45eb4jP
	2ZQVoo7zNOWWnKmmh0ssA==
X-ME-Sender: <xms:wQ2qaXFlG0A4wbxq8PtFR168SGkSCgoudaew4ztYxYGDg-JhSxBXzQ>
    <xme:wQ2qafKKiEbIaSqjWmRBDDm65j5Ke5xzb1VhNQ4jKV4CiXQ3x-FH-m8LpXkT_88f4
    RZXkc-ZTgOjI2rA5p0nXsH9BaAdxptoCtY5MrJ5i0FYm_KETX-GVKJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehlrghn
    uceurhgrihhthhifrghithgvfdcuoegrlhgrnhessghrrghithhhfigrihhtvgdruggvvh
    eqnecuggftrfgrthhtvghrnhepkedugefhudefveeileevheehudetjeehleduvefgkefg
    udejvdffgfehkeeigefhnecuffhomhgrihhnpehgihhthhhusgdrtghomhdptghorhhprd
    gtohhmpdhurhhlrddqhihouhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegrlhgrnhessghrrghithhhfigrihhtvgdruggvvhdpnhgspghrtg
    hpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgr
    nhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhies
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wQ2qaWZ0Y0_-YUCF5Yw_6A92VWcNGbCVdx_VAqBDo3T-NMEcjByilQ>
    <xmx:wQ2qaTZR3V7MIfJHoS4Snb2oH3KFvFDQ57PTlo04bZiP-ngdJ_BmuA>
    <xmx:wQ2qaXmmOBUievoP7n7H0eWn-E3YcxHB346YBWAa1bdgbpCSrZAVTA>
    <xmx:wQ2qaW2V8zTaiCZ6tHH0LNyTZ5cFGh_Q12pVD9yRLlz9dYGP0ZTLaw>
    <xmx:wg2qaRT_Jp5zIgueyjYnAZYVtAH1VkDyS1VkZD_PiyLtxL3ybUIdgfc->
Feedback-ID: i1a914699:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A51191EA006B; Thu,  5 Mar 2026 18:12:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AItb9aa6r_v7
Date: Thu, 05 Mar 2026 15:11:41 -0800
From: "Alan Braithwaite" <alan@braithwaite.dev>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Alan Braithwaite" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 christian.couder@gmail.com, jonathantanmy@google.com, me@ttaylorr.com,
 "Jeff King" <peff@peff.net>
Message-Id: <f0521097-1ec6-4e47-88d5-8c5be47ded3b@app.fastmail.com>
In-Reply-To: <xmqqcy1i3xt4.fsf@gitster.g>
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
 <pull.2058.v2.git.1772672251281.gitgitgadget@gmail.com>
 <xmqqcy1i3xt4.fsf@gitster.g>
Subject: Re: [PATCH v2] clone: add clone.<url>.defaultObjectFilter config
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> This is unlike how http.<url>.<var> configuration variables work,
> and while I can see that server operators may not want to see users
> set clone.defaultObjectFilter and affect traffic with _all_ sites, I
> am afraid that this design choice may appear a bit counter-intuitive
> to end users.

Funny enough, I actually prefer that but gathered from the previous
commentary that it wasn't desired.  I'd be more than content to add it.

Junio C Hamano wrote:
> I cannot convince myself that a new structure only to hold a single
> "char *" member is not over-engineering.  Wouldn't it work equally
> well (unless you have an immediate plan to add more members to the
> struct, that is):

You're right, it's been a while I've written C.  Thanks for catching
that.  I think my mind was going somewhere else with it, but YAGNI.

Junio C Hamano wrote:
> However, I think you want to leave the .cascade_fn NULL; you do not
> want urlmatch_config_entry() to call git_clone_config() AGAIN on the
> configuration variables, as the first call to repo_config() before
> we call parse_options() should have already handled them, no?

Good catch. I'll fix it. Will set cascade_fn to NULL so the second
pass only looks at clone.<url>.defaultObjectFilter entries.

Thanks for the review and for your patience as I shake the gopher
out of me and figure out how to do real programming again.

Thanks,
- Alan

On Thu, Mar 5, 2026, at 11:01, Junio C Hamano wrote:
> "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Alan Braithwaite <alan@braithwaite.dev>
>>
>> Add a new configuration option that lets users specify a default
>> partial clone filter per URL pattern.  When cloning a repository
>> whose URL matches a configured pattern, git-clone automatically
>> applies the filter, equivalent to passing --filter on the command
>> line.
>>
>>     [clone "https://github.com/"]
>>         defaultObjectFilter =3D blob:limit=3D5m
>>
>>     [clone "https://internal.corp.com/large-project/"]
>>         defaultObjectFilter =3D blob:none
>>
>> URL matching uses the existing urlmatch_config_entry() infrastructure,
>> following the same rules as http.<url>.* =E2=80=94 you can match a do=
main,
>> a namespace path, or a specific project, and the most specific match
>> wins.
>>
>> The config only affects the initial clone.  Once the clone completes,
>> the filter is recorded in remote.<name>.partialCloneFilter, so
>> subsequent fetches inherit it automatically.  An explicit --filter
>> flag on the command line takes precedence.
>
> The motivation behind the change is clearly described.  Reusing the
> existing urlmatch_config_entry() infrastructure is very appropriate
> as it makes the feature intuitive for those familiar with
> http.<url>.* settings.
>
>> Only the URL-qualified form (clone.<url>.defaultObjectFilter) is
>> honored; a bare clone.defaultObjectFilter without a URL subsection
>> is ignored.
>
> This is unlike how http.<url>.<var> configuration variables work,
> and while I can see that server operators may not want to see users
> set clone.defaultObjectFilter and affect traffic with _all_ sites, I
> am afraid that this design choice may appear a bit counter-intuitive
> to end users.
>
>
>> Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>
>
>>  Documentation/config/clone.adoc | 26 ++++++++++++
>>  builtin/clone.c                 | 68 ++++++++++++++++++++++++++++++
>>  t/t5616-partial-clone.sh        | 73 +++++++++++++++++++++++++++++++=
++
>>  3 files changed, 167 insertions(+)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 45d8fa0eed..5e20b5343d 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -44,6 +44,7 @@
>>  #include "path.h"
>>  #include "pkt-line.h"
>>  #include "list-objects-filter-options.h"
>> +#include "urlmatch.h"
>>  #include "hook.h"
>>  #include "bundle.h"
>>  #include "bundle-uri.h"
>> @@ -757,6 +758,65 @@ static int git_clone_config(const char *k, const=
 char *v,
>>  	return git_default_config(k, v, ctx, cb);
>>  }
>> =20
>> +struct clone_filter_data {
>> +	char *default_object_filter;
>> +};
>> +
>> +static int clone_filter_collect(const char *var, const char *value,
>> +				const struct config_context *ctx UNUSED,
>> +				void *cb)
>> +{
>> +	struct clone_filter_data *data =3D cb;
>> +
>> +	if (!strcmp(var, "clone.defaultobjectfilter")) {
>> +		free(data->default_object_filter);
>> +		data->default_object_filter =3D xstrdup(value);
>> +	}
>> +	return 0;
>> +}
>
> This will segfault with a "value-less truth", i.e.,
>
> 	[clone "<URL>"]
> 		defaultObjectFilter
>
> so there should be=20
>
> 		if (!value)
> 			return config_error_nonbool(var);
>
> in it.
>
> I cannot convince myself that a new structure only to hold a single
> "char *" member is not over-engineering.  Wouldn't it work equally
> well (unless you have an immediate plan to add more members to the
> struct, that is):
>
> 	char **filter_spec_p =3D cb;
>
> 	if (!strcmp(var, "clone.defaultobjectfilter")) {
> 		if (!value)
> 			retgurn config_error_nonbool(var);
> 		free(*filter_spec_p);
> 		*filter_spec_p =3D xstrdup(value);
> 	}
> 	return 0;
>
>> +/*
>> + * Look up clone.<url>.defaultObjectFilter using the urlmatch
>> + * infrastructure.  Only URL-qualified forms are supported; a bare
>> + * clone.defaultObjectFilter (without a URL) is ignored.
>> + */
>> +static char *get_default_object_filter(const char *url)
>> +{
>> +	struct urlmatch_config config =3D URLMATCH_CONFIG_INIT;
>> +	struct clone_filter_data data =3D { 0 };
>> +	struct string_list_item *item;
>> +	char *normalized_url;
>> +
>> +	config.section =3D "clone";
>> +	config.key =3D "defaultobjectfilter";
>> +	config.collect_fn =3D clone_filter_collect;
>> +	config.cascade_fn =3D git_clone_config;
>> +	config.cb =3D &data;
>> +
>> +	normalized_url =3D url_normalize(url, &config.url);
>> +
>> +	repo_config(the_repository, urlmatch_config_entry, &config);
>> +	free(normalized_url);
>
> This forces a second full scan of the configuration space.  But it
> cannot be avoided, because the existing repo_config() call has to
> happen early before we call parse_options() to give us the
> configured default to overwrite with the command line, and we would
> not know what our URL is before we called parse_options().
>
> However, I thihk you want to leave the .cascade_fn NULL; you do not
> want urlmatch_config_entry() to call git_clone_config() AGAIN on the
> configuration variables, as the first call to repo_config() before
> we call parse_options() should have already handled them, no?
>
> Thanks.
