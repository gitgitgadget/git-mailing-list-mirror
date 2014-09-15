From: "R. Klomp" <r.klomp@students.uu.nl>
Subject: Re:
Date: Mon, 15 Sep 2014 17:10:34 +0200
Message-ID: <CAE8x=qXt4LH=0=7kX7CMz16m8rLn7rt6bkE3MBwoyr5y5VYD+w@mail.gmail.com>
References: <CAE8x=qW7EwO9YyrQ49vYH50BFcF7RF43eVqDeVex7FKut0oaaw@mail.gmail.com>
	<CAOqJoqGSRUw_UT4LhqpYX-WX6AEd2ReAWjgNS76Cra-SMKw3NQ@mail.gmail.com>
	<CAE8x=qVrK5-nhzL57ADwzQmD+NE-ScnJyPgum6cK6hPox5+VMg@mail.gmail.com>
	<20140910000045.GA12644@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jim Naslund <jnaslund@gmail.com>, p.duijst@stylecncmachines.com,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 17:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTXvN-0001Wa-6Q
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 17:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbaIOPKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 11:10:37 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:48955 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbaIOPKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 11:10:36 -0400
Received: by mail-la0-f42.google.com with SMTP id hz20so4918963lab.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 08:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QqcTkJu+9WM7nzto1hRhbApAv76DzbxwMcp1iQCqr84=;
        b=A+/teFqwz6HPyoPb/KyEMv68cB18hYVVNSfzDtUAkd+sxX0qpKlXKOxUEyJEOMCKLE
         GrDChvZmann/YamAta75dMEC+SsUavJ+XzQrTHQltutX0O9idf3fvqpHrdhkEU9fu8vL
         1cWSZ0UTGfQG8D9JshyEsPbATr974h6W6bc2pz0ZwhDl4ZcDjAeIAuly6E1AtvbY6M+j
         FZxDx4uogR7Ctmp+4r0yLs+ySPzKA4qJID187tGaF8ppiKXVQ4K7UD89DFZkXTN8GdSq
         gEb1KzaJIuFs+Tt+IeM/wnRQpmNJwq5ytkAHPcY93LkiogUhbuLlDV39+wzcEv5XHZD+
         e8jw==
X-Gm-Message-State: ALoCoQnwgvXUX0mtObp9y88/2CZhoN03weNa5EUzRAzCf4tsK1OMNaJVlSaWA9Pk9/4Mrt+Ezb1O
X-Received: by 10.152.28.134 with SMTP id b6mr29054547lah.33.1410793834307;
 Mon, 15 Sep 2014 08:10:34 -0700 (PDT)
Received: by 10.112.142.6 with HTTP; Mon, 15 Sep 2014 08:10:34 -0700 (PDT)
In-Reply-To: <20140910000045.GA12644@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257053>

I couldn't find information about whether the -solo feature is
available in all Beyond Compare versions.
At the least I can say that it is available in version 3 for Windows,
since that is the version that we're using.

This issue does not occur when using the normal difftool (command: git
difftool), which is odd and indicates that something must be wrong in
either Git or Beyond Compare.

On Wed, Sep 10, 2014 at 2:00 AM, David Aguilar <davvid@gmail.com> wrote:
> On Mon, Sep 08, 2014 at 04:36:49PM +0200, R. Klomp wrote:
>> Ok great! That indeed fixed the issue.
>> Although I still don't understand why it didn't work without -solo..
>> since it didn't work when no instance of Beyond Compare was running as
>> well.
>>
>> There must be something not quite right in either Git or Beyond Compare.
>>
>> On Mon, Sep 8, 2014 at 3:37 PM, Jim Naslund <jnaslund@gmail.com> wrote:
>> >
>> > On Sep 8, 2014 7:39 AM, "R. Klomp" <r.klomp@students.uu.nl> wrote:
>> >>
>> >> It seems like there's a bug involving git difftool's -d flag and Beyond
>> >> Compare.
>> >>
>> >> When using the difftool Beyond Compare, git difftool <..> <..> -d
>> >> immidiatly shuts down once the diff tree has been created. Beyond
>> >> Compare successfully shows the files that differ.
>> >> However, since git difftool doesn't wait for Beyond Compare to shut
>> >> down, all temporary files are gone. Due to this it's impossible to
>> >> view changes made inside files using the -d flag.
>> >>
>> >> I haven't tested if this issue also happens with other difftools.
>> >>
>> >> I'm using the latest versions of both Beyond Compare 3 (3.3.12, Pro
>> >> Edition for Windows) and Git (1.9.4 for Windows).
>> >>
>> >>
>> >> Thanks in advance for your help!
>> >
>> > I see the same behavior. For me it had something to do with the diff opening
>> > in a new tab in an existing window. Adding -solo to difftool.cmd will make
>> > beyond compare use a new window which fixes the issue for me.
>
> Interesting. Would it be worth changing difftool to use -solo by default, or
> are there any downsides to doing so?
>
> Is -solo a new feature that only exists in new versions of beyond compare?
> I would be okay saying that the user should use a fairly new version.
>
> Can we rely on -solo being available on all platforms?
> If so, I'd be okay with changing the default if there are no other downsides.
>
> The --dir-diff feature is not the only one that needs this blocking behavior.
> Does this issue also happen in the normal difftool mode without -d?
> --
> David
