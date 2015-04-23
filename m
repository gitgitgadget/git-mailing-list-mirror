From: Dave Boutcher <daveboutcher@gmail.com>
Subject: Re: [PATCH 1/3] git-multimail: Add an option to filter on branches
Date: Thu, 23 Apr 2015 09:48:04 +0800
Message-ID: <CAEXuECj=m-TVfVzQAtw91bfgMEUvPDt4_PtN73SxWDWSZebpow@mail.gmail.com>
References: <1429657487-10809-1-git-send-email-daveboutcher@gmail.com>
	<55377A60.707@alum.mit.edu>
	<CAEXuECi=UDo7_0O22+Gi1yew1M=LrrKLXNT9gdSvdgQwCxYjow@mail.gmail.com>
	<553789B6.7030501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 23 03:48:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl6FP-0006Qe-NM
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 03:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803AbbDWBsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 21:48:07 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34597 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717AbbDWBsF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 21:48:05 -0400
Received: by wgso17 with SMTP id o17so3407978wgs.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 18:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ciucY028Mv/LNzBF7t4ZKuYPOJ+KFAY5cYTbU+xXlvk=;
        b=DDtoO43llGgPFcrV05zsgrF2Td0rCBzWDkEjI3IKgP0GybDAoD2aNJAqOMipVhn6pZ
         W+DYnQ4UMKVfx1CdAMOUEYti1fmrxRNWq4uiJ6Y62fw+t154BKi5QgTH5MSQ3WfAhKyM
         vMVJUANmAOH/WSTyZf4pyeDyOBMVjtz39Lz107gJOJgyABOVplY1oehfGqsq4QXdA6M9
         f+0qv0zpcc71soG9GlFxX3lbczNXPYVKJetctjXSmGvI0DDcMeC44sOJEubmrgV+Ni8X
         +IwbORW1Vn8UnervxbqvgQr1roFyGY1zaWie0bdAxq3Kj8LMucQYltBBWsnLA9Q+AlKb
         9tag==
X-Received: by 10.180.106.70 with SMTP id gs6mr10660630wib.36.1429753684195;
 Wed, 22 Apr 2015 18:48:04 -0700 (PDT)
Received: by 10.27.91.207 with HTTP; Wed, 22 Apr 2015 18:48:04 -0700 (PDT)
In-Reply-To: <553789B6.7030501@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267673>

On Wed, Apr 22, 2015 at 7:44 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I think what you are looking for is
>
>     return any(r.match(branch) for r in branches)

Yup, thats exactly what I wanted.  I'll submit an updated patch

> I was also wondering why you decided to support comma-separated lists of
> regexps *and* multivalued config settings. It seems that supporting only
> multivalued settings would suffice.

In practice we are using gitolite and git-multimail.  Allowing both
means our gitolite.conf file can look like

repo foo
    # always notify on master
    config multimailhook.branches     = master

   # notify for the current pre-release branches
   config multimailhook.branches     = v1.7-pre, v1.8-pre

-- 
Dave B
