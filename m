From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 13:17:24 -0500
Message-ID: <CAMP44s0C-O+c_n+46ns8B-zXLUGfyEEOmdDyWs63nX+ZNoOvkQ@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7v61z5hzqg.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rT1097=481aSH=Gy465zb2Bd_xLv=Xvte-GHcamWLyA@mail.gmail.com>
	<CAMP44s0mHxv24GtpY2KzmrKQjZo+97FNN_T7tQk_peyWmusMWA@mail.gmail.com>
	<7vsj29eysv.fsf@alter.siamese.dyndns.org>
	<20130430005304.GG24467@google.com>
	<7v8v3zewfi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:17:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXF7L-0005in-Cz
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760833Ab3D3SR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:17:27 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:54464 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760751Ab3D3SR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:17:26 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so809459lbi.37
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Kx4r21SaKU8iIc1U/UF8b6y0qg5sn11Q5zaqgY6rBiI=;
        b=F04qeFJ7WjxUAy4+iDmk8CEMxW2sXK4X54OvAlImpSW4rQzopNUdp8cp8a1Jlc2YWy
         yI/N6ayeQTmX8kWuP+t/q8+yGSDI+yy2rFJCb7oS2DuSL/JmrVvof7gB2c7x9s2xxNtF
         mu+qL5TxmQSYRe5PEtnHZRnFeXIgEGMXYyg8Zh0IjnJY8otcZ6emQrUbYw3Xu0sYkZKi
         B8Eum+bi8Sbv49O9pLuBjn2q8SQTsWihT5PBJOGPbtLMcHI6Db3lbYkCqIZ786hk8mGj
         s+tOsePH+6/Ty09dCtyrnQugenjPgYFnRgbkuXntbP9+oKnP7HeiI5jJvfwDJRL4cuqq
         3pug==
X-Received: by 10.112.154.98 with SMTP id vn2mr65609lbb.8.1367345844355; Tue,
 30 Apr 2013 11:17:24 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 11:17:24 -0700 (PDT)
In-Reply-To: <7v8v3zewfi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222979>

On Tue, Apr 30, 2013 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>> Never-mind, now I see the difference, still, I don't think it's
>>>> relevant for this patch.
>>>
>>> I don't either. With the precedence of @{u}, @ does not need to have
>>> anything to do with a reflog. It is just a random letter that casts
>>> a magic spell.
>>
>> I thought the convention was "^{...} is for operators that act on
>> objects, @{...} for operators that act on refs or symrefs".
>
> Almost.  You can ask "git rev-parse --symbolic-full-name" to see
> that @{-1} is still a ref, but @{1} is _not_ a ref (it is a concrete
> revision that you cannot run 'update-ref' on).

This has nothing to do with this documentation.

diff --git a/Documentation/git-check-ref-format.txt
b/Documentation/git-check-ref-format.txt
index ec1739a..4764975 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -52,7 +52,7 @@ Git imposes the following rules on how references are named:

 . They cannot end with a dot `.`.

-. They cannot contain a sequence `@{`.
+. They cannot contain a sequence `@{` or end with `@`.

 . They cannot contain a `\`.

diff --git a/refs.c b/refs.c
index de2d8eb..99ac4f6 100644
--- a/refs.c
+++ b/refs.c
@@ -95,6 +95,8 @@ int check_refname_format(const char *refname, int flags)

        if (refname[component_len - 1] == '.')
                return -1; /* Refname ends with '.'. */
+       if (refname[component_len - 1] == '@')
+               return -1; /* Refname ends with '@'. */
        if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
                return -1; /* Refname has only one component. */
        return 0;

% git update-ref master@ master
fatal: Cannot lock the ref 'master@'.

-- 
Felipe Contreras
