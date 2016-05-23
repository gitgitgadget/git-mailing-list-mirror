From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/5] worktree lock/unlock
Date: Mon, 23 May 2016 16:23:41 +0700
Message-ID: <CACsJy8BTHg8bkZqpaJ5XtZBxK5ZR4kJu+oNwd8sRULBeEdDW=A@mail.gmail.com>
References: <20160510141416.GA22672@lanh> <20160522104341.656-1-pclouds@gmail.com>
 <CAPig+cQVaMOKtbUCWdZqYDO8ZUZkVcSJH14S=2xrZiDVJ59Xdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 23 11:24:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4m6D-0001vd-Gs
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 11:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbcEWJYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 05:24:15 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35490 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbcEWJYM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 05:24:12 -0400
Received: by mail-ig0-f176.google.com with SMTP id bi2so30028913igb.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=avynRbPR9IBdLQuRmy/sI4bHV2ZcqPqxG/BtmGgUXAA=;
        b=kaM0pYs2eyauiRjcMB6E0Fth31AtqPFJ3OaZTwIqBLoWzlOwCaKENqmcch/bNrawSi
         t6Uo1cIXkata84abFrn5WNgQ5VnOfChi0RFgNTjNlWw0UT1DV/WL2YAdZvF8qC5wZGqm
         kefz7ScegkTeCID9husz5dp2W8VpjbWi0kfko+js2peN/zBXu8o1iBqrmhl1pZrZQ6wC
         okTwhmKvignaKdRo3wWjWmyGUGh89D5EH/nP7wui1STHvJqOyFGME1Yc9DJcPNIWEYi/
         8Z/EwE5hb5jtHh7WM5AtGFf3omDIpPnkW4/fYfERudiOH32cSI7Iy5ZxztbfWhWnHSWg
         dEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=avynRbPR9IBdLQuRmy/sI4bHV2ZcqPqxG/BtmGgUXAA=;
        b=aPCM0gerL+ewxW0yICH8G8pWWg8IEcnIaLa06pL4PwX4+KrOxQOPtBPbjfvU1NReeg
         1EWtn9SgyINnmx1htChAuLs3xmKmK72LEM08O5+nhptQWPeAFEM6VCr7QWbkEI5e0Rdy
         hdf0cojLKdmFWB1lNpklf3TniHWVB29THn2ViJl1s6i0voSr0rsvcKX5ftHPm6aR85UU
         N2BVRNu8nNTIMbfhL13rV1ZVm6JrQVU39+Ik3kxMoafLOcFcU2SRsnB0AxX79d02R9MC
         Zr9SnMfy0UCivxDyVwweqLut40oW58O6yCoKbtaPUuoKur7vX9W98CjLADAiMMX0SB1Y
         6EfQ==
X-Gm-Message-State: ALyK8tLIcelAsN3Z5pKHawKA3MhZDhypPMuVlMTv9wMH482eJnFskmfaBGqJAi0AJkJiK3BOn8gFDCkbdUaBMA==
X-Received: by 10.50.60.228 with SMTP id k4mr3768980igr.27.1463995450949; Mon,
 23 May 2016 02:24:10 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Mon, 23 May 2016 02:23:41 -0700 (PDT)
In-Reply-To: <CAPig+cQVaMOKtbUCWdZqYDO8ZUZkVcSJH14S=2xrZiDVJ59Xdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295313>

On Mon, May 23, 2016 at 11:51 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> On Sun, May 22, 2016 at 6:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> This should address all of Eric's comments (thanks!). An extra chang=
e
>> I made is free_worktrees() at the end of {,un}lock_worktree() to avo=
id
>> leaking. This series depends on nd/worktree-cleanup-post-head-protec=
tion.
>
> Thanks, this addresses all my comments from the previous round (aside
> from the suggestion to add a 'locked' field to 'struct worktree' and
> populate it automatically, which you elected to defer for the
> present).

If there's another re-roll (likely so), I'm tempted to do that too as
it's quite clear now that "locked" belongs in struct worktree.
--=20
Duy
