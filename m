From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 15:37:23 +1000
Message-ID: <BANLkTi=pjvf3hj53z1XoZU4Q_4nGzO+t+w@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>
	<BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
	<7vsjt49stq.fsf@alter.siamese.dyndns.org>
	<BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 07:37:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QExRK-0001xB-52
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 07:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab1D0Fh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 01:37:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39714 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab1D0FhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 01:37:25 -0400
Received: by eyx24 with SMTP id 24so401544eyx.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 22:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zx+FLp8GGUi5w3kQ1eYWYvKGeD2VXRrIEV8rNcB66Wo=;
        b=o9XF+2uY4QkwvpslMXbfV/tWnADSQthJadOTvYopHucrMTEwaNijXzMIA3uuSz+zct
         jFcnmr1UgoH3t8r0ntZfk5AbHZkmU/o7PVNlQ5XoaCnnLC7wAcnYxqshSuLn4/hGdokZ
         Hwcg1DTFsBsX90+fcg66Xf+ftdlELQqO/2fnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dHNGMujX0AVTeDJKEzJPGbV0yFZ0zmJ3bNN7wmJZKAkrcZL71d1jnpLp6iGHJR8/kc
         cWyO6/18gQy8+FXlftXZxxX27iVIqKdbtsKuL7iwfYmRhL66fxGk86TRvxib7+Xrk47D
         MeVTLLrjILPYfKnl9VvqZN6gHkDdMejQTgShI=
Received: by 10.14.50.15 with SMTP id y15mr734304eeb.149.1303882643978; Tue,
 26 Apr 2011 22:37:23 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Tue, 26 Apr 2011 22:37:23 -0700 (PDT)
In-Reply-To: <BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172175>

On Wed, Apr 27, 2011 at 3:33 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> Hide quoted text -
> On Wed, Apr 27, 2011 at 3:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jon Seymour <jon.seymour@gmail.com> writes:
>>
>>>> So if you have /home/js/bin on your $PATH, you can install your "git-work"
>>>> script as /home/js/bin/git-work, and that should be sufficient.
>>>
>>> Yep, that's a start, but does not a a complete plugin architecture make :-)
>>
>> Please explain yourself.
>>
>
> So, I think at a very minimum, a plugin architecture should specify
> the file system layout of packages to be managed by a plugin/package
> manager.
>
> So, where to find scripts, where to find man pages, bash completions,
> configuration help etc.
>
> A slightly more functional architecture would provide support for
> unpacking package archives into a "standard" repository location and
> for removing unwanted plugins.
>
> A plugin architecture might specify a standard way to access
> extensions. (git blah is easy for local use, but what if a plugin
> grabs a "noun" that the core wants to use that "noun" itself in
> future. Perhaps gitx blah would be a better standard way to access
> extensions. But that is an aside, I am sure this question has been
> considered previously).
>
> An even more functional architecture would provide support for a
> global registry of plugins. I understand that git may not want to
> write its own package manager (how many times has that been done),
> but it'd be nice if competing "git package managers" had a standard
> target to deploy to.
>
> My thoughts about this are inspired by how the node project manages
> packages with its npm package manager and also the fact that I have
> several ideas on the boil at the moment that would definitely benefit
> from a standard way to manage these concerns.
>
> jon.
>

Also, a hypothetical git package manager might also provide build support
for packages to easy the creation of help, archives, validating
layouts and descriptors, etc.

jon.
