Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2CE2095E
	for <e@80x24.org>; Sat, 18 Mar 2017 03:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdCRDup (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 23:50:45 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35358 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdCRDun (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 23:50:43 -0400
Received: by mail-oi0-f50.google.com with SMTP id a94so3640758oic.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 20:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mlglLcIE9KCd2k/raoWA5Nqsyw+FGO0VrrzX14hHhh0=;
        b=iTM4p/y/oyNDZR5lV5EOm+gIWDYDjFRIBBxoGVzwMo6Px4JH+UNtNE9zCUrRxydhQE
         4pv4qePzoVfFXiYdEJ1c4VJwbSRbTFFFCVDXnitWpUXBpjU78wUdZcuytZyPNiv7q4sz
         kv+hEHaQU3GyfFfidOdAt0kVUWqrt8weNSIWObLqHf17fQ2j9w7Ff2+QxGWl1X+MT1j+
         7vgovrwxVMve5iDVJqGCWlOPWFbw7ZU/7rkZFAwetGnhrjr5Eane3uan4Wu6CHf+tZF+
         ftQxKYiWm9PSqjso+NulJLB8AHcaamKLx8vIY+McsR0r3L91fYc/OsJC4eH1/fnfDwCm
         Hqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mlglLcIE9KCd2k/raoWA5Nqsyw+FGO0VrrzX14hHhh0=;
        b=QFBnwThn3LIgSmEFwT8b4EgnQ5HW4f0Mzxf8s+ke30iGjHRj5Z7YGadmd2z0T1YkUF
         6aAU3XphNGm1G1S6xShlGdjOtL02bqZYvOqL6NJXilIAo8pOW//I55cn5x1sBf7P0oom
         nkn71b1RAbT176/4aB15Vv1JmM+W0MGXjuFaGWhmM2fNe038eF4rv9ZheSk18Y0LxnTw
         s55JkNCY5100gRuOsSRxKMG2gqS45ttx7KPy4B+lqFqpItbos49XK6vrYvGyGG1xsxxi
         UBMnk79h3Z/ZWZH5WIJwm8URiXRrqCAHHR5hHlgav8b4/jVUiH1QkAZVDm+ZV3aXCdLc
         US/w==
X-Gm-Message-State: AFeK/H3jbXE9QGMgfkvw2d7KNtnOiK4UY11dE2RiXud24/Iq2nQ++8KiXUjXb4Lb/SFbD8n3zSzsleUaao/xhw==
X-Received: by 10.202.72.10 with SMTP id v10mr8333837oia.169.1489808476293;
 Fri, 17 Mar 2017 20:41:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Fri, 17 Mar 2017 20:40:45 -0700 (PDT)
In-Reply-To: <20170317220213.GO26789@aiede.mtv.corp.google.com>
References: <CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com>
 <xmqqmvcj61j2.fsf@gitster.mtv.corp.google.com> <20170317220213.GO26789@aiede.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 Mar 2017 10:40:45 +0700
Message-ID: <CACsJy8DYx_vEyUBJWQ=-rOGvWG2BBGQKbxYTVS18NPqfk02r9g@mail.gmail.com>
Subject: Re: Bug with .gitignore and branch switching
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nevada Sanchez <sanchez.nevada@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 5:02 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>
>> There is no "untracked but precious" vs "untracked and expendable"
>> difference in the current system.  An untracked file that matches
>> patterns listed in .gitignore is treated as the latter.
> [...]
>> We've discussed the lack of "untracked but precious" class a few
>> times on the list in the past, but I do not recall the topic came up
>> in the recent past.  It perhaps is because nobody found that class
>> useful enough so far.
>
> The most recent example I can find is 2010:
> http://public-inbox.org/git/4C6A1C5B.4030304@workspacewhiz.com/.
>
> It also came up in 2007:
> http://public-inbox.org/git/C0E9F681E68D48EB8989022D11FEE3D1@ntdev.corp.microsoft.com/
> Earlier in that year it even made the "What's not in 1.5.2" list.
> http://public-inbox.org/git/11793556383977-git-send-email-junkio@cox.net/
>
> Perhaps those references could be a useful starting point for an
> interested person's thinking.

I think I made it work in 2014 [1] using new "precious" attribute, but
never submitted it, probably because I was worried about the
interaction with untracked cache (adding .gitattributes as a new
dependency) though maybe we can avoid that by always checking for
preciousness after all the tree walking/filtering is done, either with
or without untracked cache. But I never addressed that loose end. Then
again, it could also be another useful starting point for interested
person's thinking ;-)

[1] https://github.com/pclouds/git/commit/0e7f7afa1879b055369ebd3f1224311c43c8a32b
-- 
Duy
