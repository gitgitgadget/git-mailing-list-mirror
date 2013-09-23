From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 00/15] Make Gnome Credential helper more Gnome-y and
 support ancient distros
Date: Mon, 23 Sep 2013 10:21:15 -0700
Message-ID: <CA+sFfMfhQ3ioMrppcTKaQ_0kMMjFuJ8mtv9iK+ixD8Ep0CFi4Q@mail.gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
	<20130923102022.GA96514@yoda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, pah@qo.cx
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon Sep 23 19:21:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VO9p3-0004FX-2Q
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 19:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab3IWRVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 13:21:17 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36974 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab3IWRVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 13:21:16 -0400
Received: by mail-wi0-f169.google.com with SMTP id hj3so2530277wib.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wUOrOWp+aYFwMDFqtgvuE5j6lkEz3HJf8/ywYwwZczA=;
        b=Vkb92ssuERqYVMfHi1HqpOb3mwjULH+37+YfLmKrMvV/AGwCWzQBDCtcdlJyZMLzVB
         G2N8eXW2BM2v4s4KLNOJpgWviaYp8R6GSBNRg3ZTVfkxGhx+JMUsF4mvThiwCGBEhCnD
         wz3ZGACb/t7mSpPegbUKLA2UGKtNE6SFrbQ5HAdAxBYoibKAXzVRStEIkE/Dx1zSryMT
         K7/JzPVK27/t9EBN4nzKGVUCy9JjVrjVQLJQaiaTzwqsX3slYF0/fS2UWnYuNXbx7K4a
         TSFMg6VZTl9Pp0eJiDJSA1u5RR/U56/2Q6mPYj+Pj2YyqvJf50li95UJGtMLY5V+8FLO
         0nMg==
X-Received: by 10.180.212.51 with SMTP id nh19mr14433728wic.14.1379956875312;
 Mon, 23 Sep 2013 10:21:15 -0700 (PDT)
Received: by 10.194.85.168 with HTTP; Mon, 23 Sep 2013 10:21:15 -0700 (PDT)
In-Reply-To: <20130923102022.GA96514@yoda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235207>

On Mon, Sep 23, 2013 at 3:20 AM, John Szakmeister <john@szakmeister.net> wrote:
> On Sun, Sep 22, 2013 at 10:07:56PM -0700, Brandon Casey wrote:
>> A few cleanups, followed by improved usage of the glib library (no need
>> to reinvent the wheel when glib provides the necessary functionality), and
>> then the addition of support for RHEL 4.x and 5.x.
>>
>> Brandon Casey (15):
<snip>

> I reviewed all of the commits in this series, and most are nice
> cleanups.  The only thing I'm a little shaky on is RHEL4
> support (patch 15).  In particular, this:
>
>     +/*
>     + * Just a guess to support RHEL 4.X.
>     + * Glib 2.8 was roughly Gnome 2.12 ?
>     + * Which was released with gnome-keyring 0.4.3 ??
>     + */
>
> Has that code been tested on RHEL4 at all?  I imagine it's hard
> to come by--it's pretty darn old--but it feels like a mistake to
> commit untested code.

The (poorly worded) comment is referring to the version of glib that
is being tested by the pre-processor statements.  Since gnome-keyring
doesn't provide a way to test its version, and I'm not sure exactly
which gnome release included gnome-keyring 0.4.3 or which glib version
was distributed with which gnome version, I'm just roughly guessing
based on dates and not-conclusive google searches that 2.8 is
reasonable.

I'll try to clarify the wording here.

The code has been tested on CentOS 4.X.

> Otherwise, there are a few stylistic nits that I'd like to clean
> up.  Only one was introduced by you--Felipe pointed it out--and

Well, not exactly "introduced" by me, but I guess I can fix it in that
same patch. :)

> I have a patch for the rest that I can submit after your series
> has been applied.

Sounds good.

> Acked-by: John Szakmeister <john@szakmeister.net>

-Brandon
