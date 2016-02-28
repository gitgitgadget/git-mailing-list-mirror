From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] git-p4: map a P4 user to Git author name and email address
Date: Sun, 28 Feb 2016 11:19:59 -0500
Message-ID: <CAPig+cTCZ_diLH+tge6bis6gjq0Qvk05zD7zqf1PBJxNTJu9bw@mail.gmail.com>
References: <1456655125-17829-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Lars Schneider <lars.schneider@autodesk.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 17:20:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa44l-0000My-ST
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 17:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758689AbcB1QUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 11:20:01 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34771 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757958AbcB1QUA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 11:20:00 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so7910671vkh.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=K3+iUoANzdL9ATFjq4JsXrkT7YY632AsgdRgthpCdBA=;
        b=ZGC2d9AwIZIEKgvgycOLOfWD7AP/VMARUffme6SgRhiPvE046NbFOrpPcJCqtl/Ap4
         zAyMCyCPR3seeHmHPPvGzKc7a4BXcM55mxE+PTGNnmXRdRyncT1BvNkV3y5yoYCvlWcz
         tCbsXspCWbPK5MgITB4IS9XrQFaAS0mBWCAVV7i3jZaSlKUtPOi26Din9a/pfzNKylMo
         M1c0YMzoEq84pvwlP5Q/Td5jo/sMxjT5PkoBTCf1wxh5pUq1sAu5Q5zubyWhXpkdxNYM
         EaPpZvkqLqMs7dzBH98D9UOkDBbznAnpFCVHRc0T+Xze52v5gXEHxWlDui2e/kmO7FVH
         XHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=K3+iUoANzdL9ATFjq4JsXrkT7YY632AsgdRgthpCdBA=;
        b=cjEej3s1ZXzDacqm8khOwAYExDfi72cEmVVOeqfF4cGdvflcp0Yk3o44URP1gx1DZZ
         WgulN3PUXJeEm9oXt64zBxbBp5s/9hHsM8ekjGR3137TI1t0eXLFW0n8FulYkMxN9DCu
         QrnyAffZwQQqHgmvnPrxbKqr1zNTIGpGwyMURYjpyJWYvfL0/8mMO7JH/XtpP7uapiAT
         7A4z1czpl7mGcOfeJ8uhxSx1Q/OcbnmLerfP5Jceqm0uCLDQvRRp4GNLaDkqpm+P71OM
         +HJ43MRSP8kL+Mg4bFU0C4qMc67UYJH+iAyjmAO7UfzI8JbdaDRR03ndxbU5d9Y7kij2
         dUPg==
X-Gm-Message-State: AD7BkJJwczCeNMlL5n7/k/GebQNddOUtDZ/Dh9jmbwOf8TaBXWK48CFHXwzwUYqcyToIoWDs/jZNTm39uZJ5GA==
X-Received: by 10.31.182.143 with SMTP id g137mr8113928vkf.45.1456676399454;
 Sun, 28 Feb 2016 08:19:59 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 28 Feb 2016 08:19:59 -0800 (PST)
In-Reply-To: <1456655125-17829-1-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: UxEi_-W07ZLUgPdk9XC3Be0Wuco
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287776>

On Sun, Feb 28, 2016 at 5:25 AM,  <larsxschneider@gmail.com> wrote:
> Map a P4 user to a specific name and email address in Git with the
> "git-p4.mapUser" config. The config value must be a string adhering
> to the format "p4user -> First Lastname <email@address.com>".

With the caveat that I'm not a Perforce user, is this arrow "->"
thingy common in the Perforce world, or was it invented with this
patch? If it was invented here, then would it make sense to instead
use a more established format, such as the "authors" mapping file from
git-svn?

    p4user = Joe User <user@example.com>

More below...

> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> @@ -553,6 +553,17 @@ git-p4.keepEmptyCommits::
> +git-p4.mapUser::
> +       Map a P4 user to a name and email address in Git. Use a string
> +       with the following format to create a mapping:
> ++
> +-------------
> +git config --add git-p4.mapUser "p4user -> First Last <mail@address.com>"
> +-------------
> ++
> +       A mapping will override any user information from P4. Mappings for
> +       multiple P4 user can be defined.

Does this format correctly with Asciidoc, or does the pargraph need to
be left-justified? (I haven't tested it myself.)

> diff --git a/t/t9828-git-p4-map-user.sh b/t/t9828-git-p4-map-user.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories and map users'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'Create a repo with different users' '
> +       client_view "//depot/... //client/..." &&
> +       (
> +               cd "$cli" &&
> +
> +               >author.txt &&
> +               p4 add author.txt &&
> +               p4 submit -d "Add file author\\n"

Broken &&-chain.

> +               P4USER=mmax

Ditto.

> +               >max.txt &&
> +               p4 add max.txt &&
> +               p4 submit -d "Add file max"

Ditto.

> +               P4USER=mo

Ditto.

> +               >moritz.txt &&
> +               p4 add moritz.txt &&
> +               p4 submit -d "Add file moritz"

...

> +               P4USER=no

...

> +               >nobody.txt &&
> +               p4 add nobody.txt &&
> +               p4 submit -d "Add file nobody"
> +       )
> +'
> +
> +test_expect_success 'Clone repo root path with all history' '
> +       client_view "//depot/... //client/..." &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git init . &&
> +               git config --add git-p4.mapUser "mmax -> Max Mustermann <max@muster.com>"  &&
> +               git config --add git-p4.mapUser "mo -> Moritz Untreu <moritz@untreu.com>" &&
> +               git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +               cat >expect <<-\EOF &&
> +                       no <no@client>
> +                       Moritz Untreu <moritz@untreu.com>
> +                       Max Mustermann <max@muster.com>
> +                       Dr. author <author@example.com>
> +               EOF
> +               git log --format="%an <%ae>" >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'kill p4d' '
> +       kill_p4d
> +'
> +
> +test_done
> --
> 2.5.1
