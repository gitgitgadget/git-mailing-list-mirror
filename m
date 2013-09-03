From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Tue, 3 Sep 2013 19:37:05 -0400
Message-ID: <CAPig+cR6gsv+D4gu+hWStqp1t2C6ZkeSkqbg9H8UuQtHQhSmNg@mail.gmail.com>
References: <20130903115944.GA29542@gmail.com>
	<xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nazri Ramliy <ayiehere@gmail.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 01:37:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH09r-0006U0-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 01:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760864Ab3ICXhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 19:37:08 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42133 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab3ICXhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 19:37:07 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so5496916lbh.5
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=69Wg0tJ2tsAu1HQQNdBEeDM5OvGUOyteFTUrdKHpyj0=;
        b=LgdbPHr8yQdM8JNXLbUuAEdv77sjY74/s9stXtVvrKrru7dlD8fVwnlvRgDJQCwBVp
         LZp9qZZAosh4v44UdDZCyzyw4RSjw809qgNlmfnNW5UKznKYc9MMJ38FnmcW/MNgWb4m
         2LDfDkMDMyxia5oxb9MCGyNmS08B4VRl4PiXWFySMBTSteYgFds65l0zkvEzDbQNJsKT
         P/kvjMTo9fTTUi1rqt10HT7Kvl7q6MuVR7de+sDMEi8e4mUPrKsoRr64SUX3N3pkL6FN
         YoBVo0+98MRZ8q3gUxF5DOxg8W5xYFkA6YONl9TFs9pCl9vy05OmNAV3+GrgDyveB9ho
         QwYg==
X-Received: by 10.152.3.201 with SMTP id e9mr9658lae.24.1378251425687; Tue, 03
 Sep 2013 16:37:05 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 3 Sep 2013 16:37:05 -0700 (PDT)
In-Reply-To: <xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: K8pQuEsO6sPL7qJDgeAR7MkgHes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233798>

On Tue, Sep 3, 2013 at 6:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nazri Ramliy <ayiehere@gmail.com> writes:
>
>> -- >8 --
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index 83edf30..6105cb0 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -9,7 +9,7 @@ git - the stupid content tracker
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git' [--version] [--help] [-c <name>=<value>]
>> +'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
>
> I do not care too deeply either way, but I am curious if there was a
> reason why you changed the earlier <directory> to <path>?  Somehow,
> when we _know_ a path has to be a directory, I find it easier on the
> readers to spell that out, instead of saying "this is a path",
> implying that it could be a directory, a regular file, or even
> non-existent.

That change was in response to my review [1] in which I mentioned:

    Other options which accept a directory, such as --git-dir and
    --work-tree, are documented as accepting <path>, but -C is
    inconsistently documented as accepting <directory>.

>>      [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
>>      [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
>>      [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]

Thus <directory> was inconsistent with existing text in git.txt, such
as what is visible here for --git-dir and --work-tree, as well as
later in git.txt where --git-dir and --work-tree are described in more
detail (also using <path>).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/233441/focus=233564
