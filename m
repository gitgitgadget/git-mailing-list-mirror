From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [BUG] Bad msysgit/egit interaction over dotfiles
Date: Mon, 14 Dec 2009 10:13:37 +0100
Message-ID: <40aa078e0912140113w23823058h4ca691963761d3be@mail.gmail.com>
References: <20091208132857.GB5425@linagora.com>
	 <40aa078e0912080534x32fe9724xcda47ad46dbdb7c0@mail.gmail.com>
	 <4B1E57BF.1000500@pelagic.nl>
	 <40aa078e0912080623q108b2affk80534ccd5fd7ace3@mail.gmail.com>
	 <20091208143700.GC5425@linagora.com> <4B200EF5.2060606@gmail.com>
	 <20091210083514.GA5971@linagora.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>,
	GIT ml <git@vger.kernel.org>
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 10:14:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK6zx-0000Tk-Qa
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 10:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbZLNJNk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 04:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbZLNJNk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 04:13:40 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33478 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbZLNJNj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 04:13:39 -0500
Received: by ewy19 with SMTP id 19so3132872ewy.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 01:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1sasKJLdt6pf69beu4DfeDI2g/9uHNfRlM6GSN45P4c=;
        b=vqY9f0cknIYd6MVjro/U8Pue4CNuR9lwQDT0mGifwfcT00AhsbAHxlSuRVjkf2eqsr
         ysKavsIhpYnRb1qHYOe7Arg/I6IfC7Zb63I1k/KMpZhQdF0o5eTyYKhLgkdZ0Joo0+1L
         LQml7NoSCiryBDw90tRmf0h4h/AcwRGNkUunQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=SCC5f5bwBT07Ako0Urn1AAGqQ2s9tpw24xpQ+eLnuoriirFto756t10Si0b6t2wgpL
         yIPih5nSrekduCcvNsp/Tr8HX2d5IsB7aq8G6tTFBhrGSAExG9FqgUqDlEsuO3n+LUL6
         6k+QjO3FxdvaAlSN8CfIT2CIJuaej8lKskMOA=
Received: by 10.216.87.131 with SMTP id y3mr1884175wee.9.1260782017404; Mon, 
	14 Dec 2009 01:13:37 -0800 (PST)
In-Reply-To: <20091210083514.GA5971@linagora.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135172>

On Thu, Dec 10, 2009 at 9:35 AM, Yann Dirson <ydirson@linagora.com> wro=
te:
> On Wed, Dec 09, 2009 at 09:56:21PM +0100, Marius Storm-Olsen wrote:
>> Yann Dirson said the following on 08.12.2009 15:37:
>> >On Tue, Dec 08, 2009 at 03:23:55PM +0100, Erik Faye-Lund wrote:
>> >>You can follow the discussion here:
>> >>http://code.google.com/p/msysgit/issues/detail?id=3D288
>> >>
>> >>I believe the reason is something like "because someone suggested
>> >>it, and no one disagreed". Do you have a good argument why it
>> >>shouldn't be the default (other than "it's a change", because
>> >>changing it back now would also be a change)?
>> >
>> >Depending on the opinion of the Eclipse guys on this issue about
>> >"writing to hidden files only says 'could not write'", which
>> >arguably could be seen as a bug on their side, we can see changing
>> >this behaviour back to the default on the msysgit side as either a
>> >(possibly temporary) workaround for a known eclipse bug, or as
>> >getting again interoperable with egit.
>>
>> Dot-files on unix are considered hidden. It's the only way files are
>> hidden there. Not so on Windows. Dot-files are just like any normal
>> file, and you need to mark a file hidden.
>>
>> So, the logic of egit, that *actually* hidden files should not be
>> written to, but dot-files should, seems to me to be a bug in egit.
>> There should be no reason why egit shouldn't be able to write to any
>> file, pending permissions. I'd say file a bug report with egit.
>
> Actually it is not egit who is unable to write to the file, but
> eclipse itself, and I do tend to think it is a bug in eclipse. =A0But
> now, even if we can convince the eclipse guys that it is a bug, it
> will be some time before a new release with this bug fixed gets
> published.
>
> So IMHO it would makes sense, for the sake of usability, to not
> activate the "hide dotfiles" feature by default. =A0It is easier for
> someone seeing unwanted dotfiles to find the switch to hide them, tha=
n
> for someone getting a "could not write" message from eclipse to
> understand that there is a seemingly-unrelate switch for msysgit to
> avoid this situation.
>

Actually, I think it makes much more sense to put a note of the issue
in the release-notes. I don't want people to lose features because
Eclipse, an IDE I don't even use, is broken. Since Eclipse is the
culprit here, I think it's the Eclipse that should "take the hit", not
the rest of us.

This of course assumes that hidden dotfiles is a feature that people
want, which is what I assumed was the reason why it was added in the
first place. Personally I don't care about this feature, since I have
the "show hidden files"-feature turned on.

> But maybe the situation is not so clear. =A0That "hide dotfiles" was
> implemented so that ".git" at first, and then ".git*" files do not
> clutter the view of the project. =A0But then, if a git repo has other
> dotfiles, those are really *part of* the versionned stuff, so I do no=
t
> see why those should be hidden at all. =A0After all, the .project,
> .classpath, and other eclipse project files have that name on windows
> too, and it will indeed *confuse* people to get them hidden.
>
> So should we have 2 classes of dotfiles, those "private to git", and
> the others, one class being hidden while the others are not ? =A0I am
> not sure at all this would be a good idea either. =A0Or maybe we shou=
ld
> only get .git hidden - after all, that one is the only real metadata
> not part of the versionned stuff itself ?
>
> Maybe we should add some sort of "core.hidedotfiles =3D dotgitonly"
> setting, and make that the default ? =A0That one does not appear to
> cause any problems to jgit, and eclipse itself has not business with
> it, so it would IMHO make sense.
>
> Opinions ?
>

IF we were to go down this path, perhaps it would be even better to
use some sort of file-pattern or even squeeze this into gitattributes?
I guess something like ".* +hidden" should emulate the unix behaviour
(given that we add a hidden attribute). I don't think we have a global
gitattributes file though, so it'd have to be added to each repo where
the effect is desired, I guess.

--=20
Erik "kusma" Faye-Lund
