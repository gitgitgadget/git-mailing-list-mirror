From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: [PATCH v3] Add an explicit GIT_DIR to the list of excludes
Date: Tue, 27 May 2014 10:16:04 -0700
Message-ID: <CAKpPgvfqTBxFXOaStEyyS7wAdR5aUsEOX_M2gPvGz4_dJYvTOA@mail.gmail.com>
References: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com> <CACsJy8CDeTn8h8uUn_=6ek7BJueN_1i01TB_AeH03RKnf6tNSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 19:16:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpKzG-0005ZS-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 19:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbaE0RQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 13:16:25 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:62506 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbaE0RQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 13:16:25 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so10924779veb.26
        for <git@vger.kernel.org>; Tue, 27 May 2014 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P0hpmxrt+qZlTqmgcEjFzYmqxepAlz3AicK/sw9Q1Aw=;
        b=UqDQfRJUiI0l2s8SGgEsyovE1kEl2PbX0+lTaXHIvdA0VnT5PDA8NgyQePYE2RQkxp
         4ShUxm5cvnJ3c1PEQGXh1sXWNjhBDBjzEs7kO6Sit4Wjv7+2uemJWMh3jwGspFJYThKm
         snv0pKONs9AnC2drjgyMhfBICFoxdXv95N8dG4WIqvS6gNd7hMcRCyZXKjiCibYYz844
         cpqFI/MiBrKDh9Qi9y8uqs+CWDA02X9x7yY35XhCYCC6aT6bBvIn7AAygaTu15ek8WAO
         nScE5xn7/U4Omy04no2n9/cQ4k43an4MRU6u5cDqS2z6llOW/97bU1pIe7XwpJib563/
         c5ag==
X-Received: by 10.220.64.138 with SMTP id e10mr2194138vci.63.1401210984229;
 Tue, 27 May 2014 10:16:24 -0700 (PDT)
Received: by 10.58.234.129 with HTTP; Tue, 27 May 2014 10:16:04 -0700 (PDT)
In-Reply-To: <CACsJy8CDeTn8h8uUn_=6ek7BJueN_1i01TB_AeH03RKnf6tNSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250177>

>> Add GIT_DIR to the list of excludes in setup_standard_excludes(),
>> while checking that GIT_DIR is not just '.git', in which case it
>> would be ignored by default, and that GIT_DIR is inside GIT_WORK_TREE
>>
> gives git-grep.txt and git-ls-files.txt. I don't know if we need to
> add something about this extra exclude rule to those .txt. If it's so
> obvious that this should be the expected behavior, then probably not.

    I suggest this. There appears to be a notion of "standard
excludes" both in the code (dir.c) and in the man pages (git-grep,
git-ls-files). However, it doesn't actually appear to be defined
strictly speaking. So my suggestion is to define those "standard
excludes" in one place (say "gitignore(5)"), and make other man pages
(git-config, git-grip, git-ls-files) have references to that place
instead of explaining every time in detail what is being excluded.
Now, gitignore(5) actually does have this list of ignored items, we
only need to call it "standard excludes".
    If done this way, then all that needs to be done regarding GIT_DIR
is to insert it into that list in gitignore(5). Please let me know if
that'd work

Pasha
