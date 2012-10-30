From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 22:35:51 +0100
Message-ID: <CAMP44s2QwdZKqJq0BZ5HOtZYiCMxCxycui9EmxxfL+Sa6M_6+g@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
	<CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com>
	<CAMP44s3MHrG_XeZEodnxemrW-V18+NHnFvi7koyx9mH8XuHc6w@mail.gmail.com>
	<CAGdFq_jJwZMLq=3co13hs7gas6y9kZRTKwcT+CP=n6-24Uv5Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ">" <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:36:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJTj-0008RC-NK
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934730Ab2J3Vfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:35:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42088 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934295Ab2J3Vfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:35:52 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so769437obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tlt/wAx/DmUeFlWv7s7NhLkTj29LgNvdPXoes4m6O9I=;
        b=HLnuaP7VZjH6V046KkwZtnJvRUr2dwPonyzmyPosUGA4UZvzqxOz7p9Avxhf751Z+O
         CaXGEkllNlSwyrsG/gUT5f0F6LPJK34AW0s1igZhdOZKXpXofotCzYVx5lr7c6nroXLB
         1L6SN54Op/2uSrf9h/s/MZcQzU0s1K9tY+PfvyYJ8lYYvbjpbpzoaClYt2TjAs22Vm92
         DKjCIDInVkvM/J5mk/J2xWQ/SEpWTWGxMtQQ/Xjf2PYP6UtNrJJKfhjUtZPlhbGjabYf
         1sbxOvyaQ51wWaKfVPNh+XptWNeRp0Ji1Gq96WKVBTV1S9atI9/WnqBDmDiL4NijbJk8
         Zt6Q==
Received: by 10.182.52.105 with SMTP id s9mr28920392obo.25.1351632951670; Tue,
 30 Oct 2012 14:35:51 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 14:35:51 -0700 (PDT)
In-Reply-To: <CAGdFq_jJwZMLq=3co13hs7gas6y9kZRTKwcT+CP=n6-24Uv5Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208745>

On Tue, Oct 30, 2012 at 10:17 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Tue, Oct 30, 2012 at 11:47 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Why would it? We are not changing the way objects are exported, the
>> only difference is what happens at the end
>> (handle_tags_and_duplicates()).
>
> Because the marking is per-commit, not per-ref, right?

Oh, you meant using marks?

It doesn't matter anyway, because get_tags_and_duplicates() would get
'one' on the first run, and 'two' on the second.

If you meant something like this:
% git fast-export $marks_args one
% git fast-export $marks_args one two

Then yeah, 'one' will be updated once again in the second command, but
there's nothing fatal about it, and your patch series had the same
result.

> Perhaps you
> could add a simple test case to make sure it works as expected?
> Something along the lines of the scenario I described in my previous
> email?

I'm not sure what that test should be doing.

Cheers.

-- 
Felipe Contreras
