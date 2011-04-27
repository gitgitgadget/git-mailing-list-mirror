From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 18:15:37 +1000
Message-ID: <BANLkTinrU8LhA0RORde0e5a1TM5VB5gVNQ@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>
	<BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
	<7vsjt49stq.fsf@alter.siamese.dyndns.org>
	<BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
	<7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
	<BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
	<4DB7CC7C.2050508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 10:15:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEzua-0004bj-Qk
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654Ab1D0IPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 04:15:43 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50464 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813Ab1D0IPi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 04:15:38 -0400
Received: by vxi39 with SMTP id 39so1107364vxi.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0gEqke/0mMC8ksljEdcsiOjMCAi8KWDKXTX3a9fdwGc=;
        b=S6aCxqNN72lIO8uiP4ALA/o9NmhDYQLrCGA3fjAuuKQgleIJ4x4HoJ/OctgrA52lT/
         eBOtS3uIEcUKUcBgKIxge491iTwAe5bPn9eppqytcTqGk6NnD51rorYM3vTraWZrZktk
         LIQwx/blzS4OKxq2j+0zq2hbZ8Z5daRKT8WtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YU662Gc8cU4OfTdVPVHQmGkXd8AnzV68mkmX6EsXIGHa+wX++XwIMhWSeP1SFJPzYF
         yukRFMej8ma1DGBir+nxxeD4u8NCuv4afWS9U6f8IoXnz60KaUzkcJpL7HKt+CppanIC
         fORIexvwHymhOVdtWQvJbsV/ku/aaHirPms5o=
Received: by 10.52.71.148 with SMTP id v20mr2720911vdu.266.1303892137307; Wed,
 27 Apr 2011 01:15:37 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Wed, 27 Apr 2011 01:15:37 -0700 (PDT)
In-Reply-To: <4DB7CC7C.2050508@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172187>

On Wed, Apr 27, 2011 at 5:57 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> I'm sorry to spoil the party before it started but I'm not very fond of
> having yet another package manager orthogonal to what distributions have
> already. This is definitely not a way to get anything like that into a
> distribution which has proper policies.

I am happy to defer work on a full-blown package manager for now. I do
agree, the world already has a surfeit of
package managers. As I say, I'd prefer a minimal interface that could
be back-ended by one or more of those if possible.

Initially I'd like to focus on:

* a descriptor format for packages providing hints about how to
activate an extension
* guidelines for the filesystem layout of extensions themselves
* a way to locally locate extensions that might be subject to activation
* the interface between the git runtime and the activated package repository
* the interface to activate/deactivate a locally located package

I also want to avoid baking in any too many decisions about things
like registries and distribution models. That can come later.

jon.
