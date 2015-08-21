From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] am: rename "struct tree_desc t" to "desc" for readability
Date: Fri, 21 Aug 2015 09:51:41 -0700
Message-ID: <xmqqfv3c7ffm.fsf@gitster.dls.corp.google.com>
References: <1440144151-24026-1-git-send-email-davvid@gmail.com>
	<1440144151-24026-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 18:51:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSpXg-0004jq-V7
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 18:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbbHUQvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 12:51:44 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34013 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbHUQvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 12:51:44 -0400
Received: by pdbfa8 with SMTP id fa8so28511935pdb.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=STdRKHOI/Oc2Cyi8sP0aDQxe0BQ43TR+deb11OOpQWM=;
        b=z+DEuUOcuUuAFjWxPXHeeEwlRJ9EE+BwG3IqOSVv859YEDpXx2BctKgT/HcV+NA4jL
         NgUTNnH/UQWFR5v5VWcNGcEnP95T0hNSHUgS8XCCEJtS+GayksKGHqSUYjICAGyzPZyR
         fCFiQZGlkLSL7F9r6p2Q9ClO3dMKNXRw4BiJ7kMk9pf7HTNPunym6mtODDsXJFUh3jLo
         0tGcu34LVK1/By46ovkFemuUHXLbViy8xR1rWuDRn5GQ5jc+GBZUczTWi65hLPGBE1D5
         niOjvCXViTdHAja/aMkU7dCQzpZaeoD5wFbESFxt8RUcNQb6FqAwF2IkGsnIPx8tEa/U
         U3cA==
X-Received: by 10.70.129.79 with SMTP id nu15mr18697215pdb.15.1440175903091;
        Fri, 21 Aug 2015 09:51:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id e8sm8428622pdm.13.2015.08.21.09.51.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 09:51:42 -0700 (PDT)
In-Reply-To: <1440144151-24026-3-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Fri, 21 Aug 2015 01:02:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276311>

David Aguilar <davvid@gmail.com> writes:

> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  builtin/am.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Naming the tree_desc parameter given to unpack_trees() as "t" is
(unfortunately) an established convention, just like we often use
"i" and "j" in for() loop control.

Descriptive names are nicer, especially on the calling sites, but we
have quite a many hits from

    $ git grep unpack_trees\( \*.c

so perhaps do this as a clean-up patch after dust settles for all
the existing callers in archive, clone, commit, merge, read-tree,
reset, diff-lib, and merge-recursive?
