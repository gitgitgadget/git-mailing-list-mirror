From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 6/7] pack-protocol.txt: Mark pushee field as optional
Date: Wed, 1 Jul 2015 12:06:24 -0700
Message-ID: <CAD0k6qQgL_nn2R2Lye3b4xqp-P7gwcMG6PGLvqQEdRAfV_64uA@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-7-git-send-email-dborowitz@google.com> <xmqqbnfvaeqk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:06:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANLM-0006nV-MV
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbbGATGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:06:44 -0400
Received: from mail-vn0-f52.google.com ([209.85.216.52]:39891 "EHLO
	mail-vn0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbbGATGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:06:44 -0400
Received: by vnav203 with SMTP id v203so7961997vna.6
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ThgGsTRgO+Tn062CgRtCXn/30pLdEPFUgN8aezt7n+4=;
        b=m7ALPeUGlk23V5eQA5dQ4DGOWHOrA3CMyc8Y4q7P/KxumSRbhYWPhzXEguCBTqHMuT
         kSXoC6yay14sJOlilW24PXi4JkASUC0gYU0rpGI1a8HqlTEgujxgLa3mDYH1WWUZu821
         CZXQrXk9vzZ6q8K12oeSyi95zW1/Nh4MUMFfLp/dli7M+ahaKVahYoUraBEQQxCebkYn
         HEkmjRTieh3aYMCudk+xIK3mamtLVeJsZht5reDcIvRE+Rst/2sO0wMgKj9j5eXV+ZFq
         Ter7VFfV+peqkIMYD9gp376ocvq6Tu28Cz61MAidgMgCQnMzBuTjGvdMD9xpCmy8zklG
         oOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ThgGsTRgO+Tn062CgRtCXn/30pLdEPFUgN8aezt7n+4=;
        b=KKkHq5X+JDY4GcN8hvO4R+aVn65V4EH/EcfIklfAuYsrd+rhD+XqJjIsXPrU0liTWD
         LDJvoJBdtl4K0qOniAliZ5wlQU8emWTQiYlilJH2UXdq+J6xN2Oxbjb5BV9fB/MVCsva
         ZSq2L/DdLw+xodSa5ga/3U1FqC3WSlNG9YvwrrB8+ntPydvYqZN6M/aJMbWzjG5koKe+
         +dHHRVx1fO9zo7eeZ6QM4yHyVDdHY/6ys/QtfsmU0cmcFzkEYff9UXi2wzLxFSLtXj1A
         olWG6FlSbQNrG9k5HX25FbbNWemmDtiSHTFsNb8vjXcWIRrnrULabXqARyW70iZNtcAu
         vxKw==
X-Gm-Message-State: ALoCoQn7znZKkxbq78+o9dY2rCD8T4zjQj8FcdxVfaAbKvcaJSlqoLDaLnDhRvAOq3VxFU3eoJj7
X-Received: by 10.52.52.114 with SMTP id s18mr27957619vdo.9.1435777603457;
 Wed, 01 Jul 2015 12:06:43 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Wed, 1 Jul 2015 12:06:24 -0700 (PDT)
In-Reply-To: <xmqqbnfvaeqk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273185>

On Wed, Jul 1, 2015 at 11:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Do some clients omit this in the real world?

I just sent you privately a trace where this happens using a recent
git client. With that in the wild, I think our server is going to have
to handle these even if there is a bug and it is fixed promptly.
