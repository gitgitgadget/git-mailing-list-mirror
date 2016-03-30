From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Wed, 30 Mar 2016 07:53:58 +0700
Message-ID: <CACsJy8BAW0E36qKjJqvLL0ZHKdh3+7G1axt1jD46Yv3atfL7fw@mail.gmail.com>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
 <20160329203425.GA24027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elliott Cable <me@ell.io>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:54:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4P9-000118-85
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbcC3Aya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 20:54:30 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36028 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbcC3Ay3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 20:54:29 -0400
Received: by mail-lb0-f170.google.com with SMTP id qe11so21579053lbc.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 17:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GnHwMxfC4BxfgFiOYwghvVFjdUniERwlCimdOIH88Yc=;
        b=yXNMrXZDdruYt35mirltBzP6KVKlxolZtwv++5kLQkrIFyH3IsVDUTH7QxzZ0Z6zs4
         vQZzvxngFQTHvnKcAHiFrD+B6jW4F0y0jtEl/UzdvpmfnJXB8WwTqCaeqKRDzZ1s61S+
         7OS/WxJjc9R22UFi6XgsE83Gnp6FW7Y6SCXDhsXqtQDk46EXD5C1fEDyqXw90FxN+nl7
         bHXcbeUhZSHOVXJ+obup9er0SE9UaWZsZr2A2BaKcqWbU/OKqsefmf4+oHb5Hl3H3Itl
         9bJ+NzSn3KfXzG/opTS1FQrKJIP6jPcTimBt6Qk+DvivVPxD4vCxbyFiWnLn0t6bSNy8
         vufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GnHwMxfC4BxfgFiOYwghvVFjdUniERwlCimdOIH88Yc=;
        b=dqkXU43ciElh/OQhi30fwigy/gN905QfmWBLzPvHj4VdCryhD62+6Q6ptgTi1GybZT
         W/MS7rBTaKPadTUru7skCiVPbnJ9PBwTRAhCDf4X+uFvegonAr2LitPdmrR5RyRZaPl6
         u9O7pbNSYOZFY5wYV4CkQETmWmZRTZxAxsw5hJ8X5yFOxQo8b1Q6tXT9yp6SibVldc8i
         3qpPhEbdQlZGJDnG3XLwxAPQ7DZ5F5P8PaLC7V18IzvdGLg+lwvDLHM+/hyEf/bTZW8B
         t4EORpGYYDGow2gQE7nX1DGXbCNiihHZoJg9Vnxfzs2S7+uAwcpndKe8Ca4IYz8x9tS6
         jOKQ==
X-Gm-Message-State: AD7BkJJvmxbujYSrl2Rpq9UiGIBt5zs+BcRN2mwhnjulhnZC2gcsKM6iRSM2Jxgvky748uFGDgLOIAyeC8eFOg==
X-Received: by 10.112.209.99 with SMTP id ml3mr2462072lbc.26.1459299268137;
 Tue, 29 Mar 2016 17:54:28 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 29 Mar 2016 17:53:58 -0700 (PDT)
In-Reply-To: <20160329203425.GA24027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290239>

On Wed, Mar 30, 2016 at 3:34 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 29, 2016 at 06:42:44AM -0500, Elliott Cable wrote:
>
>> So, I find this behaviour a little strange; I can't determine if it'=
s
>> a subtle bug, or intentionally undefined/=E2=80=98fuzzy=E2=80=99 beh=
aviour:
>>
>>     $ cd a-repo/.git/
>>     $ pwd
>>     /path/to/a-repo/.git
>>     $ git rev-parse --is-inside-work-tree
>>     false
>>     $ export GIT_WORK_TREE=3D/path/to/a-repo
>>     $ git rev-parse --is-inside-work-tree
>>     true
>>
>> i.e. when within the repository (the `.git` directory), and when tha=
t
>> directory is a sub-directory of the working-tree, `rev-parse
>> --is-inside-work-tree` reports *false* (reasonable enough, I suppose=
);
>> but then if `$GIT_WORK_TREE` is set to precisely the directory that
>> git was *already* assuming was the working-directory, then the same
>> command, in the same location, reports *true*.
>>
>> This should probably be made consistent: either `rev-parse
>> --is-inside-work-tree` should report =E2=80=9Ctrue=E2=80=9D, even in=
side the `.git`
>> dir, as long as that directory is a sub-directory of the working-tre=
e
>> =E2=80=A6 or repository-directories / `$GIT_DIR` / `.git` directorie=
s should
>> be excluded from truthy responses to `rev-parse
>> --is-inside-work-tree`.

No. Once you set GIT_WORK_TREE you tell git that worktree exists. That
overrides the "bare repo" attribute (i.e. no worktree) that's
automatically set when we try to find .git directory.

> Yeah, I think this is a bug. Presumably what is happening is that we =
are
> too eager to "cd $GIT_WORK_TREE" inside git-rev-parse, and by the tim=
e
> we ask "are we in a work tree", the answer has become yes. But the
> caller really wants to know "am _I_ inside the work tree".

On relative GIT_WORK_TREE some mail down this thread, there's this
note in t1510 that you might find interesting

5. GIT_WORK_TREE/core.worktree was originally meant to work only if
   GIT_DIR is set, but earlier git didn't enforce it, and some scripts
   depend on the implementation that happened to first discover .git by
   going up from the users $cwd and then using the specified working tr=
ee
   that may or may not have any relation to where .git was found in.  T=
his
   historical behaviour must be kept.

Basically if you set GIT_WORK_TREE you better set GIT_DIR too to keep
things sane.
--=20
Duy
