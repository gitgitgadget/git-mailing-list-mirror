From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Mon, 22 Sep 2014 17:50:01 -0400
Message-ID: <CAPig+cS9oa+9U3RQgaQ6iTxO0QBOATSU4b426fwcpS2GFJWDpQ@mail.gmail.com>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
	<xmqqoau7js6a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 23:50:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWBV2-0003ok-1I
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 23:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbaIVVuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 17:50:05 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:33037 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbaIVVuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 17:50:04 -0400
Received: by mail-yh0-f47.google.com with SMTP id t59so2328425yho.34
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0TwoqRKvHqnNZdlHmSrRfmJ2/tp7v23adFekh5wbvls=;
        b=ZG10FkIwsYCThnIX2VYFpK1BXE2R84L05bFvuSUQaFPl5ZAVxcMnhhtGUPOSytuiFp
         pFD9vBeY0hkpA67YCPUcWaJXzqqh5N+XmJy4gH/uEWFM1pQE8VkWOY+A0JwMdUQipXgE
         BUXa7lLpwZLKd9F6hIh8t07pmiHZYSlJh2qkNBY2vuCxC5ftTHE3XvuxMyd4NT/oGBS0
         scPgOzBEB5eY3uFgvcevpNbeGgxRe3NN4CdtdLqS1iZsA4+m6ac6aI5sU12ljoasGrNY
         KX5NQNnnl7VishJjj+q09b8NQieaaruADVMcc9cpVn6mqmYex7O4+vvPcLN1J+Yw9KX3
         H9rw==
X-Received: by 10.236.140.11 with SMTP id d11mr29358468yhj.16.1411422601785;
 Mon, 22 Sep 2014 14:50:01 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Mon, 22 Sep 2014 14:50:01 -0700 (PDT)
In-Reply-To: <xmqqoau7js6a.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: bqDQXiaoz9NMAEd_cYae7HmAnUY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257387>

On Mon, Sep 22, 2014 at 4:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> however, the solution in this patch allows us drop a couple strlen()s in
>> favor of sizeof()s.
>
> It is actually not a very good justification when you know you care
> about the length of the string.  A decent compiler ought to know the
> length of a constant string can be computed at the compilation time.

Indeed, which is why I mentioned this only in the commentary rather
than the commit message; but I was also thinking of some of the
less-than-decent compilers with which git is sometimes built.

> Let's at least not do that part of the change.

I don't have strong feelings about it.
