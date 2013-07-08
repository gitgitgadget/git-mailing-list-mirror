From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: Re: [PATCH] prompt: do not double-discriminate detached HEAD
Date: Sun, 7 Jul 2013 22:12:50 -0300
Message-ID: <CAOz-D1+DU=DziVOcoa1=vy-pt8AX8wnUPY38tksep4S7ngKLpA@mail.gmail.com>
References: <1373201565-14030-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 03:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw01B-0001n2-NI
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 03:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab3GHBNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 21:13:21 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:48643 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab3GHBNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 21:13:11 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so1751918iee.6
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 18:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jtoJO5f/Mgnl/akyLT1SfRkWI1q88JlDL8NhM8YyRHk=;
        b=QCRG8UM5SLdU1mSr8wOdiVmv5Jv/VuiPL1LZRxc7gfA8d9Da4paazPTQLrOxiJklQb
         chi7Gy088cQVgqspqqUVcoGIO4d8Xm1N4zePtFxjR332It3bxTa+jkF9h+jcTkkddLag
         0vCuZCsmOTEV9tgry1ADbhVuLvOOz3LuSG0mfrPCNs6kH3fbsnQ2/QsMyMTPoldp4Oc5
         nayiifHAFFsWUzSG/w0pxdkqqDL6KSRsy/aFHqCNyAI6jarcUBDPbv5D2O1f+TaxG8h6
         2XCxLtFm0nGL0f2KUNhkFpAecXF8Vl6SAjHfeuuOswIL9SuKoleMwoi+3J2OFt5fXJrz
         7a/g==
X-Received: by 10.43.168.67 with SMTP id nh3mr6481821icc.33.1373245990933;
 Sun, 07 Jul 2013 18:13:10 -0700 (PDT)
Received: by 10.42.154.198 with HTTP; Sun, 7 Jul 2013 18:12:50 -0700 (PDT)
In-Reply-To: <1373201565-14030-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229819>

I think color in terminals should be used to highlight and make it easier to see
textual information, not to replace them. So I would keep the parenthesis.

> +                               test -n "${GIT_PS1_SHOWCOLORHINTS-}" || b="($b)"

Also, the proposed change has a side-effect because color is not possible in
non-pc mode, even if GIT_PS1_SHOWCOLORHINTS is defined. (Non-pc mode
with GIT_PS1_SHOWCOLORHINTS defined would make the detached HEAD not be
shown neither in red nor within parenthesis).

Regards,

Eduardo R. D'Avila
