From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rev-parse --git-dir does report yield relative path to git directory, per documentation
Date: Thu, 17 May 2012 09:38:08 -0700
Message-ID: <xmqqfwayrcen.fsf@junio.mtv.corp.google.com>
References: <CAH3Anrrb243zdRJJEqDcWrHBVBDdYkGB=sTG7BbjTzsUHvWY-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 18:38:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV3iY-0002Ig-BW
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 18:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151Ab2EQQiP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 May 2012 12:38:15 -0400
Received: from mail-we0-f202.google.com ([74.125.82.202]:61111 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335Ab2EQQiL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2012 12:38:11 -0400
Received: by werf13 with SMTP id f13so103820wer.1
        for <git@vger.kernel.org>; Thu, 17 May 2012 09:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=4HtoNOuJNTBIhLgPRp5rIhnHVr91OCNzlIonQ1xR34A=;
        b=iEsKbch9EYXmD3o43uEm9MZw1QFBxTOTdDD0eIJHD/oYQ/nvRGgsPPl7YX8JkyCX9j
         GYxioMl9hU2w6YMRpYBf/JEZ+UqkQKlf+m3lktndeSsJT+5w9Dtms2wl5DYCPcaLtxfk
         E1YeS5SaLM4sMR4YR5bTAMavuvTWMm1AOBuc6iA6wYJ3/NLLWW1Rtr1S6dLZPSMR3LyL
         YLL2jfszc7k4F+i71EJvVSq4VEKheqSryRBvWYF/VtPknApJkSFxMPeEa1pyC47eWKf+
         P/SRlRHjxnudwXXbCD+IWLsC18jSX9Kmbjqrx+GwSjkoEIhXu30TFn3n9Sag2tgOw6uC
         hiWw==
Received: by 10.213.22.130 with SMTP id n2mr554796ebb.5.1337272689852;
        Thu, 17 May 2012 09:38:09 -0700 (PDT)
Received: by 10.213.22.130 with SMTP id n2mr554787ebb.5.1337272689636;
        Thu, 17 May 2012 09:38:09 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id d52si6042371eei.1.2012.05.17.09.38.09
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 17 May 2012 09:38:09 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 6F46F20004E;
	Thu, 17 May 2012 09:38:09 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id C0EC2E25F4; Thu, 17 May 2012 09:38:08 -0700 (PDT)
In-Reply-To: <CAH3Anrrb243zdRJJEqDcWrHBVBDdYkGB=sTG7BbjTzsUHvWY-w@mail.gmail.com>
	(Jon Seymour's message of "Thu, 17 May 2012 19:03:28 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQke8JZ/vFfODXUl8jNFdNR67lfjATKRG+GoWVU8o5+Z6uWThCAjCsRVMVl5aPUsVEAYIm0lsIpId+F5QnuR40cSSx1KnEguYMygo1oFxocBBmj/jyFvsUVt709Ao6y5AIk48EF+VNCZCDxfDEsgbv7lHPae+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197922>

Jon Seymour <jon.seymour@gmail.com> writes:

> Per this advice in git-rev-parse(1):
>
>      Show $GIT_DIR if defined. Otherwise show the path to the .git
> directory, relative to the current directory.
> ...

Unfortunate.  Here is what the commit that wrote the sentence says:

    commit 80d868b068b9e68a4aac91be578a8f097f45d8da
    Author: Jonathan Nieder <jrnieder@gmail.com>
    Date:   Fri Nov 26 22:32:31 2010 +0700

        git-rev-parse.txt: clarify --git-dir

        The current behavior is often to print an absolute path rather =
than
        a ../../etc string, but callers must be ready to accept a relat=
ive
        path, too. The most common output is ".git" (from the toplevel =
of
        an ordinary work tree).

        Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
        Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclou=
ds@gmail.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

I am not sure what we were smoking.  I am guessing that it wanted to sa=
y
that the path is something you can feed to chdir(2) to go there, but it
should have done so without promising more than what it does.
