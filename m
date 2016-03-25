From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Sat, 26 Mar 2016 00:37:15 +0530
Message-ID: <CA+DCAeQZjH+vhGYc3PSSt+mgtVi=nJbjbpMBBbTuX-eL9diE9w@mail.gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
	<vpqshzfuduv.fsf@anie.imag.fr>
	<CA+DCAeTNv-2RkbGo+ciKP_bfCvThKjGAsJEr=xuBYBFgrTvGtg@mail.gmail.com>
	<vpq7fgql7zh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 25 20:07:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajX4u-0002n9-1Y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 20:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbcCYTHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 15:07:17 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35658 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbcCYTHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 15:07:16 -0400
Received: by mail-qk0-f173.google.com with SMTP id o6so37474260qkc.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ZtddFV99DYOv8Z5avW/x5oksaiCJV/6IKZEDY8Lbpec=;
        b=Yx0kPcezEIG/DDa/LBT63t3kN7gkbKDUJY/EascxNbvWQDwVOPc3FUD/XGCL38mybp
         m0+ix7wr56dV8bLU9niwIah77+kFU4mGaEAeyKqVPE4+bgcBmbjHh+mjSoV3Cf2j/uLp
         PSimesp+mumcCdghhI/8CDtG39x59/RDB8QUPLgh98+A6XZ6zBbW5J53Mvirt1nTjRj4
         NBOLJ3wVcBL3kiyqduYpLvS2JKgVWY8hXSqf4Bm2jHWW2AS0qB2+3nAIrlmX5dH9IHQv
         lsuUmAIly3ol5Wwf/8txpWy2JkMWUUx3+nVSzkX6tpjZ0dYVbFgqg93EDYTe80sEcX8v
         /Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZtddFV99DYOv8Z5avW/x5oksaiCJV/6IKZEDY8Lbpec=;
        b=PS6tzhfyu9jVvTt7QCS1bBFMvpYcY8Iuw88coZMXFrjOvbqV6dm5buWblshdcW+YD2
         SWrtM8Ebj4Pwq8uR3UgzrU7R//YJIK0ndwQrNcQpm5ESl6HvvYfKxfYc957So20YLoAG
         S+DMHPBwt4JFQ7OSJ5XEkhb7f/gd2NqJxY+CvCX/mSxZj4XHFYbZkNKZhfoepcT2HS5I
         5jMrEsjnkHo+wZxzA7E+PHO1WrRucsUOMVafMzNgEx+FFds3KngqHEHrb2GqbTq51Oc2
         Y7An4Uiygmfrn3PCcrD8e2C2tLrUVzAplOjSZdeayYXGFhML95ndOfFzV1FKojnfaxov
         k7rw==
X-Gm-Message-State: AD7BkJIT3Ag4klmfyXrETQg00OJcLDsxCdRQ3mLsRHWSoXR1rfIYJi1bf06U3myAMkujuV6/FbJzOSxU/je9jA==
X-Received: by 10.55.215.208 with SMTP id t77mr19157325qkt.23.1458932835267;
 Fri, 25 Mar 2016 12:07:15 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Fri, 25 Mar 2016 12:07:15 -0700 (PDT)
In-Reply-To: <vpq7fgql7zh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289945>

On Sat, Mar 26, 2016 at 12:07 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I think you should also change one of the tests to use pull.resbase=true
> so that this behavior is properly tested.

Sure. I will add this test in the re-roll.

Thanks,
Mehul
