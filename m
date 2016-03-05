From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Git clone sends first an empty authorization header
Date: Fri, 4 Mar 2016 22:50:30 -0700
Message-ID: <CAGyf7-HAaWp+V99aP1b7HiZwgHXCTiAfL5865ng+9-PY_UwuDw@mail.gmail.com>
References: <CAMDzUty+O2Gu7o4bFib71AaNZn647WQ1v7ceiznHOs7-xwZGUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 06:50:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac56v-0007Bg-Mz
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 06:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbcCEFud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 00:50:33 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35717 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbcCEFuc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 00:50:32 -0500
Received: by mail-qk0-f181.google.com with SMTP id o6so29325657qkc.2
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 21:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=LgRuUX2gtToZiNB/5qR0xYnraSu3s8hC7kT+i3VJgEo=;
        b=JWUXMUm/qYm7TIdGMZbNFdZaI+/O+a7c7l1aObtukmkAzFvh9E3f0Bcp7A1MTpggaB
         J/PqHFClNn8uRhR8Ob9JMOi9VlMkHMAMEpLGwDsCA5BG4fpqgnUiJboceuMTy6I8Q995
         5tFvjXckuXN121j0l0IvqWecWWxi3bzawmF0Bx8yEQajkuxDm5+k1AH9+GD7sHrL3uOo
         lynn9Sb4Ep9GwyuaZ004BSiQj+GS2jkBL61aE6P7t8vHL3MitfPi23vJ0/p/a9R7tcE8
         iR/2yb3viZrHKI/Zx05wAQ1zqP+/GPMjswunSRLn2o/Bh7h0pYSc2xItDF7/I1r8CN7L
         h8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LgRuUX2gtToZiNB/5qR0xYnraSu3s8hC7kT+i3VJgEo=;
        b=lMOUF1fNml36zzZ5tuZQT30hp6g/Ol5BeuL2tr+dZh0q680IiX9Am/Mz+xDs+qdf0K
         +2VnYdcyvg9xLnqr6Y1vDlxe6UkbzkiFvhOt8mitguchz7h/ibuBIx0XuwLH0Hi0THq7
         K7jm8v/7dOZN1WQjQb/8W9K859l4Tx+Ulxkrf/ULiI4nnOP3ZFGce7JbXh0tS1+GB464
         5/NdwJpzzRidFnOzehdTbC/vOgTiLZVdDgfr3yP0Imgvq+AZRCiF3J9Wuoyv1RtV7PZ+
         wXJbdsHOJcHrRAHQaI17Vu5+wBJ+5GtZuBaJeHNdEzs+8JfUnw9rU1MZRvYdXH/hhBNj
         02/g==
X-Gm-Message-State: AD7BkJIhEGy5QVGHerbUrWWeMpGQF5rkG3IbNw3O2ywAQX77hxKBEkICdStdesYcZoJyaFpHJmqRMTJmKxzYwW3C
X-Received: by 10.55.48.80 with SMTP id w77mr15124552qkw.7.1457157030489; Fri,
 04 Mar 2016 21:50:30 -0800 (PST)
Received: by 10.55.164.78 with HTTP; Fri, 4 Mar 2016 21:50:30 -0800 (PST)
In-Reply-To: <CAMDzUty+O2Gu7o4bFib71AaNZn647WQ1v7ceiznHOs7-xwZGUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288294>

On Fri, Mar 4, 2016 at 9:51 PM, Guilherme <guibufolo@gmail.com> wrote:
> Hi,
>
> When doing basic authentication using git clone by passing the
> username and password in the url git clone will first send a GET
> request without the authorization header set.
>
> Am i seeing this right?

I believe this is an intentional behavior in either cURL or how Git
uses it. Credentials aren't sent until the server returns a challenge
for them, even if you include them in your clone URL or elsewhere. So
yes, you're seeing it right.

>
> This means that if the counterpart allows anonymous cloning but not
> pushing and the user provided a wrong usernam/password, it has two
> options:

I'm not sure why this would be true. If the remote server allows
anonymous clone/fetch, then you never get prompted for credentials
and, even if they're supplied, they're never sent to the remote
server. If you then try to push, if the server is working correctly it
should detect that anonymous users can't push and it should return a
401 with a WWW-Authenticate header. When the client receives the 401,
it should send the credentials it has (or prompt for them if it
doesn't have them) and the push should work without issue.

Perhaps there's an issue with how your server is setup to handle permissions?

>
> 1. Allow the access and leave the user to figure out why he is not able to push.
>
> 2. Reply by setting the WWW-Authentication header and see if a
> password/username is provided. This has the downside that if no
> username and password is provided the user will still get a login
> prompt for password and username. Upon entering twice nothing he will
> still be able to clone. This can be confusing.
>
> Can this behaviour of git clone (and I guess all the other parts that
> do basic auth) be changed to provide the authentication header right
> on the first request? Or am I doing/interpreting it wrong?
>
> Thank you.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
