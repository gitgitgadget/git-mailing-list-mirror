Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8B720189
	for <e@80x24.org>; Wed, 22 Jun 2016 12:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbcFVMWW (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 08:22:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:57996 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbcFVMWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 08:22:21 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MLO9y-1bF8vV1e5q-000cTr; Wed, 22 Jun 2016 14:21:27
 +0200
Date:	Wed, 22 Jun 2016 14:21:25 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 1/9] am: stop ignoring errors reported by
 log_tree_diff()
In-Reply-To: <xmqqporapdu8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606221421000.10382@virtualbox>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de> <e1d68fa14e7938f7e3a07bb85db28aa84017710d.1466505222.git.johannes.schindelin@gmx.de> <xmqqporapdu8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Z26tf5q36Mwpi/PnEH/yvdu0xCUWwqDT5wETsLjSMX902X6SaJR
 BMSDEbjfqGg2BZBjyGffsm3VZ2ICzhN1iC3PFAzArv+YFK3jvh8RGm0xRBk2YiSd9pc78U8
 /DpvAt6otrxhs0soCiyDdGWQS8ulSWySblUQ53Y3KIevRj8BeEbjza56tt6PjxZSU0mu9VN
 CNV4gjuSKvVMHfIXiHptw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:HRexotgJ+q4=:LvkoYhnjje8AQehGwm6W47
 aP4CvV7q9eXGG5fYmYBQp3Fze7aNU6E7Mfx0Mv+JabraIAhOQ0o7xYWgmtlZ4gd1zYW1Vu/K0
 Kq7mnLfSJWAs4tOeGOXny1qNyEapbZgHXyZ6PZap4zYlqhxSiwQ/nNYhZZ44JgRAj94laqatZ
 PpPOH26IsBy8dpwP2q5IyzEFQof9G+SlVm522T1ClmfIqSTFKoPhCbJXqaduEJVeff7xeOe53
 nvk2j8YlVgZKCr5D2K5ebLvZrs9EmSMysnBnxl1SOfpYSuyD4K9PMoflj0A7Jc/BiCnFLV4DY
 PD7NGij/MUge3jYbMega1LtHSrdFM/bxKRlPwEMgHMijJ2GLUm15nwdbWorXdOYhxCaGxcWek
 BGt6YffhRvCRCsnhLzFyQU5IUOhmW3+EdheaPYxKhAjT+r+x0sv1F60JGd6ytCtOrQTiMq3Oq
 101NSILAWcDs2v9kixHqgAeiXhAy6ZbZN+RjMVCeLpJDc2ejquJoWwKyEHgOwOWKSrHb/cR8B
 lYVknl3g/rn0LI3GZLrvCgT8aPQOKBjkx4OZMlvJrTXVWyjsFfSwW0gy71PxAkwiozPNq+wos
 CIA4hbu91rQ7YHZDw3tq5iIj9/xuFwXjlk24YYPOmU9zECDGeYa1ojYa2lHVNSky9zd/R3uHS
 B+eMMD4CjdICyE5G7+zPp0YbNFJ0qVZ1u9DUTqhbHiqv5psDwUZO7a8ifh8zBVhgmALxYFarr
 Zds4YSRYoMtN8DZQ5AqSgOC7YUK+O7Sd0sTXUG9PW493YR71J5Yccwx/WBJ7Dg7NqizCv/KKI
 3DdyBSy
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 21 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Note: there are more places in the builtin am code that ignore
> > errors returned from library functions. Fixing those is outside the
> > purview of the current patch series, though.
> 
> The caller of parse_mail() and parse_mail_rebase() is not prepared
> to see an error code in the returned value from these function,
> which are to return a boolean telling the caller to skip or use the
> patch file.  At least the caller needs to notice negative return and
> made to die/exit(128), instead of silently skipping a corrupt or
> unopenable patch, no?  Otherwise this will change the behaviour.

Yeah, that is another rabbit hole I really do not want to dive in.

Will leave it alone,
Dscho
