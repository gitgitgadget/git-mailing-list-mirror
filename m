Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76B397AEF
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308629; cv=none; b=Ro3aCjTiI77XJyEXQ0rGVImxSc7zltH+0ncLDuR4lVvdwWtaACd1027paTlsgqcjgnGtfUfClkZ83X2pZ0yYyc28eoHuOThG87kNBKhmWdpMWJF3pg/SZnt5WQiKdWMzk52fWpX5JGZd/kpjDEojsGVW31g1ShWf5BVxUGcrsro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308629; c=relaxed/simple;
	bh=fqnmEdNjVFIdE6ZvCCq12hrlhb67IEpqvhLTneWtemk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUdtRWn+f9dtzmUDgE5BFujKp60JIQNgosgFH6j+A7IIMTKeSLQOlSpcuHn+5tHGCXG9nxvvqKzX0O469byiIBN3VOCTsTIIjsLGE//u3egngm9ft0ZsjqCPvoy+KJ65m0eJg9l9uRFEskOn6LXHykOM3bfMdUuHfoU68qJKkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=jyVJ67xJ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kpxL2NkU; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="jyVJ67xJ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="kpxL2NkU"
DKIM-Signature: a=rsa-sha256; b=jyVJ67xJUvIeA+hy22E3tZ5sDc2sm/ycmvUWz06wOaPKhSVuFdPyNHo8X9UVg0K/McbuwzRg1J2IqkNTovOdVWpGoMLEswGZL/2FUy+OouVkKaD9qJztwRzV/s40fxueTHS6SiGBnf8878B2N3HCZXdUeCWs5yWO+cICT8OSOoWoTeEmG6KRWQJVd0OzCW07GI9bJSD7TyFgvUrsa84Kn8QvBa/1+/GFT+NJDT0TOM605CGazuLzDm7A8PZZYG0Z4GHHOQvzO24Y/m6/XvMZ5W7lNximLuD6F1FHaalO/izi8/0afw5pOZOqKzegbPyH4Ic9k3wDnOlsGx0OtTdcFg==; s=purelymail1; d=malon.dev; v=1; bh=fqnmEdNjVFIdE6ZvCCq12hrlhb67IEpqvhLTneWtemk=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=kpxL2NkUDo9n/a0rl/T0TUWMqTOMQnYWarYSfoI/2zkPYgHqvfpmEvJPYkYJJKBWcfbyUmdFreTWI1xgTSVxnsihOnLQ4RGivdfM7v3MDaMyFwzwQtJekXBfFbRlqWyVwVou6vZ49DFN/Ew9ANwsFWqZ4TBqOdZAfCI/p9hwGHROGUVXhZ7VN0cXnOO/eL9JxpeboVKymdLgqaUaejrSUpWLZDGwAS1RydJ4W8qN7SiAfytlxMssfH32Q9nlCCwL/PC7z20q/tqZs42qfaRHIA7t2QMTaRe4hrqYPjsXiWVvSEUxtB/k4upnR8na4jDikbhwZ65G2PfiTfnJ12SVFA==; s=purelymail1; d=purelymail.com; v=1; bh=fqnmEdNjVFIdE6ZvCCq12hrlhb67IEpqvhLTneWtemk=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -428462662;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 01 Jun 2026 10:10:13 +0000 (UTC)
Message-ID: <e0d5b1af-b040-49e2-90f9-d8325682826b@malon.dev>
Date: Mon, 1 Jun 2026 18:10:08 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] environment: move 'trust_executable_bit' into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260530160520.77859-1-cat@malon.dev>
 <20260530160520.77859-4-cat@malon.dev> <xmqq7bokebct.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqq7bokebct.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Junio,

Thanks for the feedback!

