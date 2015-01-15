From: Francesc Zacarias <francesc@spotify.com>
Subject: cosmetic bug: "git show --pretty:format" produces different output
 than "git show --format"
Date: Thu, 15 Jan 2015 14:55:08 +0100
Message-ID: <CAEKevnWfFq9gyN8Ga8zXUDwk_+Mk6RK0HVT-+sbejjVPw0U0=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 14:55:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBktx-0008BM-Cu
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 14:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbbAONzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 08:55:52 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36402 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbbAONzv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 08:55:51 -0500
Received: by mail-wi0-f171.google.com with SMTP id ho1so2621853wib.4
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 05:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=hblzqZJ5MTxvAyWIAo0WYbtwG2aakNnSFUskO5Eklv4=;
        b=jHPTv82WsdOCXZE2tVinkk5Nrh8vNhH/vxO8+5heurXcY3RKpYxHoktIf0AIHu+Fdr
         8x5w7txjzqlqapP0sKNYrceEqXojCvBM7AjT9+KU7f7lKBP3//h0HLBR3a/lIzJt+W57
         tksWIADBYnKpQL7qN2fzjmrFtvf88SDPfituE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=hblzqZJ5MTxvAyWIAo0WYbtwG2aakNnSFUskO5Eklv4=;
        b=mbHcUb63YZv3/3aNoklFCeLmOaUBjWs/R4IKiP3XC6TiW3bNObO+9Eqsv/3V/zHKGV
         hiHxlTuGIz9axRZbmoE7jYi3B2HUKK3Zd7/Rk6iN0ZtX2kRMRKupZhzo+3aOKKWEs1IO
         zTVurf9lBq1sMhx2WPGQVkT5/lhbsYQs76TgKVjnrGxXgo5MMC3IIHIPyzzlendKQDvN
         MQGh+fomsKDCWZtLriPGIbS5AFuLpeaUdNNvMpRk/AedceQjWHwfjGnrrJRdQ4ejNlkk
         7MbzBydsx4YzW+3frNI4/Dxdy3OBNECwzuD7FsLdkCiAW33sPTuvN24DPqGyPYJsu94i
         X9hg==
X-Gm-Message-State: ALoCoQn1FTJKluWwy5J7ZNC+xF6aVG6/Pf/KogDZMWY2rFohTvliPPcjGXmYslagJBklmdcM3n6j
X-Received: by 10.181.12.112 with SMTP id ep16mr6231319wid.38.1421330138823;
 Thu, 15 Jan 2015 05:55:38 -0800 (PST)
Received: by 10.217.85.138 with HTTP; Thu, 15 Jan 2015 05:55:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262478>

Hi!

I noticed that git produces differing output for
"git show --pretty:format show" and "git show --format", even though
the man page says that both are equivalent.
"git show --format" always appends an empty line at the end. The only
way I've found to get rid of that empty line in --format is by adding
-s option.

So, "git show --pretty:format" and "git show -s --format" do produce
the same output.

I can reproduce this issue in Ubuntu Trusty (git version 1.9.1) and
Debian Jessie (git version 2.1.4).
