Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF961DF261
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783865554; cv=none; b=vClApvQV58l+KXfX6askElizD6nBX1n/iOMKjkiwSSQUjmRrzvjAxSIiIIpxAfBvNrA3tj8N5TauhaQQ3EuD1PlUQoB+iThl0edZE1JOGb+dEPzcq1V52UoRt6g8nqubP74lK7Cugi3REjeTNwNc8OzR1qOOfTiAVBb0yFuwCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783865554; c=relaxed/simple;
	bh=Q3UP1LTOHI1HRFDFUt+Qr6kI8cKfWwYujQ7vrq15vDU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qwblcGFK/Jvpjbp/C+YeMZ047vi0FQJKNmaOj0qA+hK4csVBrtQ20jZNOP4ei7SeVyLd0Ty2To0+FC1kP12nUmLJoqzSPX24eZD9mfpNnoqb/6dzhRYebJ3RiR3JFAoo5W6cCJA9ry/SF706yyvDedws/I4zrA7lVgKAyNcv9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWFMfYbA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWFMfYbA"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47db714766aso1621004f8f.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783865551; x=1784470351; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z1/CF7KUHa66iEJZcGS5QGabWTiVX7GSiKvMUQbV+Co=;
        b=cWFMfYbAkn+jkpg8OtZEjP84UnlXdpDgDqEMmvrtbuQibk68kNejgBhaGxlgmmOj2d
         X3sLDC72Hk1/AvmQ5bgM8kcs6C+pSmduiGMg1BUY3JwnzsCv9t3UwGblxULTmH/q3kV4
         tM6KJD0oK3lXt+xLFwCF35vLKMD4lGPTcrv6WvYRM60hz1trCco/qfYNA8Wuc0AqPf2e
         4MaxLnn5h+pQktqD4DSjVzQlVBN+qdUia5fzgSZOyE3OB9/HO7cMV/ZKFbvL/jv/HWLu
         0GgqQ/xGEaWpDJHAXTy5FGjh43tg8sBC1y9r9m4GuRXKDzc4Mvcd+ywRrSTzMAjzcLh4
         KZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783865551; x=1784470351;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1/CF7KUHa66iEJZcGS5QGabWTiVX7GSiKvMUQbV+Co=;
        b=WnHbxm4LvT1CuIxNO177JY27WnodV/wWiqv7Xtx6/64wT5aZZP+h9hX8R+leL9xw9R
         3wCNC9f3qKYujxpqYCjb/HxL+yFXMkM8XkdLGojtpKEZPj2crUK7p9v2i9mONVMfGfRB
         LdkOmVcPCMwixbYSBrvxUZB8+bwfYzXZqI11RnnoPTDT5op+Bp41/IbWHSyxqMfWCz9w
         PXixK+G+7dgAGv6ofSKgjKWrBfOTjg/eMWhyFEqgpVKhP7ZhrS48CTWoRcVcGouh2XVk
         JWuv7Xpf79ua5p4lZTkSu5yCV4J5+H/8CK1L9yFqv7gEU26UazzzThXZApGhc+8AShhX
         9WBg==
X-Forwarded-Encrypted: i=1; AHgh+RrEFMp3C6qkQqStSvq+21QN9bRloUwDLamZLnhC5Jdjb2HV7Iv+rTlR60YhNBMyYcu3VSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYrAkkVXuciyz5q7NuZzc5jYhyI3CjUtU7AivYi9VYJ3l4kFYi
	vSUZJVIx80uRWdMkgZIm3ljWls3j6BRWS9mICftQFOOqUVxdDXJ99zJQ
