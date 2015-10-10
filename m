From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/10] ref-filter: adopt get_head_description() from branch.c
Date: Sat, 10 Oct 2015 23:47:14 +0530
Message-ID: <CAOLa=ZQ2vqBiYssW-95ojy7UeKUrzzpP9PpJy9MTEtRL2wovsA@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-6-git-send-email-Karthik.188@gmail.com> <vpq8u7dmbgw.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 10 20:17:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkyiL-0004d4-D4
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 20:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbbJJSRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 14:17:45 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34692 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbbJJSRo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 14:17:44 -0400
Received: by vkat63 with SMTP id t63so68254569vka.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2015 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aKDTHiZRGViLVcgM/tzOPuEHze4dTsq/4ekLVyyhSlI=;
        b=rkbouTEi2/GiaQ9bdfax/2Vuh8cG0rzbEclzCvlZWC8m8av2sRb55X+ldXg0M75dWG
         hhT4/7VShwDjfk8fkyxdAiPFCsuDSIJZ/4SKiAbbm4rnwqijrxyEZcqovmYtTl2zZCJk
         eKQQXYez4V1zC98bpwMBMjFO3HYhA6nMiPkZo56VKyvJenP2jO2iyu2Z+9+zHa7Q71Z4
         YfPNI4QleLZDV4kb1ZN9gajhpFvsLCiBDNtJa+qi5mhRKRyl1sFufbk8a1Z7GygWmnNF
         OpVSdChOs02Hmk4/esBfplvgnx0V/q+At5nSxL9OXujF8TeI/2K8MiXLw2d3+KlvZE2c
         ZdUw==
X-Received: by 10.31.162.81 with SMTP id l78mr12870486vke.13.1444501063786;
 Sat, 10 Oct 2015 11:17:43 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sat, 10 Oct 2015 11:17:14 -0700 (PDT)
In-Reply-To: <vpq8u7dmbgw.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279329>

On Fri, Oct 9, 2015 at 12:31 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Copy the implementation of get_head_description() from branch.c.  This
>> gives a description of the HEAD ref if called. This is used as the
>> refname for the HEAD ref whenever the FILTER_REFS_DETACHED_HEAD option
>> is used. Make it public because we need it to calculate the length of
>> the HEAD refs description in branch.c:calc_maxwidth() when we port
>> branch.c to use ref-filter APIs.
>
> If it's made public, then it could be simpler to just _move_ the
> function instead of copying it. You'd need to add a #include
> <ref-filter.c> to branch.c, but you're going to add one anyway.
>
> Code movement is more "git blame" friendly than code copy, and as a
> reviewer I'd rather see the code movement here and not hear about it
> later in the series.
>

Also this needs to be done, cause now compiling branch.c would give a
multiple declaration error. Will do as you suggested. Thanks

-- 
Regards,
Karthik Nayak
