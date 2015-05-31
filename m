From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH v4 3/8] for-each-ref: rename 'refinfo' to 'ref_array_item'
Date: Sun, 31 May 2015 10:37:24 -0700
Message-ID: <xmqqr3pwabsb.fsf@gitster.dls.corp.google.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-3-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 19:37:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz7Ay-00048X-4M
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 19:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474AbbEaRh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 13:37:27 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35644 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758371AbbEaRh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 13:37:26 -0400
Received: by igbyr2 with SMTP id yr2so46483751igb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QOo3ELUwxxo/JVi2PxxQcrej0/Uiit0TBNCRsqK0e7o=;
        b=S2dDaVKHPdo1O7rih+56kUxx2FQ6iQUQjVACWOyB50pKxPFtC10Vf+VX6J7Astszlw
         RuOB8iWvzaONo9VKbIPnSjJZa7CNTnmyl0H2w1UDUrujIph0cyFzJYhfWelZfpDEsjTR
         p7FDIGLt9HYKqRons5EdSZU5VChqr1i2Po64Xxv3m3kXG8jHcuA800Z8D+Hc9seT36Fu
         u/U7Jkr7SEihf5opRFan4kDA+LGtE2ap3ugCeuCozrCSU+K0hMHIVQkuHNLPE3nh1pgC
         naUBrg6WDdQgKCciyMXhaQI+qEfctjjPS+bxdsIqd0QNbIWxkJrwxaVrptSwT1DX3WMK
         l5eQ==
X-Received: by 10.42.240.82 with SMTP id kz18mr20514011icb.92.1433093846457;
        Sun, 31 May 2015 10:37:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3d1d:5ddf:1454:826b])
        by mx.google.com with ESMTPSA id g1sm8732137iog.4.2015.05.31.10.37.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 31 May 2015 10:37:25 -0700 (PDT)
In-Reply-To: <1433008411-8550-3-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 30 May 2015 23:23:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270335>

Karthik Nayak <karthik.188@gmail.com> writes:

> Rename 'refinfo' to 'ref_array_item' as a preparatory step for introduction of new structures in the forthcoming patch.
>
> Re-order the fields in 'ref_array_item' so that refname can be
> eventually converted to a FLEX_ARRAY.

Not a big enough deal to require a reroll, but I think it would be
easier to read if this reordering is done in the same patch that
makes refname[] into a flex array.
