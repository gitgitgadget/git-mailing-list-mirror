From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch: give better message when no names specified for rename
Date: Sun, 31 Mar 2013 08:35:39 +0700
Message-ID: <CACsJy8Bs0pBmoMjXB9rStb8_b5tQ1Tb8xT62EuFFj71osKR9Jg@mail.gmail.com>
References: <00E97900-F00D-455F-A3EB-52D0A3CF5CF6@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathon Mah <me@jonathonmah.com>
X-From: git-owner@vger.kernel.org Sun Mar 31 03:36:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UM7CJ-0004kQ-C5
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 03:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674Ab3CaBgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 21:36:11 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:48840 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab3CaBgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 21:36:10 -0400
Received: by mail-oa0-f45.google.com with SMTP id o6so1204264oag.4
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 18:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/3GJ+t/wpQeOTH/P0BJKEwusBVvRqpg5uodaAsQBifc=;
        b=ko7LraJd/VixljpvLoJ19hOmw9R0orwP6cxp7g57nunWvfer0c/jqlAd3M+ylubDGc
         an3xN0hB+DTFBnROzJ98CXp2kwD4XK8ZAn0p+VZxhRw1FRKWPfn9sgcIDWOxaCu4v0+i
         bVev51OpiqYubQDRlntCITuZ4+B97J/+CGY8b8RJGmyZwDqYmXhbwWoSRpdQ4ahIciIu
         mMpWV1LMc8tOjgk6nFPrzKfhQuyyDxNjdkZHmOPSSAjbH+1COuj1fGonoBqPV1EAO063
         s87Y4WGi9U5fUu7qBWlZoz8Apkfsg3FgBNriI9N7GyZSaBBhFtqPxO2iqzKDDnErRzzG
         edMw==
X-Received: by 10.60.8.197 with SMTP id t5mr2600164oea.4.1364693769888; Sat,
 30 Mar 2013 18:36:09 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Sat, 30 Mar 2013 18:35:39 -0700 (PDT)
In-Reply-To: <00E97900-F00D-455F-A3EB-52D0A3CF5CF6@JonathonMah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219601>

On Sun, Mar 31, 2013 at 8:27 AM, Jonathon Mah <me@jonathonmah.com> wrote:
> -               if (argc == 1)
> +               if (!argc)
> +                       die(_("branch name required"));
> +               else if (argc == 1)
>                         rename_branch(head, argv[0], rename > 1);
>                 else if (argc == 2)
>                         rename_branch(argv[0], argv[1], rename > 1);

This makes four branches based on argc. Maybe we should convert
if/else chain to switch/case.
--
Duy
