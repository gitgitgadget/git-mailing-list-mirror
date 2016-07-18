Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C7A2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 17:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbcGRRsa (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 13:48:30 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34053 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcGRRs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 13:48:28 -0400
Received: by mail-io0-f173.google.com with SMTP id q83so166864962iod.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 10:48:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4ubVzqu23wtQWPPVNcDG9blFAf8WcNwSzKlqLQ1UdkM=;
        b=r4JupyLZ9+MdGYN6CyJm21eAFFwRrqcvxEfRd2jQthwJI1bOa4dggifRJ3GPupruac
         O3xa+Z16KOv8D6PDgK5p9oJbRRN0DHaDaNpeDkRQH2bDcd1slC4Pn6nMNcUODLXaLXY5
         /MpMFJ3fWVRuylnw4mqREs3VeWsFM4Cte4XX5PrAzySM1FcUVMzHBL1E0bgikXZeRo8d
         z6KL0zMOccrIG2sXhkjY0JWequQTiPbjdZsQujuuq7W8O61eDwvz2pju/sPghdEdL7Wx
         +9GJNJEmT0ojL3fhcP47czfilodQ21WC4E/N38KdgalQdNLHFM834ehKykZEZTt7otOP
         K7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4ubVzqu23wtQWPPVNcDG9blFAf8WcNwSzKlqLQ1UdkM=;
        b=MmD0rDZtll+BPF2uxdjNztjcyeWYSekoCl+7gyG8FROwaPHoqQk+vEUbqiDChMRFyS
         4Nt7IVNhMMioTzr2I7fCkTLQY6sxJACw+OAGTWvSg8kfLvYt83MGKnjpaGHZTMlyIBLu
         EK4nQjmlpqMt/lNwknxmfKUqMWV4THqB1Ldy9fMYepwTC1NReYGWXhPq4iLBDimLTcVj
         76QSrjm0+Vd/yxiNUkjMlOEAzNk3MTjvhi/Sw9EjITYEzx+8wEtr81uZOykf7bzKP89b
         iGsyCNrv0QXojLVRO/ymeAL7kcHZCjWl47uGz2bs4A16x7vqfrEfeGV/ZgLrRW5uOocK
         g6Rw==
X-Gm-Message-State: ALyK8tL/Gc3Hy0jXh95Iwz7gTUOHCs9FzY4T8TQ8sblgFgzfSMzPCn9u+N3p/7szrQTknwasiU6ifz2AfxD/jw==
X-Received: by 10.107.182.8 with SMTP id g8mr24978150iof.53.1468864093427;
 Mon, 18 Jul 2016 10:48:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.4 with HTTP; Mon, 18 Jul 2016 10:48:12 -0700 (PDT)
In-Reply-To: <CACBZZX5wjhYosupW=-n7UbbXAQug+sgSNS+jm_uUn6QwC8p6Aw@mail.gmail.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <CACBZZX5wjhYosupW=-n7UbbXAQug+sgSNS+jm_uUn6QwC8p6Aw@mail.gmail.com>
From:	Herczeg Zsolt <zsolt94@gmail.com>
Date:	Mon, 18 Jul 2016 19:48:12 +0200
Message-ID: <CAPp-Vra5ri7V03SSkU6=UnWrsq-jk0XcNpQuzGH8kQxE-TkPjA@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:	Git <git@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> In particular, as far as I know and as Theodore Ts'o's post describes
> better than I could[1], you seem to be confusing preimage attacks with
> collision attacks, and then concluding that because SHA1 is vulnerable
> to collision attacks that use-cases that would need a preimage attack
> to be compromised (which as far is I can tell, includes all your
> examples) are also "broken".

I understand the differences between the collision and preimage
attacks. A collision attack is not that bad for git in a typical
use-case. But I think that it's important to note that there are many
use-cases which do need a hash safe from collision attack. Some
examples:

You maintain a repository with gittorrent with signed commits Others
can use these signatures to verify it's original. Let's say you
include some safe file (potentially binary) from a third-party
contributor. That would be fine if the hash algo is safe. Currently
there is the possibility that you received a (safe) file which was
made to collide with another malicious one. Once you committed (and
signed) that file, the attacker joins the gittorrent network and
starts to distribute the malicious file. Suddenly most of your clients
pulling are infected however your signature is correct.

Or, you would like to make a continuous delivery system, where you use
signed tags. The delivery happens only when signature is right, and
the signer is responsible for it. Your colleague makes a collision,
pushes the good-file. You make all the tests, everything is fine, sign
and push and wait for the delivery to happen. Your colleague changes
the file on the server. The delivery makes a huge mass, and you're
fired.

Or, let's say you use a service like github, which is nice enough to
make a repository for you, with .gitignore, licenses and everything.
Likely, you'll never change dose files. Let's say that service made
one of those initial files to collide something bad. That means, they
can "infect" anyone, who is pulling your repo.

Do you need more hypothetical stories? There are a lot. Of course they
need a lot of work, and they're unlikely to happen. But it's possible.
If you need trust, and gpg signatures that means you need ultimate
trust. What's the point in making GPG signatures anyway if you cannot
ultimately trust them? You could just as well say: well that's
repository is only reachable by trustworthy persons, everything here
is just fine and really made by the person named in the "author
field".
