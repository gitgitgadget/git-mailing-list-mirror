From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 18:09:19 +1000
Message-ID: <BANLkTi=skWHp+ALSqg9BOTqAjqw5Si_-4Q@mail.gmail.com>
References: <4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
	<BANLkTi=VLKoKxib+_NDOJYKL-R=AZWDi6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 10:09:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFMI2-0000BL-D9
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 10:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab1D1IJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 04:09:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37358 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab1D1IJV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 04:09:21 -0400
Received: by eyx24 with SMTP id 24so746493eyx.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GtEphouCaoWSqFq6ioO+99TGzLPszDovPenHiXPbFhc=;
        b=sfOFO53D9MiJg1F5t79x3fZP2IfSADBHX0NjSHVPn46b32j1ZkarwnADD8CWn8Tk+r
         4fUtsEokqSK6+Q+KEsiePinQ9FJiphawR4xEY+C3OG1XE8Gl+akI6mTJsWWgOgrW/dXC
         yddV2hYapbJ7bGknILTMr/pJUknOObejIiNdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wBseRL80PJYw2C9zlbWqoMVI0LsRHV5dB480DX1mf1PMl0zJnvXyN6QEzGjpkepbRY
         IWoeebhyopMuU9MplVP0yUCwjKRtb3S5KZNIBsNGBq++Bh+9akyzK7t7fMsrrMmqI4nY
         doaZgagsXToCWhC6lvJ5NPk+0NDfebszvSwKs=
Received: by 10.14.52.65 with SMTP id d41mr1497613eec.85.1303978159489; Thu,
 28 Apr 2011 01:09:19 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Thu, 28 Apr 2011 01:09:19 -0700 (PDT)
In-Reply-To: <BANLkTi=VLKoKxib+_NDOJYKL-R=AZWDi6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172322>

On Thu, Apr 28, 2011 at 5:40 PM, Pau Garcia i Quiles
<pgquiles@elpauer.org> wrote:
> On Thu, Apr 28, 2011 at 4:08 AM, Jon Seymour <jon.seymour@gmail.com> =
wrote:
>
>>>> I guess an unmanaged solution could use separate directories for e=
ach
>>>> plugin, but this would imply scanning all these paths each time yo=
u
>>>> invoke git. In my view, symbolic links from a dir already
>>>> GIT_EXEC_PATH to plugin directories would be a more efficient way =
to
>>>> do this.
>>>
>>> I think you are overanalyzing the problem
>>
>> I don't think so. =C2=A0Perhaps Pau can give us his view on the
>> desirability of a single directory for all plugins artifacts from a
>> distribution maintainers perspective.
>
> You are thinking too much, this is simpler than what you are trying t=
o do :-)
>
> What packages in Linux distributions do is essentially placing files
> where the FHS says, i. e:
>
> - Binaries intended to be used by an average Joe go to /usr/bin
> - Binaries for internal consumption go to /usr/lib/packagename
> - Libraries go to /usr/lib
> - Documentation goes to /usr/share/doc/packagename
> - Manual pages to go /usr/share/man/manX/command.X.gz
> - etc
>
> Define something like that inside the prefix where git is installed
> and you are done. As Junio said, git already checks for git-* presenc=
e
> for help, etc.
>
> If you want to see more about package organization, go to
> http://www.debian.org/Packages/unstable/ , go to that package's page
> and at the bottom there is a "List of files" link. For instance
>
> http://packages.debian.org/experimental/git
> http://packages.debian.org/experimental/amd64/git/filelist
>
> BTW, I fail to see why an "activation" step is needed. Either it is
> installed or it is not.
>
> --
> Pau Garcia i Quiles
> http://www.elpauer.org
> (Due to my workload, I may need 10 days to answer)
>

Ok, I have tried to explain why separating the concerns of package
management and plugin management is an appropriate thing to do, and
why one directory for each plugin is also a good thing to do. BTW: I
thought you actually suggested this concept yourself in your earlier
post.

I also explained why an activation step is desirable. It is good for
performance (since you don't have to resolve across plugin directories
on each invocation) and it is good for conflict management (since you
get a precise means to identify and prevent conflicts). More over, the
application which provides the plugin manager gets to do this conflict
detection and prevention, which is exactly the right component to do
it. Why? because it understands its own plugin architecture better
than any and all plugin authors, package authors or package managers.

There is probably only so many times I can explain these principles.

As they saying goes - code talks. I'll implement things as I think
they should be implemented, incorporating the constructive suggestions
that have been made.

To be sure, even the insults have helped.

Calling the idea of:

    git install foobar

"horrid" and then "utterly horrid" and then "crap" has just helped
crystalise in my mind exactly where the correct lines of
responsibility should be drawn between, application, plugin and
package.

It appears that many people still don't get it but there is only so
much I can do about that.

Anyway, thanks for all your help (constructive and otherwise),

jon.
