X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 11:55:54 -0800 (PST)
Message-ID: <20061029195554.77410.qmail@web31813.mail.mud.yahoo.com>
References: <200610291850.46321.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 29 Oct 2006 19:56:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=imUk+umCK6MfNM6L6SdfoK0tOa5JwmChkNbLlxQmmiTaFuiu/oHWxE666mlhGA8LzhQZGz+R7BnWFig3ml6imXrc/2aQonRXbUEBb+dcCRlJuYaxMYY7dhhMcH4AnCP1YPbtl8/OJqeMeVDg/yzOmCSlRCn3+W59khCnB8SiX1U=  ;
X-YMail-OSG: m4lfG8oVM1kC2Br2IRoBkTr09NEVRJIdiIp7FGBsnInFfM5hPIt3k1YUw9kz1CkK47Llgup7H3_SXOSWA1rz7Mr2Xx9VUHHrr2pzgTC3YzHBv_2UlpoGid6jT2xVVQKAq8dIh6FXgDM-
In-Reply-To: <200610291850.46321.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30449>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGlC-0005jf-QV for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965360AbWJ2Tzz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWJ2Tzz
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:55:55 -0500
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:18003 "HELO
 web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1751814AbWJ2Tzy (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006
 14:55:54 -0500
Received: (qmail 77412 invoked by uid 60001); 29 Oct 2006 19:55:54 -0000
Received: from [71.80.233.118] by web31813.mail.mud.yahoo.com via HTTP; Sun,
 29 Oct 2006 11:55:54 PST
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> A couple of questions regarding new patchset/diff look for gitweb.
> Currently patch starts with "git diff" header
> 
>   diff --git a/file1 b/file2
> 
> then we have a couple of extended header lines
> 
>   old|new|deleted file|new file mode <mode>
>   copy|rename from|to <path>
>   (dis)?similarity index <percent>
>   index <hash>..<hash> [<mode>]
> 
> then we have two-line from-file/to-file header

First revert back to monospace in the commit message.
As I mentioned in that other email, where the person
didn't CC you and thus so I didn't, see commit 
4b7ce6e2d6ba088da50de1df38b040ea2c0b8f18.

Can you please hyperlink what you had intended to
quote?  I.e. filenames which can lead the user browsing to a
state (pre-rename, post-rename, etc).  Thanks.

> 
>   --- a/file1
>   +++ b/file2
> 
> then patch itself.
> 
> 
> 1. Which parts to convert to hyperlinks, and which to do not? Which
>    links have visible and which hidden (underline on mouseover, the same
>    color as neighbouring text)?

I think the current state of your patch is good, sans the comments
received so far: monospace, that bug in the index links, etc.
Lets get that in, and then you can RFC another improvement on top of this.

>    I think that a/file1 in "git diff" header should be turned into
>    visible hyperlink unless file is created, and b/file2 should be link
>    unless file is deleted.

This is intuitive and makes sense.

>    Also both <hash>-es in "index" extended header lines should be turned
>    into links, as it is the only way to have hyperlink to all previou

Fix the bug though.

>    versions of the file in the case of "combined diff" format (to be
>    added later). The question is if those hyperlinks should be visible;

I personally love little hidden gems, but some people like everything
to be overly obvious to them.  Hidden gems are part of the learning,
but I'm sure I'm not going to convince everyone.

Hidden.

>    I don't have compelling reason against. Should we use title attribute
>    to give filename perhaps, or is it unnecessary?
> 
>    Currently file1 and file2 in "--- a/file1" and "+++ b/file2" are
>    turned into hidden links. Should we leave it, or should we remove
>    this link as we have similar link just above? If we decide to have

Leave it -- it's cool.

>    this link, should we also hyperlink <path> in "copy|rename" extended
>    header line?

If it makes sense.

> 2. Use quoted or unquoted filename, remove or leave surrounding quotes
>    in quoted filename? Should we unquote the not hyperlinked filename

Are you familiar with the term "legalism"?

>    in the case of creation/deletion? What should be span of link:
>      "a/_file1_", "_a/file1_", _"a/file1"_
>      "_file_", _"file"_ 
>    (where '_' marks beginning and end of link) for quoted filenames?
>    What should be span of link for unquoted filenames:
>       a/_file_, _a/file_
>    Currently gitweb uses a/_file_ in ---/+++ line.

Unquoted!  Now that we've solved this "problem", lets move on to more
interesting things. ;-)

> 3. How (and if) to explain numerical mode: the currently used

Let's not explain it for now.  Let's have your patch go in sans the
comments already posted.  We can always debate on that later.

Thanks,
   Luben


>    <mode>/<symbolic mode> (<file type>) e.g. 100755/-rwxr-xr-x (file).
>    Or <mode> (<file type>) should be enough? Should we mark the addition
>    compared to git-diff output? Or should we explain <mode> only on
>    mouseover, using for example:
>      <abbr title="100644/-rw-r--r-- (file)">100644</abbr>
>    or just
>      <abbr title="executable file">100755</abbr>?
> -- 
> Jakub Narebski
> Poland
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
