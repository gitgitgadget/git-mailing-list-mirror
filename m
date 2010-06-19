From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] notes: Initialize variable to appease Sun Studio
Date: Sat, 19 Jun 2010 11:58:59 +0000
Message-ID: <AANLkTimmnlHmt6LTHFKUtJZ7taSF10p4Pkna4CCb1G_J@mail.gmail.com>
References: <e0fbd6edc13d94a097e8e7e3649b9e669f9b4ee3.1268413246.git.trast@student.ethz.ch>
	<1276558805-26573-1-git-send-email-avarab@gmail.com>
	<7vvd9fwrmc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 19 13:59:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPwhd-0000P3-He
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 13:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab0FSL7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jun 2010 07:59:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49229 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab0FSL7F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jun 2010 07:59:05 -0400
Received: by iwn9 with SMTP id 9so1910532iwn.19
        for <git@vger.kernel.org>; Sat, 19 Jun 2010 04:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OpNzo/fmRJWQWM3/FfbJZTtNXqos0dqsi0Z9KFbUDOU=;
        b=I1yfzBx6nq1SK4fJEAytrF0ym1nEyPR17yh1NL8XOma7yJt/BNqUnsy3Qlf+pnO31m
         /VLZHQr+63cR5F0WYNUbmVjayAigJtyfhvFtGJ4ZaCybxHru6gMzc38xVV5PqsA6ZoDu
         Fo0k6GtV3BK9mgA3cQS++uo5mKkr88cNRTK20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fDN0YbBcL/Z7mbRgDd3+fqW9cqkvCSuG8qe20YKlPO1UWpH8Kiy3zP8EZzCZ/FaVNE
         7zogG1Ww0cVNGpeX7CsXtKt6VdMNt/wFo/gHObb81UhbmQ3r+eZsNKHapx6BBwKY/afU
         /88C0ID0LhFkIOBOy3hMYjIS1dotGelrSCzH4=
Received: by 10.231.173.145 with SMTP id p17mr2712289ibz.32.1276948739645; 
	Sat, 19 Jun 2010 04:58:59 -0700 (PDT)
Received: by 10.231.158.195 with HTTP; Sat, 19 Jun 2010 04:58:59 -0700 (PDT)
In-Reply-To: <7vvd9fwrmc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149378>

On Sat, Jun 19, 2010 at 04:52, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Sun Studio 12 Update 1 thinks that *t could be uninitialized,
>> ostensibly because it doesn't take rewrite_cmd into account in its
>> static analysis.
>
> Hmm, I am wondering if I should apply this or just tell you to fix yo=
ur
> compiler ;-)

I just noticed it when testing on Solaris, I don't use it regularly.

IIRC pretty much exactly the same changes were proposed for
compatibility with HP/UX a while back, and looking through the source
it seems a lot of things initialize struct pointers to NULL. Although
I haven't found any examples yet where they strictly didn't have to.
