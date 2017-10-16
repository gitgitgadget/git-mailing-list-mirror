Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4721320446
	for <e@80x24.org>; Mon, 16 Oct 2017 05:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbdJPFFe (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 01:05:34 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:49039 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdJPFFd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 01:05:33 -0400
Received: by mail-oi0-f52.google.com with SMTP id m198so23351085oig.5
        for <git@vger.kernel.org>; Sun, 15 Oct 2017 22:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=awSlPIPfbnoSCNK0M/IKOS7L+kmqlZMipjqaGzXO1VA=;
        b=XmLA+v3IGyS7nzQkpeUjCYrRVRxxURJBVjL0ftpaLz2F2351zF7CYU8CfHfVRmD9c8
         PM315BS28C0l5Z+lLNhAMh7lBPJ0Nvf0m9C+fgzU3zdZ63Sj9quwwTztmbRsBHr9kAwJ
         ddlJRlW2JP+YwKF5SAV5u8ewd8NLZevPkFMbrv0aazf5OfZ68Kk/uDmQ5gqHp9lnaObE
         tocS5tXovZnYxzGzTrIsb5h0LfHa8UeqogliGqMN0kxLWpBJr0HQ2Df3+BFIdF/ZPz3W
         tiZrwyGd/E0Gb+XFNYUKHB8A9HICrrE4TSZYfTLet4wtXiARu2vqP6Bf5MO2Gsgsonah
         rMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=awSlPIPfbnoSCNK0M/IKOS7L+kmqlZMipjqaGzXO1VA=;
        b=FdEDt2QrJThzslKnDuhdukgLyFEIlvmpdB449c6RT1PPVXKQyamPh+5AzR4yvekz2Z
         4PObtRbYM76XNiMlgM3eZYKCx5Y8dMwEx5DJ15Co4yzF8xhILFzKCzt7nXgtml5sAb/o
         C5mJydxfm75/1mfjDtUvKrcXUDASDzjk5Nj4TfAvYsrvqIXajF8vlaDIzAiFBnqL59Zm
         y1KYfgoxh8rr2A3t40A2AOu2fUYE2Ef8f0VeclLOfD8ttu9xnmClwI9G/JTfF7IhXW+G
         EkPZoUoe7DiWtZNg5e1u0lKzS3bWs8ka/Qtids88GdQPczDNHvtdgTPKDE0b8DPfn+6x
         XrOQ==
X-Gm-Message-State: AMCzsaXAxaHQ4t83fM1RJwNCLp+IB8ZZhc8J4uO7X3e1YpHTxxumwIKb
        LutTDe+Igkly6agcsbf0yvjoiQDxrsPJ6Ob5ae9cBkfS
X-Google-Smtp-Source: ABhQp+S5axn4rH53CfzfSoxPxtXlVdSAlIZHtf3eMcFbBrsXPlTfN2OhxBZ1dA+YPQ+Eu4IBTWZObPpzbolhZloMw7g=
X-Received: by 10.202.81.5 with SMTP id f5mr4556342oib.397.1508130332762; Sun,
 15 Oct 2017 22:05:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.19.87 with HTTP; Sun, 15 Oct 2017 22:05:31 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 16 Oct 2017 01:05:31 -0400
Message-ID: <CAH8yC8kx9Td51=UFvLwLAQFPKxUXg0D6KKqWR+JX+-wmTAKYRQ@mail.gmail.com>
Subject: Does Git build things during 'make install"?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My script to build Git dies during cleanup. Cleanup removes the
downloaded tarball and the unpacked directory:

********** Cleanup **********

rm: cannot remove 'git-2.14.2/perl/blib/lib/.exists': Permission denied
rm: cannot remove 'git-2.14.2/perl/blib/lib/Git/SVN/Fetcher.pm':
Permission denied
rm: cannot remove 'git-2.14.2/perl/blib/lib/Git/SVN/Utils.pm': Permission denied
rm: cannot remove 'git-2.14.2/perl/blib/lib/Git/SVN/Ra.pm': Permission denied
rm: cannot remove 'git-2.14.2/perl/blib/lib/Git/SVN/GlobSpec.pm':
Permission denied
...

When I look at the permissions:

$ ls -Al git-2.14.2/perl/blib/lib/.exists
-rw-r--r--   1 root     root           0 Oct 16 00:43
git-2.14.2/perl/blib/lib/.exists

The only place in my script that does anything with privileges is
'make install' because it runs with sudo.

Is Git building things in the install recipe? If so, then I don't
believe that's supposed to happen. According to the GNU coding
standards, Git should not be doing that. Cf;
https://www.gnu.org/prep/standards/html_node/Standard-Targets.html.

Jeff
