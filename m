From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Has anyone tried to implement git grep --blame?
Date: Wed, 29 May 2013 07:41:52 +0200
Message-ID: <CACBZZX5R=zaNBv4OGh30dxj+BAi26jDxDBO5pZTQ2QxGUB6WXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 29 07:42:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZ9O-00053b-8T
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab3E2FmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 01:42:14 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:51429 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab3E2FmN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 01:42:13 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so11244118oag.36
        for <git@vger.kernel.org>; Tue, 28 May 2013 22:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=i+bS8TxSbExJ8Cf2n9HeCvq9tYFpu2FEJdsx6uPnTsg=;
        b=PGj5Ey9cSZPwDKnn7O9+O6o479iJvyGN+Z6b+GPlxBLAHcdiWzuuwsb4Ybaf3+ZU7O
         BppENiWNP3IiQssiNmybfyK143i+FI2/X+B5fKAfDs6kDnWG8RI2wBlBPD9LRYBq5vs4
         8MUw6LKCjQCXIMqNeHfa27qGwFeAn35pZJT/Lo0Kw+P7qg+42tjNLss2CZKfnFBqWwd2
         V3bZNVSQgCkbq54NsjaMoD1bQ0/aTCmYqp56fFhJvXRHISBhuEJ81xGCMdAxP2wo02EP
         5PJDGBGflXAC1FKuC9J24dYTx7796rVsJxIJs3bkVWUD1jC9nvzTWkZ2gTPkKT5tZ2kd
         Z0vw==
X-Received: by 10.60.51.194 with SMTP id m2mr708380oeo.6.1369806133234; Tue,
 28 May 2013 22:42:13 -0700 (PDT)
Received: by 10.76.93.238 with HTTP; Tue, 28 May 2013 22:41:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225742>

This would be so much more convenient if git-grep supported it natively=
:

$ git grep -n 'if \(0\)' | perl -pe's/([^:]+):([^:]+).*/`git blame -L
$2,$2 $1`/se'
d18f76dc (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason 2010-08-17 09:24:38 +0=
000 2278)   if (0)
65648283 (David Brown 2007-12-25 19:56:29 -0800 433) if (0) {

I.e. with all the coloring/pager interaction. Some Googling around
reveals people piping things to git-blame like that, but has anyone
made a stab at a smarter implementation (that would know to blame the
whole file if it had lots of hits etc..).

Don't know if I have time myself, but I'd be very pleased if someone
hacked that up.
