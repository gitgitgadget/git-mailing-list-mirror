Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795379408;
	b=jJ86NUcSs+fHC7tzZBxFk4cJ5z7HNo2z6++sE+CzJeZqcftS5tu5Wak664l1Ce91WFvl
	 umpSmiLGyjB51NssjBY20/bQJG676u6zGLySNKuapWe4HF94QsbEANGNiPkDztBV2BFHf
	 8zcQRGFSgLgOfJPEbrHMCdbt5xj8GE4Opm+I9mY0XEmd/PFI+YbT0GRrcjn1wuND6BIiz
	 +bh1PvsRBa6kdbUxjt51hwYQBJCGDPUcoNTcrVg+xdY2Fhh+PJV3L4vHe5Cm9UE+huQe9
	 XzRuJU+ajPz4QrRBSRUbb0BlRY230iB/FGLq0/2xZRqTXyR3mt22Wsg7TlPDw+L07xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795379408;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FTzazfTufDINUNu1k/6O9kPxKwEPjTr5EbPgcOm7tno=;
	b=vRZqraNjYyVmDzVqMBDlUdLqGBxGRZiS/32J6X8zrnZFJCdJJge+SO35/2BasyXMuwaF
	 61uoiguJGEhxDL7Xm1+PgMLcHPmJYEOLXr1qOKR/gDdbE/unUdc8btksF7yn0DnJnVVQM
	 O0mJAsPEvdH1hNYKNN8R5j/DranCe2cs+DG6fP7jUb5fwLjtJ77Jkkv1KyVqXfRFH/29b
	 7f/UkqvwzE7XBuNtnvO2ef4DkOCnDwUC9+eP/vZTlonIvIoYdJdQfFytb/BK0EgpH0vas
	 lGRRTgZI4xI20qK4/OPERSHNHMPJfnaQZsWlI5y3k2RebsqmNAzyi65jbPsrziP7smQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=L1CnvMCW;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C68606A327
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 20:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C68606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=L1CnvMCW
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AMKU45g2251468
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 21:30:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795379405; bh=FTzazfTufDINUNu1k/6O9kPxKwEPjTr5EbPgcOm7tno=;
	h=From:To:Subject:Date;
	b=L1CnvMCWFqGXVXnk2M/JBipOkNCBoHYKrqU5uuXmA62jQ4cAG95nN7rDHWgXB/DZH
	 gTup8UWNa/MEUO0IC9iCch605r+APigGj+PJrK5OIjN1uUAyqBrA4wSbBxI0huPCcT
	 vyjMiJjCuVyQVvAydf9A83bkFJ1vsrVRN0ugIGHw=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Subject: [BUG] T7527 fails with 2/70 tests
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 22 Nov 2026 21:30:04 +0100
Message-ID: <gh1p8cmwxf.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I noticed T7527 (on origin/master) is failing with 2 tests
and before I start digging I want to ask if this is a known problem.

What I already saw is a core.* in a temp directory which (among others)
causes the test_cmp to fail...

Regards,

Dirk

