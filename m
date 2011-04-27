From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 17:15:50 +1000
Message-ID: <BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>
	<BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
	<7vsjt49stq.fsf@alter.siamese.dyndns.org>
	<BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
	<7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 09:15:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEyyb-0001AG-R1
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 09:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046Ab1D0HPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 03:15:52 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60441 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab1D0HPv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 03:15:51 -0400
Received: by vws1 with SMTP id 1so1073326vws.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=X2jwwQOiwLaIW1EymTcw8NcnCk/lG4Cfr+xmb0woYWg=;
        b=LvpO2jt99Xkow63KwUWJYW5Cv1E/qjGeTH3Mz0b3Uvs4IifawpBQtpzYh/ASYxHSAg
         /e8vbay1h4K/tWL3HcE/ArI3KTJj54gkTZSHf3VS6xI7YSrzYb3FBIyeTYpzIPqSTiQ2
         /Nej9LtWHG/5ADm4jHrtQkE1kxJXrrj8fpRVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=J7tMvuuRC1emGuVVzorBX7BTb+sTVtIpQ8gMfz3TW+TyVuNF5W09m9UgQRY1xcC8YO
         pOpmig8vV1XakKjohF4gpBMBcntdIY1XY2LLFdMqSG20CGL/4K9bJKkO2bLOWB6GmutY
         98ZJlJyAmmcotWX2uP60gWWdacpT4aWuOrVnw=
Received: by 10.52.169.135 with SMTP id ae7mr2594043vdc.79.1303888550762; Wed,
 27 Apr 2011 00:15:50 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Wed, 27 Apr 2011 00:15:50 -0700 (PDT)
In-Reply-To: <7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172181>

On Wed, Apr 27, 2011 at 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> My thoughts about this are inspired by how the node project manages
>> packages with its npm package manager and also the fact that I have
>> several ideas on the boil at the moment that would definitely benefit
>> from a standard way to manage these concerns.
>
> Sounds like you have a plan ;-)
>

Ok, here we go:

    https://github.com/jonseymour/gpm

Anyone who violently objects to the suggested name of a package
manager interface - gpm, please speak up now because it'll be easier
to change now.

(And yes, gpm is intended to be an *interface*. The idea would be to
allow the interface to be back-ended by different implementations
depending on taste, platform etc.).

I suggest using this list for discussion, but I also think the github
issue manager would be a pretty good option.

Speak up if, you see anything wrong so far!

jon.

NAME
====
gpm - a package manager for git extensions

DESCRIPTION
===========
This is place holder for a proposed plugin architecture for git extensions.

The initial deliverable of the project will be a plugin architecture proposal.
In parallel to this deliverable a reference plugin manager will be developed.

PRINCIPLES
==========
* define a repository layout specification
* define a package descriptor (using the git config syntax)
* package manager agnostic repo and package specifications
 * perhaps define a pluggable package manager interface
* support for:
 * existing contrib/ directory
 * existing git patterns for finding and using extensions
 * man pages
 * package specific configuration help
 * bash completions
 * scripts
* build support:
 * for documentation, archives
* layers
 * repo, package descriptors
 * tool interface specifications
 * tool implementations
 * global package registry and repository

INTENDED SCENARIOS
==================

Installation and Removal
------------------------
	gpm install package-name | package-url | package-archive
	gpm remove package-name
	gpm update package-name
	gpm list installed|available|active|inactive
	gpm status package-name

Activation/De-activation
------------------------
	gpm activate package-name
	gpm deactivate package-name

MAILING LIST
============
Until noted otherwise, please use the
[http://dir.gmane.org/gmane.comp.version-control.git](git@vger.kernel.org)
mailing list for discussions about design decisions. gpm: is suggested
a good prefix for such discussions. We might
also use the github issues manager to integrate and discuss
suggestions, subject to agreement from the list.

AUTHOR
======
Jon Seymour
