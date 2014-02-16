From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 0/3] Wider exposure for index-v4
Date: Sun, 16 Feb 2014 11:37:39 +0100
Message-ID: <87wqgvmjgs.fsf@hank.lan>
References: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com> <CACsJy8BDerqeua6zjGhniy_kxruDk9WuTJY-2zi6m4EpE9=CBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 11:37:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEz6Y-0007dc-Pt
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 11:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbaBPKhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 05:37:38 -0500
Received: from mail-la0-f47.google.com ([209.85.215.47]:61306 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbaBPKhh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 05:37:37 -0500
Received: by mail-la0-f47.google.com with SMTP id hr17so10456057lab.34
        for <git@vger.kernel.org>; Sun, 16 Feb 2014 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=FarYJQrvKanq0XIJodppKcJeZqJ0nSjfzHmQbhsi3u0=;
        b=sDaiV7k15bjLD8eS1kEUEkwUVyQos07w/ZtYFt3gq/MYUO7JZd0kl9D54uI9MsjI2i
         f6NDVvj7zbZuTzPM3JtHEmOelwpQ+oXoFPg/q79V88TUz3Dazq8ouyLCgBLFt857c8Rj
         LixunWJVGrle7sYVcGWP9BhgnfkOMm+mBGoYl9EjlR8aHJyILAmFU5u90UFUUqS2cGHw
         3dLFjF69hp39akYSs6vm3HapH56lN63Nm+KcG0Q2fwFzO9hNM3pd+RRbd3FV+L3sTcWD
         6Ygmu9A6NCQ08LmJxtuNqyVOeFEGXemDkMrZEIh731Tr/2bsbaB91HfOrbxSJSWTbZor
         LQ4A==
X-Received: by 10.152.161.234 with SMTP id xv10mr1173288lab.41.1392547055239;
        Sun, 16 Feb 2014 02:37:35 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id bl8sm13802258lbb.3.2014.02.16.02.37.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2014 02:37:34 -0800 (PST)
In-Reply-To: <CACsJy8BDerqeua6zjGhniy_kxruDk9WuTJY-2zi6m4EpE9=CBg@mail.gmail.com>
User-Agent: Notmuch/0.17+57~g9c1bc97 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242218>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Feb 16, 2014 at 2:23 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Hi,
>>
>> since index-v5 didn't seem to generate enough interest to be merged, I
>
> I thought there were some comments last time that you were going to
> address and resubmit?

Yes, there were some comments to the last round, which I already fixed
locally, I'd just have to rebase it to make sure it stell applies
cleanly.  No responses from Junio to [1] and [2] gave me the impression
that it's not going to be applied.  I would be happy to rebase and
submit if there is a chance for it getting in.

[1] http://thread.gmane.org/gmane.comp.version-control.git/238414/focus=239065
[2] http://thread.gmane.org/gmane.comp.version-control.git/232488/focus=233504

>> have a few patches that give users users easier access to index-v4.
>> Until now users have to go into the source code and compile git
>> themselves to use index-v4 by default, or use git-update-index to
>> change the index file to the new version.
>
> Not objecting this, but I think something like [1] would give v4 more
> exposure. Reading the patch again, I think putting that detection code
> in unpack_trees() or git-merge may make more sense because people will
> be advised about upgrading to v4 at the next fast-forward.

Thanks, I forgot about this patch.  I still think at least the first two
patches of this series make sense in addition to your patch, allowing
developers to easily run the test suite with index-v4.

> [1] http://article.gmane.org/gmane.comp.version-control.git/216307
>
>> With this patches it's possible to set the default index file format
>> either in gitconfig or in an environment variable.  It also simplifies
>> testing index-v4 by adding a Makefile knob to use it for running the
>> test suite.  For safety, existing repositories are not changed when
>> the environment or the config variables are set.
>>
>> I'm not sure about the precedence in patch 3, right now the environment
>> variable has precedence, but it should be easy to give the config
>> option precedence over that.
>>
>> Thomas Gummerer (3):
>> introduce GIT_INDEX_VERSION environment variable
>> test-lib: allow setting the index format version
>> read-cache: add index.version config variable
>>
>> Documentation/config.txt              |  4 +++
>> Documentation/git.txt                 |  5 ++++
>> Makefile                              |  7 +++++
>> read-cache.c                          | 36 +++++++++++++++++++++++-
>> t/t1600-index.sh                      | 52 +++++++++++++++++++++++++++++++++++
>> t/t2104-update-index-skip-worktree.sh |  2 ++
>> t/test-lib-functions.sh               |  5 ++++
>> t/test-lib.sh                         |  3 ++
>> 8 files changed, 113 insertions(+), 1 deletion(-)
>> create mode 100755 t/t1600-index.sh
>>
>> --
>> 1.8.3.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Duy
