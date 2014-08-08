From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 0/5] ref-transactions-send-pack
Date: Fri, 8 Aug 2014 09:15:59 -0700
Message-ID: <CAL=YDW=VTOVdjrUf2b_MDznsyUrBQg1xNx-AjWYQdKuP61Ta9Q@mail.gmail.com>
References: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:16:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFmpq-0003hM-HI
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbaHHQQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:16:01 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:60483 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976AbaHHQQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:16:00 -0400
Received: by mail-vc0-f180.google.com with SMTP id ij19so8431015vcb.25
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cW7ahdTFbCy09Zz9b369DNjy9iyGremhkWmr7pl/NyM=;
        b=ccAl2VAHixo2s97EhZ1376rjIvPOFb1f4YVs7yBLav55aDScP9JTaEVtLGMSqTelzJ
         dNAuGPVbVHBoxe5g67tP3DKzY34KsLNPiz4C0Q2676/TvoalxRdCw2AFiFJMf/Jp5Sp4
         P3KQ2bz2nwPv8Yds4klrVUVwaEtnQP1lrD84GTxwrpapIJKIdEJrRtyaPIMcG9TwSwTo
         6ZxOcStjN6I6bBikLIAE7oafQH09kSGvMmkKgQIW0f73l2sHacC9NBE4BreCICJv1ii7
         3+1ADZ+a5OTR7Uu7/q/3fa/oHkrfAq0B/gw/xzx8nvAbiayxPHhd4XsU2L8kgBil8DlL
         fUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cW7ahdTFbCy09Zz9b369DNjy9iyGremhkWmr7pl/NyM=;
        b=bti7bXrU+yPFeWDKJZq7o6h+ZiZTMI3VafnKpBMR6zOz7XX/UN5Wvcmore1V1zeYKE
         BmfhS5zWF9QxdqfnCJTC5U6zVqJuDT7yP8P+BfZPuwF1A8pwB+JXycf7Mrz22rfYZ1N3
         SVTSrsL7AnOODEdnrcLYnCC9lJRpUFgyg3TsdQOTLAw35SDzEQcBgbZ+xeqGnPVf8ap0
         ZjBUltIJeYN3qMn3VbQiDj6+oFV1gy6fr9TexJta3o6v4XT+GrbGrosxLc1UUDJr/N0O
         VVQSIbRvLyhqtrmUuWmx/daw8YIsFQDNyNoCfc/0P0HZfugrG+UtAWBBSUYvM9NYLRp1
         Xe1Q==
X-Gm-Message-State: ALoCoQmoWWm8Z/xMXdCAqdPnI7r/Hjsx5UbGVH2oVefa/Z54+BcrBb6hKqDWrJSl+WtlhOJRciH9
X-Received: by 10.221.21.201 with SMTP id qt9mr2501188vcb.39.1407514559293;
 Fri, 08 Aug 2014 09:15:59 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Fri, 8 Aug 2014 09:15:59 -0700 (PDT)
In-Reply-To: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255021>

Ping

On Thu, Jul 31, 2014 at 2:39 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> List,
>
> This small patch series adds atomic-push support to for pushes.
> By default git will use the old style non-atomic updates for pushes,
> as not to cause disruption in client scripts that may depend on that
> behaviour.
>
> Command line arguments are introduced to allow the client side to request/
> negotiate atomic pushes if the remote repo supports it.
> There is also a new configuration variable where a repo can set that it
> wants all pushes to become atomic whether the client requests it or not.
>
> This patch series is called ref-transactions-send-pack and depends on/is built
> ontop of the series called ref-transactions-req-strbuf-err
>
>
> Ronnie Sahlberg (5):
>   receive-pack.c: add protocol support to negotiate atomic-push
>   send-pack.c: add an --atomic-push command line argument
>   receive-pack.c: use a single transaction when atomic-push is
>     negotiated
>   receive-pack.c: add receive.atomicpush configuration option
>   push.c: add an --atomic-push argument
>
>  Documentation/config.txt        |  5 ++++
>  Documentation/git-push.txt      |  7 ++++-
>  Documentation/git-send-pack.txt |  7 ++++-
>  builtin/push.c                  |  2 ++
>  builtin/receive-pack.c          | 66 +++++++++++++++++++++++++++++++++--------
>  builtin/send-pack.c             |  6 +++-
>  send-pack.c                     | 18 +++++++++--
>  send-pack.h                     |  1 +
>  transport.c                     |  1 +
>  transport.h                     |  1 +
>  10 files changed, 96 insertions(+), 18 deletions(-)
>
> --
> 2.0.1.528.gd0e7a84
>
