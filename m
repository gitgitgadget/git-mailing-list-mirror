From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git daemon --access-hook problem
Date: Mon, 3 Jun 2013 19:20:54 +0200
Message-ID: <CALWbr2ypPCoftVLfP9uKeKStg3TWwLDchkUaL1d9s9O3kcuPwA@mail.gmail.com>
References: <CAPZPVFZDHHGyHhzBVVK6jS=XhEd2+JpmBT8ofiGOww8vuLUWWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:21:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYRH-00010T-SR
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759053Ab3FCRU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:20:57 -0400
Received: from mail-qe0-f52.google.com ([209.85.128.52]:58406 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab3FCRUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:20:55 -0400
Received: by mail-qe0-f52.google.com with SMTP id i11so675597qej.11
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ESN0JmehM/QnyriPvbIH1eZoVXNuYfduY9pfpFyjcxk=;
        b=FP/rjZEYfailM6xrQ62eGJyiFUW/yZYHgqhq4wwOaA4EHh4CKyTagxGyU91bldF5gK
         GTj2yvcKHYCTJAlFc8DOVdIKoCySqY83hL1o2dSSp82uE1v0CKZVIYSWlMGyM46+RPoA
         DNeJsmjmF58GHgTRFrUdEIbVtCh9HS6Wot0n4hjqIgZqVj7LcnySGM8qtBYG86CpyBMh
         0B4X+iSgtL/Pl/oQaopB0MpqF4U49t20F7A2cW/RRKy6y+iq9Wi/ib9lbq089Y88gYsp
         YAKPt+xiBXGzm8R8S1VDMcNSwvfuVlvWZAM1MoHnyjXs8KDk1v91IH5AArnBxlEDO04o
         /uqg==
X-Received: by 10.224.79.209 with SMTP id q17mr19569358qak.88.1370280054912;
 Mon, 03 Jun 2013 10:20:54 -0700 (PDT)
Received: by 10.49.14.40 with HTTP; Mon, 3 Jun 2013 10:20:54 -0700 (PDT)
In-Reply-To: <CAPZPVFZDHHGyHhzBVVK6jS=XhEd2+JpmBT8ofiGOww8vuLUWWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226240>

On Fri, May 31, 2013 at 10:22 PM, Eugene Sajine <euguess@gmail.com> wrote:
> and trying to perform some operations like fetch or push. It is cloned
> and fetches and pushes successfully.
> The problem is that the file test_hook_out.txt doesn't have anything
> in it after the execution, So the hook doesn't seem to work.
>
> What might be the issue here?

I have no idea what the issue might be, but here's how I usually debug
this kind of situations:
- Exit with a non-zero value will make it an error, try "exit 1" at
the end of your script, you will know if it's executed or not
- Your log file might not be located where you expect, you should use
absolute path to dump text
- Dump the cwd to know where it's executed from
- The documentation says you can print one line before a failure, also
try this to show the cwd

Hope that helps,
Antoine,
