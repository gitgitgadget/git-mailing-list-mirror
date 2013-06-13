From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] t/checkout-last: checkout - doesn't work after rebase -i
Date: Thu, 13 Jun 2013 12:43:31 +0530
Message-ID: <CALkWK0=zJP2uYtd2T-Xt26d5XqJBbKkBqLf08G0sAmda_F9Mog@mail.gmail.com>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
 <1370881332-9231-2-git-send-email-artagnon@gmail.com> <7vhah5izv4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 09:14:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un1jd-0005QO-28
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 09:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab3FMHON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 03:14:13 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:44316 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab3FMHOM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 03:14:12 -0400
Received: by mail-bk0-f52.google.com with SMTP id d7so4576619bkh.25
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 00:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eEMEhFUICip0pflkh9N3ckGCziNjxvfgGT3EvcV7C7Y=;
        b=kSwUen77V6gnhgdDhBhUnE5aEbzCuaHthmpoe4XlrxIpsJBFCHBPAivAFjazHix/wx
         AYxFshpUnS1HSQ3wb7iqSJNhOLVcAjop9vKnq1hkO9oSc8xDCJxnwOA1uPeZDkh6hLko
         ZKapn00XCeXQlzAm9aVZ51fp0YArGoGm4z7AA+w7zj/sT5eFx0GaHjmJRwY73R9Btkgq
         geq/Q/o7T6lkqSDnEL8q360WTRKP2K0QFJFEtDHTx2Qzsfh+00E7cq5+k3SFXeOtqWqw
         cvJNM37svKlwNy8ljHpnSCs+L7cXA1PnOAdVbNyrux53yDRqINwL0ukdT7juKhhBUkrR
         NOTw==
X-Received: by 10.204.233.16 with SMTP id jw16mr3680087bkb.82.1371107651161;
 Thu, 13 Jun 2013 00:14:11 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Thu, 13 Jun 2013 00:13:31 -0700 (PDT)
In-Reply-To: <7vhah5izv4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227702>

Junio C Hamano wrote:
> These four are all valid ways to spell the "rebase -i master" step.
>
> and I think it is sensible to expect
>
>  (1) they all behave the same way; or

Yes.  My reasoning is very simple: a rebase is a rebase; it should not
write "checkout: " messages to the reflog.  Therefore, the @{-<N>}
will ignore it; for the purposes of checkout -, the rebase event is
inconsequential.
