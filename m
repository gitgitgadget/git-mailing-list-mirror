From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git fast-import : How to change parent during import?
Date: Tue, 8 Mar 2011 21:19:50 +0000
Message-ID: <AANLkTini6NgeYxRdFtSDKe8GEEszDvXwRtLnuymiRNt4@mail.gmail.com>
References: <AANLkTikiEfUSdNqqTjuYy_JLJnEyCizmusSucYsEHC2r@mail.gmail.com> <20110308024427.GA21471@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4KQ-0005m3-RH
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255Ab1CHVUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 16:20:22 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63573 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab1CHVUV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:20:21 -0500
Received: by vws12 with SMTP id 12so5092036vws.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 13:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=rv3bk5Eg6Lgk1KW7tTrXEiDzKJ6fJGzMZe72Qa9iwUI=;
        b=dDDaVs1Z/uEl1RG+zmBlkzLfQcGI5wTA4HaQX9tmn0H502T0h7VK97eRUOBJ86ikFa
         z+qk9tpzfOai4sKqAQoh0kK5ZLP/qJTsgBkEdWUCitTCghkef1SkgRVxcbEzOHpKfKsC
         8v0Bm4EPolCOcG8r5zz//7UuRbIzNI0FFqGjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=R73LhYCBxeHyVpD9e0m2mhlDhERsBwduXe2VSf14lq3YrPoO1NqQkXMQqFlaSo3TMD
         BJcziTVIrbnM1J7n8qLNhvU1ymxtPJaFV/hY25ScVxaMNy/1GuDw27q99YcfhiH7sptK
         j8eh5b1i7hASWHBubfpLtriQqfcqLtYtZikSI=
Received: by 10.52.0.169 with SMTP id 9mr8096582vdf.303.1299619220086; Tue, 08
 Mar 2011 13:20:20 -0800 (PST)
Received: by 10.220.178.130 with HTTP; Tue, 8 Mar 2011 13:19:50 -0800 (PST)
In-Reply-To: <20110308024427.GA21471@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168697>

Hi Jonathan,

On Tue, Mar 8, 2011 at 2:44 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Is it possible to change the parent of a commit during fast import?
>> I've tried using "reset" command and making a new commit pointing to a
>> new parent, but in both cases I get a "new tip ... does not contain
>> ..." error message.
>
> Have you tried "git fast-import --force"?

Oh... I completely overlooked the command line argument list in the man page...
Thanks for the tip, worked like a charm!

>> Providing a bit of context. I'm trying to improve git-p4 to detect the
>> parent commit of a new branch.
> [...]
>> To achieve this I used the checkpoint command to flush the list of
>> imported commits to disk and then used standard rev-list and diff-tree
>> commands to make find the parent commit. I am now at a point where I
>> am able to correctly identify the parent commit, but when trying to
>> update the from information I get the above message.
>
> The advice in the section "Use Tag Fixup Branches" of git-fast-import(1)
> might be useful.

I'm still trying to understand it. Do you know of any practical
example that I can look into?

Thanks for your help,
-- 
Vitor Antunes
