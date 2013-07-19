From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] checkout --rebase
Date: Fri, 19 Jul 2013 18:01:39 +0530
Message-ID: <CALkWK0=vpTHfVsa1QiM75cQL7Ou-_=2=_e-++ZLeeo-d8hqhOw@mail.gmail.com>
References: <CALkWK0m-ZpVvvgAB_yzooah0=veeNDudahs=4ur2YHN03h-h4g@mail.gmail.com>
 <CA+xP2SbHD+MU4K0JBbZdA6bWQFQerBi5mWA+7G9=tBksjp+LXw@mail.gmail.com>
 <CALkWK0nM4fkCPNJo_c3Rpwh1azsGRdGvM3S80vcuRiRXDT0vOQ@mail.gmail.com>
 <CALkWK0kVNw3Ko3+_Y-KDF=pdha6wxyMmQmLtOOr5tQYzgUr_Mw@mail.gmail.com> <CALkWK0mp=2xuQwSjMPRBvwRUEnAbM2=r_hZu=ZKc8wxZYxgSVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sebastian Staudt <koraktor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 14:32:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V09rF-0006R2-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 14:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965385Ab3GSMcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 08:32:22 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57365 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760121Ab3GSMcU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 08:32:20 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so9563092ied.0
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EJyGMs/gGdMwRoGKAj5+Az2768FloUaWMNkHkdFczgA=;
        b=MAhY0C3yu3XawDCX09wu6BrwNze+Gsguyp27fmOsp0jgjFIm4e8ojCKv/JArcJYTNj
         sHBSrvzuwEo9aGaYgAkWG5QuW+IKVpFimI+Z1aw9FVEDiGK4WCVZCXu5wKcbSKVWR8mJ
         ejldZ3QyIsA7aq1xnB3Ov7NhNu/S9OX9hYo0zlzs51vqLq53MTHOYeDKGmaTZd8QIvrI
         bTPE1BP/SnX0/Y7/IzWYTK/WxTS1rkMsH8LD4z65KysgRTqa/0aiFpGQFWVUZHEvAIHd
         4xmgz0On3p1du4nnTAychgq110iB+TTEpTH2hDAkkTCdGgkkpOszS5UGO1p+allSEyLt
         BPZA==
X-Received: by 10.43.9.4 with SMTP id ou4mr10215485icb.53.1374237140084; Fri,
 19 Jul 2013 05:32:20 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 05:31:39 -0700 (PDT)
In-Reply-To: <CALkWK0mp=2xuQwSjMPRBvwRUEnAbM2=r_hZu=ZKc8wxZYxgSVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230799>

Damn it: checkout doesn't get executed at all because the $mb = $onto
condition fails; I was looking in the wrong place.  It's format-patch
and am that are slowing things down terribly.  Has anyone looked into
stripping out the dependency?  Why is cherry-pick deficient?

My current workaround is to use the faster `--keep-empty` codepath,
but it doesn't persist state on conflict.  Isn't this an undocumented
fact (aka. bug)?

Thanks.
