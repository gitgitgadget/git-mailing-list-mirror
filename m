From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Mon, 21 Sep 2015 09:48:48 -0700
Message-ID: <xmqqpp1bbtvz.fsf@gitster.mtv.corp.google.com>
References: <1440157010.1759.83.camel@transmode.se>
	<CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
	<1442245035.10125.18.camel@transmode.se>
	<CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
	<1442508864.21964.26.camel@transmode.se>
	<CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 18:49:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze4HG-0004DI-Sy
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 18:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbbIUQtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 12:49:11 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32953 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756686AbbIUQsu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 12:48:50 -0400
Received: by pacex6 with SMTP id ex6so121297226pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wE2Fvi0o5T2a4xTTTurvQ4QSng5KhuX8/jKEumz6rNY=;
        b=MpaaWYtLlz0wiFUtlLEpiA7ZU4MgZCsvT8aawiln8/gdQCBWNhwrDmaDfNASfCcEGH
         WPIcd0K+kJJxMCC81vf5KFnemgxCI7kC/IOcr0zj/JXDDJjZaMNR4YubjM5fYDW2VLIB
         7ZkhiFBT8n0sWEmijrhPTWTm55DwqvyjCNWhtyS1ILbuTs+j3aBdJnp5HPY507sbthVW
         5Ee+getBj93vMVaxqfQVsYHtcs/+ytSZO9ikTMuLcu/pPvKjkFz5inph1XzQRRjU1116
         1zQPGFGK9FXu+/9+WuJag8CoaOPy6hyd7c32AWz3Dh7HWTHxZQuz6bU6umkLBtNPZJfq
         5Kbw==
X-Received: by 10.68.200.40 with SMTP id jp8mr26512945pbc.16.1442854130287;
        Mon, 21 Sep 2015 09:48:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id qa5sm11446054pbc.70.2015.09.21.09.48.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 09:48:49 -0700 (PDT)
In-Reply-To: <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 19 Sep 2015 09:21:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278309>

Duy Nguyen <pclouds@gmail.com> writes:

> Is it really necessary to remove write access in $GIT_DIR? Do we (git
> devs) have some guidelines about things in $GIT_DIR?

Those who are allowed to "git push" into it should be able to write
there.  It is a different matter that "git" program itself may make
a policy decision to disallow some operations that the filesystem
bits alone would have allowed (e.g. you can arrange the "pusher" to
only come over the wire via "receive-pack" and "receive-pack" may
deliberately lack support for writing into $GIT_DIR/config).
