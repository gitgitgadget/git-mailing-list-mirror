From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 4/4] Move builtin-related implementations to a new
 builtin.c file
Date: Thu, 2 Jan 2014 21:58:48 +0100
Message-ID: <CAHGBnuMathrjUt10AqnEP=d4b306=+D4DFhPeDX0zmpsniA-rg@mail.gmail.com>
References: <52C58FD7.6010608@gmail.com>
	<52C59130.4050003@gmail.com>
	<xmqqy52yp3tm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 21:58:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypLy-0007WV-Dy
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 21:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbaABU6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 15:58:50 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:34910 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaABU6t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 15:58:49 -0500
Received: by mail-qa0-f52.google.com with SMTP id cm18so13618158qab.18
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 12:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m4XblTA1wSgQjVdWZOFoqQdTMkbBNxv+xymonH1Eb38=;
        b=NTJXZHLwc53zNB2LMMSek3zcAuOqOBPi8HRoqlNXanDC/cAkRvU+qZF5nraIzj774V
         MsgixtGrViRFs4KxPKqP87C/IAp9Jkb9hE279D+xO3REQaCo06Ch33vp8e5KRIH877jw
         ASVmnPyPQiBMJUJ65di8/wivPtvQkBAmhJn/mwvllfvtMBYCW6tls3yxk/QcoijEjoXh
         p2eh6uSTo0HzG/e/KhATGnY4xiNDEnCrZNcAUXBpt3ddaEo0kuaKyoZ4I0yH4fcLyKvh
         1UqNNMOtvo4Who2clQKW8j3eCRWjwslOF0Jg8Tkucc0YrcyfunP/KbuNOJJ6Vv1Bv2Yp
         V1OQ==
X-Received: by 10.229.122.195 with SMTP id m3mr139997825qcr.7.1388696328514;
 Thu, 02 Jan 2014 12:58:48 -0800 (PST)
Received: by 10.96.22.229 with HTTP; Thu, 2 Jan 2014 12:58:48 -0800 (PST)
In-Reply-To: <xmqqy52yp3tm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239879>

On Thu, Jan 2, 2014 at 8:43 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>  Documentation/technical/api-builtin.txt |   2 +-
>>  Makefile                                |   1 +
>>  builtin.c                               | 225 ++++++++++++++++++++++++++++++
>>  builtin.h                               |  21 +++
>>  git.c                                   | 238 --------------------------------
>>  5 files changed, 248 insertions(+), 239 deletions(-)
>>  create mode 100644 builtin.c
>
> I'm sorry but I do not see a point in this.
>
> It is not like builtin.c can be used outside the context of the main
> Git program, and many helper functions you moved out of git.c that
> used to be static want to be called from other places.

I've added this commit because Christian suggested so in [1], and also
because it has always bothered me that the Git project does not define
a function in a file named after the header file that declares the
function. Anyway, I've made this the last commit in the series on
purpose, I can just drop it in the next re-roll.

[1] http://www.spinics.net/lists/git/msg222452.html.

-- 
Sebastian Schuberth
