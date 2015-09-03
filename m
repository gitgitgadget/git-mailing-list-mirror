From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/43] refs.c: create a public version of verify_refname_available
Date: Thu, 03 Sep 2015 16:08:56 -0700
Message-ID: <xmqqk2s7gkxj.fsf@gitster.mtv.corp.google.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
	<1441245313-11907-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 01:09:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXddO-0004ZF-3n
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 01:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757161AbbICXI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 19:08:59 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34501 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbICXI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 19:08:58 -0400
Received: by padhy16 with SMTP id hy16so1755441pad.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nA/44aDKjPaXyjXFrqCfcrH/CAhrVzHpzpIDqHU0sTw=;
        b=aVYwudRAx0K1wXrN20N0q5rYG7dtPQBMz5gYI+PU8gVqcYjAFGdKQxryfx6KahDFCv
         zdwZjTH05xdvThF7CgWfWIJ+U93Lc+OUwt2A2tVymbS+oKDk3wkol+ewCALekarsYd4M
         IB1khOPyhuQQcExhhpvvwiO/eCLZXEolOXM4j0bXbjypg8teLJcGpaBtVjTHLXqQoz96
         J3ICtxduCXfHOv4leYH5Q2/r16GZxt54Qf0VyM/qInjrYgcZU2QcvTbh6qDyFdaYZksW
         9EL07BmpcaR1XpgI7deg51VNKgX3W6dHxAr5lCcr9y4OMx9aHgJ19yi4NXBi8x7xXu1h
         KBcQ==
X-Received: by 10.68.221.198 with SMTP id qg6mr874963pbc.147.1441321737936;
        Thu, 03 Sep 2015 16:08:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id y15sm202812pbt.90.2015.09.03.16.08.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 16:08:57 -0700 (PDT)
In-Reply-To: <1441245313-11907-2-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 2 Sep 2015 21:54:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277278>

David Turner <dturner@twopensource.com> writes:

> @@ -2827,7 +2831,7 @@ int pack_refs(unsigned int flags)
>   *
>   * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
>   */
> -static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
> +int repack_without_refs(struct string_list *refnames, struct strbuf *err)
>  {
>  	struct ref_dir *packed;
>  	struct string_list_item *refname;

An unrelated change (belongs to 2/43) snuk in here?
