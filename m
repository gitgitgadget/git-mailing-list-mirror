From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/10] Convert struct ref to use object_id.
Date: Mon, 15 Jun 2015 15:13:57 -0700
Message-ID: <xmqq4mm87h7e.fsf@gitster.dls.corp.google.com>
References: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
	<1434233803-422442-4-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 00:14:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ce3-0001b5-2r
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 00:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbbFOWOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 18:14:14 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38146 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993AbbFOWN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 18:13:59 -0400
Received: by igblz2 with SMTP id lz2so1632752igb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 15:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jDntLu8V1OEabYvqlMirYozUBwcQYZW2j9o8E1DQ0WM=;
        b=PKivZ1zA677pusD0ovWXTKtE7ii93JvlvM00WJfmJjqPoHMrA+QXB1gKjssaPB9TdK
         Ol6SI5YzW/qtFqX5fHFKpsf71uHR7WDJh0EphuUqWNvlV5yedEb/1W0QybnTcerSeAQ/
         22BTuXVcDyB09Z/59fijOvSppjT1d5YGTqKhnfjjfy9sD5+Xwrr8LXt1RlGACvT2cwJV
         HHLk3maXHQAsKMAgASaFazf4VuD1An1Oln2MOdrQoMyjQdhCsqyRIcAsYgQbgz2aG8Xa
         Lgvy4Iz84F1+E26MIa8FLIa34ETdvPbXupe0FXr1mt9DVxfRugzGbJc4JVdY8BErNymi
         piFw==
X-Received: by 10.107.10.151 with SMTP id 23mr467144iok.89.1434406438753;
        Mon, 15 Jun 2015 15:13:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id i7sm8511358igt.18.2015.06.15.15.13.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 15:13:58 -0700 (PDT)
In-Reply-To: <1434233803-422442-4-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sat, 13 Jun 2015 22:16:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271737>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Use struct object_id in three fields in struct ref and convert all the
> necessary places that use it.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/clone.c        | 16 +++++++-------
>  builtin/fetch-pack.c   |  4 ++--
>  builtin/fetch.c        | 50 +++++++++++++++++++++----------------------
>  builtin/ls-remote.c    |  2 +-
>  builtin/receive-pack.c |  2 +-
>  builtin/remote.c       | 12 +++++------
>  connect.c              |  2 +-
>  fetch-pack.c           | 18 ++++++++--------
>  http-push.c            | 46 +++++++++++++++++++--------------------
>  http.c                 |  2 +-
>  remote-curl.c          | 10 ++++-----
>  remote.c               | 58 +++++++++++++++++++++++++-------------------------
>  remote.h               |  6 +++---
>  send-pack.c            | 16 +++++++-------
>  transport-helper.c     | 18 ++++++++--------
>  transport.c            | 32 ++++++++++++++--------------
>  transport.h            |  8 +++----
>  walker.c               |  2 +-
>  18 files changed, 152 insertions(+), 152 deletions(-)

Whew.  This was a big patch.

I've eyeballed it and did not find anything questionable.  Thanks.
