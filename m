From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation/log: fix description of format.pretty
Date: Mon, 12 Nov 2012 15:09:38 +0530
Message-ID: <CALkWK0nR_9mWDKzKygR379x3L=d4bGKKo27AP-2Y=+coc7H+sQ@mail.gmail.com>
References: <CALkWK0=hdmYF2VoOZY4F7+yPD8D0rBnPY-tvp5pryRWp-0WBeg@mail.gmail.com>
 <20121112080527.GB3581@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:40:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXqV4-0001PA-V4
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 10:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab2KLJj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 04:39:59 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60380 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab2KLJj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 04:39:58 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5997871obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 01:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qOg8anwcCM3aP9Q24kFpLZvleSloFXKEA3HLE3PkfPI=;
        b=uNHcsRl42Czeu8FuHY4dmuOWhMbVe0fBuajHKx1aCvhUbCddaxyQ8D9yXd9H8bbm34
         pRWFePo/g4GPFaAyHmWnqMVJDHFxBic3dErPW3K2ZCeycd1OHFMXMnuwuDWvh0j/jIB3
         sshmTbvn0RNwlTLfrDBki50SF2cxSQ6SNCXGHwc7/9eCxCSLOQIWp/Tmgo+E61j91sq1
         NwbFJsBoiANbESoxaeEvZTkA0zxnIyx9yYG+m9LiaLUxe+5eJ4RD7KBLZt7gmYYdrnk5
         +AIfvH4gc1Dz29jAK5Swxv+BzumdSMlpOKyCpwvviGjWLp/+OVxxAPqCegfVXLGHVjJ9
         7/7A==
Received: by 10.60.31.199 with SMTP id c7mr13897401oei.126.1352713198266; Mon,
 12 Nov 2012 01:39:58 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Mon, 12 Nov 2012 01:39:38 -0800 (PST)
In-Reply-To: <20121112080527.GB3581@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209473>

Hi Jonathan,

Jonathan Nieder wrote:
> Hi Ram,
>
> Ramkumar Ramachandra wrote:
>
>> 59893a88 (Documentation/log: add a CONFIGURATION section, 2010-05-08)
>> mentioned that `format.pretty` is the default for the `--format`
>> option.  Such an option never existed,
>
> False.  Have you tried it?

Oops, I read about `--pretty` in pretty-formats.txt and didn't realize
that `--format` existed.  However, your patch is still wrong because
there seems to be a subtle (and confusing) difference between
`--pretty` and `--format`.  In the latter, you can't omit the format,
and expect it to be picked up from format.pretty:

  $ git log --format
  fatal: unrecognized argument: --format

Instead, you have to specify the format explicitly:

  $ git log --format=medium

So, we should change the commit message in my patch?

Ram
