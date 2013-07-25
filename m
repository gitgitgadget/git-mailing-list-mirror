From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git and cyrillic branches
Date: Thu, 25 Jul 2013 11:26:28 -0400
Message-ID: <CACPiFCKDjLVrJWPYn1Y5290ipvpVaGzB0VhsJHb2GrPpiBO5gA@mail.gmail.com>
References: <922031374754788@web29h.yandex.ru> <20130725164522.f8841abf18742cc5f6e0fdbe@domain007.com>
 <992731374757601@web29h.yandex.ru> <20130725182851.c17d3ed662434d1d91838949@domain007.com>
 <322491374763917@web5g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git Mailing List <git@vger.kernel.org>
To: =?KOI8-R?B?y9PP18nSwc4=?= <xowirun@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Jul 25 17:27:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2NRT-0007nS-BJ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 17:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412Ab3GYP0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 11:26:53 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:46534 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756374Ab3GYP0u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jul 2013 11:26:50 -0400
Received: by mail-qc0-f181.google.com with SMTP id n1so159565qcx.12
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/UapqDJf8phPW9bJlOAumLKXVhnltzpx1J5f85KvWgc=;
        b=SeN+hHjBoXmXLvS7GseM/4yBXbRvfRzo1PuOS84f6/M5lVf8J4QbfxZksfU96CBeOL
         BcDIOSpuxdqtCfFV/wk1wZ0+ru+9b5cmoqqr3T6a+cdAmS4OXDjowbNUHcPZ9lYlAxhH
         H5MUgZ5uI5r7TbmaRDuWhxXJxlGEHmiSS/41nA+BGnH7tQ8EI0eBLwxzfg8OZ0Vs1/GI
         +5HaY/CyZaypxCJxH3i5On9sZ+UpqLC/fCeRV8YVVm5re7oQu2ArJr1VF9dZu3pJaaiY
         oppG6IN6aFJFC7rZkDUouwuJYDcUwAQo9BD2Xb4UjDoBl6AwDjonTA0/U+065JNB8na+
         vYQA==
X-Received: by 10.49.24.129 with SMTP id u1mr4749635qef.88.1374766009276; Thu,
 25 Jul 2013 08:26:49 -0700 (PDT)
Received: by 10.49.52.137 with HTTP; Thu, 25 Jul 2013 08:26:28 -0700 (PDT)
In-Reply-To: <322491374763917@web5g.yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231139>

On Thu, Jul 25, 2013 at 10:51 AM, =CB=D3=CF=D7=C9=D2=C1=CE <xowirun@yan=
dex.ru> wrote:
> problem is still here, i've got ubuntu on VM and same shared git-fold=
er causes this problem on Mac Os and no problems on Ubuntu.
> git version on Mac is 1.8.0.1 (on Ubuntu is 1.7.10.4)

OSX filesystem code canonicalizes UTF-8 filenames in a way that
disagrees with GIT's design (and Linux's fs design) which considers a
filename to be a bag of bytes better left alone.

So the ugly fixes applied to filenames need to be applied too to refs, =
I guess.

Are you using packed refs? That's probably a good workaround in the
meantime. Using packed refs, git will not need to store the branchname
as a filename...

cheers,



m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
