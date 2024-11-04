Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A61EEE6;
	Mon,  4 Nov 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723863; cv=none; b=MI4yKi2g9mRdtOtUG0FrsgQ/4bJo6aTwdhhDSb4BKfh6vdqKLCH5vn26CuyU1tBu/Du0aS12/BiQrO2+eSPI5eOANTVMnj6HNTfYrNtfjOKzy1vEsh+3hsAWSdoY2pU6FbcsYyPhtWXNe0k2tH8ObSX61cK+OaI0zlKnQIsY0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723863; c=relaxed/simple;
	bh=lD9EhOkqky8/x13fa1vyaCFKqUOmfHFsFsgUO9CC2B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI6KVC3fG4PcUvSEcSaA7zzFl9xYsV7Gr4wuAnXRmUKj6qg3oXewzUMGbW+m5mxrGr35F6q+wkfAU9TQSaLROhnG4x1yX1cJOzRM8XZNQ5RwbafmUQ0CILlkgp8vxbZWk0u6FQ+MXAi4CAs3gZvZ36vYM/l91PRty+GRgzz5wVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSJVuqhy; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSJVuqhy"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb587d0436so43711441fa.2;
        Mon, 04 Nov 2024 04:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730723860; x=1731328660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vvlWvnMnzqiKZJ0eLOHxGLNTRWNJbjSMZIkx7cs7dhQ=;
        b=lSJVuqhyYgR0YP0hjgjZxwy9ZMGvO7G9pjhG9MNCtm5LyS8xhV2xeUfUtqkk4IVAGx
         5UqK0z0DJ/WWpZPOQOlnY7krEY0aWxKo5wSszSkYzMNEl/D86AccsNTHICtGh4rzuBHl
         scs+di48v8MMsWKq6mx3Ps+Uy3E60tC76lSWmYyDOKIgkZ+dx7vFsuzHhM9qPR8TeeMj
         Xu+JmxlzxzTxULhkJpigRWXAmJRXBmKn+NF7cfx3XGcLYV57ZsGsBfEk4oCp2/it2ldb
         ZTplMfm+WFi53i78ugrXa10CFI0ogm8YHoWhpJoTCLzXXYdt8iWz7B/KesiN2u3kiLQg
         YdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730723860; x=1731328660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvlWvnMnzqiKZJ0eLOHxGLNTRWNJbjSMZIkx7cs7dhQ=;
        b=dXuMk+0BmdDLlc+ZAeaP3nbs1rBE9hp4hMemScx31VWIKOa76Evg4M7wdGRC1udbv3
         3sCpqKO9jIGd0ZtPK5yjSatbZTSYnIPlYqyInRhJw1nZNYd3pxnZlku7xipNKQ7OY0ID
         ZqaEWPsfI0APAMHprgZDsPCMWm5xFeOcnXDfgBTqT7jKonkxGm7pUgJpMgE09iQyZ4KK
         xYqYW46Rk2fCsXY3dOivvKiHDS8YxAkiH9tJF0QjgTh0DzVWsXe3dv2O1FZQSbGh8L3U
         tw8wE9EXQoBgYBDHlwkbADiCqs2+DSBDKPYFDGHetpt+FXw9D/qLbF4FEj09QiI0dpsi
         tbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYqkcuXCl7YKdr5hXsQOj67z2gGfXWWHeZYqfB+oq7twUqxxb4AJUwtr2XwEgtAhr7HlhOguf44sCiyTh6@vger.kernel.org, AJvYcCUqsAb77IGwKdQNAdHPzwTtdQ8JkyZxsTEYz0saPb0Cfnd/iE505SHT+yyTyEJH7W/uKPQ=@vger.kernel.org, AJvYcCW+fOqMzRIsCFZrOnFHkV52SOA4kXXVV+YAHMac3vHq0LLfDjmvVSMrrayt8Rd5ZoYv5IOhcNYR+vCtTpGH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4iRM3F7hyP7n7Af3fnc20D3QBLk8fXMKPyg+dXDmj1Akakri
	uRgS6Ng5s0cbHf2jExraOOCuvc4Af8STZDDSBqh5jW/GT3jXgbUk3VkndGPHxpeowpk4yrdxZTk
	ZgBZqr2Uy8kMnB4YiF09V6vrmFj8=
X-Google-Smtp-Source: AGHT+IF1RiXoyxgWmaSDQWv/gU9IJuYmxxoR7wwdAcMzImzUEknB17ZKd23IyyNvy5r7UGlBU/ED0Z+2NFA1GNF3Ya0=
X-Received: by 2002:a2e:bd15:0:b0:2fb:34dc:7beb with SMTP id
 38308e7fff4ca-2fedb7a2114mr61252401fa.12.1730723859326; Mon, 04 Nov 2024
 04:37:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
 <87bjz0k17c.fsf@prevas.dk> <20241031114210.GA593548@coredump.intra.peff.net>
 <20241031122456.GB593548@coredump.intra.peff.net> <20241031144351.GA1720940@coredump.intra.peff.net>
