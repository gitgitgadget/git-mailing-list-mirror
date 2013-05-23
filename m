From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] Geolocation support
Date: Thu, 23 May 2013 11:52:52 +0200
Message-ID: <CALWbr2w3=DTAMkFtJoLF1_X46fefpEq2WtTb7HGiTiOExFHG3w@mail.gmail.com>
References: <87mwrncfkh.fsf@ethzero.com>
	<CALkWK0kHEDn4Wt3Y+XUE59_9ZDf504yopMp9QtBUk49Sd+EXbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alessandro Di Marco <dmr@ethzero.com>, git <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 11:53:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfSCh-0007Dz-GB
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 11:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758019Ab3EWJwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 05:52:54 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:41487 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757890Ab3EWJwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 05:52:53 -0400
Received: by mail-qe0-f50.google.com with SMTP id x7so1737871qeu.37
        for <git@vger.kernel.org>; Thu, 23 May 2013 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oIEvUKIopOGXl0ZayNyikUUrUH5dUwO/UNcFV9I53GE=;
        b=BJ+FqESa0lbU1ekIfWxkM2GJvNU7a24eQDB8VBpOk+27f4mvp8R0vol2c8pkdq47U0
         Ipiew57f2f5EW0Mi5T+6B9FOpCLXNuBOhn7Yu14savjOI0sikKjKR9Vmj/aXi9kufcEu
         cBXUK/FKtY+0gP1tZ+SlFbJpILxllypM44PIAGo69SUzSLxb+4VOqNwT4Vx6WC6ne2Z5
         R3jw/mDrTGVyoYYGZrs3CfincwTWUnAf2JcJtAsn8pKCWgFNC2JcOIUlVRE1kdLGc+hy
         qLaXQ9SlrQ74WKJYe7rqf7us0s43ilEgv54DWs+S5Bxa1CuNI8TwG6s0gqx8joQzho9p
         vq+g==
X-Received: by 10.224.128.135 with SMTP id k7mr10768837qas.17.1369302773028;
 Thu, 23 May 2013 02:52:53 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Thu, 23 May 2013 02:52:52 -0700 (PDT)
In-Reply-To: <CALkWK0kHEDn4Wt3Y+XUE59_9ZDf504yopMp9QtBUk49Sd+EXbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225228>

On Thu, May 23, 2013 at 10:45 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Alessandro Di Marco wrote:
>> this is a hack I made a couple of years ago in order to store my current
>> location in git commits (I travel a lot and being able to associate a
>> place with the commit date helps me to quickly recover what were doing
>> at that time). Long story short, the screeenshot at
>> http://tinypic.com/r/wars40/5 shows the new gitk interface once this
>> patch has been integrated. Geolocation is controlled by two envvars
>> GIT_AUTHOR_PLACE and COMMITTER_PLACE, respectively. You can set them via
>> something like this:
>
> Obviously very interesting.  Now, how do we mainline (parts of) this
> feature?  I'll raise some questions here:

I'm really not convinced this kind of changes should make it into
Junio's tree (of course, he's the only one to decide). I really
believe this is a very specific solution to a very specific problem
(that is not for me to judge if the problem is real). Bloating the
commit object with this kind of information doesn't feel like a good
idea.
I think it could be nice to provide a simple shell script to build the
location, callable from a post-commit hook, to construct a
"geolocation" note. Gitk could be programmed to read the notes to get
the location, but once again, I'm not sure it should be mainlined.
