From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 09 May 2014 03:36:39 -0500
Message-ID: <536c939781d8b_2bf0e952f08@nysa.notmuch>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net>
 <536c7f9089b77_182dd0d31084@nysa.notmuch>
 <20140509081507.GA26494@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>
To: Eric Wong <normalperson@yhbt.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:36:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WigIV-0007tq-0i
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 10:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266AbaEIIgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 04:36:46 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34885 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbaEIIgp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 04:36:45 -0400
Received: by mail-yk0-f182.google.com with SMTP id 9so3147142ykp.13
        for <git@vger.kernel.org>; Fri, 09 May 2014 01:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=6/ZosmeqowuiZNtGjvA3uYAvWNA5Kf2jNY4pcuREIZ8=;
        b=y6sbkxElN7LrrJOJoU5888DvQJyZCQjhQMywwfkyKfTWL61i5RxWU1CdLFmOB5XrZX
         nH6Yd0qbMGrQGtNsNao1h+FFNlE5RhoVnjWsHaL1qqXKh4B8etjERlvjZo5XbCHMkaO5
         EDhT2KPs8TEMOkpKIs2eXR5JDCcQ7OecrSbKnqsXeJj1nbEXtSBYidZG6NsTRpPBzCGh
         tOONNz7jmd05un3u/iow/PgyEz3QSuHGJlBcYhfXkWJMNQa4/NzUYTRkbx1oTiIWy1Rk
         ZY0Vux2Q3KTHl3LBZ/anRAZ9T28/8RuDQM5CUbgOnKEI/UUyyRQk29vsmn9AvzZOsrUG
         aniw==
X-Received: by 10.236.61.45 with SMTP id v33mr12900072yhc.20.1399624604495;
        Fri, 09 May 2014 01:36:44 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t27sm5232777yho.55.2014.05.09.01.36.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 01:36:42 -0700 (PDT)
In-Reply-To: <20140509081507.GA26494@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248534>

Eric Wong wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > Eric Wong wrote:
> > > Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > > > No updates since 2010, and no tests.
> > > 
> > > Who benefits from this removal?  Is this causing a maintenance
> > > burden for Junio?
> > 
> > It is cruft that nobody uses and we are not even testing.
> 
> We do not know nobody uses it.

And we do not know if aybody does either.

As a minimal token that anybody might possibly be using it, I would like
to see it work at least once. Since you said you have arch repos, can
you confirm that it does something?

> I have old GNU Arch projects I have not looked at in a decade.  There
> is a small chance I may use archimport again (whether for nostalgia or
> contractual/legal reasons).

 % git show v1.9.0:git-archimport.perl > ~/bin/git-archimport

Problem solved.

> Of course I know to extract archimport from history, but someone in
> the future may not know the existence of it.

If somebody cared, that person would add tests, or even better, create
an out-of-tree project.

> > > > Plus, foreign SCM tools should live out-of-tree anyway.
> > > 
> > > Even if so, there ought to be a transitionary period in case there are
> > > any users.  We would need to warn potential users of its impending
> > > removal in the documentation and at runtime.
> > 
> > All right, so you are OK with adding deprecation warnings whenever the
> > tool is run, and a note in the documentation?
> 
> No, I am not convinced existing foreign SCM tools should move
> out-of-tree.  Perhaps something like the following would be helpful:

Tell that to Junio.

If tools like git-remote-hg with tests and active maintanance and many
users cannot be in the core, why should 'git archimport' be?

Would you at least be OK with a demotion to contrib/?

-- 
Felipe Contreras
