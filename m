Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283C1F956
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534438; cv=pass; b=Zvz0cqjr7yhjcE6dJorJ3yqRCXa67pnVtjxi+VkBTlaZJBwQfDrKg8Dv0YA1o1OMh375/sALovyMYyFkrgodqj2LmSlUj9rM1OGBI/myyTHNd7Yi9pw7AdVJjwOkcNtNCaT+4zx0yEOCpOMX14MY85E4jVysFgIzGdHV2031lBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534438; c=relaxed/simple;
	bh=C+8SjQgjnWpGRgsonI8SYfK41LeW9vQaq1xQputCCao=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jyuTkkXeyuUpqpy29/T7ECeee9/TmKt7BU4fyyVydS9ys5d2q0r8gM68XvxzQHHlWjJum/iLumhS5MQwVpZpTgz6wkYSZLNdUAjFSu2EayWIag/5YMHtI1bLcl9Yp/kZZ5ALBAcSItIbpREg408TQ0iMroavENaSWiYFt71jVoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=KQreg9Dy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="KQreg9Dy"
ARC-Seal: i=1; a=rsa-sha256; t=1754534427; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VH9GcEHhTf20KIEQBc6lgYZFYfswx0gqpuztFv8Y9WAcuwce9WZctlF6puCobXDi/hH6TGqs4RW++BaCcO73Zx6k082Wah3MYbgmfL3QdbizuOKz5hGODAUrkqwjZonTioX1Pqs+g1UIt6Cpei4LfxyhkODbMEhcKUWN8eCZHuw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754534427; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z7wRPl7ifV1zX3CznSyuK0YC2egTyjCSwyYe7918vLU=; 
	b=I4zlvh5/SlGqD0uVMwTRK/Qul3+ffN9qtgZ2weO14bJoqPMaxaWnb12u6zqCoGutqKi1SamWHHxhSRYaRhASa9gxmcXuZM7c+byxZ9MPV5K/uEPoQtXhIF9qFy3CeXYrO8q6yYMTHbW5nfJaROXWSDSz+1yhaQMLiCgx4IBzm/w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754534427;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Z7wRPl7ifV1zX3CznSyuK0YC2egTyjCSwyYe7918vLU=;
	b=KQreg9Dy4eddD6LJcUqYdOkXCHQV+n19BYNg63oCcgUdFpIklxgJqJJ4sCnteoba
	eduIFSkWfHg401QGJjRehQQd1pnEKNQVVRuGz/ifk/y8eqDS8CgZ0/k12OMImdOO16o
	gPXnVHYQ0G7KLVzy/vzSdwuxldI4x9JT2okEDgcw=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754534425794496.5178325796127; Wed, 6 Aug 2025 19:40:25 -0700 (PDT)
Date: Thu, 07 Aug 2025 10:40:25 +0800
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>
Cc: "git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-ID: <1988266b4aa.56246ae51710041.3057149707985856726@linux.beauty>
In-Reply-To: <499da566-66a8-4c38-a2b3-13c06092568f@gmail.com>
References: <20250803150059.402017-1-me@linux.beauty>
 <20250803150059.402017-3-me@linux.beauty>
 <e911d897-8664-40a7-b7a9-8eb9f71a8735@gmail.com> <499da566-66a8-4c38-a2b3-13c06092568f@gmail.com>
Subject: Re: [PATCH v3 2/2] rebase: support --trailer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail




 ---- On Wed, 06 Aug 2025 21:19:57 +0800  Phillip Wood <phillip.wood123@gma=
il.com> wrote ---=20
 > Hi Li
 >=20
 > I had a couple more thoughts about the tests ...
 >=20
 > On 06/08/2025 11:28, Phillip Wood wrote:
 > > On 03/08/2025 16:00, Li Chen wrote:
 > >> +create_expect() {
 > >> +    cat >"$1" <<-EOF
 > >> +        $2
 > >> +
 > >> +        Reviewed-by: Dev <dev@example.com>
 > >> +    EOF
 > >> +}
 > >> +
 > >> +test_expect_success 'setup repo with a small history' '
 > >> [...]
 >  >> +    create_expect third-signed    "third"                 &&>> +   =
=20
 > create_expect conflict-signed "conflict"
 > >=20
 > > Normally we create the "expect" file in the test where it is used.
 >=20
 > Thinking about this some more, if we want to use test_commit_message=20
 > then I think we can change create_expect to write to stdout and do
 >=20
 >     test_commit_message HEAD <<-EOF
 >     $(create_expect first)
 >     EOF
 >=20
 > rather than having to create a file.
 >=20
 > >> +
 > >> +test_expect_success 'reject empty --trailer argument' '
 > >> [...]
 > >> +test_expect_success 'reject trailer with missing key before separato=
r' '
 >=20
 > Should we also test for a missing value or are trailers without a value=
=20
 > allowed?
 >=20
 > >> +        git rebase -m \
 > >> +            --trailer "Signed-off-by: Dev A <a@ex.com>" \
 > >> +            --trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 &&
 >=20
 > Lets use example.com here rather than some random domain that might=20
 > actually exist.
 >=20
 > >> +test_expect_success 'rebase -m --trailer adds trailer after conflict=
s' '
 > >> +    git reset --hard third &&
 > >> +    test_must_fail git rebase -m \
 > >> +        --trailer "Reviewed-by: Dev <dev@example.com>" \
 > >> +        second third &&
 > >> +    git checkout --theirs file &&
 > >> +    git add file &&
 > >> +    git rebase --continue &&
 >=20
 > This checks that the commit with conflicts has a trailer added but it=20
 > does not check that the commits picked by "git rebase --continue" do. To=
=20
 > check that we actually save the trailers and use them when continuing we=
=20
 > need to add a fourth commit on top of third and check that has a trailer=
=20
 > add here as well.
 >=20
 > A couple more thoughts:
 >=20
 >   - We should check that
 >       git -c trailer.review.key=3DReviewed-by rebase \
 >           --trailer=3Dreview=3D"Dev <dev@example.com>"
 >     adds a "Reviewed-by:" trailer. We can do that by changing one of the
 >     tests in this patch rather than adding a new one. This checks that w=
e
 >     accept '=3D' as a separator as well a respecting the config.
 >=20
 >   - We should check that the todo list
 >       pick first
 >       fixup second
 >     adds the trailer as expected and that
 >       pick first
 >       fixup -C second
 >     also works. To do that we will need to source lib-rebase.sh at the
 >     start of the test file and add a test that uses set_replace_editor()
 >     which should be called in a subshell.
 >=20
 >=20
 > Do please ask if you have any questions about these suggestions
 >=20
 > Thanks
 >=20
 > Phillip
 >=20
 >=20
Regards,

Li=E2=80=8B

