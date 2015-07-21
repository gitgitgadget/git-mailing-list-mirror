From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 6/7] update-ref and tag: add --create-reflog arg
Date: Tue, 21 Jul 2015 09:42:13 -0700
Message-ID: <xmqqio9dwjh6.fsf@gitster.dls.corp.google.com>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
	<1437493504-3699-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 18:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHacc-0000Y0-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 18:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058AbbGUQmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 12:42:16 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35919 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655AbbGUQmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 12:42:15 -0400
Received: by pdjr16 with SMTP id r16so125567927pdj.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8EEhMw7bSAmDmi87KvZ1hYJEsc8noPriabi6eBSayTo=;
        b=rUwqOegfro2VgDGsjcXg3qo/d8m1hnycSNBiZbgAPWi25jVpH5e6Rzjr6LzlKfRVDD
         SHIrPnnM2Ez4HkCGaKlG6xA+FsdHW0Z/NXOQDyobXI2d7+jzL34+woLpleur/6HEFBN9
         gLAMFlUTNHgf3I8SOIT70GKSShdM5cJ9Hwx5T4ZUqUnFIZjgTMB1psyHajzTVbhy/8GZ
         xqX3Wq1OFDhU1mmQcVe266o8GkBuGq+FKMhhL0ZiC6dLNBgSD4FpgmwvRYMLvHhiLF6p
         d2PMyf3J/ATCQXfA9qo0+0J5N+V3hPpjU5eCxEEW9578KjVFYD6K5JEuUuG/dZv242WR
         cjCQ==
X-Received: by 10.67.5.2 with SMTP id ci2mr73719704pad.97.1437496935478;
        Tue, 21 Jul 2015 09:42:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id zj15sm28521229pab.1.2015.07.21.09.42.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 09:42:14 -0700 (PDT)
In-Reply-To: <1437493504-3699-7-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 21 Jul 2015 11:45:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274389>

David Turner <dturner@twopensource.com> writes:

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 6763cf1..d9646ef 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -14,6 +14,7 @@ static const char * const git_update_ref_usage[] = {
>  
>  static char line_termination = '\n';
>  static int update_flags;
> +int create_reflog_flag;

No need to reroll only for this, but I'll s/^int/static &/; while
queuing.

I may have more comments later; this was found in the first pass.

Thanks.
