Received: from mx1.e4ward.com (mx1.e4ward.com [50.116.17.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4C2561C3
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.116.17.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912645; cv=none; b=BtQfqVh4q4QpnsxKNIGcVfuHk4TA8JzSWICpj9THnEpd5z1kkDlTRw3dI4a7zVExanqyNq6MS/qUKELObmYB+bkpl4xffIuEWFJ+v3QYf14/bYPhLKOF3ysomU6qwNZs/7hRJNw6M7iJ4nY7ZE+9gJS85hJWmME8HM3vZgKFYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912645; c=relaxed/simple;
	bh=5tuvV8XzCMwfZi31P5d2nP61ddR80cbHqbIZuHWjb4Y=;
	h=Subject:From:To:Date:Content-Type:MIME-Version:Message-ID; b=EJNQLEIt47I84KMGTi14Egf5e+44++JCFHp7q2RGv5Ig5qLBSPLs8JKpb9qYVmQJ+diKhjVHy+3gi9e0OzXympX0mApr1mzcwQrDQMUd5mmwCuup54/E0zUQq0z4+1aAtX4DDUnaVW7CP3r71TynNn1AWRWwfCjfbkCELMyn1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=derflupp.e4ward.com; spf=pass smtp.mailfrom=mx1.e4ward.com; dkim=pass (2048-bit key) header.d=e4ward.com header.i=@e4ward.com header.b=G6bjsVRA; arc=none smtp.client-ip=50.116.17.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=derflupp.e4ward.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mx1.e4ward.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e4ward.com header.i=@e4ward.com header.b="G6bjsVRA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=e4ward.com; s=e4ward;
	t=1742911926; bh=5tuvV8XzCMwfZi31P5d2nP61ddR80cbHqbIZuHWjb4Y=;
	h=Subject:From:To:Date:From;
	b=G6bjsVRATvdwRz7UtLWgafynGb/KIESSBl+G+PHyMQpEytS5381K4eVZTrvx3z+8p
	 nhNQmP4AHEAQORxgdjNZjmRvVraHE3fQjKmmiY92ADpy7m1i+C5arDuExhunBj2CD5
	 bN+iQcbHf2I5FVkbEOn5QXA9BJBSwMDRqEZepBcrSJSO4PLhq8MV6iYEc+vkjgatJh
	 BJBFcY3zmopucdcQZW81MBPQQtrHBFvTXtYUFgg56uzxgE1XDDnqXcJct/qx4gkEyP
	 qe95e3f13rIsM1+4TWV1oUQ8ZqR6lmV5wjhpx9xImFEFDEsRuhbLpyyxeyXcjqCUX8
	 5p4VBgOlc0OMw==
Received: from mx1.e4ward.com (mx1 [127.0.0.1])
	by mx1.e4ward.com (Postfix) with ESMTP id 1EA2F8C262
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 10:12:03 -0400 (EDT)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	by mx1.e4ward.com (Postfix) with ESMTPS
	for <git.vger.kernel.org-git-at-vger.kernel.org.derflupp.e4ward.com@ooe5qsi97m7.reply.e4ward.com>; Tue, 25 Mar 2025 10:12:03 -0400 (EDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZMX0m44Y1z9slK
	for <git.vger.kernel.org-git-at-vger.kernel.org.derflupp.e4ward.com@ooe5qsi97m7.reply.e4ward.com>; Tue, 25 Mar 2025 15:11:52 +0100 (CET)
X-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1742911912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=5tuvV8XzCMwfZi31P5d2nP61ddR80cbHqbIZuHWjb4Y=;
	b=hn7KdUIeqhB9vFA5UWGrAlGH2FBh8yfe/jBS+QL0wObs/mnHOmo8jmC6LaXtseJgmaallB
	/ODACodXgp/mQbUkqybrg9wxD3qXJxwUx+HIs0XO2wNDsyhpID/Tvu3tydJkmCHhGlqHLC
	taQtJXKfsNkAMh1xVQdVf2atRSCit4f6eFz5K4wsSiLDj/dHAbm5iu3P9+t+XtYRMc8ez4
	Ir8LJh2N5EoFeEHvn8I6LBaRa5w9Hohu2n7aXg7aH5mrNbpaQVqtJU7ggFAr38gORy6VAT
	MU/HXw2QCN/8NkXeBwL6Uy8kh21GwVVGq5gq113J5RfaoOwQfzuCl/VSzNXeTQ==
X-Message-ID: <b632c64f8c9b0f72afe55ea87776514d5f19f49e.camel@mailbox.org>
Subject: gitk falsely tries executing non-executable files in PATH
From: Toni Dietze <git-at-vger.kernel.org@derflupp.e4ward.com>
To:
	git@vger.kernel.org
Date: Tue, 25 Mar 2025 15:11:51 +0100
Autocrypt: addr=Toni.Dietze@mailbox.org;
 keydata=mQINBFmExLcBEADkKI/P1SgZU7Cd2QdXrRWvislKU1SmGYtjjmHjoR+6Niy/mgGinfapF
 /izq4f+9HZzy1azEm8ydatZcxkWNtNalqKI3eZWwbfDJsF8V0MB6NJIV6HMzhAm132Sl/aFXp8X/c
 8WKNAcZc96qMFRf8Jaw7RXLk6YQJRHw4WEjjk0X1UHCUadBGYFa/VUzIXDB8rnNrqT9066hd+rscw
 hHBokEklzss8O2VzZKSfNMJROu4YdcmC8+6ZxENFBhjycWSKTK+W0kDmOIIZsviNs3sU4GXMtwBMI
 3MDzImzAzzyHs3MaZ+Wfb12aeJrfnp1CdUI/E7TnkNYifZ7rpcpQmyqICoy5hsWynHvU+RU5+suVu
 Br3ueblOE1m9XFPYWdex2RVzZzpINnUX2omLc+FVp2HSaoKNiJpU9VLhtYIEegk7m/qioUT02CHxF
 SjVGq7rr9Vh1f0XHI9JmudcGm4qeQPG+fm+1svV+oVUoAbfUfWNiJL+6325KvVDmw2jnR0+J7MC4e
 9u92o1s9Gu5FVBUx9mOb+VRBJKAdvym3Ae7/W6QXYrkkx1GX0AymRtV47op0yuXgNizk8FBiAKNqw
 3D8qCFcANyBLIY3qousa3n0NI/NUX6qaepiP0R9+TikqolMFwEx6TSZilQaliuiVFYhNo5AsdbG/w
 1FpITxyuOHLpwARAQABtCVUb25pIERpZXR6ZSA8VG9uaS5EaWV0emVAbWFpbGJveC5vcmc+iQJWBB
 MBCABAAhsjBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AWIQSYDEx7q9tKzHbWz7HvXq5jNAAZMgU
 CZiEkSQUJEG8oSgAKCRDvXq5jNAAZMuaiD/41zcoqvcQrd2aaZGyezKp2YRdLoRtFoS9TOLoaSyu+
 2cb3OYCgEuKAakTcNVantzFfu0sZFigvXrD3p3UaPB/W6KXeyyiSQtd2X35Dm4GVGtbQy/889Awx4
 LYvZFSnsWYuEQwtjshj7NR/d3NFGgIGhggIums38grX57t1lTpX3/lGTSfUuhsteN/SW/rwOoxApc
 C0diBCxiat0e0osHI1uAKJOY35EGGRWlhyAUr5UsMRDYu4hsXtslEPHlK0IcU9F+PLP3JTVV/pYC/
 64N+F0uRHRc06V/gz8JBLABQFY+K1itfZsjVh0yCVWpWRKQXpN4WnCmJnoARvvQPTjNmmCCuTUCN9
 zC61kxoA6VUgJZodHEAVifoVRGgPle2Lg8ByOi4WnxlPDAmKBk9e/aPq5wcYQBpH91cvxVtjfgFPR
 wJUP8+yKyzktnjyhqTi0p/Unq+EJON863cHw4sjAzD8Ek+ZwvG3+bXM1zY2LlBjUF7YqHJzJ0q/jG
 p4kIlxHMaVhKhFAG5ge6T3H5v425wV3dTWxaC89ldBffAVPpGIwr8c5HzCZC97mES3GX2MU+SYwe3
 bh588vINAy+vUXXZJ+Q1aiS/9Peu6YVejvzB083Vt6REZVH5P9jWjcW+aEY7hkYoRuQV1pYFWKQTh
 U/2Awrg31Cnn54dUqjIPrH9n0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 5847de0438e255dd5f6
X-MBO-RS-META: yzd495urm4d81h577n6kcwk16pwb4eqi
X-Sender: forwardedby@e4ward.com
X-Real-IP: 80.241.56.152
X-Forwarded-For: 80.241.56.152
X-e4ward-RCPT: git.vger.kernel.org-git-at-vger.kernel.org.derflupp.e4ward.com@ooe5qsi97m7.reply.e4ward.com
Message-ID: <553b40dd-b054-430c-a596-43cd240f7f82@mx1.e4ward.com>

Hello,

I think I encountered a bug or at least unfortunate behavior in gitk
that I noticed the first time with version 2.49.0.

Assume a Linux system. Assume there is a directory /some/dir containing
a file named 'git' which is *not* executable. Also assume that the PATH
variable contains /some/dir somewhere before the directory that
contains the actual git executable. Under these conditions, when gitk
is executed within a Git repository, it shows the misleading message
"Cannot find a git repository here." It seems that gitk tries to
execute /some/dir/git, which fails, because it is not executable. The
error message seems to be just a misleading symptom.

Note that, considering the above conditions, my shell (zsh) and the
which command both resolve git to the actual git executable ignoring
/some/dir/git. I think, also gitk should ignore non-executable files in
the PATH. Currently, gitk seems to check just for existence but not for
executability (see line 82 [1]).

PS: In case you wonder about a use case where a file named git would
end up in the PATH: My PATH looks like PATH=3D/home/me/overlay:=E2=80=A6. F=
or
debugging purposes, I sometimes replace/wrap a binary like git by/in a
script by putting this script into /home/me/overlay. When I am done
with debugging, I often keep the script and just remove the executable
bit assuming it is then ignored by the PATH resolution.

[1] https://github.com/git/git/blob/683c54c999c301c2cd6f715c411407c413b1d84=
e/gitk-git/gitk#L82


[System Info]

git version:
git version 2.49.0
cpu: x86_64
built from commit: 683c54c999c301c2cd6f715c411407c413b1d84e
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.12.1
OpenSSL: OpenSSL 3.4.1 11 Feb 2025
zlib: 1.3.1
uname: Linux 6.13.8-arch1-1 #1 SMP PREEMPT_DYNAMIC Sun, 23 Mar 2025
17:17:30 +0000 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.41
$SHELL (typically, interactive shell): /usr/bin/zsh

--=20
Regards

Flupp
