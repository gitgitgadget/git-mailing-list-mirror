Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795838941;
	b=dJb0davaiAcS1gYkEXoaEXsQkYIe7EYw7NI3Lgn328TxNrGjwlUd/sg7wC/T8x1i/r+k
	 StpJsv9CSwihJ2/hUNMxp1O6R86fkFAHdUPPpQbQgUV/ckx++8JUNLPqftF5Lh8xK0cYT
	 WE3st8z7B6BTTbtrxBFhNm56/D+gHX6uMYaL1LbKPwK5gG+slpxfba3mwNZgiDXQR6W97
	 2A/t4ivPTtjpF8mDayOav/Dyv1U4+/LJ+V1cHBNjkKJvMKar3PX4UKjW6Bo9AGaRS+hhi
	 us8iJ3DC+Z9gcoD0bJqR1fxDAPWJYGn/T9Q3ct5oA861CU02R1GymY1u+b/GAspbHMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795838941;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/8bx0QUH3MtlvBy2Zw44QVRv6t9O/n3UHpS8pnATt94=;
	b=i7TjjUXBuEcS6XYsg6FEdBO7iaih5c5NsVGOZ8NhussUCPnqR48LZKVexEvgRSmPjGAc
	 vwch110Ui87Sci1Da0Tb6/98M1thEtBunjvYx8ZQYTKis8Cn3ZwsylVZUqOGzVpYyppko
	 SPHp8BU63TmyKDwM0rOEHX//Qmbm8VZZbwXwfjwspWT8c3Tv0BRZv+D8ueUYoAmWIXTF5
	 M4k4/x0RAdT8W+13BdrzMoJoH4rwlwkuDjzId7e6z0f4QDc37Ol2QFfW0UsRmsA2JLzDM
	 bo04k9MCFTARbFZtYRB9OwzMBScsSQcOl714vR1yVhOOqMH61spxBAkIwJ5cj977jLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="MP/kS33c";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5ZYWJSH9;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD1606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 04:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EDD1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MP/kS33c;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5ZYWJSH9
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B57B01D003A9
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 23:08:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 27 Nov 2026 23:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795838939; x=1795925339; bh=/8bx0QUH3M
	tlvBy2Zw44QVRv6t9O/n3UHpS8pnATt94=; b=MP/kS33cnhVDPQdi7kdjVoaFKd
	U3dkupeAOmmV5OzWW+rRemSgGCAwtQOKNMhFLhhgqpGlQDVj+RqC8cs1vmC+NCg9
	gkot+I3g/GvvCDALh8QoFzb6MZ046WEz1d9OyaSbBZh6alCXm7IWJyAg0wm5D2oA
	6rgT6zIGp7fQsf+ah5zHqXQQrdqtWI08Qg0Px2UUZi/mv7Z7okdg5Amj4YTcvK+K
	KRjFUqxjIUBG1QZiTsCvRDJ7oWXYx2IsWKcyQGV+FmIPr9vPaNZQmfdy6T22bi1d
	kSwbrFOgK11jEgeu4NnFNxPyllQbnEtGaDPQDRVN0jmwoymJnBVupRmhzTmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795838939; x=1795925339; bh=/8bx0QUH3MtlvBy2Zw44QVRv6t9O/n3UHpS
	8pnATt94=; b=5ZYWJSH9YfVp+tBrkMRoKM+pXf0ovGV6Y++KCyR9qSv6oD41xYs
	MqCDQ0PRQSZDdUE3AivnVvustdzDWJxIL+nMwQvc7/37+w9acZec94+ulFnJiuF4
	5MN8UbHjtEUqzSfBnAzsPi+HUtI2U3m03C7gFSxv3KLM5Z8dESFnZI9Nx1vu0747
	eXN0J8L0MamfLRJQJPNWwbk7W5YFZ+4e1DJ/XP9//lPKJHWp3vQgzz/KdJRIBrG6
	RBfEPBmknTisWJryY6WUOum5drzfHXP4dRzRGRr9tI2x5Dl+cgffdOp4Sp1TBLHh
	tr89R0Q3CmggxZtIm2xVUKQCPAs3g8YetrQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795838939; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LxN9MyteT91MU8wRwwRCbSdEwujJaX8ybsuFK+Mj7z2ST43
	Jy9gKV82YYss5fn9Z+noNgA7b0CDysPvBmITj/d6YlPYZDxsTizflcIz67wElmjy
	ogARq+soTt0COuJ0uwv9np8oJBJRCnYhPC4uqPfv8YWqWaMoaEbyG9w9lbjHgcEl
	JmWaCb6b64aqxVp6UbAKc2MZHwauHYHsbvmV75Y+eKLT+urwTuLrZ3onDC7j17V0
	9i3w6kQMgBH9Zaidjr77tBi+sXdLsogdZZ/QMvtDkRG/DlGdPYggtabfzCiWhue1
	gESUT0DxMMANAWNMIZHjIu5U+H+8P0F8jvxEaSQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dyGhJOTnJsBAOlRFNJ6VrsKPUuY0BKjRWwErHz6rFRI=:IYfuelxVew5GJijyLwmByfgoiMKJ6duGR7nRAjqYbL0=;
