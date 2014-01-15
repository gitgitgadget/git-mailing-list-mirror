From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git symbolic-ref does not recognize @ as the shortcut for HEAD
Date: Wed, 15 Jan 2014 18:26:07 +0700
Message-ID: <CACsJy8Dy5xgF5m6BOo1cfdzg5dOx58sZo0aa_YKdnyAvJ6g4=Q@mail.gmail.com>
References: <CAOBEgJjmoXEDVa4L5LbAGMYR7_+NCf2tDSveieZxtU4bfWyzDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Mathieu Lemoine <mathieu@mlemoine.name>
X-From: git-owner@vger.kernel.org Wed Jan 15 12:26:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3OcM-0000kC-77
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbaAOL0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 06:26:39 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:48586 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbaAOL0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 06:26:37 -0500
Received: by mail-qc0-f172.google.com with SMTP id c9so806498qcz.17
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 03:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=thjchTMj8CAEA8YvSqLqo0Yo6a13BCOuog71sLwNW/g=;
        b=gK6GCyr2hgjoNVJNsLnmMkpJ5X8TDmW/2jBb5R1GQr7KDPHLykRbgi9Q2Te946eWXb
         9e8xmrFsAsWDJLsRV6l8+7Ey2AeK7aM2n17ff/Niw6OhGguig8pvR4w/ShpkEav8cppH
         I9PzKlVACxCDcS//5fwKYS3A7QZNEZhfB6lO1Qiyzh5UUNMQbnXJQcKGE6rg5kOMLqSL
         RrqdpA/BPb2+i0VTDrAx4VU6UUWRJuMNqqLLv/R1E9IB0qpC4qLP4OeomtGPPW1rbR/B
         sXoduU0J8agToJwFocgrDk5snZXFMm0oXI+rty+hUzhSHbpFZqdSKg9dJbM5ycuAAprE
         ceYw==
X-Received: by 10.224.165.12 with SMTP id g12mr3249845qay.89.1389785197413;
 Wed, 15 Jan 2014 03:26:37 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Wed, 15 Jan 2014 03:26:07 -0800 (PST)
In-Reply-To: <CAOBEgJjmoXEDVa4L5LbAGMYR7_+NCf2tDSveieZxtU4bfWyzDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240459>

On Thu, Jan 9, 2014 at 10:05 PM, Mathieu Lemoine <mathieu@mlemoine.name> wrote:
> Hello,
>
> In https://raw.github.com/git/git/master/Documentation/RelNotes/1.8.5.txt
> is mentioned:
>
>  * Instead of typing four capital letters "HEAD", you can say "@" now,
> e.g. "git log @".
>
> However, `git symbolic-ref @`  gives "fatal: No such ref: @", while
> `git symbolic-ref @`  gives "refs/heads/master".

you meant "while `git symbolic-ref _HEAD_` gives refs/heads/master"?

> I looked around in the archive and #git, but nobody seemed to be aware
> of the behaviour.
>
> I wonder if it's on purpose given the low level of symbolic-ref or if
> it's a bug.

I think this is because symbolic-ref (and show-ref) takes plain refs,
either in full or short form, but nothing else fancier. I'm not sure
if we should add support for @ (and maybe @{u} as it's in the same
boat) to these commands. If it's confusing and hard to explain in
documents then maybe we should.
-- 
Duy