On 5/31/26 07:17, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
>=20
>> diff --git a/apply.c b/apply.c
>> index 249248d4f2..73ca9907f8 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -3890,10 +3890,12 @@ static int check_preimage(struct apply_state *st=
ate,
>>   =09}
>>  =20
>>   =09if (!state->cached && !previous) {
>> +=09=09struct repo_config_values *cfg =3D repo_config_values(the_reposit=
ory);
>> +
>>   =09=09if (*ce && !(*ce)->ce_mode)
>>   =09=09=09BUG("ce_mode =3D=3D 0 for path '%s'", old_name);
>>  =20
>> -=09=09if (trust_executable_bit || !S_ISREG(st->st_mode))
>> +=09=09if (cfg->trust_executable_bit || !S_ISREG(st->st_mode))
>>   =09=09=09st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
>>   =09=09else if (*ce)
>>   =09=09=09st_mode =3D (*ce)->ce_mode;
>> diff --git a/read-cache.c b/read-cache.c
>> index 54150fe756..18af533649 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -204,10 +204,12 @@ void fill_stat_cache_info(struct index_state *ista=
te, struct cache_entry *ce, st
>>  =20
>>   unsigned int ce_mode_from_stat(const struct cache_entry *ce, unsigned =
int mode)
>>   {
>> +=09struct repo_config_values *cfg =3D repo_config_values(the_repository=
);
>> +
>>   =09if (!has_symlinks && S_ISREG(mode) &&
>>   =09    ce && S_ISLNK(ce->ce_mode))
>>   =09=09return ce->ce_mode;
>> -=09if (!trust_executable_bit && S_ISREG(mode)) {
>> +=09if (!cfg->trust_executable_bit && S_ISREG(mode)) {
>>   =09=09if (ce && S_ISREG(ce->ce_mode))
>>   =09=09=09return ce->ce_mode;
>>   =09=09return create_ce_mode(0666);
>=20
> How hot are the code paths that call into this helper function?  In
> the original under some condition, it was possible to return without
> even consulting the trust_executable_bit variable, but in the
> updated code, the helper unconditionally makes a call to the
> repo_config_values() helper function even before it knows it needs
> to know the value of trust_executable_bit.

That sounds reasonable to me. I=E2=80=99ll adjust the conditional logic in =
some=20
of the statements so that they short-circuit appropriately to avoid=20
performance overhead.

>=20
>> @@ -217,11 +219,13 @@ unsigned int ce_mode_from_stat(const struct cache_=
entry *ce, unsigned int mode)
>>  =20
>>   static unsigned int st_mode_from_ce(const struct cache_entry *ce)
>>   {
>> +=09struct repo_config_values *cfg =3D repo_config_values(the_repository=
);
>> +
>>   =09switch (ce->ce_mode & S_IFMT) {
>>   =09case S_IFLNK:
>>   =09=09return has_symlinks ? S_IFLNK : (S_IFREG | 0644);
>>   =09case S_IFREG:
>> -=09=09return (ce->ce_mode & (trust_executable_bit ? 0755 : 0644)) | S_I=
FREG;
>> +=09=09return (ce->ce_mode & (cfg->trust_executable_bit ? 0755 : 0644)) =
| S_IFREG;
>>   =09case S_IFGITLINK:
>>   =09=09return S_IFDIR | 0755;
>>   =09case S_IFDIR:
>=20
> Ditto.
>=20
>> @@ -321,6 +325,7 @@ static int ce_modified_check_fs(struct index_state *=
istate,
>>   static int ce_match_stat_basic(const struct cache_entry *ce, struct st=
at *st)
>>   {
>>   =09unsigned int changed =3D 0;
>> +=09struct repo_config_values *cfg =3D repo_config_values(the_repository=
);
>>  =20
>>   =09if (ce->ce_flags & CE_REMOVE)
>>   =09=09return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
>> @@ -331,7 +336,7 @@ static int ce_match_stat_basic(const struct cache_en=
try *ce, struct stat *st)
>>   =09=09/* We consider only the owner x bit to be relevant for
>>   =09=09 * "mode changes"
>>   =09=09 */
>> -=09=09if (trust_executable_bit &&
>> +=09=09if (cfg->trust_executable_bit &&
>>   =09=09    (0100 & (ce->ce_mode ^ st->st_mode)))
>>   =09=09=09changed |=3D MODE_CHANGED;
>>   =09=09break;
>=20
> Ditto.
>=20
>> @@ -732,6 +737,8 @@ int add_to_index(struct index_state *istate, const c=
har *path, struct stat *st,
>>   =09=09=09  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
>>   =09unsigned hash_flags =3D pretend ? 0 : INDEX_WRITE_OBJECT;
>>  =20
>> +=09struct repo_config_values *cfg =3D repo_config_values(the_repository=
);
>> +
>=20
> Lose the excess blank line before the new declaration.
>=20
>>   =09if (flags & ADD_CACHE_RENORMALIZE)
>>   =09=09hash_flags |=3D INDEX_RENORMALIZE;
>>  =20
>> @@ -752,7 +759,7 @@ int add_to_index(struct index_state *istate, const c=
har *path, struct stat *st,
>>   =09=09ce->ce_flags |=3D CE_INTENT_TO_ADD;
>>  =20
>>  =20
>> -=09if (trust_executable_bit && has_symlinks) {
>> +=09if (cfg->trust_executable_bit && has_symlinks) {
>>   =09=09ce->ce_mode =3D create_ce_mode(st_mode);
>>   =09} else {
>>   =09=09/* If there is an existing entry, pick the mode bits and type
>=20
> Almost all of these places that care about trust_executable_bit also
> cares about has_symlinks.  I wonder if they should be converted to
> repo-local settings in the same series.

That=E2=80=99s true: I had actually planned to start migrating has_symlinks=
 as=20
soon as this series was approved. Since you think it would be better to=20
merge them into a single series, I=E2=80=99ll go ahead and do that ;)

Thanks, yuchen

