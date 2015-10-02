From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] ref-filter: modify "%(objectname:short)" to take length
Date: Fri, 02 Oct 2015 14:02:06 -0700
Message-ID: <xmqqd1wx3rxt.fsf@gitster.mtv.corp.google.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 23:02:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi7T4-0003AS-0j
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 23:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbbJBVCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 17:02:09 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32913 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbbJBVCI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 17:02:08 -0400
Received: by pacex6 with SMTP id ex6so116216893pac.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dUvanvqvrx97uBffaskF/2ASwQx07xyG+VHx1cKYgHc=;
        b=yPW9oXYY79pc2MO8AMU0GcnRNYqzxMA/6gXpVni6LZo0uEKBc5Stp4v4DPIrq6BkqA
         P0r0RC+u5B2zz6qjR+zI6QlIhmRD74uxLnwtqYKcVyU4YQkBPj6SqkpSmWWf4zMNSAfA
         SgyudCV3tVxhKgKULyW8Bxjwwq2YYOBTtykXkp3IlfX5tCMzRGmJMXSYvH9Ixx+KTfIJ
         7VLO/n43QWtWg42kHki/7ZMgTSaLKUYg+85VN2Hz3s7WonYflKOkrgl3pmRzTrKqK/7m
         0JbCC2EPOvLMVweL845/ywcS+h5aR5ufu+btZ2ktjACJ1fIMXTjyyXkTQ6c2QR6Np0sP
         7bJQ==
X-Received: by 10.66.122.98 with SMTP id lr2mr22428111pab.146.1443819728247;
        Fri, 02 Oct 2015 14:02:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5831:5c0e:ce5f:86ea])
        by smtp.gmail.com with ESMTPSA id be3sm13558827pbc.88.2015.10.02.14.02.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Oct 2015 14:02:07 -0700 (PDT)
In-Reply-To: <1443807546-5985-5-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Fri, 2 Oct 2015 23:09:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278949>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add support for %(objectname:short,<length>) which would print the
> abbreviated unique objectname of given length. When no length is
> specified 7 is used. The minimum length is 4.

It would have to be "short=<length>", not "short,<length>", if I
recall the previous discussion on width=<w>, etc., on the %(align)
atom.
