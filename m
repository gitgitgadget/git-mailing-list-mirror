From: Michael Mc Donnell <michael@mcdonnell.dk>
Subject: Re: git imap-send converting my patches to CRLF line endings?
Date: Fri, 17 Jun 2011 16:45:42 +0200
Message-ID: <BANLkTin1DAv0pZmZCcrtDyjrUD-ukO6MNQ@mail.gmail.com>
References: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com>
	<20110617141450.GA12114@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 17 16:45:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXaIw-0007nC-33
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 16:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083Ab1FQOpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 10:45:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50253 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758224Ab1FQOpn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 10:45:43 -0400
Received: by gyh3 with SMTP id 3so614184gyh.19
        for <git@vger.kernel.org>; Fri, 17 Jun 2011 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=D1ECnuHMpc/kFbj7Qtx7W3yWWDTQF30L0bZtFOhs57o=;
        b=ro1V+2Ve7OA6+S8MU8DQBlqjs6BDGM0xcd3tsFfRhGbB4uXUUSLwATYLfcEdXRK5F9
         zjtoxk0+HS87evl4w+t67FTyzFBMiXgvpJRUZ6Bh1eKDCQYi6gcA7za/TqdWM/nK7qLV
         KaS0f+PKwvrZzLeVUuQ5IIbyUwJB4HQIjmpGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=CfTARhBrq4xj0jrEfVp7yxYEbs+Led2xjjY+yAUY/CO9FrEDZa2LrwcFBX8tXCSXIJ
         hyLPV60uK2w11zt+BfI7YV/c7wbU41/has0cDtPfc745byYbw0AEye4OfY8pcmUQH74A
         v+18CM81tEJKdG+M/L5Q/42y6ATAEwEJFLQl0=
Received: by 10.236.185.202 with SMTP id u50mr2075658yhm.201.1308321942641;
 Fri, 17 Jun 2011 07:45:42 -0700 (PDT)
Received: by 10.147.113.1 with HTTP; Fri, 17 Jun 2011 07:45:42 -0700 (PDT)
In-Reply-To: <20110617141450.GA12114@sigill.intra.peff.net>
X-Google-Sender-Auth: lmpUi1sRlvgWqD8z5v-zBUks-pI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175948>

On Fri, Jun 17, 2011 at 4:14 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 17, 2011 at 03:35:04PM +0200, Michael Mc Donnell wrote:
>
>> I'm using git imap-send to send patches to wine-patches, and it seems
>> like it converts all my patches to have CRLF line endings?
>
> The canonical line ending for mail is CRLF. So yes, it will convert your
> patch to CRLF for storage. But anything pulling it out of the IMAP
> folder should convert it back to native line endings.

Ok, so it's the clients responsibility to convert it back?

>> I can see it when I download the patch from the Gmail drafts folder.
>> Git complains about white space when I apply the downloaded patch. It
>> works fine if I just use git to create the patch and then apply it on
>> a new branch. Is it git imap-send or just Gmail that's the problem?
>
> How do you download and apply the patch exactly? If you are speaking
> imap to gmail, generally the client would strip out the CR's from the
> mail.

I'm just downloading it with Chrome.

Steps to reproduce:
1. Upload patch via:
$ git format-patch --stdout --keep-subject --attach origin | git imap-send
2. Open Gmail in Chrome.
3. Open email in drafts folder.
4. Click attachment download link
5. Apply patch on a fresh branch with git apply.

Git complains about the white space, which indicates that the
downloaded version has CRLF line endings.

I guess there's not much to do if the fault lies with Gmail?

Thanks for your reply.
