From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: libcurl dependency for implementing RFC3161 timestamps
Date: Wed, 9 Mar 2016 18:41:07 +0700
Message-ID: <CACsJy8BNNQFP3LHxH06KewUjUVc1eox1mQPsg8b=acq-M=mHNQ@mail.gmail.com>
References: <e57d18f6010c0b581b38a3daef145221.squirrel@faumail.uni-erlangen.de>
 <59de05c280143e7dd3ead6139df7a525.squirrel@faumail.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, i4passt@cs.fau.de,
	phillip.raffeck@fau.de
To: Anton Wuerfel <anton.wuerfel@fau.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 12:41:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adcUp-0007k3-4d
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 12:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbcCILlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 06:41:40 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35271 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbcCILli (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 06:41:38 -0500
Received: by mail-lb0-f171.google.com with SMTP id bc4so61024574lbc.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 03:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zgNffizvP3R/nhg2Qj+UWZ5t9tndjAIwWnZBW2fe6HA=;
        b=CI3YXxWtilK5Cog8wOX2RZ8KkpUk/Wgul+b2g9zzncymc5GCEzFRJNc2nNsYRqzXyN
         0LzHcFO716aEw01O/2DG5S8NW4zlyXOg4w4v17as5XRBb40ifjcdY4VqB/Rquyx7RmQh
         cgqaquMEkYml5+e6+gEkciePNXDdu/H04x07Ba7z9eGTJP0G2gOKEq63go02xGq7j35w
         8gJoW3qoV6cYDVPtVvzOEqatt5vi0OrxZ/HSedyh0wM1ncIyVzkaSnWvX76VDLddncSE
         m5H4WZDg4wHVQWbEHrVVtLerToo/6yFzVwiWj6+EobkwTUaqdsvw3vYDE/nHbkgWKf9v
         wP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zgNffizvP3R/nhg2Qj+UWZ5t9tndjAIwWnZBW2fe6HA=;
        b=JZ2wbeta2Urzj2EcRKMfUEAAoMvRRwJrpGOY8hFUCrhpNqYSK+YvdztuqKsA1rFMjf
         vWpoyPmIcTYA24xtCVRzR/OwgNoiLrFJNDSVntQymKCipwJPDSn3058uDaTbRW+cInzM
         f1t2U+qKtzk4GWi7W/RkX5A35I4vQwYFML1iOaCKwOugo902gkRvvebakCm5QCHqmjzm
         sIiVtVUHD69TjsCzm/0NeNUCpfaURbHmi9gI/P9fn9/T614f1Q6QvE4RVqonYmojY+AK
         sC0p+wgowtWF3nkezj1tsvQdsSoPc6bapl8xeqhSse/LkO5Whkug1IJvNg+oykF9xNSG
         PsEg==
X-Gm-Message-State: AD7BkJLMCyF+QwJ9di9VO+u3IvmL04UlEQfooj2z5yRwHxMOiQMIVWtrr34ghGb4WYciZJWMXYU8cglYHrsSzg==
X-Received: by 10.25.212.213 with SMTP id l204mr11799469lfg.118.1457523696979;
 Wed, 09 Mar 2016 03:41:36 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Wed, 9 Mar 2016 03:41:07 -0800 (PST)
In-Reply-To: <59de05c280143e7dd3ead6139df7a525.squirrel@faumail.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288482>

On Wed, Mar 9, 2016 at 6:24 PM, Anton Wuerfel <anton.wuerfel@fau.de> wrote:
> -As git tag is a builtin part of the main git executable, introduce a
> libcurl dependency for the main executable (maybe not best-practice).

libcurl was part of the main executable and then split out because it
increased startup time [1]. I don't know if it's still true nowadays,
maybe you should do a simple test before deciding to go that way.

[1] http://article.gmane.org/gmane.comp.version-control.git/123946
-- 
Duy
