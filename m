From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] diff --no-index: support more than one file pair
Date: Thu, 12 Jan 2012 16:17:57 +0700
Message-ID: <CACsJy8BvA_o1+xrOx4hYhmwNWpsRnh5+mftb471h3yFW2b6vhA@mail.gmail.com>
References: <1326359371-13528-1-git-send-email-pclouds@gmail.com> <vpq39bll1ua.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jan 12 10:18:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlGns-0004qH-1m
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 10:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab2ALJSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 04:18:32 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:53524 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab2ALJS3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 04:18:29 -0500
Received: by werm1 with SMTP id m1so1172552wer.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 01:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bF0mzDoJPXyZw1yub4M3LnA9zJBhRue7gUWVI31dMK0=;
        b=tGSpBJQA733WJvVaHN8rDj7oKOFKghwyD/FNTZTCxDyAnyXPHgXnvrAKfYY3T/Cdab
         kWXDAOVf6WYiJixjoQdaaPXWYxEomwT62Qwq78zMMrmA6g7fKOwivqABri7woLnfW8MA
         Yr+cpQuzgIgSLeJBKe8qmkUyxGSNL7qVBxq0M=
Received: by 10.216.138.159 with SMTP id a31mr4293827wej.20.1326359908306;
 Thu, 12 Jan 2012 01:18:28 -0800 (PST)
Received: by 10.223.90.194 with HTTP; Thu, 12 Jan 2012 01:17:57 -0800 (PST)
In-Reply-To: <vpq39bll1ua.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188438>

2012/1/12 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> This allows you to do
>>
>> git diff --no-index file1.old file1.new file2.old file2.new...
>>
>> It could be seen as an abuse of "git --no-index", but it's very
>> tempting considering many bells and whistles git's diff machinery
>> provides.
>
> I find this very, very unintuitive. I tried with GNU diff:
>
> diff 1 2 3 4
>
> and it complained with "diff: extra operand `3'". I find
>
> git diff --no-index file1.old file1.new
> git diff --no-index file2.old file2.new
>
> far more intuitive, less error prone (when you start having a
> non-trivial list of arguments, it's hard to tell which is the new and
> which is the old visually), ... So I'm curious why you prefer your
> syntax.

Single operation has its advantages:

 - one pager
 - one stat and summary
 - might be easier to script (just throw them all to xargs)
 - hell, i might even benefit from git copy/modify detection
--=20
Duy
