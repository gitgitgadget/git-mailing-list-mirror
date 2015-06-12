From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-rebase--interactive.sh: add config option for custom instruction format
Date: Fri, 12 Jun 2015 13:56:35 -0700
Message-ID: <xmqqa8w4d4sc.fsf@gitster.dls.corp.google.com>
References: <1434075808-43453-1-git-send-email-rappazzo@gmail.com>
	<1434075808-43453-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: johannes.schindelin@gmx.de, git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 22:56:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3W0I-0001bx-S9
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 22:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbbFLU4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 16:56:38 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35212 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbbFLU4h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 16:56:37 -0400
Received: by igbzc4 with SMTP id zc4so19403478igb.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 13:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mCY5LCCoafOFzCDz0StM+/dPCRO57DlXUowye66zL0o=;
        b=PRdj7N57+Z6Q3cwr8kPkBXQXr1irL60j9V32m72r4wNif4OyrqzGhrW6rPc/HmzMh/
         DAe7MZ0XaeAPMg+yvfwvczL6Zq2EUW9zvMCv7d/XqHAhpjxEAWIJuD3nEUB9Ani4I0Kq
         KQF374O4MBv8kjTG2IImRdFQIF4pOXG9tn14fklrAd5CAa62HHqX1OdYvF1HWU7MzMFM
         P3Ikp+lWEgAZGaYCck/RzE+JsGkgXwCBMbOmPps0CL/71WB020XSMuqtL9PR7LXBSYdS
         oWz2cNAEdToWvYoIvr6DokX7Rwoqwd7yJUjMvoszBRp2iEe24E6FZPl8KznYuE4HDZ7O
         9gCQ==
X-Received: by 10.42.175.74 with SMTP id az10mr1243835icb.55.1434142597339;
        Fri, 12 Jun 2015 13:56:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id p17sm1911098igr.15.2015.06.12.13.56.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 13:56:36 -0700 (PDT)
In-Reply-To: <1434075808-43453-2-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Thu, 11 Jun 2015 22:23:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271521>

Michael Rappazzo <rappazzo@gmail.com> writes:

> A config option 'rebase.instructionFormat' can override the
> default 'oneline' format of the rebase instruction list.
>
> Since the list is parsed using the left, right or boundary mark plus
> the sha1, they are prepended to the instruction format.
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  Documentation/git-rebase.txt |  7 +++++++
>  git-rebase--interactive.sh   | 20 +++++++++++++++++---
>  t/t3415-rebase-autosquash.sh | 21 +++++++++++++++++++++
>  3 files changed, 45 insertions(+), 3 deletions(-)

Thanks, will replace.

The autosquash part somehow makes me feel uneasy, though.  The
feature fundamentally has to have %s as the first thing in the
format to work, but by making the format overridable, you are
potentially breaking that feature, aren't you?
