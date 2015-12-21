From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [git-for-windows] Case insensitive branch names
Date: Mon, 21 Dec 2015 19:21:02 +0700
Message-ID: <CACsJy8CEYaf9NA4J_2u1cqsikYvtR7nz=FEiwAxsKMLSREDhCg@mail.gmail.com>
References: <D350A5BC87B74A53B5BE4B10BC658208@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	git-for-windows <git-for-windows@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Dec 21 13:21:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAzT7-0001Yx-K4
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 13:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbbLUMVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 07:21:33 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33194 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbLUMVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 07:21:33 -0500
Received: by mail-lf0-f42.google.com with SMTP id p203so111034170lfa.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 04:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+la1TfcUg3oEKlInN5Fh9fL9+m4XfMD3tPDXZyx/490=;
        b=WDyYQ3Ou5kIBe4pIJhBHYRyBXgN8Q5XEW5UWc+BdUvY+aOYmg4e7QTW09gQYJoLfxX
         P58oxUnvsgf40PWdKtN/BE7aqGjvRzHTQJI809MXPU7cro7tFxkvVwojGT72M3prp74n
         U27T5TzeWyQ3bmjy9QUdlrapEdLUS5HFH+owwOgC2l3tWa2nBP8GTgrANvhRGcNvOOOt
         J8kKrBn6oOI9mtXgKM9+tPQOOty+dF8owmMuz2qwPYaek70+hw4JNueVc12fI1VGTZTO
         TbKbP4d597Ggq3EWIGrhp3cK4YGg8h0r0G9yA4zoK37ZSUb4nGJsRQNRkWRFA4Ja1gWp
         gQfA==
X-Received: by 10.25.141.9 with SMTP id p9mr6378534lfd.112.1450700491709; Mon,
 21 Dec 2015 04:21:31 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Mon, 21 Dec 2015 04:21:02 -0800 (PST)
In-Reply-To: <D350A5BC87B74A53B5BE4B10BC658208@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282792>

On Mon, Dec 21, 2015 at 6:01 PM, Philip Oakley <philipoakley@iee.org> wrote:
> On the Git User's list, Diego J. reported that:
>
> 'When I "checkout" a branch using different Upper Case/Lower Case than the
> original, the branch doesn't show in "git branch [--list]"' [1]
>
> While case sensitivity for filenames is a common issue on Windows and the
> like, I haven't seen any discussion regarding ref name sensitivity - any
> pointers to past discussions?

Multiple ref backend [1] should solve this.It's supposed to help
handle a huge number refs. But a side effect from not using file
system for refs is we can handle ref case-sensitivity much easier. And
I believe David had that in mind he chose lmdb (because of Mac, which
shares the same problem with Windows)

[1] http://thread.gmane.org/gmane.comp.version-control.git/281925
-- 
Duy