In-Reply-To: <20241031144351.GA1720940@coredump.intra.peff.net>
From: Benno Evers <benno.martin.evers@gmail.com>
Date: Mon, 4 Nov 2024 13:37:27 +0100
Message-ID: <CAEQVFRFWT02QTL7PTf84p6AAferijHx8L_Tu6ON1H7U=iEdb3A@mail.gmail.com>
Subject: Re: [PATCH] setlocalversion: Add workaround for "git describe"
 performance issue
To: Jeff King <peff@peff.net>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Benno Evers <benno@bmevers.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm afraid I can't offer much wisdom, but a few thoughts:

In the testcase, the difference between A-3 and B-4 looks very
academic, but on a real repo the results are more obviously wrong. For
example, if I put the test setup on top of the current git repo:

    benno@bourbaki:~/src/git/tmp-test$ git describe HEAD
    A-3-ga53f69dfb5
    benno@bourbaki:~/src/git/tmp-test$ git describe --candidates=2 HEAD
    B-75205-ga53f69dfb5

When writing the patch I thought that it might be a good idea to
change the definition of `describe` to favor the tag with the shortest
first-parent distance to the described tag and print A-2 in the test
scenario, to me that seems the most intuitive description. But that's
a change in behavior, and it's not even clear that most people would
agree A-2 is better, so I discarded the idea.

Other than that, the only way I can see to implement the behavior
exactly as described would be add the same condition when breaking for
reaching the max number of candidates, ie. to stop adding new
candidates but to delay the break from the loop until all disjoint
paths are unified. No idea how much of a performance hit that would be
in practice, I guess it depends on average branch lengths.

Best regards,
Benno

Am Do., 31. Okt. 2024 um 15:43 Uhr schrieb Jeff King <peff@peff.net>:
>
> On Thu, Oct 31, 2024 at 08:24:56AM -0400, Jeff King wrote:
>
> > We have to feed at least one commit with the "within" flag into the
> > traversal so that it can let us end things. But I don't think it really
> > matters if that commit is the one we found, or if it's a parent of one
> > that we happened to pass "within" bits down to.
> >
> > So I think we can just set "gave_up_on" to the final element we found
> > (whether from max_candidates or from finding every possible name). I.e.,
> > what I showed earlier, or what you were proposing.
>
> Hmph. So I don't think this is quite true, but now I'm puzzled again.
>
> It is accurate to say that we must make sure _some_ commit with the
> those flag bits set remains in "list". And I don't think it matters if
> it's the candidate we found, or its parent.
>
> But there's other stuff happening in that loop, after we process that
> max candidate (where we'd proposed to break) but before we hit the next
> possible candidate. Stuff like adding onto the depth of the other
> candidates. Josh's example doesn't show that because it only has one
> candidate, but I could imagine a case where it does matter (though I
> didn't construct one).
>
> So I'd have thought that this:
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 7330a77b38..b0f645c41d 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -366,6 +366,12 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
>                 struct commit_name **slot;
>
>                 seen_commits++;
> +
> +               if (match_cnt == max_candidates) {
> +                       gave_up_on = c;
> +                       break;
> +               }
> +
>                 slot = commit_names_peek(&commit_names, c);
>                 n = slot ? *slot : NULL;
>                 if (n) {
> @@ -381,10 +387,6 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
>                                 if (n->prio == 2)
>                                         annotated_cnt++;
>                         }
> -                       else {
> -                               gave_up_on = c;
> -                               break;
> -                       }
>                 }
>                 for (cur_match = 0; cur_match < match_cnt; cur_match++) {
>                         struct possible_tag *t = &all_matches[cur_match];
>
> would do it, by just finishing out the loop iteration and bailing on the
> next commit. After all, that commit _could_ be a candidate itself. But
> it causes a test in t6120 to fail. We have a disjoint history like this:
>
>                  B
>                  o
>                   \
>     o-----o---o----x
>           A
>
> and we expect that "x" is described as "A-3" (because we are including
> the disjoint B). But after the patch above and with --candidates=2
> (since there are only two tags and part of our goal is to limit
> candidates to the number of tags), we find "B-4". Which is worse (at
> least by some metrics).
>
> I think this comes from 30b1c7ad9d (describe: don't abort too early when
> searching tags, 2020-02-26). And given the problem description there, I
> can see how quitting early in a disjoint history will give you worse
> answers. But the patch above is triggering a case that already _could_
> trigger.
>
> So it feels like 30b1c7ad9d is incomplete. Without any patches, if I
> limit it to --candidates=2 but make A^ a tag, then it gets the same
> wrong answer (for the exact same reason). And I don't see a way to make
> it correct without losing the ability to break out of the traversal
> early when we hit max_candidates (which is obviously a very important
> optimization in general). But maybe I'm missing something.
>
> I do think my patch above is not introducing a new problem that wasn't
> already there. It's just that the toy repo, having so few tags, means
> any logic to reduce max_candidates will trigger there.
>
> +cc the author of 30b1c7ad9d for any wisdom
>
> -Peff
