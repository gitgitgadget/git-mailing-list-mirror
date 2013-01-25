From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v4 0/3] Finishing touches to "push" advises
Date: Thu, 24 Jan 2013 22:31:43 -0600
Message-ID: <CAEUsAPYAikZUTf9OE=PoGBYot6Udnw9XTYDs6Ug7h=PWbCYM1Q@mail.gmail.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
	<1358978130-12216-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:32:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyaxT-0004d7-2d
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab3AYEbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:31:46 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:53102 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab3AYEbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:31:45 -0500
Received: by mail-lb0-f169.google.com with SMTP id m4so31140lbo.28
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 20:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=SmHx/Z5FNOX69lhgsdDTQr2bai+J1/48K1RkUkx9cxc=;
        b=bTMKIa7bIlJEqVUYB+saEtVnCLXhwFIbM42GwG4y7km3/Orh2tfTLcksQcBIaDgmUn
         zeJHGLZFtI7XQrR7WGi1EnbME3W/REDSA82jTegxJ1Q1tjNaM65ITEPKAlxFxLLUOiMw
         0oGmlTgmS2RWBdtRtPxSqlIj06n3cPB4hCyB7TQEDYwIifkjJASFbyDMBd7GE8Hynwnt
         NP6D9ulwi54fmB1lngKXcahjejqtc5PpKbbwEptA0e45sIcjJgPveGqqBXACWpvVQkxe
         w0r//XgU7D+IiUIpIWWtN3m6KZbwRbiZ5MlwiHZxZ605XecmXTgRiO8ROuzTmOUlfXex
         sKAA==
X-Received: by 10.112.40.197 with SMTP id z5mr1626541lbk.14.1359088303303;
 Thu, 24 Jan 2013 20:31:43 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Thu, 24 Jan 2013 20:31:43 -0800 (PST)
In-Reply-To: <1358978130-12216-1-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: tGuW7XJFjAqj-F8P7LDj2qg-5PE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214492>

On Wed, Jan 23, 2013 at 3:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This builds on Chris Rorvick's earlier effort to forbid unforced
> updates to refs/tags/ hierarchy and giving sensible error and advise
> messages for that case (we are not rejecting such a push due to fast
> forwardness, and suggesting to fetch and integrate before pushing
> again does not make sense).

FWIW, these changes look good to me.  The logic in
set_ref_status_for_push() is easier to follow and the additional error
statuses (and associated advice) make things much clearer.

Had I written the the "already exists" advice in the context of these
additional statuses I would have said "the destination *tag* reference
already exists", or maybe even just "the destination *tag* already
exists".  It's probably fine the way it is, but I only avoided using
"tag" in the advice because I was abusing it.

Thanks,

Chris