X-Gm-Gg: AfdE7clKhiUePPGVArgi/bouFqOs42CKbqAoxJTDd3+L5kNvYHjkO2v3PCXwhxcCMzY
	KzDNaiJ3KcD/TNI9u00kQiKKE9w+mKdJk7l3qcmffvxcSwfjMfahrK+FnN0tE5FZVaWd8mnaYy0
	rWosy5Oizq+oNgvKXNV+KbnMSqAgdmA8zdgx17XOGb6RZY97E25wgb+1z3CFJ6aUwjg+nbqysSX
	w1iW3QysLAR9lhv1ZlRioaN7Qh+CeXM0YlLnBvmcUm4e+KxCEsldbW5N26FidVxPtCOM1b8QBmy
	siwkSkp2zrphvmEMuw4UIhyFcIOwRhCS+ao/ol0zNw5P6jBSf2j0hiBftV5RKHVT0ZFYa54E6FA
	di+FyPD3vTx6wN7cTcJvUqei0EZ8GBjXl5nEkqsh/MOkm78rGhZPWmQXAn38umlsXQezxBWoYzw
	zu9jlSBwz4ICKYduhsI4tEVMGZYdU+kQg9KnBh5Dfsc2ZDi0MpHnX9t3JKUTP5GfcHO4ykqn2P/
	VE/gs3jgshZWR/T7AWZBJs7A11J2vLlw8kfrN1L9S626AOE2yoaUCun75DgD28VITQ5/tQ9kWWu
	bYN6qcVljBKTZ74dzEqgqjxlTwuUpPmCoezy9AAIkmevw8lw9igYJDKpsoww822ycYmRoNmbQY5
	DZQKI
X-Received: by 2002:a05:6000:250d:b0:473:fc10:f675 with SMTP id ffacd0b85a97d-47f2dcc0fe2mr5480850f8f.18.1783865551235;
        Sun, 12 Jul 2026 07:12:31 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm78161198f8f.25.2026.07.12.07.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 07:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 16:12:29 +0200
Message-Id: <DJWNK8BOFIAW.3VVAROHMKVDWE@gmail.com>
Cc: <pabloosabaterr@gmail.com>, <cirnovskyv@gmail.com>,
 <szeder.dev@gmail.com>, "Christian Couder" <christian.couder@gmail.com>,
 "Ayush Chandekar" <ayu.chandekar@gmail.com>, "Olamide Caleb Bello"
 <belkid98@gmail.com>
Subject: Re: [PATCH v10 4/9] environment: move pager_program into
 repo_config_values
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Tian Yuchen" <cat@malon.dev>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260709161145.13349-1-cat@malon.dev>
 <20260712111734.1073514-1-cat@malon.dev>
 <20260712111734.1073514-5-cat@malon.dev>
In-Reply-To: <20260712111734.1073514-5-cat@malon.dev>

On Sun Jul 12, 2026 at 1:17 PM CEST, Tian Yuchen wrote:
> The 'pager_program' variable is currently defined as a file-scoped
> static string in pager.c. Move it into 'struct repo_config_values'.
>
> The configuration parsing logic remains strictly within pager.c to
> respect subsystem boundaries. The read/write operations are simply
> redirected to the repository-specific structure using
> 'repo_config_values()'.
>
> Similar to the recent editor_program migration, no standalone getter
> is introduced to keep the code minimal. The dynamically allocated
> memory is now managed by 'repo_config_values_clear()'.
>
> On top of that, fix a memory leak in pager.c while we are at it.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  environment.c |  2 ++
>  environment.h |  1 +
>  pager.c       | 26 +++++++++++++++++---------
>  3 files changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index a65d575af4..975c9cb9eb 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -725,6 +725,7 @@ void repo_config_values_init(struct repo_config_value=
s *cfg)
>  	cfg->attributes_file =3D NULL;
>  	cfg->excludes_file =3D NULL;
>  	cfg->editor_program =3D NULL;
> +	cfg->pager_program =3D NULL;
>  	cfg->apply_sparse_checkout =3D 0;
>  	cfg->branch_track =3D BRANCH_TRACK_REMOTE;
>  	cfg->trust_ctime =3D 1;
> @@ -742,4 +743,5 @@ void repo_config_values_clear(struct repo_config_valu=
es *cfg)
>  	FREE_AND_NULL(cfg->attributes_file);
>  	FREE_AND_NULL(cfg->excludes_file);
>  	FREE_AND_NULL(cfg->editor_program);
> +	FREE_AND_NULL(cfg->pager_program);
>  }
> diff --git a/environment.h b/environment.h
> index 8178ebab76..39b6691b47 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -92,6 +92,7 @@ struct repo_config_values {
>  	char *attributes_file;
>  	char *excludes_file;
>  	char *editor_program;
> +	char *pager_program;
>  	int apply_sparse_checkout;
>  	int trust_ctime;
>  	int check_stat;
> diff --git a/pager.c b/pager.c
> index 35b210e048..bc55546670 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -5,6 +5,8 @@
>  #include "run-command.h"
>  #include "sigchain.h"
>  #include "alias.h"
> +#include "repository.h"
> +#include "environment.h"
>
>  int pager_use_color =3D 1;
>
> @@ -13,7 +15,6 @@ int pager_use_color =3D 1;
>  #endif
>
>  static struct child_process pager_process;
> -static char *pager_program;
>  static int old_fd1 =3D -1, old_fd2 =3D -1;
>
>  /* Is the value coming back from term_columns() just a guess? */
> @@ -75,10 +76,15 @@ static void wait_for_pager_signal(int signo)
>
>  static int core_pager_config(const char *var, const char *value,
>  			     const struct config_context *ctx UNUSED,
> -			     void *data UNUSED)
> +			     void *data)

