From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: bug: compactionheuristic config var case issue
Date: Wed, 15 Jun 2016 19:33:31 +0700
Message-ID: <CACsJy8Dp_s9avkkA4x=EfTjkObBNF8sB3zhkdgXmjkipDNdvNw@mail.gmail.com>
References: <8C006106-EED2-48B5-B9A5-6FCEB64597C1@bravo5.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Lalor <blalor@bravo5.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 14:34:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDA1H-00030n-U0
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 14:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbcFOMeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2016 08:34:04 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:36601 "EHLO
	mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbcFOMeB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 08:34:01 -0400
Received: by mail-it0-f50.google.com with SMTP id a5so103621139ita.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+0fUJNgZ0NAWyr87TI3sjdmUEgBtdPlrW3TU+iUoK9o=;
        b=z4g7v1wB2T3sd8pvdDZe62oAZEfcaR3DFfpm515BbTDLDflVsp/pGxEGbqAzmolcoq
         jAYyr5jRU/IRvovfIKqCuhc/Z5YZu74rEXVJYgpEBGs7GTxsE2y6e8l6DHSpScxKWeCV
         ekfRE0VHTQuL8+GzYChUgSw+e8mPhwartXXMNgaqxHAQXLl8opQ7cQkszbjEVRiR+4Ek
         7osF09gz+LOUDE7N/B7MJIRQddhings5brqBhpM9rzrqgSsxfo92SlBr5DvFd0H+LcGB
         cJltNImCG33XEJ2p/auf+7oeaJWGMF2618pOMXMnZOHtQxZ8sT418Jujf/Y8abg3YVtD
         LkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+0fUJNgZ0NAWyr87TI3sjdmUEgBtdPlrW3TU+iUoK9o=;
        b=E5vPB5L+uCkx1FFDzLLO41xY5N11FiEPAlkL4LApHZbCAcyqZM/aUltGXPQXLZrTxd
         wkz7lGeWBh9m21MuvjmHhxrVGk7moNgnCiAgR1TtNdPa5OhPTEdFb3mvnFYQkTOtktNj
         8+INcVY6JkgiuKRRcCs5nmyT24FduOiNHvJa0cOYx6hKNeJUt8W6w84T48mh344In0kY
         +ksworbjN5lSjsCNsSnLyqdy/o57u+NK/87y+tWtC1ZIaJRC4gdMUb99AjYQ8ERWJrFG
         hSAQ4vPbm0ef6aGdpjXVjKcTFzsaFZkEbxGEnDZXLXckdooV9lwro46BUHWhPL1i52xC
         GN7w==
X-Gm-Message-State: ALyK8tKzfVblw3iinPlJBW351xoYXvz+ZVGBbqewciJHncNyGMk+00RPEOVAAWaBm9ouWS+EKVb+w0VdlT+qyg==
X-Received: by 10.36.43.200 with SMTP id h191mr16758773ita.57.1465994040749;
 Wed, 15 Jun 2016 05:34:00 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 15 Jun 2016 05:33:31 -0700 (PDT)
In-Reply-To: <8C006106-EED2-48B5-B9A5-6FCEB64597C1@bravo5.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297369>

On Wed, Jun 15, 2016 at 5:39 PM, Brian Lalor <blalor@bravo5.org> wrote:
> I=E2=80=99m very happy to see the new compaction heuristic option; it=
=E2=80=99s the way I always thought diffs should read!
>
> The config option in the documentation references =E2=80=9Cdiff.compa=
ctionHeuristic=E2=80=9D, but diff.c does a case-sensitive comparison on=
 =E2=80=9Cdiff.compactionheuristic=E2=80=9D (note the case of the =E2=80=
=9Ch=E2=80=9D in =E2=80=9Cheuristic=E2=80=9D)

I think this misled you. All configuration variable names are
lower-cased before they reach that strcmp() call, the whole picture is
more like strcmp(tolower(var), "diff.compactionheuristic"), which I
believe is correct.

> and `git diff` does not honor the config.  Confusingly, `git config d=
iff.compactionheuristic` returns true when diff.compactionHeuristic is =
set in ~/.gitconfig.  When diff.compactionheuristic is set to true in ~=
/.gitconfig, the desired behavior is achieved.
>
> Thank you all for Git: it=E2=80=99s hard to remember the terrible wor=
ld we lived in before it existed. :-)
--=20
Duy
