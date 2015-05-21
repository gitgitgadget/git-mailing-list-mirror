From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Occasional wrong behavior of rev-walking (rev-list, log, etc.)
Date: Thu, 21 May 2015 09:41:55 -0700
Message-ID: <xmqq617llw6k.fsf@gitster.dls.corp.google.com>
References: <20150521061553.GA29269@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu May 21 18:42:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvTXm-0005ck-5w
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 18:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbbEUQl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 12:41:59 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35193 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbbEUQl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 12:41:57 -0400
Received: by igbyr2 with SMTP id yr2so14691880igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kA7oHn1UAdBIONDiDTSddBQv5BcfVfyrXg3cLAx8T78=;
        b=rDj2BHcSeQhe3w0OnTUunARHR1AsSZVnESi0JB5vzy19bxA6oeo/S9MiHXdJoYGNlk
         XZJUinWpwVbI5WY96I2+VYZie2WDSnvQFTOsEBEkDODkoAuJQpzQ2ItWiaTIq2bURhwU
         Ugr4zGSFqLFVw37KjBUBzYKvCSQqICS2yZN70BE72yqfNj2DmagE9FXEwmkNm7kQAvHF
         sobqAVuCV0LPNpK2UYhjKSsMBEKsF6XMH2Y9vUxJaSQNTEh5N8Fuyfh85BMLLx2G5tWg
         dcrh75th96ys0IyJOVb3gCEprZVeSGrOoDvS8eL0gKalADoOzQ6EUnue2uIHX3IqCk44
         +yaQ==
X-Received: by 10.50.109.138 with SMTP id hs10mr5197777igb.48.1432226516685;
        Thu, 21 May 2015 09:41:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id qh1sm1532142igb.17.2015.05.21.09.41.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 09:41:56 -0700 (PDT)
In-Reply-To: <20150521061553.GA29269@glandium.org> (Mike Hommey's message of
	"Thu, 21 May 2015 15:15:53 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269607>

Mike Hommey <mh@glandium.org> writes:

> My guess is that rev-walking is tripping on the fact that this repository
> has commit dates in random order.

Yeah, that is well known (look for SLOP both in the code and list
archive).
