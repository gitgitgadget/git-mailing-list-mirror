From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git find (was: [RFC PATCH v3 8/8] --sparse for porcelains)
Date: Tue, 18 Aug 2009 21:35:05 +0700
Message-ID: <fcaeb9bf0908180735s583bfdcajc354723c9faa48@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<2729632a0908171734p16d6ee7dm5f62848f7625ffbc@mail.gmail.com> 
	<fcaeb9bf0908171843x6ab0763dqff7e8aea0443c374@mail.gmail.com> 
	<200908180825.55289.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 16:35:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdPmo-0001cu-5O
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 16:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451AbZHROfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 10:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbZHROfY
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 10:35:24 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:52402 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbZHROfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 10:35:24 -0400
Received: by ywh3 with SMTP id 3so5204696ywh.22
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UnU4CcnHpTulAT+WTZVpZCjDbNdulUH4W3ECJKAa/BE=;
        b=qraPzxjvWLAwysRyGfagUDTVNNLuALuwoWAGux/XLoRb/gwTddb7p7UzzUSY6awH+/
         T61JLwVvTtQRkxlwTGPgC9XZzDZ8PKgmK8w60GZmIKuH31s8iDIdbHi9ZQDnpvqe+fCN
         tQFMPty/VC2S6Yowou3UQabdMSti//c9m9A5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uWeTBmfyRgID4GeTcAhS/4KxJq1DFsO6zEO0T0f01lKxNuwuMzOPlvHMZYXOnOe0Ec
         m6Yd2V4aJiQQYgNmpfbXGtPaM7UsZ4KvTn0ghpPR8PHoQg5/xcrKDLvW3dWN0yGfWdCY
         DRMt13bZRu+D1XS32DnThUc7mJ0gfXo6Nlglg=
Received: by 10.101.44.1 with SMTP id w1mr5574554anj.113.1250606125152; Tue, 
	18 Aug 2009 07:35:25 -0700 (PDT)
In-Reply-To: <200908180825.55289.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126400>

On Tue, Aug 18, 2009 at 1:25 PM, Jakub Narebski<jnareb@gmail.com> wrote:
> Well, I also think that it would be nice and useful to have "git find"
> in addition to current "git grep".

Can you make a draft on how you want "git find" to be? Except the
"-exec" part, Git allows us to search using various commands
(ls-files, rev-list, log). I don't think a single "git find" can cover
them all. I was thinking about putting more find-options to search
commands we already have. ls-files would support -exec, for example.

A few things that I'd love to have supported:
 - --depth for ls-files (probably all pathspec-as-argument commands)
 - logical combination of search criteria
 - unified blob locator. git-show understands SHA-1:/path/to/blob
syntax. What if git-log can output using similar syntax, then feed
them to git-grep in order to grep through (across commits)?
-- 
Duy
