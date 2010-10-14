From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2010, #01; Wed, 13)
Date: Thu, 14 Oct 2010 09:23:36 +0000
Message-ID: <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 11:23:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6K2S-0001Zs-EU
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 11:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab0JNJXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 05:23:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36143 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab0JNJXi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 05:23:38 -0400
Received: by fxm4 with SMTP id 4so2246010fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=stSMhobB+aW5pJ6cLLsPAcKYn0H1za0seCy4uHuT7bg=;
        b=xROY2UdJfGOb3QUGNw9CCt69yHAd+vh2328NK4xEdnBfCP5nZADFL+yCKU+86pdsio
         E8ijNQuasg7OMsiOyY5UGdI512qNCAvaxGTTCBZ/rE8iEaB9KlIyFvnGXvrVVhzt2mtL
         KZELKyWpufguoa6BLD0YraUUrsiMZ57z9B+vA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k/BZFc5uQVwSNcvmUSsB6MS7KwXSCEFxaRQiDhaqHkHx/ECoEjbhC6IldnCxmpmReN
         zOLWQ62izIkKN8E1rSmRQd7FjyMYjHI5iYVfuvNs603AC5Qnd44s/YSPA0SCX7lgPo4z
         IDivYBfiHe2BGDhF2y23d6KApWvKiv0VSCsek=
Received: by 10.103.247.1 with SMTP id z1mr1786585mur.74.1287048216966; Thu,
 14 Oct 2010 02:23:36 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 02:23:36 -0700 (PDT)
In-Reply-To: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159035>

On Thu, Oct 14, 2010 at 04:46, Junio C Hamano <gitster@pobox.com> wrote=
:

> =C2=A0- test-lib: make test_expect_code a test command
>
> Somewhat rerolled, but the largest one among the series was Nacked by=
 a
> few people and needs to be rerolled again.

Why did you amend this to use this sed trick:

    +sed -e 's/Z$//' >expect <<\EOF &&
    +not ok - 1 tests clean up even after a failure
    +#      Z
    +#          touch clean-after-failure &&
    +#          test_when_finished rm clean-after-failure &&
    +#          (exit 1)
    +#      Z
    +not ok - 2 failure to clean up causes the test to fail
    +#      Z
    +#          test_when_finished \"(exit 2)\"
    +#      Z

Is it just to keep it diff --check clean?

Anyway if we munge the output like this the output of test_cmp will be
more confusing when it fails, because it'll be diff(1)-ing something
that the test-lib would never emit.

> * ab/i18n (2010-09-12) 159 commits

Could you please pick up the 160 commit version of this at:

    git://github.com/avar/git.git ab/i18n

It has the new "gettext.c: use libcharset.h instead of langinfo.h when
available" patch by Erik Faye-Lund and me, which would be nice to have
tested in pu.
