From: James Pickens <jepicken@gmail.com>
Subject: Re: [PATCH 6/8 v2] sh-tools: add a run_merge_tool function
Date: Tue, 31 Mar 2009 11:15:52 -0700
Message-ID: <885649360903311115o6131988emdcba6ef215ec0ab0@mail.gmail.com>
References: <1238400684-14881-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 20:18:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoiX1-0006dQ-3w
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 20:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbZCaSP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZCaSP6
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 14:15:58 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:48506 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbZCaSP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 14:15:58 -0400
Received: by gxk4 with SMTP id 4so5678942gxk.13
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zUoBznZHEWpIGT2bwia9Ec0vXdQgJvqgCmuhNOg5sSc=;
        b=GRmDR2PSryxLGThS0xLYm10olximje/Td9kKJKhJGQrlwCvQVnAQy5ja4FS92fbkQr
         CZuP5xtvphYZ5j0CFFfd73/oMTlT48ZrHzhxQprGh+l6IZGT8Q6x6wF2IkqcNtwuQFd6
         1bfSJB4IHe7H7Rnb1p8bGYWfBvflWpKm/KBdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vf2A1FZJ7AClPKFneZbmtc9GmsjPyHUQdJvuPAo9NfeXaHyMfDnWTviCp5r9eGUpd/
         sMWDSQ1azN86DyZRD7JEQJasZGqfIVs11T6Lnt2eLN7sICbDDPvCWl2sc4DJVRHQCXv5
         uOwBeu1avGDMb0kGPghQ7Gx9DLqBpSkayqymw=
Received: by 10.114.195.19 with SMTP id s19mr4561978waf.123.1238523352997; 
	Tue, 31 Mar 2009 11:15:52 -0700 (PDT)
In-Reply-To: <1238400684-14881-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115296>

On Mon, Mar 30, 2009 at 1:11 AM, David Aguilar <davvid@gmail.com> wrote:
> This function launches merge tools and will be used to refactor
> git-(diff|merge)tool.

Thanks for writing difftool; I find it quite useful.  I tried it with
tkdiff, and noticed that it shows the 'merge preview' window even though it
isn't doing a merge.  If a user with unstaged changes were to carelessly
click the 'save and exit' button, his changes could be lost.  So I think
it's a good idea to stop the merge preview window from showing up under
difftool.  To do that I think you just have to remove the '-o "$MERGED"'
option to tkdiff.

James
