Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5940A1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 01:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032372AbeBOBX4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 20:23:56 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:50949 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032245AbeBOBXz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 20:23:55 -0500
Received: by mail-wm0-f44.google.com with SMTP id k87so8246361wmi.0
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 17:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AkW+3fz2S6gI3iA2y3UbHhGm07s453EYmJTTe2VmXNE=;
        b=tND0YA9nqzan/MMD7bl+5DqKe/so7TXQ7F2gHtNpTzbGpb+XbLhG5L9taU+WLJYLiE
         3DPL67r6HII9ryjr7Hm4H4FJ2d/QArlfgPJBFWrUnESIVC07XZNqTXHshC8am1uCUtz1
         TqWhJEFNf1YUQ6bDDq3q6Gl18h6KCChjs9zt3jCVIifRGPE3n/7/8D57ILu3wuxXdU4e
         EoQ2J2V3Sva2brHSPQA0WaGqr4gpGQieHhBoouFRH9j1LdSrNBQ8bBYKORMTFCu31Z4X
         di4140c+eRJVRrYT8QgGgAmb1sPNHsmuXO8G2ydQKU9F6N+JOVvtCDoUrg5IFJTV6qGj
         ALTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AkW+3fz2S6gI3iA2y3UbHhGm07s453EYmJTTe2VmXNE=;
        b=FLZ9FRk6XlNfiwAk6D6ujqFLCpCDO/U8Jbx6P3qkyb8gVNCQ2DtZCOP5/UB1yBZX9D
         6BcQPzidYqDHEbY5mWUu4z8peq3roafhoM9F+mEPH+ma2SEJGjcfd1r63zXJ4W+gDZm5
         59OoEdCjKbBmmX5bpg5oYIJEiRG+6/EJcqpZzeOBZBjVD/Okcxi4u7NZJRK71eO3MtQ6
         QqySW/rJvcXRSeGXSHU/6rUtZ5Pck5LEzgKRKiHRHt5dj7sIDvkrwrLVKjpoqbMGzQpV
         49zFGQ+1c+JhTL7ec4GcQt75nUV6Fr96JYmhfgVA/OsMN0m/ZdZLerLOI+Tjphuf9pf2
         RSMQ==
X-Gm-Message-State: APf1xPBSFWIOnAn/r9FbG/9FGh9DfxbxfNvrn0J2z8oQ/ZeIJtWeCLI/
        jJ7gUtkpvKqQdWS5puD5kbD7/PO/EI1Ge7kEJ/s=
X-Google-Smtp-Source: AH8x226EjSzUdriN4AookiQD8BhprIHwoRC02s/KpCeNdS3DPG9hncJ+1IHQ+t1pBxyN9bBlwFdMNFFTdbfy/iTvvek=
X-Received: by 10.80.178.99 with SMTP id o90mr1052113edd.255.1518657833812;
 Wed, 14 Feb 2018 17:23:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.149.220 with HTTP; Wed, 14 Feb 2018 17:23:33 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1802150148040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com>
 <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com>
 <CAEWZXo6ws5q-73AP6+Ru39a+drO88fRO49_QGJbQXfOYRpqKwg@mail.gmail.com> <nycvar.QRO.7.76.6.1802150148040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 14 Feb 2018 17:23:33 -0800
Message-ID: <CA+P7+xrNPe5106qSjs1BiGJ5RbVxmR=MiGNVeCAUbT3gR0cdLw@mail.gmail.com>
Subject: Re: git-rebase --undo-skip proposal
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Psidium Guajava <psiidium@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Paul Tan <pyokagan@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 4:53 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 14 Feb 2018, Psidium Guajava wrote:
>
>> On 2018-02-13 18:42 GMT-02:00 Stefan Beller <sbeller@google.com> wrote:
>> > On Tue, Feb 13, 2018 at 12:22 PM, Psidium Guajava <psiidium@gmail.com> wrote:
>> > I think this could also be done with "git rebase --edit-todo", which brings
>> > up the right file in your editor.
>>
>> Yeah that'd would only work if one started a rebase as a interactive
>> one, not am or merge.
>
> I agree that the original proposal was clearly for the non-interactive
> rebase (it talked about .git/rebase-apply/).
>
> The biggest problem with the feature request is not how useful it would
> be: I agree it would be useful. The biggest problem is that it is a little
> bit of an ill-defined problem.
>
> Imagine that you are rebasing 30 patches. Now, let's assume that patch #7
> causes a merge conflict, and you mistakenly call `git rebase --skip`.
>
> Now, when is the next possible time you can call `git rebase --undo-skip`?
> It could be after a merge conflict in #8. Or in interactive rebase, after
> a `pick` that was turned into an `edit`. Or, and this is also entirely
> possible, after the rebase finished with #30 without problems and the
> rebase is actually no longer in progress.
>
> So I do not think that there is a way, in general, to implement this
> feature. Even if you try to remember the state where a `--skip` was
> called, you would remember it in the .git/rebase-apply/ (or
> .git/rebase-merge/) directory, which is cleaned up after the rebase
> concluded successfully. So even then the information required to implement
> the feature would not necessarily be there, still, when it would be needed.
>
> Ciao,
> Johannes

Instead of an "--undo-skip", what if we ask the question of what the
user actually wants?

Generally I'd assume that the user wishes to go back to the rebase and
"pick" the commit back in.

So what if we just make "git rebase --skip" more verbose so that it
more clearly spells out which commit is being skipped? Possibly even
as extra lines of "the following patches were skipped during the
rebase" after it completes?

Then it's up to the user to determine what to do with those commits,
and there are many tools they could use to solve it, "git rebase -i,
git cherry-pick, git reflog to restore to a previous and re-run the
rebase, etc".

Thanks,
Jake
