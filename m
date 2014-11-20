From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 1/1] refs.c: use a stringlist for repack_without_refs
Date: Thu, 20 Nov 2014 11:05:40 -0800
Message-ID: <CAGZ79kYogEQuynukSkb9La+7DZxOQonAyuYD=kWB7KRdsXLHOA@mail.gmail.com>
References: <20141120021540.GF6527@google.com>
	<1416506666-5989-1-git-send-email-sbeller@google.com>
	<xmqqppch3dde.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 20:05:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrX34-0007WT-79
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 20:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459AbaKTTFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 14:05:42 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:47826 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757084AbaKTTFl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 14:05:41 -0500
Received: by mail-ie0-f175.google.com with SMTP id at20so3312223iec.6
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 11:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TScnIu2XY07E/Qv7yd4yv/bwe5huXmhe5KaS4UfPytI=;
        b=f527xvDxmFMkuewX0/EgXNvLT9ZG+tJTffE4ph0UD6LmYGsxrFnMUe6Ou+K2ptiktp
         y6U+C+o98uoi/AOTWKHkSyIMTKbkjwRUui7g7NYP02kwYb12Odu4jK2A8jFVxZWOtu21
         Ln08RkFdB3fZEu17pe8F16JjZPMavSnR1dPcwAJHLcMxbeRNKNOkQozPP3sBb7R2yEcz
         naThAMI9VG1kZG9yZlLH19O9PJkFjwHARs+Hf2NJJrFcZ9CRJYSBS9mtAKkgXknF5CXl
         kYoXduBFrrb8v3v0Enom1novatVq5ag2ezmF8rgSPj2SLy+5xjj27x1QyWc4Qo3t7auH
         kApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TScnIu2XY07E/Qv7yd4yv/bwe5huXmhe5KaS4UfPytI=;
        b=YolWpNL0CzGtID+M5tT1G4Nqeut1Kxwz+LGS04XEanfcBEIk4WjFwAp9EFDgXrioxW
         s2Je17uxi4X8/pB20URakrzR5n8PSF9r2vbXtsMxHnAi0x9+kv5yOKN4nqGKd+QPago4
         Gnjp/zz8QKwlERFb5TkBQWpt9a62sqt0O7CypU6rtT8dZ5RmfG4tqJ2ZS6UDU8hQWmAM
         uaH57t++XkNGJ8+8DZ5H7VSATBUQcbwpvVRN9gp3z9J0cOvG6eN4dfRvS2PUYdFWfe7D
         imW0OhqHZaIXz9RXjWOQijXBjnCQw0P+D3o3DfafpGRf+/2Cr5mLzkbIP2uKXHyoz8C5
         NpCA==
X-Gm-Message-State: ALoCoQnCrGzSjxBcUC41ex0kOqaPAqDHLse+v8FWbu//LF7ZapbZ79BB4Jd/DMf5LfqFP3YsTkHx
X-Received: by 10.42.129.140 with SMTP id q12mr1875451ics.68.1416510340968;
 Thu, 20 Nov 2014 11:05:40 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Thu, 20 Nov 2014 11:05:40 -0800 (PST)
In-Reply-To: <xmqqppch3dde.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 11:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I think this matches more-or-less what I've locally tweaked after
> following the discussion between you and Jonathan.  Thanks.

Do you want me to resend the patch with Jonathans nits fixed?

Jonathan wrote:
>> Change-Id: Id7eaa821331f2ab89df063e1e76c8485dbcc3aed
> Change-id snuck in.

I need to get the format patch hook running, I was talking about
earlier this week.
