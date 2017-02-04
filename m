Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726D11F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 18:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbdBDSn7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 13:43:59 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:33683 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbdBDSn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 13:43:58 -0500
Received: by mail-it0-f47.google.com with SMTP id d9so14806973itc.0
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xOo/SpAfKPz83aTkWlzcBgz+4FwHSk3leXSbc7fUeA8=;
        b=F7jTJu6csOf/7u5NidlpXsl8Cw4iLoCzslzem4uO2ECXmH2ImuZ+K2lFTbecLFuRo4
         40016HIxgmIcLkzq81mzP4bw1ScgkoXKkh3z9/0WWWpoZapEGvKxUQXW+fOx7VFMr0oK
         Ndo6AQssW5C/6wHh1gNh972lOOGdeNi+7QyI9Z5aaL6Bclw+t0CQBrO6tNylnzWt53F1
         XrC2u42saGvoRdT2v9OX22q66k6zIsoJjFpS88PPYelHNOobUDdbQYCXm99zlf8r2mSp
         +QjICr6E0WIlM72E/TaA1JjnSwwIP/8zrXXPVyyVyXWuIU5hTeCOHEvh/Eax4C4YLl5f
         HhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xOo/SpAfKPz83aTkWlzcBgz+4FwHSk3leXSbc7fUeA8=;
        b=ANAXokOk8xBirRkLf7WZ6qalIfjYwWwjRhcXwh6t9jaJbeUfqbJa0ibwPHxJgnNNXh
         8djZ48UtjkbxyJAWkTA0c8ELqgSbL6FHwwbkQRe6KecpFcf2uQVcShwN8N9BZwjyjMfS
         SvXG5ymCkZzSFJ3FC5Gc1mcqWoqKUy0nmwCyiW3pD+1RGFLJUzpYvElYG6sMTIr4gIAU
         iQwrSn3dR/6gk8a1SXTUVm+Gb2kczmwheviBVwOGuZD8lQ/yLP7Z1y2znKBExQIu3Ut3
         TUO3yT9VxfXzeWtfLi7bOueNigojQ0zXFQzs4SYKBEZlQr7y5aZDGesnyEbdnreEj4/1
         qX4Q==
X-Gm-Message-State: AIkVDXLBFPqX8s2PRLgdGioVoU69y810UxBFGrX/lUQ91MyvgwYwl4tnGbjyLE1Me7BJ6XMNj+VXYNFPCMa4xLwP
X-Received: by 10.36.169.12 with SMTP id r12mr2072650ite.69.1486233837056;
 Sat, 04 Feb 2017 10:43:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Sat, 4 Feb 2017 10:43:56 -0800 (PST)
In-Reply-To: <20170201021040.4f6cc827@hikaru>
References: <20170129203348.1a8c0722@hikaru> <xmqqvasxwee1.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbCfKVDq+9Pr5LmOtT=+uB+u+EMQg1=FUNS2umCvtvHhg@mail.gmail.com> <20170201021040.4f6cc827@hikaru>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 4 Feb 2017 10:43:56 -0800
Message-ID: <CAGZ79kYXc-cT-059ZpoVrUjLodY-x61bW2ANQqtcAQLzGiRZ3A@mail.gmail.com>
Subject: Re: git push failing when push.recurseSubmodules on-demand and git
 commit --amend was used in submodule.
To:     Carlo Wood <carlo@alinoe.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2017 at 5:10 PM, Carlo Wood <carlo@alinoe.com> wrote:
> On Tue, 31 Jan 2017 14:08:41 -0800
> Stefan Beller <sbeller@google.com> wrote:
>
>> On Sun, Jan 29, 2017 at 5:00 PM, Junio C Hamano <gitster@pobox.com>
>> wrote:
>> >  2. If the amend is good and ready to go, "git add" to update the
>> >     superproject to make that amended result the one that is needed
>> >     in the submodule.
>>
>> yup.
>
> But that is what I am doing. The amended commit IS already
> added to the superproject (and pushed to the remote).
>
> Please have a look at my script, this happens here:
>
> # Correct that in the parent too:
> pushd parent
> git add subm
> git commit -m 'Updated subm.'
> popd

And if you were to use ammend here, too; there would be no problem;
In the parent there are now two commits, the first one pointing at the
first (unammended) commit in the submodule, the second pointing to
the corrected commit.

>
> The commit from before the amend was added to the super
> project (but never pushed) but has now been completely
> replaced. I still think this is a flaw in git. It shouldn't
> not complain and simply push.

The problem here is in the design.
When "on-demand" is set, the parent repo determines which
sumbodules needs pushing, then runs a plain "git push" in them
and then checks again.

The push operation in the submodule did not push out the un-amended
commit (which is correct IMO).

The parent in the second check determines that there is a commit, that
is not pushed, though. Maybe we need an option there "on-demand-but-no-recheck"
as a weaker promise what Git can deliver there.

>
> --
> Carlo Wood <carlo@alinoe.com>
