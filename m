From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Is column.ui.* configuration a bit too strong?
Date: Tue, 24 Jun 2014 19:00:44 +0700
Message-ID: <CACsJy8DfKCEQ961mF09e8=Ced6v-CGes=VN65ViAMBrNRk04Eg@mail.gmail.com>
References: <xmqqsimvbg9c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:01:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzPPb-0004d3-Lg
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 14:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbaFXMBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 08:01:16 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:54873 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbaFXMBP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 08:01:15 -0400
Received: by mail-qg0-f51.google.com with SMTP id z60so141647qgd.38
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=avDxzEGMrRJjligcdtDbhgL0tAdh4JZ526vv3NwYnUc=;
        b=jvxAijXLU+sIN5rjB02XRXW6ccqS3Y/RFoFCTDzndrrS4OKeeMwNsNIA7J+JNlZGQf
         OhBgsOZ3+C+skjFT6vAMcsr37ODF0ypNbnXG5DrG/xruy4N7QFStgvdWOastxEM/2kWo
         p11D9vataE5lq9FJZ710rDX7L6Pmt1vOO/6fvS/I7S29kHgYhv0Xa0hey1X/OzI2ZFHD
         8vXCm0J48WukZrA1L+bt8LQoS411wkRBdsT0tS6AMdpt31J8yiCwvDna9khFMpLP7wQi
         tlWTlreRFoI00LTr2/cRVCnU+KA82IHJKj6b+DFN/41JA3S4KYjVnZAxXQbIqr6g+/2z
         eovg==
X-Received: by 10.140.104.66 with SMTP id z60mr697923qge.21.1403611274602;
 Tue, 24 Jun 2014 05:01:14 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Tue, 24 Jun 2014 05:00:44 -0700 (PDT)
In-Reply-To: <xmqqsimvbg9c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252402>

On Tue, Jun 24, 2014 at 2:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Since its inception at 7e29b825 (Add column layout skeleton and
> git-column, 2012-04-21), it seems that git_column_config() asked for
> a specific $command did not give "column.$command.*" any precedence
> over the fallback value defined for "column.ui.*".  If you happen to
> have column.ui.* earlier than the corresponding column.$command.* in
> your configuration, then the values come from column.ui.* may be
> overwritten, but the code does not seem to enforce "if there is a
> setting for a specific command, honor that, otherwise fall back to
> the generic 'ui' setting".
>
> Am I misreading the code?

Hmm.. probably not. The way I read it, the git_column_config() relies
on the order that git_config() calls it, which should be "undefined
order" from git_column_config point of view.
-- 
Duy
