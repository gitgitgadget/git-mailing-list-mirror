Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F04126C18
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990357; cv=none; b=rWP4xGAiDQP7p4+bkGW32EOGrgMR3WGX1FG/vkQJwGuVDBa19nORmJ691X62wTpDLzVhNLgY3QrojdE/xBWYCm/A1Ti+ezQ1DkmWrnpQOk4Eg16M/qFkPi9I33vBveWYGDLAolXC4GR7f94KZiZBv5iKubJKCFDyT5RdImsNnnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990357; c=relaxed/simple;
	bh=5zQJvWjstXnRtgGdV4KvsBfNJloW7apApP6qvfr/ufI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4htP+7EeS6lXTlxLdMxdS99qlG7XpZXGtTjDzBhTvTgQAmHEwxxRPgrRTCjGcYaJb0FOlqnQl77iFnIPv6pz4Rpflfp1A1lQ+HWXNm7L6UpJyyXW33/kJRjFmpIqm09NkyzhUhRNSdQpZ/YJizUGr3Xh/w17GGiOWMyLf8fqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1FhZEH2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1FhZEH2"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso7818210a12.1
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990353; x=1738595153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zjMT4CG43/1VMnRXHhyxhv6cMbPd0DflpVlYne4a1E=;
        b=X1FhZEH2BRv+38hzH4T4QTjrij1suM0L1zIZ+GOZzYCo3RbD0nsDtE6gSQkpZvzI0/
         N86AoxEKShr/XXRlg6uOwKbZarL8MahoCcXleq8SaMyL5tcRr/PlJSDLp8H/qWR7O+Ly
         XaHkF1kqT1ABiPBbZ+GU9T1UGzFgjbouCI5ejjXZ/QIyTlbKNO8MhOoQbQAkC3b5Og/C
         hhIr5pjho0S/3/Mzg8w7PODzUPexr77FjRKKqEeEOgsWYJX4sEzzFB40sgcDb0zNq7/d
         zC4DQQoRJoD1vpM9RYwFARuUcu/5t60ZoNA2oAK0VY58hGLL4ftGdh/4SjrkPYrVUmfh
         7nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990353; x=1738595153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zjMT4CG43/1VMnRXHhyxhv6cMbPd0DflpVlYne4a1E=;
        b=wu4Gvm/DgpOQvIuuvDC8a/L3BgydShwOa3IMzOP5uYQEbargDZqH1XBSYDyCiZY9Uh
         d0vGKz65TJRNHQaqULAdUwPEaA0SLcngGAEEhWxP7QErVtiw6hIqlFIek6Jf14V9137W
         oyebZCfdh3moXOY3JoPuLbne/kuA0X3LTrC3P3wEl2NS+P1Em6RcLeTneMr6QAm3WP7J
         qJLGOI9YUEePiNEqS566FLP2dVnEy04wV+OHtfxIqShWynnKyvrubZJcFxM+gWtpZLse
         SBWqkekPfF7fK+c48E7Nza4HOEcAmriRzyeDw3rHVbrjUmY+7YXOfsa5ROQzLOZMfAST
         xRQg==
X-Gm-Message-State: AOJu0Yy2f6A3dD1eF0cJ9qQP5n1o1PNyzyjLOWbTQqZqzr8C0R454Vef
	HfyLL7kplZ5hzgmt/n42K2NKRYmCGh2H4whG7rISoSbkOYVLGvnJOLTWqTusGgcXMkz7qbQDluu
	BG/I9MC3s/0p7p/qSjnCMX91s2nE=
X-Gm-Gg: ASbGncsQ7m9AtLcYpp+h2dkPxxLQ+pwJEWm0c8aAngwknYP4XTMDWRcRbAebraVTWI+
	hEzhxKRglnIEXC+60RBuwSeykgJ0WfgCTP1BNqVrBqB/kZ8j8o/aM1cIRrykqJMn7