X-ME-Sender: <xms:21MKa9wSDKhty8KyiUKaQ_rFdjn0UATtaoFojIQtN9MPu7iZtFRBiA>
    <xme:21MKa0RwFPRQNJ2kIb4Ge6SQ3Z0PzCNQKWwpFRbuDVBxogciZiai8zeyHi7DSQAbn
    7hdTwVIZrE2KM4Wt3EIutuW04xr2vrEt9NcwLQ1_CFoAnUpQuagRD0>
X-ME-Received: <xmr:21MKa8XyKi5SkLQRBJ5NZtZiQTSsEZ158CDGpvsgVgS1KggDFX2dVNVkAEdSrRb8n3HWAJcOYLrK6JZOI8xNrWtWNNWrtl9zVPkFIXM>
X-ME-Proxy-Cause: dmFkZTE0OsCyFW4Ar7aSAEFzYK8oFUI46D/HhWX1iCEWqnyS3SQyfj8skfowJE26JAUwhg
    hGe9OapVhNa8QFmYEp51GXX4vuydikpokeV14wYm8zsYN1wFAeg6zBC9bskqs0DwiAMvq/
    qLJzlS9JrIvwmpMk7LmHAJp2XV4CqVSCFVEbHly6pr6uppTfbFLorDjQOP+8fht0JG3gBu
    FVxZA5usr7H+surBj16GQ7H8pzu0UvroB92zcvflqcpLdS6kaRq7Zac2MD+r9yGypMXaEv
    fZgVwybUIm2mR5PCBE/si7lP2Uwhkr53NLr+FooeQM3KmiQQ1ifvUSn2PEEhEs4Vo4ncJP
    0X05bpF7EWxLnorYSS4AHRnapt5UVnlPdtDvYBGawFDxmYDwQvyN9lrlJK++g/Agj0ivB0
    ktofrmMox2rAESXLL8/Xbxid7UoSbc2oBOzyMY7QywlwbIBaOb31qJ5UKucUvnLFhqH0Vb
    DGonVwcw7j3cV8fQTRGQAUBA5XKGiFcVdaD7yQEC4ynP0VA7S7clYsc01RmJ4V/okFXH0M
    Vc34FJSfXf7enkQe7OPlTq0KxojJZ3HEqndrc4R8AJGIOUlRhHJJVHByJHe96idvj/G1FE
    UFZjiHn37Ky1QOXiYcsF0IutM6xoBYmKVKXlf0PBd6MD1lruubbnp4JY/GQg
X-ME-Proxy: <xmx:21MKa-ZpIrv4SuPWp4uYV66hbQd4uoAlVaoHM0BLukn0nhDgpEkBvg>
    <xmx:21MKa63wFFrDjd4N-eMGUzxOWPrpPsOYFyyLXTgq5ZBdE1-QltXQoQ>
    <xmx:21MKa4g1OF-chzj_o0KIPYNeXpft09qzDsW4tSPvpg8JtPclvp_ZKw>
    <xmx:21MKa2YOUtzamSVgcCgR5cWsxeua3VJ1bbJ8G-A5q9ApVrJPbuylxw>
    <xmx:21MKa7UCpr_Hf68OA4lSM8MLohiiRRDLgaI99DNB2BOWfAXmVNi3C4J_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 23:08:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alessio Attilio <attilio.alessio@protonmail.com>
