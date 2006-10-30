X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 17:59:18 -0800 (PST)
Message-ID: <92622.251.qm@web31812.mail.mud.yahoo.com>
References: <200610300051.37896.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 01:59:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=01W3uw9ZG5hQ0K9ie83VcknuT+P9TLe0fN3N0QYSd9iZLi3eEe+f1uJL/JOeiB9m4A+sUwjnSlKCi+fzxCf5yTn7v/nWQ805XRqYohiqGKQt75r0XXLwiyk3soqDRKSDRfV+AflJXBwWGLyIQPxh+H6s+qlxOENSze/7Rj81ubU=  ;
X-YMail-OSG: rYd3OqcVM1m6oWzHBexvZ0l11xUjYZ5DhaZAoWmbIx9PgwqFhFsmMfbbt9.X0pWf4jQQSom5M1h5MeMhQH3xvvd7TChHrPq0DNbkCfCLCRNjCLhbSX3otysfa2GfzxZ.6pM_EHk6d14-
In-Reply-To: <200610300051.37896.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30481>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeMQx-0006Ll-8F for gcvg-git@gmane.org; Mon, 30 Oct
 2006 02:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030487AbWJ3B7V (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 20:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbWJ3B7U
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 20:59:20 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:25008 "HELO
 web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1030503AbWJ3B7S (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006
 20:59:18 -0500
Received: (qmail 464 invoked by uid 60001); 30 Oct 2006 01:59:18 -0000
Received: from [71.80.233.118] by web31812.mail.mud.yahoo.com via HTTP; Sun,
 29 Oct 2006 17:59:18 PST
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Replace "gitweb diff header" with its full sha1 of blobs and replace
> it by "git diff" header and extended diff header. Change also somewhat
> highlighting of diffs.
> 
> Changes:
> * "gitweb diff header" which looked for example like below:
>     file:_<sha1 before>_ -> file:_<sha1 after>_
>   where 'file' is file type and '<sha1>' is full sha1 of blob is
>   changed to
>     diff --git _a/<file before>_ _b/<file after>_
>   In both cases links are visible and use default link style. If file
>   is added, a/<file> is not hyperlinked, if file is deleted, b/<file>
>   is not hyperlinked.

"Everything clickable underlined" isn't the best way to represent things.
Anyway, my 2 cents is that I don't like the overly explicit underlineing.
I liked it the way it was in take 1.

> * there is added "extended diff header", with <path> and <hash>
>   hyperlinked (and <hash> shortened to 7 characters), and <mode>
>   explained: '<mode>' is extended to '<mode> (<file type>)'.
> * <file> hyperlinking should work also when <file> is originally
>   quoted. For now we present filename quoted. This needed changes to
>   parse_difftree_raw_line subroutine. And doesn't work: perhaps
>   unquote is broken.

In which case we shouldn't commit this.  IOW, let's commit things
which we _know_ to work.

Why not resubmit your original patch with the bugfixes as few comments
as mentioned?

> * from-file/to-file two-line header lines have slightly darker color
>   than removed/added lines.
> * chunk header has now delicate line above for easier finding chunk
>   boundary, and top margin of 1px.

Wouldn't this be confusing with the other fine lines?
I personally don't like this chunk separation.  Chunk separation
already exists as is and we view it all the time elsewhere.

If you'd like to separate chunks, why not darken the background
of the section of line the chunk header is printed at?  I.e.
anything between the @@ including the @@.

    Luben