X-Google-Smtp-Source: AGHT+IGsJsLrWGXO1z5hxXfdZU3geG9k99gIl0qpshIQRECGkjQqOios59XpQr9HhdKuWQC8eLTP819AU4tp1zU5poY=
X-Received: by 2002:a05:6402:1d4b:b0:5dc:45e4:7705 with SMTP id
 4fb4d7f45d1cf-5dc45e47985mr1746700a12.6.1737990352529; Mon, 27 Jan 2025
 07:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com> <xmqqikrtnuyp.fsf@gitster.g>
 <CAP8UFD3bdEo1_bg+aX52xSGxmg9KfNrpiX+2LwUM-yDqjvfZbQ@mail.gmail.com> <xmqqed2go40d.fsf@gitster.g>
In-Reply-To: <xmqqed2go40d.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Jan 2025 16:05:40 +0100
X-Gm-Features: AWEUYZk_Ql9qDzhB3i5RMva4mpNP-L0_TMAEo8MgzTxalKTql0kd3dCzn4Hb-IM
Message-ID: <CAP8UFD2BSy5dL4r4LhuYgc7uvkVoL4uemuwzYXv-XrCKScpnwQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Introduce a "promisor-remote" capability
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 12:01=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > I noticed that fcb2205b77 (midx: implement support for writing
> > incremental MIDX chains, 2024-08-06)
> > which introduced GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL adds lines=
 like:
> >
> > GIT_TEST_MULTI_PACK_INDEX=3D0
> > GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=3D0
> >
> > at the top of a number of repack related test scripts like
> > t7700-repack.sh, so I guess that it should be OK to add the same lines
> > at the top of the t5710 test script added by this series. This should
> > fix the CI failures.
> >
> > I have made this change in my current version.
>
> Thanks.
>
> Is it because the feature is fundamentally incompatible with the
> multi-pack index (or its incremental writing),

It's not an incompatibility with the feature developed in this series.

Adding the following test script on top of master or even fcb2205b77
(midx: implement support for writing incremental MIDX chains,
2024-08-06), shows that it fails in the same way without any code
change to `git` itself from this series:

