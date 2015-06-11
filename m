From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] object_id part 2
Date: Thu, 11 Jun 2015 13:00:04 -0700
Message-ID: <xmqq4mmef22j.fsf@gitster.dls.corp.google.com>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqq381zi3ev.fsf@gitster.dls.corp.google.com>
	<20150610235114.GA786544@vauxhall.crustytoothpaste.net>
	<20150611000251.GB786544@vauxhall.crustytoothpaste.net>
	<xmqqpp53gkmq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Jun 11 22:00:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z38eB-0007RJ-97
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 22:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbbFKUAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 16:00:09 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36200 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbbFKUAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 16:00:07 -0400
Received: by igdh15 with SMTP id h15so4341741igd.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6F8dHaBMaHj5NgIlrTQc70RMNKkeg6zB3m97jg39XF0=;
        b=OiR80r7TXU/AAZy1SpJ6S/ZnJT55R2J1ymDdpEelSTAL6r2P/4lJidP5UqBfAm0wfR
         ADndZs8ZAXHPg4x99ISY7hHoOCaIPkM8qKUWHDEpFQMjsoTGodUAF26uq4EZ6A+cL8PE
         oEsVrWcgqBKnEmnhvR9EhKm8sGXhCFyC8EoxpX5JW1sKw4ZctSeCgkYa9ZrlLYe2J9v3
         b2SHz2b7viC3q3Y2yCs57B7hjL937+cyM2Q4PcboSG9O4cQvySdNocoqTI8t/JziznSB
         5xq3AzHImc0wD5lbuj/cs1RgBaQihEj5AxpXKSjK08ZiAI4R8FmMEh9A84askWdXoe0W
         +e5g==
X-Received: by 10.42.238.14 with SMTP id kq14mr12817409icb.23.1434052806436;
        Thu, 11 Jun 2015 13:00:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac40:153c:ed59:12ce])
        by mx.google.com with ESMTPSA id o19sm5989363igi.14.2015.06.11.13.00.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 13:00:05 -0700 (PDT)
In-Reply-To: <xmqqpp53gkmq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 10 Jun 2015 17:21:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271459>

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On Wed, Jun 10, 2015 at 11:51:14PM +0000, brian m. carlson wrote:
>>> On Wed, Jun 10, 2015 at 03:50:32PM -0700, Junio C Hamano wrote:
>>> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>> > >   Convert struct object to object_id
>>> > 
>>> > It seems that the last one didn't make it...
>>> 
>>> It appears the mail was too large for vger.  Unfortunately for
>>> bisectability reasons, it is necessarily large.  I'll resubmit the patch
>>> with less context.
>>
>> Unfortunately, the only patch I can generate that falls under to 100 KB
>> limit is with -U0, which isn't very useful.  How do you want to proceed?
>> The branch is available at [0], or I can send the -U0 patch, or I can
>> split it into unbisectable pieces.
>>
>> [0] https://github.com/bk2204/git.git object-id-part2
>
> No approach other than just letting reviewers fetch from there and
> taking a look is reasonable, I would think.

Fetched that branch, built and found out that it does not pass the
tests, at least these (there may be others I do not usually run that
are broken by this series; I dunno), so I'll discard what I fetched
for now X-<.

Test Summary Report
-------------------
t5540-http-push-webdav.sh  (Wstat: 256 Tests: 19 Failed: 12)
  Failed tests:  4-10, 12-15, 17
  Non-zero exit status: 1
t5539-fetch-http-shallow.sh (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t5541-http-push-smart.sh   (Wstat: 256 Tests: 34 Failed: 27)
  Failed tests:  3-17, 22-29, 31-34
  Non-zero exit status: 1
t5551-http-fetch-smart.sh  (Wstat: 256 Tests: 26 Failed: 17)
  Failed tests:  4-14, 16, 19-20, 22, 24-25
  Non-zero exit status: 1
t5550-http-fetch-dumb.sh   (Wstat: 256 Tests: 29 Failed: 12)
  Failed tests:  3, 7-16, 19
  Non-zero exit status: 1
