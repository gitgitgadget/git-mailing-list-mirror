From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Remote hung up during `git fetch`
Date: Thu, 22 Nov 2012 11:01:30 -0800
Message-ID: <CAJo=hJveYb09uhZWsKWKYor5Jcuz+wZ40F3wnsR3Hy8bcxeb6g@mail.gmail.com>
References: <CAMvDr+R__wWRwm2xNC3-v0T1RVu_rKdjKUJhb8cHwEXvuX9OMQ@mail.gmail.com>
 <CAMvDr+QuMpfdTdkOMOiYyEnHvQjia2cDCt3sx2rQwwLcJiCVmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Yichao Yu <yyc1992@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbc2O-00039Y-F9
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab2KVTBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:01:53 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36016 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964805Ab2KVTBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:01:51 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so5929276qcr.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JEJVQ9N0o6Wk6XHPKaTOOKuBiQKrx9GE1GoP2e7tI3U=;
        b=ZLEjgsjtkV/HMYAf37i1ocV8JwMUXRf4sy73Yw81xDFE/yJG/4+bBrfPnLBmaCwbQL
         rv3gK/pI4zhrvCsjkZPZPND/LueMnOcI/atD84akxd1MpmFS5X8uORtghPcfzfQ4MHAq
         1ysUbFLbeUwRmEvVDg997kE3e2OQlO3/G6ZPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=JEJVQ9N0o6Wk6XHPKaTOOKuBiQKrx9GE1GoP2e7tI3U=;
        b=VQ0lj/7DNOO9OSAda4iKKdtEUJIS92lFZ+qOk9NgklswPRf0+N+5DhZrtAXZVUJAKK
         CpVFNFuDBI6/VnN2TzxFgHgJpLa+e/OWM9Qp0vld9Yd5Lr31L1vXedG/OxND6BKPRCI1
         ygq//plh9Xz+spSqiSSQRhYpOHUyphB7ibjsYnfC7fon+PClpEX166pgC9qF0YhmDt5K
         t69jsiZFv4jqwXBeOyME8+xeyKZjtJQANFHBhJn90cZlFaRQF+fIs/XfHXunPfkb5mQC
         02tYW6fiOyRGc1Y+7eTGGBAd3cBLBY3jrdB4VpMsRB00203pBJ7MYg5oHC/91jOBqIUP
         Fjlw==
Received: by 10.229.174.98 with SMTP id s34mr330892qcz.65.1353610910228; Thu,
 22 Nov 2012 11:01:50 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Thu, 22 Nov 2012 11:01:30 -0800 (PST)
In-Reply-To: <CAMvDr+QuMpfdTdkOMOiYyEnHvQjia2cDCt3sx2rQwwLcJiCVmw@mail.gmail.com>
X-Gm-Message-State: ALoCoQlYB1aquuIBIkUtImFl+wN7hRFTJ8DOWDzgQ+lJIMI6Qri+L8vH77I64RskNl/+AjwU+UVj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210187>

On Thu, Nov 22, 2012 at 10:39 AM, Yichao Yu <yyc1992@gmail.com> wrote:
> I sent this email yesterday to the git mailing list but I cannot find
> it in any archive so I decide to send it again.

If it was HTML formatted it would have been silently dropped by the list.

> Does anyone know what has happened to the mailing list? I haven't
> receive any email from several kernel related busy mailing lists for
> several hours....

US holiday today? The list traffic tends to be down during holidays.

> I want to build packages for snap shoot of different branches from
> different remote git repositories in the same local directory (so that
> I don't need to recompile everything everytime.) and I am using a
> combination of `git clone/checkout/reset/fetch` to do that. However,
> during git-fetch, the remote sometimes stop responding or simply reset
> the connection. This happens occasionally at least for both ssh and
> git protocol (not sure about http/https) on github, bitbucket and also
> kernel.org so I think it is probably not due to a weird behavior of a
> certain host. Does anyone know the reason or is there anything I have
> done wrong? And is there a better way to set the local tree to a
> certain branch at a certain url? THX

If the remote server is really busy it might be OOM'ing the server
process which would disconnect the client. Or maybe its your ISP
sending a rogue RST packet to kill the connection because they don't
like traffic that leaves their network and costs them money on a
peering agreement. Or... ?

> #!/bin/bash
>
> repo_name=git
> # remote1='git://github.com/torvalds/linux.git'
> remote1='git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'
> branch1='master'
> # remote2='git://github.com/git/git.git'
> remote2='git://git.kernel.org/pub/scm/git/git.git'
> branch2='next'
>
> git clone --depth 1 --single-branch --branch "$branch1" "$remote1" "$repo_name"
> cd "$repo_name"
> git fetch -vvv "$remote2" # "$branch2:$branch2"
>
> -----------------------------------------------
>
> Cloning into 'git'...
> remote: Counting objects: 43215, done.
> remote: Compressing objects: 100% (41422/41422), done.
> remote: Total 43215 (delta 3079), reused 22032 (delta 1247)
> Receiving objects: 100% (43215/43215), 119.06 MiB | 1.60 MiB/s, done.
> Resolving deltas: 100% (3079/3079), done.
> Checking out files: 100% (40905/40905), done.
> fatal: destination path 'git' already exists and is not an empty directory.

Why does this error come up? It looks like git already exists locally.
Git should have aborted much earlier in clone when the directory
exists.

> Server supports multi_ack_detailed
> Server supports side-band-64k
> Server supports ofs-delta
> want 2d242fb3fc19fc9ba046accdd9210be8b9913f64 (HEAD)
> have ef6c5be658f6a70c1256fbd18e18ee0dc24c3386
> have db9d8c60266a5010e905829e10cd722519e14777
> done
> fatal: The remote end hung up unexpectedly

This looks like its from the fetch command. Since the server doesn't
report any errors to the client, its hard to say why the server just
gave up right there. I wonder if this is related to the fact that you
did a shallow clone initially. The shallow clone may have confused the
server when fetch ran because it only sent 2 have lines and gave up.

Try exporting GIT_TRACE_PACKET=1 and seeing if you can get more
detailed information from the protocol on the client side.

FYI, https://kernel.googlesource.com/ mirrors git://git.kernel.org/ so
you can also try pulling from that server (e.g.
https://kernel.googlesource.com/pub/scm/git/git.git).
