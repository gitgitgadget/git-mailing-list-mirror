From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature: git stash pop --always-drop
Date: Mon, 10 Aug 2015 08:08:34 -0700
Message-ID: <xmqqzj1zuqod.fsf@gitster.dls.corp.google.com>
References: <loom.20150810T124037-407@post.gmane.org>
	<20150810124125.GC32371@sigill.intra.peff.net>
	<loom.20150810T144849-152@post.gmane.org>
	<20150810133220.GA3559@sigill.intra.peff.net>
	<loom.20150810T153939-856@post.gmane.org>
	<20150810134957.GC6763@sigill.intra.peff.net>
	<loom.20150810T155117-978@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:08:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOogr-0007CC-MM
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 17:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbbHJPIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 11:08:37 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35338 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbbHJPIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 11:08:36 -0400
Received: by pacgr6 with SMTP id gr6so28916946pac.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dHjKfuie+LSbnfny5ubZ0KnsoXYrVe0/QKn00fcWylQ=;
        b=uesooVWLrnet+zEj9k8eDZoduVg6Yo/++BQ0wtN8sLbjBZnWv/G7Ix+PpbNnWtgCi6
         Np5BB7/hsDBgWsj860m3kIubyJcsTwYp83qaSq7Fd0m+QYdJT+YZy7NIf6DdGxvAZiDO
         pFjENUFL8bHYAQJxPg7VDa6IHb3Y8DUeXgDicn6SxAvM5hn3C9Tz5MnN4fV03lwRNHym
         SDnvg0V1LAAH5+cCdzfBwQGqDscYE1Z7+Qj3Ozf1PxzQYLIjJs3xrd95dRQ+uEV6xV3B
         bMSkRCGWI8UhHnIuFFMm+ru+UUfkgdDxK91sCJo8WPJUW9oIcASyfyk80wq/uOlhG2sJ
         aQng==
X-Received: by 10.68.253.232 with SMTP id ad8mr46273460pbd.115.1439219316021;
        Mon, 10 Aug 2015 08:08:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id db1sm20313184pdb.50.2015.08.10.08.08.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 08:08:35 -0700 (PDT)
In-Reply-To: <loom.20150810T155117-978@post.gmane.org> (Ed Avis's message of
	"Mon, 10 Aug 2015 14:01:23 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275624>

Ed Avis <eda@waniasset.com> writes:

> Yes, my use case is that I get confused about whether the stash has been
> dropped or not and whether I might have stashed something else in the
> meantime.  So for me plain 'git stash drop' feels a bit dangerous.

Then "git stash apply" followed by "git stash drop" would be a pair
of good workflow elements for you, no?
