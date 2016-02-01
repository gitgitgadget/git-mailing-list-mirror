From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/6] worktree: new repo extension to manage worktree behaviors
Date: Mon, 1 Feb 2016 12:23:46 +0700
Message-ID: <CACsJy8DGsDFnX57eQ7rN2hkOR3Wuw_eQ9ED4e-9FhAm30sBFEQ@mail.gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com> <1453808685-21235-2-git-send-email-pclouds@gmail.com>
 <xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com> <20160130142039.GB4978@wheezy.local>
 <xmqqh9htya2e.fsf@gitster.mtv.corp.google.com> <jwvfuxd17bz.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Mon Feb 01 06:24:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ6yM-0004l2-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 06:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbcBAFYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 00:24:20 -0500
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35245 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbcBAFYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 00:24:17 -0500
Received: by mail-lb0-f193.google.com with SMTP id dx9so5549068lbc.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 21:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Obwts72hJgDK56PZuF4p5Wi++IZNPTi7u/OBiqbeUF4=;
        b=mNXxkv6qLX5BgWf4OtP/9Wq8zasxAg3xO+8RDiEvEZTDpB9HM0dBOI/zQ/Sa72sFlW
         jHr6Q3Y1XoI1c3IB1YIcF9ofZcI6IHe/AvWCshfUo2t1RRm/wEw0I/9VTjjc8egEM3jv
         G5h4d+psU2bi12brqt0PeljJTNWWQ1irqNKW8HssPSvEidvHI14/tjDr6ePsMkqFfqxM
         inSVumc54DlhmzxHwRqafNlUyzp/DKNW56OIC+iDFdBV7GBIzHZYWPGR46XclE2DDvZy
         Oxl22mbmSSI2wxW4EJpSxe4jTPgCDQZ784rCqQQkCGOAo0Td7IjK9bTik5zBcnBjHAIz
         oAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Obwts72hJgDK56PZuF4p5Wi++IZNPTi7u/OBiqbeUF4=;
        b=IQB5e2fhLopSUJMVz5QT7zS+c6N7WCR7emzXsMdclyrV20LL5KWjJJO6E8cqyeOv9v
         WcYRPnjVN9ERVOAlYfLTQWKkPnCZZGVI16Q2+gA7av1ISTyQ918vkD3kCay46ugTsbIo
         tlXUpMr0UkqCEQlRLFQ+W84B00+OwP9Kndohhd2mnx6ORN3GhH8Ym9L2sXSwjyf5gExc
         meQjg5o5ERcvszwqjMeOmdUyagm4+clHtLkiP2xBPJ9pjLKnZH5Op+q3XQkhs7s1cCDX
         Y30mKL/m8tb3DVWYYXhosbpHu07VKGQoMWPsWZuLL/44R4Xrh5vtqjTuYVVgeQcpCwKQ
         Dv/w==
X-Gm-Message-State: AG10YORvG6LVXdJzP5Kih7LWE/CLWTQnB3LA6J5u4iEZbaPYRTAAOjIiV9q9O92nVnl8bDnZSWPndfOoyDF8Kg==
X-Received: by 10.112.12.2 with SMTP id u2mr7644542lbb.145.1454304256271; Sun,
 31 Jan 2016 21:24:16 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 31 Jan 2016 21:23:46 -0800 (PST)
In-Reply-To: <jwvfuxd17bz.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285186>

On Mon, Feb 1, 2016 at 9:41 AM, Stefan Monnier <monnier@iro.umontreal.ca> wrote:
>> One lessor key phrase above is "so far", I think, and another one
>> you forgot to use is s/which requires/that we know &/, which to me
>> is a more serious one.  IOW, I do think it is premature for us to
>> say that that config split issue is the only thing, or to say that
>> the issue is best solved by changing the layout in the way being
>> discussed; the multiple-worktree feature needs more lab experience
>> for us to gain confidence.
>
> As a heavy user of the git-new-worktree "hack / script", is there
> something I can do to help "get more experience"?

You can try out "git worktree" command (in "lab" environment) and see
what's missing, what use cases of yours it does not support.
-- 
Duy
