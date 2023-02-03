Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2219EC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 13:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjBCNnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 08:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjBCNns (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 08:43:48 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFB98D622
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 05:43:46 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id be8so5245153plb.7
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 05:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eJWuPG5m0iXolfPL6T7Prcfzm6PDxPB4nb0CaRSF37I=;
        b=VrWgk7DY+23sq9vO92bRMmD/VHnFcA7Ilgp8akvxv43wir4S0C4hmvHtoaYGTXIOj8
         8aPa7V7mLSwgVy0j6HPVFncX+Xa5psCK8h70EhBsjJTtQ9te+ZR4wmcHK5QqT22nBR78
         OjG7XBmkauHkishq5+yXZtF3tPwsqXmf0bHjRr41XVWY+nFLdiqc6lg5iIgkQAcFjqbb
         SH43scJZvE1iqTZNiqg5vgUTI/dh6lg9VPriITlVMCHsQ3FRP9WIV99rkiR9KYefkyrz
         c/ERRcI4SA0XxFa0QqVxceen2CFGJyLh8Eq4HPZMSjuNJGyeCA6j3kVAJa97612+pkXg
         ikUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJWuPG5m0iXolfPL6T7Prcfzm6PDxPB4nb0CaRSF37I=;
        b=1yCGONN7G5woA7ke2l+ABogcXutwVEV9F0LcQ81j7hxu2LVN/A10R+bXRDdP9n+wz1
         80Qs05ozAyd4hepS7fMfJbIqeWx19Vp8sFFfkmR8IFR93d2fX4iki8Ox2IS20mhdsY/Z
         kZOpp//QV+PXhVjdsIOGIkbiYqQEUuEQXHyuVdaLXmXh/OfaFisc91lQD7JIEsMArMeP
         ShJTPJ3YU5OBve0XPxOY0Es2GPv/0ry3xqzMW3fYFUX8WFlgeLwKjI9K6OeVS3nuzcid
         ymhG2O1zR1oIwl9Rl7MEODzxvuCzEmjp0jZnwuLypGslOhY1TW4002jjNt85ZfKGPEIW
         Y9tQ==
X-Gm-Message-State: AO0yUKUVHDF9hsW1iJZ7ZlOOpMGJdUZvZjLkjpndsT+HJ8h7d3okEJh0
        4aColuhWlc5JoyNgwUKZtUEdHvI2KRwkRkQ7YJZYBMdkBX4=
X-Google-Smtp-Source: AK7set8JIgx82WvP902W+bJwYlSUfyzsNRYjPr3BbjwM8+BuXhkRGv7HXK9jXDdU0JY/L5L0bWdSgXAygGgJq2RXc1c=
X-Received: by 2002:a17:902:8649:b0:194:706a:ad18 with SMTP id
 y9-20020a170902864900b00194706aad18mr2398161plt.18.1675431826338; Fri, 03 Feb
 2023 05:43:46 -0800 (PST)
MIME-Version: 1.0
References: <CADPR2CUgrO6ius5ss9Mgk8Zktf+4zQDq0vP4EEKOMku7K=V6FA@mail.gmail.com>
In-Reply-To: <CADPR2CUgrO6ius5ss9Mgk8Zktf+4zQDq0vP4EEKOMku7K=V6FA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 3 Feb 2023 14:43:34 +0100
Message-ID: <CAN0heSqwVV_G_nrt=omK0UjXVAD+TYPC+oB-1xHF4dG4oovncA@mail.gmail.com>
Subject: Re: Bug Report: Superfluous Tab Characters
To:     Diogo Fernandes <diogoabfernandes@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Diogo,

On Fri, 3 Feb 2023 at 13:50, Diogo Fernandes <diogoabfernandes@gmail.com> wrote:
>
> I have run into a bug where git seems to be adding superfluous tabs to
> the end of filenames that contain a space. I have attached the output
> of `git bugreport` for your review. Feel free to have a look
> https://github.com/trufflesecurity/trufflehog/issues/1060 for
> additional context.

The code that adds this tab in the output of `git log` and friends has
changed a bit since it was originally added in 1a9eb3b9d5
("git-diff/git-apply: make diff output a bit friendlier to GNU patch
(part 2)", 2006-09-22), but in that commit you can see the original
motivation.

Here's an online view:
https://github.com/git/git/commit/1a9eb3b9d50367bee8fe85022684d812816fe531

Martin
