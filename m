From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking extra
Date: Tue, 25 May 2010 08:41:14 +0200
Message-ID: <246B0C3F-EBD3-41EC-B0FD-300BD1DBF43E@gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost> <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com> <20100522222746.GA2694@localhost> <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com> <20100523115127.GA20443@localhost> <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com> <20100524094905.GA10811@localhost> <986EE696-5997-40AD-929C-D82D40D7242E@gmail.com> <20100524221128.GA29588@localhost>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue May 25 08:41:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGnpM-00034i-ND
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 08:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184Ab0EYGlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 02:41:19 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:50155 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121Ab0EYGlS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 02:41:18 -0400
Received: by ewy8 with SMTP id 8so435348ewy.28
        for <git@vger.kernel.org>; Mon, 24 May 2010 23:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=A9Zp5eQxcumOBwkqaNG1nIA92Wq3jqX4HuC2IY301Uo=;
        b=b3RUncc8Mk9WkP9MZttj2MyeiuQi9+7tkA9wpmjQEQlziZgsRbOr1sFoCIOuD2Xjsp
         7/QLppfVl8kSfIexMZKVlKL8BtI/InrGQ+ySerNf6issSUmQwfykOm3123A7pxmev86g
         jg5+vqGfrW5VTecWoF8voT6kowpH2gqKMuyZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=xxVRercu5whUvWVbvAgAGvC7OUHLot6Q8LqyI7k43GRzCY6xf+LB4zYSHH0AsF15Tz
         cXHxhZmwMcewmzyi0RarjaL5NsReXdBhtGRmojvrj9yWQSVv29LjwSXrgUFEeLehFWHz
         m+Ps9nWBHCtmeTshRTlhuGHrI46ObCtLUfyhc=
Received: by 10.213.14.11 with SMTP id e11mr261176eba.44.1274769676868;
        Mon, 24 May 2010 23:41:16 -0700 (PDT)
Received: from [172.16.3.204] (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm2327267ewy.2.2010.05.24.23.41.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 23:41:16 -0700 (PDT)
In-Reply-To: <20100524221128.GA29588@localhost>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147668>

On 25. mai 2010, at 00.11, Clemens Buchacher wrote:

> I am not just making this stuff up. These things have bitten me in
> the past, and there have been complaints about it in #git. And even
> after finding the solution I always felt like crlf handling in git
> was really broken. I was hoping that after enabling the new eol
> handling, these weird effects would go away, but obviously they
> don't.

Sorry, I was in a hurry and shouldn't have been so dismissive.  I do think that the new features will help more than they cause trouble, though.

[...]

> And I don't see why we cannot do better. In the first scenario of
> my previous post (no attributes set), since I already enable
> core.eol = lf, couldn't we handle that as if text=auto were set on
> every file?  Isn't that what core.autocrlf = true means in this
> case?

Isn't that just the current core.autocrlf=input behaviour?  The reason autocrlf was changed is because it breaks badly on repositories that have text files (ie, files that the autocrlf mechanism wants to normalize) that contain CRLFs in the repository.

If you see someone who has problems with autocrlf in #git, it's almost certainly because autocrlf is on by default, they cloned a repository, and now a seemingly random selection of files are dirty and checking them out doesn't help.

The "safe autocrlf" patch fixes this by not trying to normalize any files that are not already normalized in the index.  This is what you noticed: the files do not show up as dirty and will not have their line endings converted.  The tradeoff is that setting "core.autocrlf" no longer normalizes all text files, only new ones and ones that are already normalized.

You (rightly) expected line endings to be normalized to LF when core.eol=lf, and I do need to fix that in the documentation.  Safe autocrlf _only_ works if you want CRLF line endings in your working directory.

A similar feature that converts text files that have CRLF in the repository to LF would need more development.  I don't know how many people would use such a feature, and I would solve that problem by setting "* text=auto" and normalizing the repository instead.

> And once we normalized the file to LF, why don't we also checkout
> that version, or at least mark it as dirty in the index, so a reset
> --hard will fix it up?

I dunno.  Won't it be even more confusing that the file is still dirty after you add it?  The problem with converting it in the working directory when you add is that it loses information: if you didnt' want that file to be converted, there's no way to revert (this is very bad if it's a file that contained a mix of CRLF and LF).

Maybe rewording the "[CR]LF will be replaced by [CR]LF in <file>" warning to tell the user how to get the working directory version normalized would be the best solution.

As I said, though, this is a one-time problem: once your repository is normalized and has text attributes set, it will stay normalized.
-- 
Eyvind
