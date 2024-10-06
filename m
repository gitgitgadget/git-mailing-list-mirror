Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A34C91
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728212722; cv=none; b=VqQLj/VGsFXnu/UxRNlad6S5kLFJrt94/0bTEMJj9Ao9IoxdkzLNtAg4rVTOXf9e4qKgL0lvafDNgMr6CSJCFuf4Nlw7FG+lqIIXXZ0+cBPI8hGRCdb+/A+Sm9EpDMy6jQPDMazdIs2yTZiM5N/CyHP13OiIJg1pCmJjpikC0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728212722; c=relaxed/simple;
	bh=lIR+bsO79FGpAEyR1WwZ6+xIa4L3rXE94b0zS87uTAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxtQu8AF/gm+Qq9S/R6qsetjTbGd4l7ms/UgKb6vk1VIY/ZTgACU8OmrhKFVsBB8F/jwBHydbOjRxHH/eoPksRaogfkGi8U3kpG7LbN7nqJlsHfp2nljSVraxOv5fnTIQNKVmq9ZKCPaqAvEUgQfIjtTZEqoEThltvn5Y7SDTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cb48e77b16so5600506d6.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 04:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728212719; x=1728817519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIR+bsO79FGpAEyR1WwZ6+xIa4L3rXE94b0zS87uTAg=;
        b=UEwzji6UswvfMweH/xreTBluFV2W1HQfswx6cbgTlOmACnucuP208de3i9ieJfl8z4
         S01w8O+1qLPTes2yBlAau4Ane18Feog1exWFDleB7WpQKkPc+VQCNam14yDLzqK0Bd+R
         h/PPvro4MTkGGrihczwnwaHGYcUG9lf/yVLy+QeLxUNNixG2itl6PpH4susXDj3Bxc4p
         HX3oELhwi8cDT3wiqXvFxA0VkeWorhRFTOapAaSNIuUXk7Wfa3Quhh53Hhe/erz5L+g9
         lKBNlP8PC9BvGbiD3DlPBfMaANFO2+tJLSQc5n6+EHXq2M1aIAUGpHG/MlbzlUvXIfhG
         W73g==
X-Gm-Message-State: AOJu0Ywp7jokxFhY/CRvcxOz5UZzDjSnhMFbZjJT7/7tsXn17eHZ8J4G
	ZeYa8zyW4VliAJ/cgSJGp53oI44TL1jp8d8/LsIwA6nvIPbb/YXbjhZDwlmjxCleZox6pYUH4d/
	qyeuVCJ62yAJTVPc6gGkzlBJRBGzRTC7w
X-Google-Smtp-Source: AGHT+IG6SMwWHdCF55L+WJmaWD7Py1ra9C4UCaLYb01ZHtWUV+CgCV89/JsQ4CqNOKelTKT3m6sQqfjws593sXhOubs=
X-Received: by 2002:ad4:5bc8:0:b0:6cb:6782:6a8c with SMTP id
 6a1803df08f44-6cb9a54e244mr55639076d6.12.1728212719455; Sun, 06 Oct 2024
 04:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-3-cdwhite3@pm.me>
In-Reply-To: <20241006060017.171788-3-cdwhite3@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 07:05:06 -0400
Message-ID: <CAPig+cT5BHuWMrjefP9BMocE7EFXgzRyHMFbUmEZv73F4g+XEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] worktree: link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 2:01=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrote:
> This modifies Git=E2=80=99s handling of worktree linking to use relative
> paths instead of absolute paths. Previously, when creating a worktree,
> Git would store the absolute paths to both the main repository and the
> linked worktrees. These hardcoded absolute paths cause breakages such
> as when the repository is moved to a different directory or during
> containerized development where the absolute differs between systems.
>
> By switching to relative paths, we help ensure that worktree links are
> more resilient when the repository is moved. While links external to the
> repository may still break, Git still automatically handles many common
> scenarios, reducing the need for manual repair. This is particularly
> useful in containerized or portable development environments, where the
> absolute path to the repository can differ between systems. Developers
> no longer need to reinitialize or repair worktrees after relocating the
> repository, improving workflow efficiency and reducing breakages.
>
> For self-contained repositories (such as using a bare repository with
> worktrees), where both the repository and its worktrees are located
> within the same directory structure, using relative paths guarantees all
> links remain functional regardless of where the directory is located.
>
> Signed-off-by: Caleb White <cdwhite3@pm.me>

When you reroll, please extend the commit message to give a more
detailed overview of how this patch actually changes the behavior both
at a high level and at a low level. This is especially important since
this patch is sufficiently long and involved that it's not easy to
glean these details at-a-glance from the code changes themselves.

For instance, the cover letter talked about retaining correct behavior
for both absolute and relative paths, but this commit message mentions
only relative paths, so it's not obvious just from reading the commit
message whether absolute paths are still supported or, if they are,
what exactly that support looks like or how the user controls the
choice between the two path types. This sort of information should be
present in the commit message.

Similarly, if there is a chance that this change may break existing
tooling and workflows, then the commit message should talk about those
risks, as well, and what if any remediations are available. Also, if
there are such risks, then Documentation/git-worktree.txt may need to
be updated to warn users.

Regarding what you wrote above, there seems to be a good deal of
redundancy between the first two paragraphs; combining the paragraphs
and folding out the duplication might make the message more
streamlined. I do like the discussion about containerized environments
being used as (at least one) justification for employing relative
paths, and think that may be a good lead-in for the commit message.
Please see [1] for some helpful hints for composing a good commit
message.

I'm not going to review the code itself right now since I haven't been
able to apply the patches or play around with the functionality, but I
wanted to get the above written up since I think this series is going
to need to be rerolled anyhow.

[1]: https://lore.kernel.org/git/xmqqmsm6sc0q.fsf@gitster.g/
