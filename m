X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Sun, 10 Dec 2006 18:01:58 +0100
Message-ID: <200612101801.58247.jnareb@gmail.com>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <elgpjk$ggm$1@sea.gmane.org> <b0943d9e0612100831t7b79d4b1p436de5dbb813e51a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 16:59:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JTxzeP6XMrvhnSxvmZIeK6KPcAN9YIps3wCS4XjHP0ErHXxEuQBtWNGzkDsU1rziErhgiYKl87xUKOcnF9yc6zoC7t9yQFJ8wR6x9dFiIzDUwaXNB7ywad1wzA9aYazLnP9vUSLS4pF4sqsBjYrBTh46vKMUqrkxevmao0jVSuM=
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0612100831t7b79d4b1p436de5dbb813e51a@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33901>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtS1p-0001wb-IR for gcvg-git@gmane.org; Sun, 10 Dec
 2006 17:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762263AbWLJQ7l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 11:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762264AbWLJQ7k
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 11:59:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:51775 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762263AbWLJQ7k (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 11:59:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1124430uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 08:59:39 -0800 (PST)
Received: by 10.67.92.1 with SMTP id u1mr2237608ugl.1165769978849; Sun, 10
 Dec 2006 08:59:38 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id i39sm5973231ugd.2006.12.10.08.59.38; Sun, 10 Dec
 2006 08:59:38 -0800 (PST)
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Catalin Marinas wrote:
> On 10/12/06, Jakub Narebski <jnareb@gmail.com> wrote:
>>>> Here are some issues which are a bit annoying for me:
>>>> - make "stg help" (without command name) equivalent to "stg --help"
> 
> There was a patch in this area. Doesn't it work correctly now?

I use stgit 0.11

1056:[gitweb/web!git]$ stg help
usage: stg help <command>

while "stg --help" lists all commands.

>>>> - stg new lacks --sign option (I have to remember to do this during
>>>>   "stg refresh").
> 
> For that I use the .git/patchdescr.tmpl file to use as the initial
> commit message. This has a Signed-off-by line.

Ah. I'm sorry, I haven't noticed this. It is
in /usr/share/stgit/examples/

>> And as far as I can see it doe not use git credentials (user.name and
>> user.email).
> 
> StGIT now uses the GIT credentials (and config files).

Hmmm... in stgit 0.11 "stg refresh --sign" once gave me Signed-off-by:
Nobody line instead of using git user.name and user.email.
 
>> And yet another one: better support for reflog, namely giving the "reason"
>> i.e. the reflog message (like "stg push: <subject>", "stg refresh:
>> <subject>", "stg pop: <subject>", "stg commit" etc.), like git-rebase,
>> git-commit --amend and git-am (for example) does.
> 
> I had a patch doing this but I haven't included it. I considered it
> was taking extra time for the push operation. I eventually added some
> patch history support via the "stg log" command.

The git commands StGit uses to perform operations automatically record
changes in branches in reflog. What StGit does not provide is the "reason".
You do use git-update-ref?
-- 
Jakub Narebski
