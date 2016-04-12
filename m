From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Apr 2016, #03; Thu, 7)
Date: Tue, 12 Apr 2016 09:25:17 -0700
Message-ID: <CAGZ79kad=9-TA7yFhkOesMv63DWN_wPNYEj249ne6Le1QRsN1Q@mail.gmail.com>
References: <xmqqfuuxz1jh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 18:25:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq17z-0001i4-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 18:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497AbcDLQZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 12:25:19 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35505 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcDLQZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 12:25:18 -0400
Received: by mail-io0-f176.google.com with SMTP id g185so35037192ioa.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=HVC0JSw5oWKfIVRvMr44wkW0CZm3QUOco/AS05cK9qc=;
        b=WGx0cKOyRzqlDxjCcq2KkobJH/wq2BDjAy3Ibaw7AykalzgHmnKqQy8DtWH+NOcMq4
         2hMbOYdADmwTmEdWWuhOv6eq0lq4qMMdeKqD9w3pa0QwWa1POJIdB19VabwDqbIOmiA5
         qT6YxwiICJjl9AzlZWFetO2MF/E2iLysjy6NtsHvYDpT8ZzMXWRdOLY3odTDbKXD1nx7
         6/k3PSv3krpfrWlDaNnTZjd0ud99rou5T2UYw3hnN+4fo1jiiLBPj2u8MD8HPrfQFPFe
         bFL+M9vb+sfXMs53qkX0tHz3ZyQ5623GIgY6vr6tYix0kgCgi7QxbPf55kEvDJZAPJ3c
         BKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HVC0JSw5oWKfIVRvMr44wkW0CZm3QUOco/AS05cK9qc=;
        b=Sf1AojN/R1zYH9RZp5ykyfnpjwwC/kw3SP4bYCvQen1Rq5qYx+LpUL61n/b9JqpSTU
         1JSaROJyn9+WADQlBK8USPI7FZGazLA2q2x/0al9nyBD1YHhV+TT9KZobbgEBteo2LbF
         KO9B9XbsgX9h2CxVn/HTbBtldGyguD+PxQjGCD91Qavh36qQLY40nUVn/zgwC+C2PfT4
         t7f7m4Nag3zz5jGdGE+AA+8xRhadGGN93CAKg4av2zcCiuTEqK1UR+rxhYCRD+NyBYXB
         AFARP2Qv5gjBIfVfYk4NKKgTS/ZjAozVR8GJsNqgMTsFSbIBJkHxrRZuTgjoR728j2CM
         ByKA==
X-Gm-Message-State: AOPr4FUg2gknIFVU3I88/7xsfxoWj/o6LBXZNVMAjl40p3uZwL2XtKzrXs0HmCMTkEOi9quoclTM5bATLKLo1RFK
X-Received: by 10.107.161.68 with SMTP id k65mr5689013ioe.110.1460478317322;
 Tue, 12 Apr 2016 09:25:17 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 12 Apr 2016 09:25:17 -0700 (PDT)
In-Reply-To: <xmqqfuuxz1jh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291275>

On Thu, Apr 7, 2016 at 12:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * sb/submodule-helper-clone-regression-fix (2016-04-01) 6 commits
>  - submodule--helper, module_clone: catch fprintf failure
>  - submodule--helper: do not borrow absolute_path() result for too long
>  - submodule--helper, module_clone: always operate on absolute paths
>  - submodule--helper clone: create the submodule path just once
>  - submodule--helper: fix potential NULL-dereference
>  - recursive submodules: test for relative paths
>
>  A partial rewrite of "git submodule" in the 2.7 timeframe changed
>  the way the gitdir: pointer in the submodules point at the real
>  repository location to use absolute paths by accident.  This has
>  been corrected.
>
>  Any further comments?  Otherwise will merge to 'next'.

I've looked through that code again now and responded to
Ramsay Jones, who found an issue with another version of the patches
(0 instead of NULL passed into strbuf_detach), but the current version
of sb/submodule-helper-clone-regression-fix doesn't have that issue.

Please merge to 'next'.