diff --git a/t/t5709-midx-increment-write.sh b/t/t5709-midx-increment-write=
.sh
new file mode 100755
index 0000000000..8801222374
--- /dev/null
+++ b/t/t5709-midx-increment-write.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+
+test_description=3D'test midx incremental write'
+
+. ./test-lib.sh
+
+export GIT_TEST_MULTI_PACK_INDEX=3D1
+export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=3D1
+
+# Setup the repository with three commits, this way HEAD is always
+# available and we can hide commit 1 or 2.
+test_expect_success 'setup: create "template" repository' '
+       git init template &&
+       test_commit -C template 1 &&
+       test_commit -C template 2 &&
+       test_commit -C template 3 &&
+       test-tool genrandom foo 10240 >template/foo &&
+       git -C template add foo &&
+       git -C template commit -m foo
+'
+
+# A bare repo will act as a server repo with unpacked objects.
+test_expect_success 'setup: create bare "server" repository' '
+       git clone --bare --no-local template server &&
+       mv server/objects/pack/pack-* . &&
+       packfile=3D$(ls pack-*.pack) &&
+       git -C server unpack-objects --strict <"$packfile"
+'
+
+check_missing_objects () {
+       git -C "$1" rev-list --objects --all --missing=3Dprint > all.txt &&
+       perl -ne 'print if s/^[?]//' all.txt >missing.txt &&
+       test_line_count =3D "$2" missing.txt &&
+       if test "$2" -lt 2
+       then
+               test "$3" =3D "$(cat missing.txt)"
+       else
+               test -f "$3" &&
+               sort <"$3" >expected_sorted &&
+               sort <missing.txt >actual_sorted &&
+               test_cmp expected_sorted actual_sorted
+       fi
+}
+
+initialize_server () {
+       count=3D"$1"
+       missing_oids=3D"$2"
+
+       # Repack everything first
+       git -C server -c repack.writebitmaps=3Dfalse repack -a -d &&
+
+       # Remove promisor file in case they exist, useful when reinitializi=
ng
+       rm -rf server/objects/pack/*.promisor &&
+
+       # Repack without the largest object and create a promisor pack on s=
erver
+       git -C server -c repack.writebitmaps=3Dfalse repack -a -d \
+           --filter=3Dblob:limit=3D5k --filter-to=3D"$(pwd)/pack" &&
+       promisor_file=3D$(ls server/objects/pack/*.pack | sed
"s/\.pack/.promisor/") &&
+       >"$promisor_file" &&
+
+       # Check objects missing on the server
+       check_missing_objects server "$count" "$missing_oids"
+}
+
+copy_to_server2 () {
+       oid_path=3D"$(test_oid_to_path $1)" &&
+       path=3D"server/objects/$oid_path" &&
+       path2=3D"server2/objects/$oid_path" &&
+       mkdir -p $(dirname "$path2") &&
+       cp "$path" "$path2"
+}
+
+test_expect_success "setup for testing promisor remote advertisement" '
+       # Create another bare repo called "server2"
+       git init --bare server2 &&
+
+       # Copy the largest object from server to server2
+       obj=3D"HEAD:foo" &&
+       oid=3D"$(git -C server rev-parse $obj)" &&
+       copy_to_server2 "$oid" &&
+
+       initialize_server 1 "$oid" &&
+
+       # Configure server2 as promisor remote for server
+       git -C server remote add server2 "file://$(pwd)/server2" &&
+       git -C server config remote.server2.promisor true &&
+
+       git -C server2 config uploadpack.allowFilter true &&
+       git -C server2 config uploadpack.allowAnySHA1InWant true &&
+       git -C server config uploadpack.allowFilter true &&
+       git -C server config uploadpack.allowAnySHA1InWant true
+'
+
+test_expect_success "setup for subsequent fetches" '
+       # Generate new commit with large blob
+       test-tool genrandom bar 10240 >template/bar &&
+       git -C template add bar &&
+       git -C template commit -m bar &&
+
+       # Fetch new commit with large blob
+       git -C server fetch origin &&
+       git -C server update-ref HEAD FETCH_HEAD &&
+       git -C server rev-parse HEAD >expected_head &&
+
+       # Repack everything twice and remove .promisor files before
+       # each repack. This makes sure everything gets repacked
+       # into a single packfile. The second repack is necessary
+       # because the first one fetches from server2 and creates a new
+       # packfile and its associated .promisor file.
+
+       rm -f server/objects/pack/*.promisor &&
+       git -C server -c repack.writebitmaps=3Dfalse repack -a -d &&
+       rm -f server/objects/pack/*.promisor &&
+       git -C server -c repack.writebitmaps=3Dfalse repack -a -d &&
+
+       # Unpack everything
+       rm pack-* &&
+       mv server/objects/pack/pack-* . &&
+       packfile=3D$(ls pack-*.pack) &&
+       git -C server unpack-objects --strict <"$packfile" &&
+
+       # Copy new large object to server2
+       obj_bar=3D"HEAD:bar" &&
+       oid_bar=3D"$(git -C server rev-parse $obj_bar)" &&
+       copy_to_server2 "$oid_bar" &&
+
+       # Reinitialize server so that the 2 largest objects are missing
+       printf "%s\n" "$oid" "$oid_bar" >expected_missing.txt &&
+       initialize_server 2 expected_missing.txt
+'
+
+test_done

Changing `export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=3D1` into
`export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=3D0` at the top of
the file makes it work.

This could probably be simplified, but I think it shows that it's just
the incremental writing of the multi-pack index that is incompatible
or has a bug when doing some repacking.

> or is it merely
> because the way the feature is verified assumes that the multi-pack
> index is not used, even though the protocol exchange, capability
> selection, and the actual behaviour adjustment for the capability
> are all working just fine?  I am assuming it is the latter, but just
> to make sure we know where we stand...

Let me know if you need more than the above, but I think it's fair for
now to just use:

GIT_TEST_MULTI_PACK_INDEX=3D0
GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=3D0

at the top of the tests, like it's done in the version 4 of this
series I will send soon.
