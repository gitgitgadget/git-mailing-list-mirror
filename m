Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850393F39DF
	for <git@vger.kernel.org>; Fri, 29 May 2026 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077995; cv=none; b=bEGaOqwsMEtmCAaxyojEdAJvz/n2GuB4c+f7VeLcn+b4AUGdHIDxsW79Q7NFGuSSEjcxBmTi+uQkjdxz/hT4Kh/CkFY6WPLUxx7vKizjTw9lOqeMY/wT0ss2VzuOmnQ92WbPF3f6QzI4bPBWWzUsYQF2XUgPcs7Mz+zlUjzaFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077995; c=relaxed/simple;
	bh=YiXAgiEpY0LieI7RBbYwPmcE8dsW8LzEfJrnBV6roE8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEQguwqOjTbf5TUTu2LeF2nfzzpAThau29lbwiwkgbUUb1unYWrFyiUahfvLzz7Iph/3vCuBN3TCprtcH/Py04JMyRsY1ErJDL9MAU0rSvJD9NzYFAvuW0LIdlX2YgsH77sJ9oiTm8lu+rP84iJqvp8b5kOIyI/NrwcfjiJeMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCVvOr7Z; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCVvOr7Z"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef4332d89so74220f8f.3
        for <git@vger.kernel.org>; Fri, 29 May 2026 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780077992; x=1780682792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfEnkfPzv8JoIzTDLgSfKjGtYZVb9cugycLXni1I5rs=;
        b=HCVvOr7ZA04PZPJ/QjHHuy2a/XWhFl26Fg8zeHtZhxd5ElgGQEDdVVnfdDF206Bfzq
         ol2rVih3ulDAONWwBdUVRrvkO5Y+5JVHFcAKc/HvYiZ8fS8oqd0E6e13v7eq6keE2K56
         VXyB7YBGkir3W4UPZbJMDXxANEwClSkRsvq0IEBcpDuJ1WN8ypEgaZnezPNocWrVQ3Wn
         mvb7BkN0bnOp5kmClz0Rx/QWCfyeNfOiii4xmOi6aGnSsk3ObxZObjiqQeFsSWjtx43+
         GUPs6JSvDju2nq/RGx2bGe8aTWzT8GZQRUbioysSQCBt8k8MmL/CAEUT/iL3r3lUgFmm
         BStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780077992; x=1780682792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RfEnkfPzv8JoIzTDLgSfKjGtYZVb9cugycLXni1I5rs=;
        b=C7K48BFzlBHZk1SKRz9+bEIuXHW8VLE/87L0i6+IPnoLbHI6yqQB5F4Z8PLwIyHeF1
         LTT7FO58WAUk9jcvG2o4Dk6qZ8T54whF5O4cRqUGWjIyYLowMHRcasWh7hJ02rsoKdWi
         W2I4fEFjgRDLQvZTVG6eEcxJ+p+/byM/W6pe+GgqOLOdov3FksOXliQAha3edy5zd4np
         7vKhktQNyIAPVno8IDMXXgUQ+07VEIECCEFSVApkVyMdlHtDpwPll4yBbi8KLEnD/n1R
         fqoVikyxRyzGbKoCXsrh46o2U71dJ9yd6V3e03Wh8hGUQtFS+90wjrD2hoEYPMHLuC9M
         IWhQ==
X-Gm-Message-State: AOJu0YwyI+Urd6J+SIvGedzAqyi9Yh7pZ6FCkNITceWWjnVJeYIlbhsi
	ntCKwkw2DF98+900GXKaAexeCWpXwfxxycPEmmBgb0lG9h0FTLevpPBaXS19TPALDj4=
X-Gm-Gg: Acq92OGsj9wO81o93pZQHfzEcVcpA8hFu7xjBCl2X1fNcUFJ2PREhoSBxxGJavGWnMF
	25QmCX7NI8em8w09iwx+dgDdQ548Ox3ue2OwifrQ0csnvfDFK0qc+aHyfBtrZqhtlGc8tz4dBCF
	zmuYpupzHtEBbkScqkLqOtep3C6pQfnsTqrCDUY6JXEmvc4XhyK1SCoN22j4vtEJuFGlZuHLi8I
	ntDWsp+NAIMsCJ3NQHgiddRn6B7pRi0I8vnLd3GCeU5xEboCSfUjuarRJtZk1WB93jqFVI3vSaO
	QHFhUm7wOFgKl6lOZpjjzBwHAGB1ZL44xOdJbeiCtfmJK+UJfIyYI1ZDj7FlEd3kXhfhMpFmsBu
	/atXPvwLUqsKuwbz01zTvIahvZFy33OhuIU9gMy5+7btSJxDR94nlrThancxI1xi8tViU+UnQ5x
	JWw+XiaEzfk3wbdwKJz3yE0doc2i+D4FqZgND34A==
X-Received: by 2002:a05:6000:2892:b0:44c:e7f6:3a5c with SMTP id ffacd0b85a97d-45ef6a945e7mr779827f8f.0.1780077991779;
        Fri, 29 May 2026 11:06:31 -0700 (PDT)
