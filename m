From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Fix verify_lock() to report errors via strbuf
Date: Wed, 27 May 2015 12:55:10 -0700
Message-ID: <xmqqfv6hlrs1.fsf@gitster.dls.corp.google.com>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
	<5565B1AE.3010708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 27 21:55:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxhQ6-0007mF-Pk
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 21:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbbE0TzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 15:55:13 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34430 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbbE0TzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 15:55:12 -0400
Received: by ieczm2 with SMTP id zm2so22254420iec.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XStidHGqpb7JGLbcV0aQ+7SbqsmpaLAIizPh7vQZSH0=;
        b=bUfyoO5A3r1tnvnhGQWOLI4mtUyIawouBlqzl9LQtLrTxc8MbtljaDzeL8z9dFY7+j
         yhjxpI6t9EGxYJTGI7z4RCOvIyQkx9/9x29if+vMukxxOrZUOlZ6Vbvie7igqP9YfPyG
         X6mojT9CftwgpTo1R70maEFKBSDqCX8xUnIGYJu58W/0C7YVYr4HMy62G7tzYUyfRPOY
         kpMsYTwcLKIzoI/5AwHfazWX44vn0A9SvAPd35EEBqJ0EipkyoJzde6wlZqSLF0+VzIQ
         kQ0U5Rmb7Wl/Aas5r78syWwTR4rCdXymrdj/xEykRyeN6m30VF7s2pK4xSJZ1ZzEuHZY
         IYWw==
X-Received: by 10.107.162.147 with SMTP id l141mr44360381ioe.77.1432756511768;
        Wed, 27 May 2015 12:55:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id 33sm14226412iop.22.2015.05.27.12.55.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 12:55:11 -0700 (PDT)
In-Reply-To: <5565B1AE.3010708@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 27 May 2015 13:59:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270075>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The last sentence is nonsense. This patch series relies on
> lock_ref_sha1_basic() having a "strbuf *err" parameter, which is only
> the case since
>
>     4a32b2e lock_ref_sha1_basic(): report errors via a "struct strbuf
> *err" (2015-05-11)
>
> The latter commit is in mh/ref-directory-file (which has now been merged
> to master, so technically the last sentence is now correct again).

[5/5] seems to conflict with the write_ref_sha1() vs write_ref_to_lockfile()
updates; I think I can manage, though ;-)
