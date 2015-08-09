From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] config.mak.uname: Cygwin: Use renames for creation
Date: Sun, 9 Aug 2015 03:01:06 +0100
Message-ID: <CA+kUOa=KRBSKDqWUj2RiO45PqVYGmN+yqG426jtUoXayxGkduw@mail.gmail.com>
References: <1438979428-5888-1-git-send-email-adam@dinwoodie.org>
 <55C66AF2.3060706@gmail.com> <20150808210627.GB155450@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Aug 09 04:01:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOFvx-0006n6-5z
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 04:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992838AbbHICBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 22:01:47 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35548 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992828AbbHICBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 22:01:46 -0400
Received: by igr7 with SMTP id 7so51475141igr.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 19:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=RkRXGKCKgeG1vjXiA7hi0aTkGMl2UPjI8yyoj01OJgQ=;
        b=YDGV9iOF9Out/odr/Y9lpXHRZuTHERmakNl8lIE1tmUqwTxnh74ptAaf4AAmL+szpv
         btH6h1cFut/iMqxyibF2/rlBjI2cDBoqERy6C7TxtQMobbzYH2bp3iCXX3knZm3f5P1I
         MyCuuOweqW33gcxJSfQQQ2mGniUCmDZIcd15s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=RkRXGKCKgeG1vjXiA7hi0aTkGMl2UPjI8yyoj01OJgQ=;
        b=lAqNU44HmXaHLGWNXaQsrRjpG/wO4CwQwaxWygAg0hZ+EpIztIjuo4EOec6gEW6Al0
         1VmWfoiyh1/0xgvivCNHLqL1x5F/FAov1vpIcwPSEfRW87TDfJz0F7weaSKUXWr2fKAo
         DN+oxRAsm9+I039EXYiJjFnxc1DAYb/DCu0UiRXfiJZExzITtkHf0+CPpxi5VNU/PHFm
         1LdM7gvAbjEuJu+U8SuWWxKzaj1Ux6ayaR0V5yZEbFIAdGhXJgECXQgMK8MAIUX91ski
         Qj5WR5h9FXxaSHOGrEGYOF/FfVJjYjFNtg4CDbFkGp95y21MAuuKJuOoZvb0lDMw6kqk
         MVHw==
X-Gm-Message-State: ALoCoQmt60LUciItt2SDG72C45NMVB4HZxfP/q8cJaaPp/jEFrO4vksfXl69HemBCWHyWdAiXem+
X-Received: by 10.50.138.232 with SMTP id qt8mr5384943igb.21.1439085706115;
 Sat, 08 Aug 2015 19:01:46 -0700 (PDT)
Received: by 10.107.140.209 with HTTP; Sat, 8 Aug 2015 19:01:06 -0700 (PDT)
In-Reply-To: <20150808210627.GB155450@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275523>

On Sat, Aug 08, 2015 at 09:06:28PM +0000, brian m. carlson wrote:
> On Sat, Aug 08, 2015 at 04:47:46PM -0400, Mark Levedahl wrote:
> > On 08/07/2015 04:30 PM, Adam Dinwoodie wrote:
> > >When generating build options for Cygwin, enable
> > >OBJECT_CREATION_USES_RENAMES.  This is necessary to use Git on Windows
> > >shared directories, and is already enabled for the MinGW and plain
> > >Windows builds.
> >
> > I've been supporting use of git on cygwin since about 2008, this issue has
> > never risen that I know. Whatever issue is being patched around here, if
> > truly repeatable, should be handled by the cygwin dll as that code is
> > focused on providing full linux compatibility. If git on linux does need
> > this patch, git on cygwin should not, either. So, I vote against this.

There has been recent and historical discussion on the Cygwin mailing
list about this problem, as well as in other places like Stack Overflow.
I've put a link to one of those discussions on the Cygwin mailing list
in the original patch email.  I can also see some discussiions on this
list that seem related (search archives for "failed to read delta-pack
base object" and "Cygwin").

It may be the technically correct approach that the Cygwin library ought
to fix this, and indeed some improvements have been made in this area.
However given the limited interfaces that Windows offers here, a final
fix is very unlikely to come any time soon, so this patch is the
pragmatic solution.

I do not see any difference between the situation here and the situation
for MinGW, which is fundamentally a Cygwin fork, but which already has
this build option set for it in config.mak.uname.

> We've gotten a lot of users on the list who ask why their Git
> directories on shared drives aren't working (or are broken in some way).
> Since I don't use Windows, let me ask: does the Cygwin DLL handle
> link(2) properly on shared drives, and if not, would this patch help it
> do so?  I can imagine that perhaps SMB doesn't support the necessary
> operations to make a POSIX link(2) work properly.

I'd need to go back to the Cygwin list to get a definite answer, but as
I understand it, yes, this is is exactly the problem -- quoting Corinna,
one of the Cygwin project leads, "The MS NFS is not very reliable in
keeping up with changes to metadata."

We have verified that setting `core.createobject rename` resolves the
problem for people who are seeing it, which very strongly implies that
this build option would solve the problem similarly, but would fix it
for all users, not just those who spend enough time investigating the
problem to find that setting.

Adam
