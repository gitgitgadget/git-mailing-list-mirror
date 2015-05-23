From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git status doesn't ignore GIT_DIR directory?
Date: Sat, 23 May 2015 18:42:57 +0700
Message-ID: <CACsJy8C2LHVrZ-MPupz2_BbE-5m7_fA7qK5HdUa9GR30y8YNPw@mail.gmail.com>
References: <555FD1EA.2060706@rightscale.com> <CAPc5daW2yTHHegPDrEWS5KiSYWZECV+AxMnewzz9ayASB1QNUw@mail.gmail.com>
 <20150523022256.GA17789@lanh> <20150523053900.GA2364@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thorsten von Eicken <tve@rightscale.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat May 23 13:43:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yw7q5-0001Er-Kq
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 13:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908AbbEWLn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 07:43:29 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36687 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757290AbbEWLn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 07:43:28 -0400
Received: by igbpi8 with SMTP id pi8so8354726igb.1
        for <git@vger.kernel.org>; Sat, 23 May 2015 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ontRWzNn3g1p209t3P9mKfjHj/4iPojInsVEKU4fXm0=;
        b=X1umH8Be7B6CiTtfLCNIDSYfKV7xxLdyUge5ZgX2cnl2G5w8kn5bUyTw+jWZaPalNM
         qwOcyyarUeJJE3l0Nci59PGqc7FaN3EnkibTCkn6ebZmKAQAZDmch7S28Mz3uyxUeqD/
         DByQCzxfaz3SuK8NN3LOXJievOxntV6bFP5xnk8gBSKl/UY7FdbhKbzVGe21Us30QZff
         24lc3B4hq5Qy3jRfBRxUeMpt7E4tpmNK8aNDTdKcJ92xy+f2jn1Y+kznmFmHk4zAZv9i
         YljvaDhCXbuO/pDPgcPHloAR9gkZ17TVHd1NS3uLM72p7iE+DHokcfIPV4O7Rrrvr2UB
         bg5Q==
X-Received: by 10.107.128.30 with SMTP id b30mr16271552iod.84.1432381407501;
 Sat, 23 May 2015 04:43:27 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Sat, 23 May 2015 04:42:57 -0700 (PDT)
In-Reply-To: <20150523053900.GA2364@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269800>

On Sat, May 23, 2015 at 12:39 PM, Mike Hommey <mh@glandium.org> wrote:
> On Sat, May 23, 2015 at 09:22:56AM +0700, Duy Nguyen wrote:
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -691,6 +691,9 @@ Git so take care if using Cogito etc.
>>       specifies a path to use instead of the default `.git`
>>       for the base of the repository.
>>       The '--git-dir' command-line option also sets this value.
>> ++
>> +Note that if GIT_DIR is set explicitly to a directory inside working
>> +tree, the directory name must be ".git".
>
> Isn't the requirement that it _ends_ with ".git" (that is,
> GIT_DIR=/path/to/foo.git would work)

If $GIT_DIR points to somewhere inside worktree, ".git" exactly (it's
strcmp(), not ends_with()) is the only exception. If it points outside
worktree, the directory name could be anything.
-- 
Duy
