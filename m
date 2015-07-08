From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Wed, 08 Jul 2015 00:31:23 -0700
Message-ID: <xmqqmvz7yuk4.fsf@gitster.dls.corp.google.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:31:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCjpL-0003fq-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbbGHHb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 03:31:28 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37882 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbbGHHb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 03:31:26 -0400
Received: by igau2 with SMTP id u2so56210003iga.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 00:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ewpgw7aMoPVypkLXD2Ekvc1TA94ed+6vduK5TTM6saQ=;
        b=DzEpqHnHC+JDwSD+UJLSP4k7SmERyvPTBO3up2BSurfc1Jjjx/XGO9ouTjn4Yh3t/U
         HQ3OSiIbybrkvbC5bpcH+scwMZ4gEfs4+VN7FZPq5PQu/IeonJGKBtUeHPcWf1pK5d2P
         mC9bluAOQtGKEdWzLNH39Vl1Q70+SHS8frlzqNBH645G+mXntwwzQHCoVdSaopvHg2EO
         hP8eM8nkdiKtavg8v09pjBGPb2ljGahNnfr7qZrTm0quKFj8/tkQOoKolm7/77Q6TMon
         4UsZglTNrnN5Tm1iPxTuLJfynMTzr9SelqmY0IGQFW/i7vNcOiKW9qBFOoc50b7dgYDK
         5EkA==
X-Received: by 10.107.10.17 with SMTP id u17mr14812138ioi.16.1436340685967;
        Wed, 08 Jul 2015 00:31:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id p8sm1352409iga.13.2015.07.08.00.31.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 00:31:24 -0700 (PDT)
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Tue, 7 Jul 2015 22:20:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273645>

Paul Tan <pyokagan@gmail.com> writes:

> This patch series rewrites git-am.sh into optimized C builtin/am.c, and is
> part of my GSoC project to rewrite git-pull and git-am into C builtins[1].

I merged this to 'jch' (that is somewhere in between 'next' and
'pu', which is what I use for everyday work) and tried it to apply
the 8-patch series that starts at $gmane/273622 on top of 912bd49.

It appears that your builtin version makes "am -3s" barf at the
[PATCH 7/8] in that series, complaining about lack of author
identity.
