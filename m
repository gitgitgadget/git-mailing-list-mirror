Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961741F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 06:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfJ3Get (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 02:34:49 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46786 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfJ3Get (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 02:34:49 -0400
Received: by mail-oi1-f172.google.com with SMTP id c2so1001444oic.13
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 23:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RgBzXFUW6oMJZpBPCl9h7RQ5aom7oTL1tAj1TzCCLM=;
        b=dQmTK4URQNS9wr5SQ9ADN2xK9QIrb9ZQFMWA49cAgizzHqQNTdyJQXpKxkUb+4dJxH
         WrlscBOF3mKrb0W1FIQU/2OvTdS1BaYAunSRfhU/uHDLo39QQs3Bl6NaoyGF+5uKw5N8
         2Kv4uLdenoB9YZ2beDh5fmM5a6R+aoZcoKuUHOyAO/6cn2/uducKshof9lC0OeNBSa80
         p/M73Ui5kbK+EQFwyvMCHgUbBbW/THKHHwe0Jbli3WPy+/5vicGJCN7EEgmaXWtG5peM
         mXt03zQxVwNkZD8KpTUdXt0cEY0ci/FYXy0p094WBo8VqGKepXIV9MHMmL97Nc7fhtuO
         iWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RgBzXFUW6oMJZpBPCl9h7RQ5aom7oTL1tAj1TzCCLM=;
        b=RZvNpLwhOv+a8kjcyM6V1BzW8a1GC3ktdLCBJNfutVFKrrHVjS+wFmLzTxxozuWPvW
         dUTfYtr43LS6CZ/90rkD5h4ysXOPk/usYXXn7OPZT2EnM1r7iuZ7o3aKTJZLw5xsjFrp
         A6Hov0jrCYRNidT9mkMmxWgOsTNunfyUiR0e2/So9/h6CpgbVbCZP6f3S6BFhEje6v/A
         bUeLo4+v4BPAL9AEIDkbDhAEOFPnRCCYAwf5NObCDDKz2LtolNn/i/+S8qGB1HXTyMhe
         d2nQKugQME9hlxK1byhVvJ4FAIn5ofEnulTBjZu/CXuOUp1KKbpOeQzZAETrslSwSRHx
         3u7Q==
X-Gm-Message-State: APjAAAUGh9Of1yxHuqHSqIDVsHJDsXMSlILftpv/gVp9mqCFsHcWOsrR
        OyFD0ajXPRA8JF/yB4BtPFB4vY3Mq3Fr0HXeTUc=
X-Google-Smtp-Source: APXvYqyyIdkSIAIUFAG9h1hce36WpCzP7q6fY4vp12fzcC3e42ej2ViZLaKiYMRUSQr/Q+AFIMzdmUEF2OsAmuLfRMA=
X-Received: by 2002:aca:dad6:: with SMTP id r205mr7167623oig.6.1572417288252;
 Tue, 29 Oct 2019 23:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8=uGb3J+fvkSj7-gdhqy0vtQw90K-MWQ3T1TTMQzAJnJA@mail.gmail.com>
In-Reply-To: <CAH8yC8=uGb3J+fvkSj7-gdhqy0vtQw90K-MWQ3T1TTMQzAJnJA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 29 Oct 2019 23:34:37 -0700
Message-ID: <CABPp-BFzAYmaQ5J0nnN9930UC5kJ1=qyvUJxL0oJNixLX3XQCQ@mail.gmail.com>
Subject: Re: SELinux context for Git user on Fedora server?
To:     noloader@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Oct 29, 2019 at 10:30 PM Jeffrey Walton <noloader@gmail.com> wrote:
>
> Hi Everyone,
>
> I'm trying to setup a Git server on Fedora 30 server with SELinux in
> enforcing mode. I am following
> https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server
> .
>
> At the push on the local machine:
>
>   $ git push -v origin master
>   Pushing to ssh://git@euclid:/var/callboot/source.git

So you're using ssh...

>   Enter passphrase for key ...
>   fatal: '/var/callboot/source.git' does not appear to be a git repository
>   fatal: Could not read from remote repository.
>   ...
>
> I suspect the SELinux labels for /var/callboot/source.git are not
> quite right. Right now it looks as follows. httpd_sys_content_t is
> typical for a web server and I think it needs to be something else.
>
>   # ls -Z /var/callboot/source.git
>   unconfined_u:object_r:httpd_sys_content_t:s0 branches
>   unconfined_u:object_r:httpd_sys_content_t:s0 config
>   unconfined_u:object_r:httpd_sys_content_t:s0 description
>   unconfined_u:object_r:httpd_sys_content_t:s0 HEAD
>   unconfined_u:object_r:httpd_sys_content_t:s0 hooks
>   unconfined_u:object_r:httpd_sys_content_t:s0 info
>   unconfined_u:object_r:httpd_sys_content_t:s0 objects
>   unconfined_u:object_r:httpd_sys_content_t:s0 refs
>
> What should the SELinux labels be for the Git user?

They should be whatever is needed to access via ssh.  I think that's
something like 'ssh_home_t' (sorry, haven't fought SELinux and SSH for
a few years now), but the question isn't really anything to do with
Git but of the combination of SELinux and SSH.


Hope that helps,
Elijah