Received: from desktop ([194.127.199.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb62sm4769059f8f.19.2026.05.29.11.06.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:06:31 -0700 (PDT)
Date: Fri, 29 May 2026 19:06:29 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Subject: Re: Suggetsions for collaboration workflows in large repos
Message-ID: <ahnUeESE1x802Z9N@desktop>
References: <20260529163117.z2auhbg4sdxxgmis@archP14s>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529163117.z2auhbg4sdxxgmis@archP14s>

On Fri, May 29, 2026 at 05:31:17PM +0100, Matthew Hughes wrote:
> I thought about doing something like tracking
> `refs/heads*/some-colleague-branch` from the remote, since with the wildcard
> `*` I at least won't the fatal error on the missing reference during fetch, but
> that risks my config containing an ever growing list of such wildcards, or a
> bunch of manual work occasionally cleaning up old ones (or maybe that could be
> automated).

I hacked some scripts to automate this. Firstly, one for fetching:

1. Fetches the branch
2. Adds a fetch config with wildcard hacks so `git fetch` brings in updates for
  that branch (the refspec should match _exactly_ that branch and never
  anything more)
3. Adds a separate ref to record that we're tracking this branch (so something
  knows to clean it up later)

    #!/usr/bin/env bash

    set -o errexit -o pipefail -o nounset

    # save command as e.g. git-fetch-other
    CMD_NAME="$(basename "$0" | sed 's/git-//g')"
    if [ $# -lt 1 ]
    then
        echo "usage: git $CMD_NAME branch-name [ remote-name ]" >&2
        exit 1
    fi

    BRANCH_NAME="$1"
    REMOTE_NAME="${2:-origin}"
    FETCH_CONFIG_NAME="remote.$REMOTE_NAME.fetch"

    git fetch "$REMOTE_NAME" "$BRANCH_NAME"
    git checkout -b "$BRANCH_NAME"

    # we want to record that we are tracking this branch, to do this create
    # a new ref whose name tells us what we're tracking, but whose value is
    # unimportant. So as a placeholder value just use the hash of an empty tree
    # taken from https://git.kernel.org/pub/scm/git/git.git/commit/?id=9c8a294a1ae1335511475db9c0eb8841c0ec9738
    EMPTY_TREE_REF="$(git hash-object -t tree /dev/null)"

    # refspec used to track the branch: we expect branches to be deleted from the
    # upstream when merged so tracking exactly:
    # "+refs/heads/$BRANCH_NAME:refs/remotes/$REMOTE_NAME/$BRANCH_NAME" will error
    # when we go to fetch that exact ref after its removed upstream.
    # so HACK around this: add wildcards that we still expect to only ever match
    # this exact branch (but doesn't have the issue of git complaining when it
    # tries to fetch an _exact_ ref)
    TRACKING_REFSPEC="+refs/heads*/$BRANCH_NAME:refs/remotes*/$REMOTE_NAME/$BRANCH_NAME"

    # record that we're tracking this branch. First check we've not already
    # recorded this, then ...
    if ! git config get --local --fixed-value --value "$TRACKING_REFSPEC" "$FETCH_CONFIG_NAME" >/dev/null
    then
        # ... set the config to track it for fetching, and ...
        git config set --comment "$CMD_NAME: tracking at $(date -I)"  --local --append "$FETCH_CONFIG_NAME" "$TRACKING_REFSPEC"
        # ... record that we have special cased this tracking
        git update-ref "refs/tracked/$REMOTE_NAME/$BRANCH_NAME" "$EMPTY_TREE_REF"
    fi

And the cleanup script (needs to be run periodically):

1. Collects all the remote branches we know about
2. Checks all the references from step 3. above and checks if any branches
defined there are missing remotes (I have fetch.prune=true to keep the remote
tracking references up-to-date)
3. If they are, drops the tracking config for that branch

    #!/usr/bin/env bash

    set -o errexit -o pipefail -o nounset

    REMOTE_NAME="${1:-origin}"
    TRACKED_REF_PREFIX="refs/tracked/$REMOTE_NAME"
    REMOTE_REF_PREFIX="refs/remotes/$REMOTE_NAME"

    declare -A remote_branch_lookup
    while read -r remote_ref
    do
        # strip prefix, e.g. 'refs/remotes/origin/some-branch' -> 'some-branch'
        branch_name="${remote_ref#$REMOTE_REF_PREFIX/}"
        remote_branch_lookup["$branch_name"]=1
    done < <(git for-each-ref --format='%(refname)' "$REMOTE_REF_PREFIX/")

    while read -r tracking_info
    do
        tracked_branch="${tracking_info#$TRACKED_REF_PREFIX/}"
        if ! [[ -v "remote_branch_lookup[$tracked_branch]" ]]
        then
            echo "branch $tracked_branch has been removed from the remote, untracking it"
            git update-ref -d "$TRACKED_REF_PREFIX/$tracked_branch"

            tracking_refspec="+refs/heads*/$tracked_branch:refs/remotes*/$REMOTE_NAME/$tracked_branch"
            git config unset --local --fixed-value --value "$tracking_refspec" "remote.$REMOTE_NAME.fetch"
        fi
    done < <(git for-each-ref --format='%(refname)' "$TRACKED_REF_PREFIX/")

So functionally I think this allows for the workflow I want, but does feel like
a big ol' hack :>

