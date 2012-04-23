From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tags not present in bare clone
Date: Mon, 23 Apr 2012 12:17:12 -0700
Message-ID: <xmqqsjfui7gn.fsf@junio.mtv.corp.google.com>
References: <0BE9553B-C799-43D5-BA9A-28FC83CA0773@linea.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>
X-From: git-owner@vger.kernel.org Mon Apr 23 21:17:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMOlD-0002dm-F0
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 21:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab2DWTRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 15:17:14 -0400
Received: from mail-gy0-f202.google.com ([209.85.160.202]:61719 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab2DWTRN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 15:17:13 -0400
Received: by ghbz15 with SMTP id z15so1369868ghb.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 12:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=bDyv1SwYR1i0IFHZAJyrf7wLlmCCoxuYfPkZRMwpuro=;
        b=NSnr7res05TUWgrdOsU1olJwYDvP6WkK1B2lYsGqNrPaoUlInFNY91yRkbxokbpXpi
         4CfIYuRFYIMFc67Nm1Wu+VJ7KKXUTtjxL1XUQr4HRWffnE4Mk0EhOtzw5euWa6sfeP9A
         vNSOSrvQEoaz2p7YjsbwXuytoBqL0AYeYmtiV6aJ7umXrcfROsFsqxBLZj+n4RmLKwBR
         xnczUyTyTbuop38kgW/VeZHstgXMN8ogDYS9/tMwK4DWljjgvKOWPNJSoIX1Wm8OaNDj
         JlI377iT8ry1Y8Ef0qRhNQHkwg5ZJcMjoyDOQlNGy9HVn/Q3HjdCb2UR+8BxQjqyMBPN
         6Qrg==
Received: by 10.101.11.36 with SMTP id o36mr6318801ani.2.1335208632919;
        Mon, 23 Apr 2012 12:17:12 -0700 (PDT)
Received: by 10.101.11.36 with SMTP id o36mr6318787ani.2.1335208632806;
        Mon, 23 Apr 2012 12:17:12 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id b69si15740898yhe.0.2012.04.23.12.17.12
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 12:17:12 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id B09D81E004D;
	Mon, 23 Apr 2012 12:17:12 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 5A6E1E120A; Mon, 23 Apr 2012 12:17:12 -0700 (PDT)
In-Reply-To: <0BE9553B-C799-43D5-BA9A-28FC83CA0773@linea.gov.br> (Patricia
	Bittencourt Egeland's message of "Mon, 23 Apr 2012 11:28:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmx/u1jtjgnfm26XxMz6GwfO+0JByhoO9FGZE3/gkpCkk/cgJAtjexO+ZSls1UNSdW7bdPCzxRYXjeHmczhlky7WzU9FGK6HqmuuCxVyLIs0+M/gkBv7pUWe41eeYF0WvWhSRCXB9BEErUHp7cthryFnajTprJfJ/pVmCOurZLOl3bM54w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196161>

Patricia Bittencourt Egeland <pbegeland@linea.gov.br> writes:

>        I'm trying to create a bare clone from a regular repo (all
>        locally; in the same machine). However a tag created in the
>        regular repo can't be found in the fresh bare clone.  I
>        expected that the tags would also be present just like anything
>        from "refs". Am I wrong about that?

Reproduction recipe???

A simple and straightforward attempt to reproduce what you said you did
in your message does not exhibit any problem.

    $ mkdir -p /var/tmp/junk && cd /var/tmp/junk
    $ git init src && cd src
    Initialized empty Git repository in /var/tmp/junk/src/.git/
    $ echo frotz >xyzzy && git add xyzzy && git commit -m initial
    [master (root-commit) b9c684a] initial
     1 file changed, 1 insertion(+)
     create mode 100644 xyzzy
    $ echo nitfol >xyzzy && git commit -a -m second
    [master 6982d52] second
     1 file changed, 1 insertion(+), 1 deletion(-)
    $ git tag -a -m 'First revision' v1.0 HEAD^
    $ git tag -a -m 'Second revision' v2.0 HEAD
    $ git for-each-ref
    6982d523f08b93dc6862ae80e80065b208d0ba85 commit	refs/heads/master
    33a6b315ffb461cba32d84ecd1692525a0846f5a tag	refs/tags/v1.0
    0d3f9dce20e28c6898423eb4a2c2010908e46a6c tag	refs/tags/v2.0
    $ cd ../ ;# back at /var/tmp/junk
    $ git clone src dst
    Cloning into 'dst'...
    done.
    $ cd dst
    $ git for-each-ref
    6982d523f08b93dc6862ae80e80065b208d0ba85 commit	refs/heads/master
    6982d523f08b93dc6862ae80e80065b208d0ba85 commit	refs/remotes/origin/HEAD
    6982d523f08b93dc6862ae80e80065b208d0ba85 commit	refs/remotes/origin/master
    33a6b315ffb461cba32d84ecd1692525a0846f5a tag	refs/tags/v1.0
    0d3f9dce20e28c6898423eb4a2c2010908e46a6c tag	refs/tags/v2.0
