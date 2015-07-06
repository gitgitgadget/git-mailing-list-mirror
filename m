From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 08:46:09 -0700
Message-ID: <CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com> <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dave Borowitz <dborowitz@google.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 17:46:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC8bQ-0000gi-4N
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 17:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbbGFPqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 11:46:35 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34168 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783AbbGFPqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 11:46:30 -0400
Received: by wifm2 with SMTP id m2so33860766wif.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wlvJkkqciYIpoBWEi+qJpEhW3iumxZYy7rnukufgVwg=;
        b=Q4EUF3euawKM7woH9W6G7JVGpcY8BMRBkaFhixBDQ9ckj8VZRkiXRAU4zK3eygAdPj
         Q+jYdB5x1iozc6Fvmm77CMOU6+w0tCDgaZvEJnZce+bWEsnJUuVDu8VoZDYU0YkGqXmu
         9/PICyPo3aQgYcErKpbaMhL9Zjz0bwwB4pBuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wlvJkkqciYIpoBWEi+qJpEhW3iumxZYy7rnukufgVwg=;
        b=gEomgisAAbw+NSk9qxh4J8OnjF19VvsuQb38fJJvOT/qxbq2v9Bako3qeIwaqW8JL6
         mDF9QA5FQPDzV+WXXUCFxoN/A3OCRrP+evcnUGyZSHEthSLWa4ZQ2IXZfHmNX+TycKht
         eqOsU3CqS8uaLb/T+wxUUrro44CJiYvsbPeRS+A0KqE4sQYZU+dzz+LrS/PPAj2/r9Wa
         3jy8GFzOtQd0ncZ1Af7C9dAyZvGSpYvW/yQtZqqaJQlsJNCF2RaxVsAeOQgu35eZPBr8
         8C69/+Vi5eWbm5zM11NPhx7n/HBXiXaPqnomxkyfkfEIn3DUk9jTefFqUr7Ro1sXNoAE
         9Atg==
X-Gm-Message-State: ALoCoQl3x3dkexxYfBT2BeUpuxceuP9Mpgp7kw6zzV9xhgZ25tlC8IJVk2KgFEGnq1vHpHP4OYYw
X-Received: by 10.194.93.3 with SMTP id cq3mr49093035wjb.20.1436197589390;
 Mon, 06 Jul 2015 08:46:29 -0700 (PDT)
Received: by 10.28.228.70 with HTTP; Mon, 6 Jul 2015 08:46:09 -0700 (PDT)
In-Reply-To: <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273392>

On Wed, Jul 1, 2015 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>>> I am moderately negative about this; wouldn't it make the end result
>>> cleaner to fix the implementation?
>>
>> I'm not sure I understand your suggestion. Are you saying, you would
>> prefer to make LFs optional in the push cert, for consistency with LFs
>> being optional elsewhere?
>
> Absolutely.  It is not "make" it optional, but "even though it is
> optional, the receiver has not been following the spec, and it is
> not too late to fix it".

This is madness. For all the reasons Dave points out later in the
thread. You can't store and make sense of the push cert without the LF
record delimiters.

push cert format is like commit or tag format. You need those LFs. We
can't just go declare them optional because of the way pkt-line read
function is implemented in git-core.