Could this change behaviour that a caller expects?

(looking at the hunk below) we are now using repo_config_values() which
contains the condition 'repo !=3D the_repository'. This means that if there
is a caller that sends anything but the_repository, it will BUG() out.

Before this patch it would have worked, it worked because callers were
sending the correct repository. Now we enforce it.

If we check the callers we can see that everyone sends the_repository,
so this new assert is fine and prevents sending submodules by mistake.

Makes sense.

I think it's worth mentioning that on the commit body/function.

>  {
> -	if (!strcmp(var, "core.pager"))
> -		return git_config_string(&pager_program, var, value);
> +	struct repository *r =3D data;
> +
> +	if (!strcmp(var, "core.pager")) {
> +		FREE_AND_NULL(repo_config_values(r)->pager_program);
> +		return git_config_string(&repo_config_values(r)->pager_program, var, v=
alue);
> +	}

Ok. Now that pager_program is not file-scoped we drop the UNUSED and
pager_program now lives in the per-repo field.
Then we change the address where ->pager_program (which we access through
repo_config_values()) points to.

FREE_AND_NULL() is new, before this patch it must have been leaking,
good job.

Similar to previous patches, let's change the pattern to only call
repo_config_values() once and use the pointer it returns.

> +
>  	return 0;
>  }
>
> @@ -91,10 +97,10 @@ const char *git_pager(struct repository *r, int stdou=
t_is_tty)
>
>  	pager =3D getenv("GIT_PAGER");
>  	if (!pager) {
> -		if (!pager_program)
> +		if (!repo_config_values(r)->pager_program)
>  			read_early_config(r,
> -					  core_pager_config, NULL);
> -		pager =3D pager_program;
> +					  core_pager_config, r);
> +		pager =3D repo_config_values(r)->pager_program;

Same as above, let's call repo_config_values() once.

>  	}
>  	if (!pager)
>  		pager =3D getenv("PAGER");
> @@ -302,7 +308,9 @@ int check_pager_config(struct repository *r, const ch=
ar *cmd)
>
>  	read_early_config(r, pager_command_config, &data);
>
> -	if (data.value)
> -		pager_program =3D data.value;
> +	if (data.value) {
> +		free(repo_config_values(r)->pager_program);
> +		repo_config_values(r)->pager_program =3D data.value;

Same pattern. This also frees, but the log says "a" memory leak is fixed
in this patch, should we change it to two?

> +	}
>  	return data.want;
>  }

I peeked at later patches of this series and the multiple calls of
repo_config_values() pattern keeps appearing.
I haven't finished reviewing 5-9. If you reroll before I get to those
patches, it may be worth fixing this pattern across the whole series.

Regards,
Pablo
