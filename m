From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Unicode: update of combining code points
Date: Mon, 7 Apr 2014 12:54:58 -0700
Message-ID: <20140407195458.GA3912@google.com>
References: <201404072139.42519.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 07 21:55:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXFdU-0003R8-6B
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 21:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbaDGTzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2014 15:55:09 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:57161 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbaDGTzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 15:55:07 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so7246218pbc.13
        for <git@vger.kernel.org>; Mon, 07 Apr 2014 12:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4WurMSp1b+mYkUMFJzbZEh6rTS4qHKgO6Ir+SubvVPY=;
        b=tHlp3sdX16yF96bWb5hI6bChf8bNc81YLbKA+zYxmFlFViMEIm90wlPHpeBY9y5gih
         VKGBOY5ejiHY/rTsNeJVuh/TFvsp1CBC72n4+5ctq2c0IQ+peB7X/EGkQ9L1xHQPuDaP
         K9YX8Qrdrmo/Of/c5FjDlB7vX9/W4vZHE/8LK/j0xHwi539IAYo623gL+wze1Bqoh29L
         ly+ahXnmTzTmuBFY8LGHjexwud59IbZWGWGKJVRHgvDohNM+2HHoarbLZChh6EFDZgCJ
         gk+ShZp6P71vNAN+ig9eNhs9/jf0zbhCv4jq/p4qzVbjBrXkmOhyiqbWYRvXpp/+7dYj
         fiHg==
X-Received: by 10.68.112.164 with SMTP id ir4mr4152814pbb.153.1396900506876;
        Mon, 07 Apr 2014 12:55:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sv10sm31308310pbc.74.2014.04.07.12.55.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 07 Apr 2014 12:55:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201404072139.42519.tboegi@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245902>

Hi,

Torsten B=F6gershausen wrote:

> Unicode 6.3 defines the following code as combining or accents,
> git_wcwidth() should return 0.
>
> Earlier unicode standards had defined these code point as "reserved":

Thanks for the update.  Could the commit message also explain how this
was noticed and what the user-visible effect is?

=46or example:

 "Unicode just announced that <...>.  That means we should mark the
  relevant code points as combining characters so git knows they are
  zero-width and doesn't screw up the alignment when presenting branch
  names in columns with 'git branch --column'"

or something like that.

[...]
> 358 COMBINING DOT ABOVE RIGHT
> 359 COMBINING ASTERISK BELOW

I'm not sure this list is needed --- the code + the reference to the
Unicode 6.3 standard seems like enough (but if you think otherwise,
I don't really mind).

> This commit touches only the range 300-6FF, there may be more to be u=
pdated.

The "there may be more" here sounds ominous.  Does that mean Unicode
6.3 also added some zero-width characters in other ranges that should
be dealt with in the future?  How many such ranges?  How do we know
when we're done?

Just biting off the most important characters first and putting off
the rest for later sounds fine to me --- my complaint is that the
above comment doesn't make clear what the to-do list is for finishing
the update later.

Thanks and hope that helps,
Jonathan
