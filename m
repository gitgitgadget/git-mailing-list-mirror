From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add case insensitive support in matching pathspec
Date: Sat, 5 Feb 2011 11:14:58 +0700
Message-ID: <AANLkTi=5j1kjAjY6ek6YXTs24DO9J7X0QQjTB4qrZ_g3@mail.gmail.com>
References: <1296751106-15316-1-git-send-email-pclouds@gmail.com>
 <201102032117.32745.j6t@kdbg.org> <AANLkTi=8-NibvV0NMCpA_KN6+x3GNa0mDr87jtWki_-S@mail.gmail.com>
 <7vei7nxuw5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 05:15:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlZYe-0001OH-T7
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 05:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab1BEEP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 23:15:29 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59525 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab1BEEP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 23:15:29 -0500
Received: by ywo7 with SMTP id 7so913032ywo.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 20:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HkgDs70kNUYRY3rphS7IZqCC+H7FH5aLe84MJAAAjb0=;
        b=gC4GIiwn5W6am3/zho15Tl9T7gfTZfK7Gtc2tMYS8NOc4xgUbpjJ6dsW8zUBEK1LIr
         ubiG3gC/yb+ruTLJTwjfIE6mM0B/xsL+rYA/GZlcYdD6DUFpbiKg4LBXB22Zv9XyI9cm
         o9VkeBrNwpWyOmqP0w0kiukKZ2cu4lvdkuxws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=R0KCq7Ul3qmIncvHvs0qN8y5v5nqvdsz18an+k1QAfauZtKmBXNSTE2k/w6MA3nCfI
         2qBHlXplHeb0wgqfG7nctKgbL8zxCaUrYsHjoNZGOW5+kFEGy65e6hC6jLaiFm/UM9LM
         2v44JsJHLDWHgEcXwbchdOnB4kjdaNXaMsr3Y=
Received: by 10.236.103.11 with SMTP id e11mr6401748yhg.43.1296879328252; Fri,
 04 Feb 2011 20:15:28 -0800 (PST)
Received: by 10.151.145.12 with HTTP; Fri, 4 Feb 2011 20:14:58 -0800 (PST)
In-Reply-To: <7vei7nxuw5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166074>

On Sat, Feb 5, 2011 at 6:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>>> core.ignorecase should be honored only when files on the filesystem are
>>> matched, IMO.
>>
>> Names in index, just as same as match_pathspec().
>
> If the matched entities are names in the index, they should already be
> canonical and we shouldn't be matching with icase, no?

The patterns are case-insensitive. The example given in 21444f is "git
ls-files mydir" should also match MyDir/* in index. Although by
modifying match_one(), it affects more than just git-ls-files. I'm not
the original author, so Joshua, was that patch to fix git-ls-files
only?
-- 
Duy