Subject: Re: [PATCH v3 2/2] status: warn about stale submodule URLs
In-Reply-To: <9dc62830755b06ca2a95d307dd0b593d2a77c536.1795814853.git.gitgitgadget@gmail.com>
	(Alessio Attilio via GitGitGadget's message of "Fri, 27 Nov 2026
	21:27:33 +0000")
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
	<pull.2509.v3.git.git.1795814853.gitgitgadget@gmail.com>
	<9dc62830755b06ca2a95d307dd0b593d2a77c536.1795814853.git.gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 20:08:57 -0800
Message-ID: <xmqqv75hy4va.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

"Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Resolve relative URLs using the same paths as git submodule sync, and
> do not resolve the already-resolved cached URL a second time. Emit the
> warning on standard error for long, short, and porcelain status output,
> limited to submodules matched by the pathspec. Do not emit it when
> --ignore-submodules is given or when the wt-status machinery is used by
> another command.

The three-URL check now avoids double-resolving config_url and
gitmodules_url when the superproject remote URL is relative, and
switches from the get_value() config readers to the get_string()
family.

The check at the beginning of wt_status_check_submodule_urls() has
been replaced with different logic, but I thought that we agreed to
move the check to the caller, wt_status_print(), to avoid calling
this new helper?  There also is a glaring bug in the updated logic
for the "--ignore-submodules" check.

Other than these, the issues in the remainder of the patch I saw in
an earlier round got much better.

> diff --git a/submodule.c b/submodule.c
> index 3eab799f1f..24775b21b7 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -296,9 +296,13 @@ char *resolve_submodule_url(struct repository *repo, const char *rel_url,
>  			    const char *up_path, int quiet)
>  {
>  	char *remoteurl, *resolved_url;
> -	const char *remote = repo_default_remote(repo);
> +	const char *remote;
>  	struct strbuf remotesb = STRBUF_INIT;
>  
> +	if (!starts_with_dot_dot_slash(rel_url) && !starts_with_dot_slash(rel_url))
> +		return xstrdup(rel_url);

It would make resolve_submodule_url() self-contained if you moved this
early return into the preparatory patch (the one you will split out of
[1/2] for the "repository aware" step).  It would allow callers in
builtin/submodule--helper.c to drop duplicate checks if desired, too.

Also, starts_with_dot_dot_slash() assumes 'rel_url' is non-NULL;
wt_status_check_submodule_urls() checks sub->url first, so current
callers are safe, though an explicit NULL guard or doc comment in
submodule.h may be worth considering to prevent future surprises.

> diff --git a/wt-status.c b/wt-status.c
> index 238bb48643..5bcbe634df 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2692,8 +2696,124 @@ static void wt_porcelain_v2_print(struct wt_status *s)
>  	}
>  }
>  
> +static int submodule_has_custom_remote_url(struct repository *repo,
> +					  const char *path,
> +					  const char *gitmodules_url,
> +					  const char *config_url)
> +{
> +	struct repository subrepo = { 0 };
> +	const struct string_list *remote_urls = NULL;
> +	const char *remote;
> +	const char *remote_url;
> +	char *key, *up_path, *config_remote_url, *gitmodules_remote_url;
> +	int error_code, ret = 0;
> +
> +	if (!is_submodule_populated_gently(path, &error_code))
> +		return 0;
> +
> +	if (repo_submodule_init(&subrepo, repo, path,
> +				null_oid(repo->hash_algo)) < 0) {
> +		repo_clear(&subrepo);
> +		return 0;
> +	}
> +
> +	remote = repo_default_remote(&subrepo);
> +
> +	key = xstrfmt("remote.%s.url", remote);

In builtin/submodule--helper.c, sync_submodule() picks which submodule
remote to update by calling get_default_remote_submodule().

That helper checks repo_remote_from_url() against the resolved
.gitmodules URL first and falls back to repo_default_remote(&subrepo)
only if no remote matches.  If a submodule has both a customized
'origin' remote and an 'upstream' remote that matches what .gitmodules
has, sync_submodule() updates 'upstream' without touching 'origin',
whereas submodule_has_custom_remote_url() checks only 'origin' and
suppresses the warning.

Checking only the default remote is reasonable for the common
single-remote case, though it is worth keeping this subtle difference in
mind.

> +static void wt_status_check_submodule_urls(struct wt_status *s)
> +{
> +	int i;
> +
> +	if (!s->check_submodule_urls || s->ignore_submodule_arg)
> +		return;

I do not think checking .ignore_submodule_arg like this helps.  It is of
type "const char *", so I assume it holds string values like "none" that
you will get when

    git status --ignore-submodules=none

is run, right?  You do not want to punt in such a case.

Comparing against wt_longstatus_print() in wt-status.c shows how other
status checks handle this:

    if (s->submodule_summary &&
        (!s->ignore_submodule_arg ||
         strcmp(s->ignore_submodule_arg, "all"))) {

Using

    if (!s->check_submodule_urls ||
        (s->ignore_submodule_arg &&
         !strcmp(s->ignore_submodule_arg, "all")))
            return;

here keeps '--ignore-submodules=none' (and =dirty/=untracked) warning as
expected, and matches "suppressed when '--ignore-submodules=all' (or
bare '--ignore-submodules') is specified" in the docs and commit log.
