Received: from p00-icloudmta-asmtp-us-west-2a-100-percent-7.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-west-2a.k8s.cloud.apple.com (p-west2-cluster3-host8-snip4-10.eps.apple.com [57.103.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D038F6F
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.69.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742443533; cv=none; b=iee95KiFThaSudH/7Y/RODU3lh/8qA7Tv4/DWBBJ2wfylKjgSbN1WlZLunA5t4QqfoKuTPkG1CeZ3V89oEuaxOX31YzE1zejEGx3HJaSIe6b68z+kgxb6Qz9V+PRO7naEMR0z9XoFvFPQNAmVSa8V4tvO9YINcgCP+oAtg6Ep+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742443533; c=relaxed/simple;
	bh=/DWXiwaiyZUSDa0YtXLYxTxHpzQESK9JN5xGs+lspck=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=WIMuLiwQtFgUgYImI6JMaHTCk1RHljl2PjI+S/I3YDdrIJGgoV48u6YN/zl0AsYm9c+dkohI+rQBkLs9qawC7A+Dd2C9r2C2LlPb5EyYQ8OKTmtdCq6cnryacd7anPbtgfo4NlPMwx/5oZIpjsqjPFMLhDhtZq2s9CGjhY+KVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=norbauer.com; spf=pass smtp.mailfrom=norbauer.com; dkim=pass (2048-bit key) header.d=norbauer.com header.i=@norbauer.com header.b=FPHU9yZG; arc=none smtp.client-ip=57.103.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=norbauer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norbauer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norbauer.com header.i=@norbauer.com header.b="FPHU9yZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=norbauer.com;
	s=sig1; bh=/DWXiwaiyZUSDa0YtXLYxTxHpzQESK9JN5xGs+lspck=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To:x-icloud-hme;
	b=FPHU9yZGcPIwUIrS71UhedoGmrE+PtWCRFLuojxu+gzDH9DxW/6Fskh1igezDjgJH
	 G4E7fFxYtLjSejy3glywO4fYH+p4YQGIqs/+JNFyyHrYKupP7iD3Vtr6eGCdYVLSNh
	 GKZIZ6AAbxiH9MUi4lfDBuy+Q3EVuC7vVXZ/I+tZgoG91VGa0NIMMXb5c6OaIavX85
	 qXWtNOg3KYsVg46yCNpwNbmb/3+mxcD0XiSYWbE+b1fHIS5BaEdaI5pYQHBIZqbBsz
	 J6Q5fPc5q3XR/0DLQuq0GqRXVN79RbW8q6N4+IEY7lVRe1IZxIG1GtRWgMjQsM01rB
	 uNk0WmxFsOiQw==
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-7.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-west-2a.k8s.cloud.apple.com (Postfix) with ESMTPSA id B9BCB18000A9;
	Thu, 20 Mar 2025 04:05:28 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: alan@norbauer.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: bug: git shows hints that should be suppressed
Date: Wed, 19 Mar 2025 21:05:07 -0700
Message-Id: <00213714-D232-49BB-BE8F-300E74758E8C@norbauer.com>
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
In-Reply-To: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
To: Justin Tobler <jltobler@gmail.com>
X-Mailer: iPhone Mail (22D82)
X-Proofpoint-ORIG-GUID: E0IJvNplpAop4YwGVFa4d2f9XTFluzi2
X-Proofpoint-GUID: E0IJvNplpAop4YwGVFa4d2f9XTFluzi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_01,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1030
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503200024

Thank you, Justin and Elijah. I really appreciate you digging in.

> On Mar 19, 2025, at 6:40=E2=80=AFPM, Justin Tobler <jltobler@gmail.com> wr=
ote:
>=20
> =EF=BB=BFOn 25/03/19 07:45AM, Elijah Newren wrote:
>>> On Wed, Mar 19, 2025 at 2:59=E2=80=AFAM <alan@norbauer.com> wrote:
>>>=20
>>> Thank you for filling out a Git bug report!
>>> Please answer the following questions to help us understand your issue.
>>>=20
>>> What did you do before the bug happened? (Steps to reproduce your issue)=

>>> `GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3D/dev/null GIT_CONFIG_=
NOSYSTEM=3D0 GIT_ADVICE=3D0 git clone --quiet /Volumes/sourcecode/npm-packag=
es/packages/repository-tools/node_modules/.cache/@altano/repository-tools/20=
78b9db1d71a4f4a5422e25a7016c75/git.bundle .`
>>>=20
>>> What did you expect to happen? (Expected behavior)
>>> I would expect the clone to happen without any hints because I provided b=
oth `GIT_ADVICE=3D0` _and_ `--quiet` to the command. Both should suppress th=
e hint.
>>>=20
>>> What happened instead? (Actual behavior)
>>> I received the "hint: Using 'master' as the name for the initial branch.=
 This default branch name" on stderr, which caused my tests to fail (I am us=
ing git programmatically in a test).
>>>=20
>>> What's different between what you expected and what actually happened?
>>> The hint on stderr was displayed.
>>>=20
>>> Anything else you want to add:
>>> This behavior is NOT observed on git v2.44.0 and is observed on git v2.4=
8.1. So the bug started occurring somewhere in between those versions. I can=
 find the exact version the bug was introduced manually with some effort if t=
hat would be helpful.
>>=20
>> Bisects to 199f44cb2ead (builtin/clone: allow remote helpers to detect
>> repo, 2024-02-27); cc'ing its author.
>=20
> It looks like prior to 199f44cb2ead (builtin/clone: allow remote helpers
> to detect repo, 2024-02-27), the default branch name advice message
> would never be printed when cloning from a bundle regardless of whether
> `--quiet` option was set. This particual advice message also doesn't
> respect `GIT_ADVICE` either. So something about the change has made the
> message start printing when it previously did not.
>=20
> Digging a bit further, this change started partially initializing the
> refdb with a HEAD file which had a side-effect of changing the location
> where the first `git_default_branch_name()` was invoked. This matters
> because `git_default_branch_name()` only computes the default branch
> name once and uses a cached value for subsequent invocations.
>=20
> Previously, `create_reference_database()` was the first
> `git_default_branch_name()` call site and was configured to always
> suppress the advice message. Due to the refdb being partially
> initialized with a HEAD file, `create_reference_database()` stopped
> invoking `git_default_branch_name()` altogether and the default branch
> name computation was defferred to a subsequent potential call site
> `guess_remote_head()`. At this location, `git_default_branch_name()` is
> configured to not suppress advice messages.
>=20
> Also, `guess_remote_head()` only invokes `git_default_branch_name()` in
> cases where the transport is unable to figure out the remote HEAD and
> must guess. This explains why the advice message gets printed for bundle
> clones, but not all clones.
>=20
> One option to fix this would be to adapt `guess_remote_head()` to
> support configuring the underlying `git_default_branch_name()`, which
> has since been renamed to `repo_default_branch_name()`, to be quiet and
> suppress the advice message. The call site in clone could then be
> updated accordingly.
>=20
> I'll submit a patch that does this.
>=20
> -Justin
