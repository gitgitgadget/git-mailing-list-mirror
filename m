From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-notes: Run partial expensive test everywhere
Date: Tue, 10 Aug 2010 15:29:59 -0500
Message-ID: <AANLkTim2tozO31HKLwxi6kWyZKYMd9egDhS5U_gb5OvZ@mail.gmail.com>
References: <1281470164-27008-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 22:30:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OivSs-0000No-3M
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 22:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab0HJUaV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 16:30:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53557 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0HJUaT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 16:30:19 -0400
Received: by ywh1 with SMTP id 1so3861678ywh.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JVxSH8yW8oCBoaEDgvLkhbmGkX5KL3pSvA/B6oW69iI=;
        b=caoA2/53kr/kXAm4rbwt7JOgYtYy8qeuE0TF2QfkSDqtMr/TuuyWJs3Sh8TXt8SmXl
         EdUbEK6rpp9cW6hSHdJ3kcMxMFD9yA4YHCGKp8UED8MeH1Vh7Iudk+9hjLGJoYUDip2D
         weiZh3HqdML1o6OQ+tD9PaAN+8yn5dQvJIMSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tpbOHh/ANB9v+jhGdUn1YjzFcbvBIUsnKiFXMI7hjyWloLpSd/f81SCNAeJgjR6Gny
         bE6TQfS1bAKO6m/ls/QqH8XTRsJmR8tYU0XQsdHKc0BacNFw1mX2vrPvHKwrOHWRPkFK
         EIq0QmyQ8ZUMHras3pPekqhuXerT0tNf3/ob4=
Received: by 10.150.14.21 with SMTP id 21mr20705020ybn.65.1281472219089; Tue, 
	10 Aug 2010 13:30:19 -0700 (PDT)
Received: by 10.151.6.12 with HTTP; Tue, 10 Aug 2010 13:29:59 -0700 (PDT)
In-Reply-To: <1281470164-27008-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153154>

Heya,

On Tue, Aug 10, 2010 at 14:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> The git-notes expensive timing test is only expensive because it
> either did 1k iterations or nothing. Change it to do 10 by default,
> with an option to run the expensive version with the old
> GIT_NOTES_TIMING_TESTS=3DZomgYesPlease variable.

Nice, why 10 though? Any motivation for that particular value?

> Since nobody was ostensibly running this test under TAP the code had
> bitrotted so that it emitted invalid TAP. This change fixes that.

Nice catch.

> The old version would also mysteriously fail on systems without
> /usr/bin/time, there's now a check for that using the test
> prerequisite facility.

Should this patch be split up?

--=20
Cheers,

Sverre Rabbelier
