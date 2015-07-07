From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 18/44] cache-tree: introduce write_index_as_tree()
Date: Tue, 07 Jul 2015 13:10:30 -0700
Message-ID: <xmqqpp433f0p.fsf@gitster.dls.corp.google.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<1436278862-2638-19-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 22:10:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCZCS-0003pR-GK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 22:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbbGGUKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 16:10:35 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36202 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757731AbbGGUKd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 16:10:33 -0400
Received: by igrv9 with SMTP id v9so184872223igr.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=4u9z+aFEj6K8rS07Ddh9skYh2q6mr3n5DQGnjc0pt5U=;
        b=QVr08sHFNHx0IhRs1pt3ypn83lISk/ZRtOiBdTEWqOZjaFE6B0wEs/9IViwI6A2g/w
         56BxBWUgOvLFd91Vubj1qlG8dQCkKEm3rtsFGcmQNHIfAmee1oFAXzKKEZaVBpTjAClC
         hPJK4opZFNbEbUL4zjp3zIF/oqOYTiX6XlTAs7V/T9Oz8461xTC4A32VBO+/mzqIzXj5
         WIHhM0c6CjF2WQwfbMb/ZUurZWlkxSJ3A3MRTbK71fFn02e8KgnZjjVMknLdTe/BpBKW
         ok83ELrbhlOy3ip6WK+vK+dPaMOfF9T+38m7ynTJSfg5t4NQGXl0WdoSGwsPd3EhnG5u
         e1VA==
X-Received: by 10.107.8.7 with SMTP id 7mr9610886ioi.15.1436299832305;
        Tue, 07 Jul 2015 13:10:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id d8sm250299igl.19.2015.07.07.13.10.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 13:10:31 -0700 (PDT)
In-Reply-To: <1436278862-2638-19-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Tue, 7 Jul 2015 22:20:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273597>

Paul Tan <pyokagan@gmail.com> writes:

> A caller may wish to write a temporary index as a tree. However,
> write_cache_as_tree() assumes that the index was read from, and will
> write to, the default index file path. Introduce write_index_as_tree()
> which removes this limitation by allowing the caller to specify its own
> index_state and index file path.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  cache-tree.c | 29 +++++++++++++++++------------
>  cache-tree.h |  1 +
>  2 files changed, 18 insertions(+), 12 deletions(-)

Makes sense; thanks.
