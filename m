From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking extra
Date: Sun, 23 May 2010 14:53:18 +0200
Message-ID: <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost> <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com> <20100522222746.GA2694@localhost> <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com> <20100523115127.GA20443@localhost>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun May 23 14:53:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGAgJ-0006Fo-Tf
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 14:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab0EWMxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 08:53:22 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60970 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab0EWMxV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 May 2010 08:53:21 -0400
Received: by wwb13 with SMTP id 13so421063wwb.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=/oujvEeISyMqaDs0An703JsVwZ8W3t3xnPyA9HK2Z4k=;
        b=VF2MuZl54GGKRQdZTcZqD4QjzAMKvleCtt1vHhPe5SVa0NlZ34u+Mg8eO343XOjd4T
         FrMqZzbiG1c5IoR8PvFkTvZYhKLPzVupz+cbi/wBqGLo15nNRYPFQGo00B+0s8M4kqaM
         PUoetUvvz5JJayAuFDaOZak1xOwIH/OolWbxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=C3ZRhnmrGvp3XMB3wvJKO/ZMm02xVWj50oa9B+vejSXu0GsMVh33Onn9pAXnMRUbtm
         UhFlxr1OMMDh+j09UpjXBgt7CNnr9rdeP3rX/GczCSR3gb8GXnbfTaYyrftlCp/zXtBG
         Sdd/ZW9z8MH3iBB090OXH+hZuOKMtwSFffBiE=
Received: by 10.216.160.132 with SMTP id u4mr2089629wek.19.1274619199876;
        Sun, 23 May 2010 05:53:19 -0700 (PDT)
Received: from [172.16.3.204] (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm1439723ewy.7.2010.05.23.05.53.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 05:53:19 -0700 (PDT)
In-Reply-To: <20100523115127.GA20443@localhost>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147576>

On 23. mai 2010, at 13.51, Clemens Buchacher wrote:

> On Sun, May 23, 2010 at 12:36:51PM +0200, Eyvind Bernhardsen wrote:
>> Yeah, that's what I initially thought too, but it makes sense to
>> be able to use normalization to prevent line ending breakages in
>> your repository.  If a file needs CRLFs for some tool to work,
>> you don't want anyone to inadvertently convert it to LF, and
>> "eol=crlf" makes git enforce that.
> 
> Unsetting crlf/text already disables converting it to LF. The user
> would have to change the line endings in his work tree and commit
> the file with wrong line endings. I do not see how this can happen
> inadvertently.

That's because you don't use (or work with people who use) editors that mangle line endings without asking.  Modern versions of vi and Emacs don't do this, but the problem still exists in popular Windows editors.  I don't have strong feelings about the need for this feature, but it has been requested so it's probably useful.

[...]

> No, I am aware of autocrlf=input, but apparently I did not
> understand the meaning of eol=lf correctly. So if a file has CRLF
> endings in the repository, and eol=lf, it will _not_ be converted
> to LF in the work tree? Conversely, if it has LF endings in the
> repository, and eol=crlf, it _will_ be converted to CRLF in the
> work tree?

That is correct, but "eol=lf" means that the file _should_ be LF-only in the repository.  If it isn't, the repository is "corrupted".  Such a file is marked as dirty when it is checked out and will be normalized to LF-only line endings when it is committed, at which point the repository will be fixed.

This should only be a problem if you set the "text" or "eol" attributes in an existing repository, or if someone adds CRLFs to a normalized file using an older version of git.

I'm sorry if I was unclear about Finn Arne's patch: "safe autocrlf" only applies when files are normalized due to core.autocrlf.  If "text" or "eol" is set on a file, the file is normalized to LF-only regardless of whether it contains CRs in the repository.

> I was expecting eol=lf and eol=crlf to be symmetric, which is also
> the reason for my reply to Finn's safe crlf patch.

I think they are symmetric in practice.  While it's possible to get the repository into a state where you will get CRLFs in a text file that should be LF-only, it is both unlikely and easily fixed.
-- 
Eyvind
