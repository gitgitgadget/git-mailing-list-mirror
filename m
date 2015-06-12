From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 03/12] for-each-ref: change comment in ref_sort
Date: Fri, 12 Jun 2015 10:40:50 -0700
Message-ID: <xmqqy4joddul.fsf@gitster.dls.corp.google.com>
References: <5579B253.4020804@gmail.com>
	<1434039003-10928-1-git-send-email-karthik.188@gmail.com>
	<1434039003-10928-3-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 19:43:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Syv-0008Uj-4g
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 19:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbbFLRkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 13:40:52 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36755 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbbFLRkw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 13:40:52 -0400
Received: by igbpi8 with SMTP id pi8so16498200igb.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZNb360FR/ydIQhXjBMLCaPbj1jJ2yQIgsDXGh8KrlAQ=;
        b=ql04ZYfaD8nMXzD+Ph2XLaTIlY+iPpyyWERMk4lnbJUyzlG21rMFgrqQn1Y08vHsI3
         FjhARStbZS8gKNXim0Avd8N4hvSGMVGe3DBAgoXJv2vBzPRE13bTvBhlc4Rr0K1jx3/X
         ki8MJqCflF6zHSoXG4cKw6+T95AyFGPXXvUk30DtXxq1r/04rtxODYvVhh+EMUYO07Tn
         9PbMflbfrkwD928OXlXRX2LpXFGLD6vtz3EASuqzNh+drV/LL/FBa+3qxGvWTUDxIZtl
         R45zyfKrwxUgyKMi1LyP1tTedXBWK6JP2H/C2tV2W0f5NolIV1Vu2HZGIfzxAxspE1lI
         CRcg==
X-Received: by 10.107.17.87 with SMTP id z84mr1814609ioi.81.1434130851458;
        Fri, 12 Jun 2015 10:40:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id j3sm1582813igx.21.2015.06.12.10.40.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 10:40:50 -0700 (PDT)
In-Reply-To: <1434039003-10928-3-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 11 Jun 2015 21:39:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271503>

Karthik Nayak <karthik.188@gmail.com> writes:

> The comment in 'ref_sort' hasn't been changed 9f613dd.

Bad grammar?  "hasn't been changed since 9f613dd", perhaps?

But more importantly, don't just give an abbreviated object name.  I
think "the comment hasn't changed since the for-each-ref command was
originally introduced" is what you meant to say, and it is OK to
append "since 9f613ddd (Add git-for-each-ref: helper for language
bindings, 2006-09-15)" to that sentence as a supporting material.

> Change the comment to reflect changes made in the code since
> 9f613dd.

What change since 9f613dd do you have in mind, exactly, though?

I do not think the fact that this field indexes into used_atom[]
array has ever changed during the life of this implementation.
I see "static const char **used_atom;" in builtin/for-each-ref.c
still in the 'master', and that is the array that holds the atoms
that are used by the end-user request.

So I do not think "The comment was there from the beginning, it
described the initial implementation, the implementation was updated
and the comment has become stale" is a good justification for this
change, as I do not think that is what has happened here.

You may be changing used_atom to something else later in your
series, but then isn't that commit the appropriate place to update
this comment?

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/for-each-ref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 0dd2df2..bfad03f 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -27,7 +27,7 @@ struct atom_value {
>  
>  struct ref_sort {
>  	struct ref_sort *next;
> -	int atom; /* index into used_atom array */
> +	int atom; /* index into 'struct atom_value *' array */
>  	unsigned reverse : 1;
>  };
