From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 24/34] checkout: reject if the branch is already checked
 out elsewhere
Date: Wed, 3 Dec 2014 19:50:31 +0700
Message-ID: <CACsJy8DLd4biEHo+FWYLqc4HKezHfv1ymWSQ8kLHLTQv=YKc3A@mail.gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
 <1417335899-27307-25-git-send-email-pclouds@gmail.com> <547B5170.6050206@gmail.com>
 <20141201103818.GA20429@lanh> <xmqq1tojqnfg.fsf@gitster.dls.corp.google.com>
 <547D487B.4040502@gmail.com> <CACsJy8DjbgNpbf9Z-OVCpv+YNmvsuHfcPW_Jfm3_gbq2VgYgkQ@mail.gmail.com>
 <xmqq4mtem029.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 13:51:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw9Oi-0000PK-SF
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 13:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbaLCMvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 07:51:04 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:38337 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaLCMvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 07:51:02 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so13795864iec.1
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 04:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=G+6s1f4AreEJ3bLvKgleF4kRcpGzWuaGmTrR4kZCfS4=;
        b=P+nIYXAh9yh3/Rf5vBuZSTl+mqrCY+fXiWrifPRsYTpzMV9/7+Y7owx7lTYFfFahCH
         ARqfhQovYDAIHGZGGhFjP8wSlnFinBzKi9TBo4heQaye8gWH8I8AKRgHkUa5QUEd6rMq
         t26KHDEB4tPjFWFJIgvkzBGqTrk4YlBAhmzkxsE5BBLgyWvcICVVEnVYvDBQZ/OBnbGj
         6e/i91L7qwGfp3hgQp4v1Q+F3OY2s1j/m8HFTR34FF7YCqueUBe0j0V+FjzjnXSPdWLR
         RfmoDm3Y3S4ZHaly4caerMfk3/f68vRPXxLIHpc0NlShNawZRnTy0p8hRAXo8PXLIGwd
         30kw==
X-Received: by 10.107.135.34 with SMTP id j34mr4286667iod.84.1417611061470;
 Wed, 03 Dec 2014 04:51:01 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Wed, 3 Dec 2014 04:50:31 -0800 (PST)
In-Reply-To: <xmqq4mtem029.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260647>

On Wed, Dec 3, 2014 at 12:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I do like "read-only" ref concept where we can keep ref name
>> (especially tags) in HEAD until the next commit. But it didn't go
>> anywhere
>
> Remind me.  That sounds somewhat interesting.

Couldn't find anything in my mail archive. But the idea is simple:

 - we delay detaching HEAD until we need to update the associated ref
at commit/reset time
 - currently refs/tags/* are read-only. we generalize it to allow this
'read-only' attribute on some refs/heads/* as well. Because we can't
really add attributes to refs, config var could be used.
-- 
Duy
