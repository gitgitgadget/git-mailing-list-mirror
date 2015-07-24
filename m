From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] refs:  Introduce pseudoref and per-worktree ref concepts
Date: Fri, 24 Jul 2015 13:44:30 -0700
Message-ID: <xmqqegjxl1zl.fsf@gitster.dls.corp.google.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
	<1437713129-19373-2-git-send-email-dturner@twopensource.com>
	<xmqqio99mkfp.fsf@gitster.dls.corp.google.com>
	<1437768818.1141.14.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 22:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIjpf-0001H9-4V
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 22:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbbGXUoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 16:44:34 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36710 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbbGXUod (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 16:44:33 -0400
Received: by pachj5 with SMTP id hj5so19497875pac.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8cc/UbraIeyb6XXXgj4ga1zMGZ3DV7kyOZdDW9ETx6M=;
        b=F/tZ02fNxHcMHzyqiI7phg4VwcLQywxqFFOg2hwBvwik5ITWZCQ0/3yCk1anb1luKE
         jSSeU5FLBGK4woBDgZuXVFN1qomm75zWCKt4A/O6qLigB+68WYKExEtOr46aUIEg8qz2
         kEBMV7WBELcf6sBINKvXU9BTXoWZCFESc8lfCm3uWysZdl4DHYHjn7NVONuLusr62jOS
         /WRF32dnJ4SF+pXlJTk4d5Q0wSYHy/O+WvchYjm38DsRF93cD99cX5ErKmGB7ml6NECC
         wVch/0ODhYfTfEhLqgyGl98eoLWDmHvLyqaJd2gzyXu2X57GRN0w+/qHhSfUkQLCBw8t
         0Hrg==
X-Received: by 10.66.118.237 with SMTP id kp13mr35415562pab.9.1437770673299;
        Fri, 24 Jul 2015 13:44:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id c5sm16120292pds.87.2015.07.24.13.44.31
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 13:44:32 -0700 (PDT)
In-Reply-To: <1437768818.1141.14.camel@twopensource.com> (David Turner's
	message of "Fri, 24 Jul 2015 16:13:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274600>

David Turner <dturner@twopensource.com> writes:

> I meant "and that contain a line consisting of a SHA" to exclude HEAD,
> but I need to add a "always" in there, since detached HEAD would
> otherwise apply.

I do not think "always" is as a good escape hatch as an explicit
exclusion of "HEAD".  The latter is more direct and to the point.
