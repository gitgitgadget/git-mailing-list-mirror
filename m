From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git Clone Parameter
Date: Fri, 19 Jul 2013 15:31:29 +0530
Message-ID: <CALkWK0=q62SmQwDPKjRv+Z8D59Uy=Kpanth8QFYFJ=xOA5JCtw@mail.gmail.com>
References: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Allan Acheampong <allanadjei@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 12:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V07Vv-0007vp-Iv
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 12:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760094Ab3GSKCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 06:02:11 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:50591 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759996Ab3GSKCK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 06:02:10 -0400
Received: by mail-ie0-f177.google.com with SMTP id w15so770236iea.36
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gAEQtC6slZIX2EF+4F9Gklz0QkDhKss83wbPbGmYo4k=;
        b=q/USXp1WoAV2kwfAdb76aRKSEiRMUdgNz5cVnuH+MT0u3gY63vVBIr3MV0kflZYGv8
         bjcO4ZkqprRtSxdsT/8ehaukPvm0qZ4+ujVQr9zXRyAYYGvJJOBvpm7sVdb5yBzG+tq9
         3hBDXNe/x5kWv9h3DHzLpCypsiiEWgWQCQ56vRiAaZekJ/gVnnSPpumT51S9bcdTvZ5H
         gnz03Oceq+73zmRHKgKDxqLp7GW56sUH/FuLyemFjjbYA992n8Ma6q29IjPpKaSMAIv3
         OMad3yjo1yWMEfRJE/K/773v3+Uucuc2aNXzGCQGfK98e9qoBwDMQVnV2CDB9Vm8t5Jp
         IUkw==
X-Received: by 10.43.118.136 with SMTP id fq8mr9283248icc.101.1374228129463;
 Fri, 19 Jul 2013 03:02:09 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 03:01:29 -0700 (PDT)
In-Reply-To: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230787>

Allan Acheampong wrote:
> I could write a script with for each in but thats way too much hassle

  $ git for-each-ref --format="%(refname)" refs/remotes/origin/ | sed
's/refs\/remotes\/origin\///;/HEAD\|master/d' | xargs git checkout -b

(completely untested ofcourse)

Do you see what the problem is immediately?  There's nothing special
about "origin": I could have branches with the same name on several
remotes.  Without detaching local branches from remote branches, there
is no distributed workflow: your central workflow is just a special
case.
