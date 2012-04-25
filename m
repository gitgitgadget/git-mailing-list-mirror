From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to analyze binary delta compression
Date: Wed, 25 Apr 2012 14:21:25 -0700
Message-ID: <xmqqsjfrbj8q.fsf@junio.mtv.corp.google.com>
References: <jn9phl$t7s$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:21:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN9eX-00075T-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 23:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758840Ab2DYVV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 17:21:29 -0400
Received: from mail-ee0-f74.google.com ([74.125.83.74]:56936 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758085Ab2DYVV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 17:21:28 -0400
Received: by eekc41 with SMTP id c41so71452eek.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 14:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=yM9IuYykR6YRN8Cg97/nSDmavZNICPUsuHeJyFUPRxA=;
        b=kgB6Ag/0XgLrEZfgslyV2u0H1PnZMMyMXbd2iJwwUjAcrqAtmjAOlsXJ4kAxCbJ1IA
         J6lwC1BDtehWBhq1j1gpJ1FBmgIAHbN5tnMvN/gWdgOOX4yGOwUSq7B7E+nxUq4TS8DI
         rbD2ChNw0qjhWn/wPVDGukESO5/dSaZtrJEz0+E8x74CEyerKQzlFVPFS6014u6CWaPN
         fmXc3EvHt8KiHUkEJ0DxOlIZqzjB3M9Htf6lgI93AnW3Xpeo2eDC0XHTrT8chzVNvDMj
         0rP9R5SKb2ZvpsnFHxA8acjXyXJeOF8Jz5eaz2MZZxUa7eEuUqV31rl9HfGrq50fODPG
         NjAw==
Received: by 10.213.110.15 with SMTP id l15mr451336ebp.22.1335388886929;
        Wed, 25 Apr 2012 14:21:26 -0700 (PDT)
Received: by 10.213.110.15 with SMTP id l15mr451325ebp.22.1335388886809;
        Wed, 25 Apr 2012 14:21:26 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si791384eef.2.2012.04.25.14.21.26
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 14:21:26 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 9C0135C045F;
	Wed, 25 Apr 2012 14:21:26 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id EB514E125C; Wed, 25 Apr 2012 14:21:25 -0700 (PDT)
In-Reply-To: <jn9phl$t7s$1@dough.gmane.org> (Neal Kreitzinger's message of
	"Wed, 25 Apr 2012 16:15:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmUylstQLGhBNeD2xD6Yo1fSOlETNB5XqgzOhD/8Y4PLwNquFfyxvQ3uaKm0BQAAplnkQkSbAoS/Bfkiwtt9ZZvVH1eSOw5qeIIz+VBONutlw8Xae8LMivSX2DlmUJyqIB1g0nwg6cHhuQJphuH6prNa2f4xEQ4EfrJ7O//KcDYtPP4icA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196339>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> I need to assess the delta compression efficiency of various types of
> binaries.  Can I do it this way:

Use test-delta to see how large the output is, perhaps?
