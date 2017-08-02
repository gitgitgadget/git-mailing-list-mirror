Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD791F991
	for <e@80x24.org>; Wed,  2 Aug 2017 07:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbdHBHln (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 03:41:43 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:32796 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdHBHlm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 03:41:42 -0400
Received: by mail-oi0-f49.google.com with SMTP id d71so32341048oih.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 00:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=backbase.com; s=backbase.com;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4ktCaToqzJ/PhbowxeRPma5hou8Nk5FMjypHFCAQAEM=;
        b=LJj8h1/wCvPbspRNtrrhFeKHi0h/wEY57FdnQCMBRTsHFYLT2LLc+3oqqRL7NekCil
         5Cy0/mxnUVRuDCL5MhxlOfrk3ZbJXIG93avZ3Qsmdny2cjbTY3J7g8EL/b+fSn+PjEtE
         YTR0uayrWxV6kbVjbhxzHBSdUBJnJpQqFxEIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4ktCaToqzJ/PhbowxeRPma5hou8Nk5FMjypHFCAQAEM=;
        b=J46RHswFFosU+JZCqdubGyjk07zhDBOx5XuiBQoM/wGsi9BIFX8UEUTZpwRqmwh15w
         ulJVLbKQ3FWCe1XpuEiSakD35jfMIY6bnKEeQtFKotUrlV+cfM4hkdfxmanZwEna2cfk
         47Fp4dm8Ab8gIs6E6tsX6B/8Dc2Bndt+d+QKiI3/i+NfeWP8ekQJHQz3dRZLkcr6HyOT
         6sOYo5Ur76zPWRYqQbYkJ7IVJByjHikdao7BYDojXk80rztcHL2ymNdf+iVDr/E6MiiB
         njsLmr1kO7AR8vczk3ruBo8ov0fsJn+8kuTZqpsO85a66ttVKf2EdQNNlNEzWuq7CiVq
         Ag2A==
X-Gm-Message-State: AIVw111Icp2GNSnuY2admoJrNaVwnsdYoR6oU2owWWRzf1/qNYkqLc3X
        N47+fFDbQbu8ZWlqPN4hfzjH8SfE/aXdvOQVEw==
X-Received: by 10.202.187.194 with SMTP id l185mr11155931oif.228.1501659701736;
 Wed, 02 Aug 2017 00:41:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.142.196 with HTTP; Wed, 2 Aug 2017 00:41:41 -0700 (PDT)
From:   Richard Jones <richardj@backbase.com>
Date:   Wed, 2 Aug 2017 08:41:41 +0100
Message-ID: <CACq05g+4HH9L_fiFLR8php=w5JkqB0792SzR9EZU-o+QHuoM8A@mail.gmail.com>
Subject: Git log --tags isn't working as expected
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I=E2=80=99m trying to locate a commit which takes place after another one,
matches a certain tag, and is by a specific user. I have the following
command:

git log <COMMIT_ID>..HEAD --decorate --author=3D=E2=80=9C<AUTHOR>" --tags=
=3D=E2=80=9Cproject-name=E2=80=9D

The tag follows the format: project-name-version

How ever this doesn=E2=80=99t seem to work, as it returns all the commits b=
y
that user since the commit ID supplied.

There is also another tag, the release version which follows the
format: x.y.z. I have tried searching for this, using:

git log --tags=3D=E2=80=9Cx.y.z=E2=80=9D

But it returns all the commits, not just a specific one. The tag I am
searching for is returned by: git tag

My understanding from the docs
(https://git-scm.com/docs/git-log#git-log---tagsltpatterngt) is that
git log should only return matches to the =E2=80=94tags argument pattern.

I have tried using git version 2.11.0 (Apple Git-81) and version 2.13.3.

Cheers,
Rich