ok 1 - explicit daemon start and stop
ok 2 - implicit daemon start
ok 3 - implicit daemon stop (delete .git)
ok 4 - implicit daemon stop (rename .git)
ok 5 # skip implicit daemon stop (rename GIT~1) (missing SHORTNAMES,MINGW o=
f MINGW,SHORTNAMES)
ok 6 # skip implicit daemon stop (rename GIT~2) (missing SHORTNAMES,MINGW o=
f MINGW,SHORTNAMES)
ok 7 - cannot start multiple daemons
ok 8 - setup
ok 9 - update-index implicitly starts daemon
ok 10 - status implicitly starts daemon
ok 11 - edit some files
ok 12 - create some files
ok 13 - delete some files
ok 14 - rename some files
ok 15 - rename directory
ok 16 - file changes to directory
ok 17 - directory changes to a file
ok 18 - rapid nested directory creation
ok 19 - flush cached data
ok 20 - setup worktree base
ok 21 - worktree with .git file
ok 22 - cleanup worktrees
ok 23 - Matrix: setup for untracked-cache,fsmonitor matrix
ok 24 - Matrix[uc:false] disable untracked cache
ok 25 - Matrix[uc:false][fsm:false] disable fsmonitor
ok 26 - Matrix[uc:false][fsm:false] edit_files
ok 27 - Matrix[uc:false][fsm:false] delete_files
ok 28 - Matrix[uc:false][fsm:false] create_files
ok 29 - Matrix[uc:false][fsm:false] rename_files
ok 30 - Matrix[uc:false][fsm:false] file_to_directory
ok 31 - Matrix[uc:false][fsm:false] directory_to_file
ok 32 - Matrix[uc:false][fsm:false] move_directory_contents_deeper
ok 33 - Matrix[uc:false][fsm:false] move_directory_up
ok 34 - Matrix[uc:false][fsm:false] move_directory
ok 35 - Matrix[uc:false][fsm:true] enable fsmonitor
ok 36 - Matrix[uc:false][fsm:true] edit_files
ok 37 - Matrix[uc:false][fsm:true] delete_files
ok 38 - Matrix[uc:false][fsm:true] create_files
ok 39 - Matrix[uc:false][fsm:true] rename_files
ok 40 - Matrix[uc:false][fsm:true] file_to_directory
ok 41 - Matrix[uc:false][fsm:true] directory_to_file
ok 42 - Matrix[uc:false][fsm:true] move_directory_contents_deeper
not ok 43 - Matrix[uc:false][fsm:true] move_directory_up
#=09
#			matrix_clean_up_repo &&
#			$fn &&
#			if test $uc =3D false && test $fsm =3D false
#			then
#				git status --porcelain=3Dv1 >.git/expect.$fn
#			else
#				git status --porcelain=3Dv1 >.git/actual.$fn &&
#				test_cmp .git/expect.$fn .git/actual.$fn
#			fi
#=09=09
ok 44 - Matrix[uc:false][fsm:true] move_directory
ok 45 - Matrix[uc:false][fsm:true] disable fsmonitor at end
ok 46 - Matrix[uc:true] enable untracked cache
ok 47 - Matrix[uc:true][fsm:false] disable fsmonitor
ok 48 - Matrix[uc:true][fsm:true] enable fsmonitor
ok 49 - Matrix[uc:true][fsm:true] edit_files
ok 50 - Matrix[uc:true][fsm:true] delete_files
ok 51 - Matrix[uc:true][fsm:true] create_files
ok 52 - Matrix[uc:true][fsm:true] rename_files
ok 53 - Matrix[uc:true][fsm:true] file_to_directory
ok 54 - Matrix[uc:true][fsm:true] directory_to_file
ok 55 - Matrix[uc:true][fsm:true] move_directory_contents_deeper
not ok 56 - Matrix[uc:true][fsm:true] move_directory_up
#=09
#			matrix_clean_up_repo &&
#			$fn &&
#			if test $uc =3D false && test $fsm =3D false
#			then
#				git status --porcelain=3Dv1 >.git/expect.$fn
#			else
#				git status --porcelain=3Dv1 >.git/actual.$fn &&
#				test_cmp .git/expect.$fn .git/actual.$fn
#			fi
#=09=09
ok 57 - Matrix[uc:true][fsm:true] move_directory
ok 58 - Matrix[uc:true][fsm:true] disable fsmonitor at end
ok 59 - unicode in repo root path: u_c3_a6__=C3=A6
ok 60 - unicode in repo root path: u_e2_99_ab__=E2=99=AB
ok 61 - submodule setup
ok 62 - submodule always visited
ok 63 - submodule absorbgitdirs implicitly starts daemon
ok 64 - submodule implicitly starts daemon by pull
ok 65 # skip case insensitive+preserving (missing CASE_INSENSITIVE_FS)
ok 66 # skip Unicode nfc/nfd (missing !UNICODE_COMPOSITION_SENSITIVE)
ok 67 - split-index and FSMonitor work well together
ok 68 # skip fsmonitor subdir case wrong on disk (missing CASE_INSENSITIVE_=
FS)
ok 69 # skip fsmonitor file case wrong on disk (missing CASE_INSENSITIVE_FS)
ok 70 - untracked cache is checked after a trivial response
# failed 2 among 70 test(s)
1..70
