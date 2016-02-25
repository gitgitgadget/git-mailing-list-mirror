From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] refs: mark a file-local symbol as static
Date: Thu, 25 Feb 2016 15:09:20 -0500
Organization: Twitter
Message-ID: <1456430960.18017.49.camel@twopensource.com>
References: <56CF55ED.9040906@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:09:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2E4-0007gh-4R
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933740AbcBYUJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:09:24 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34291 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933286AbcBYUJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:09:23 -0500
Received: by mail-qg0-f51.google.com with SMTP id b67so49162740qgb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 12:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=VJesyLTBxvRvov1NMCkMcvN4HkM/uBplPmB9V5+DPE4=;
        b=U86JdeS9vPcNmoSfVQz2Ahz1R72IW7MdATyIxCOBzRE/UWK/pHZzVeeBpN6nc/pSU+
         4BFapwOvJ3RDvy/vIO8l9TNAVHxrywhPhfXmKK/XYlYOWLlWAr6a1Z8o4ZlY6D3LyfUK
         cFoxu65ayDwjVpwBhQpUk7iYDGJGaZC3txuq8dRpSamq9Z8ybCLreM+2kaW6c4mRUJxE
         Tf/7SFqivp/uqBe7pqBtTzl8daLl6CTwMpoDqkkAZt67ljGG262fFIPZOT2uZL41REKz
         PGLFEQxx6N/BoMleZnMwhGJ+YikyVpJWG7w27968egK+2xwCcSXRU6oGEEP8XK2cohWP
         8K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=VJesyLTBxvRvov1NMCkMcvN4HkM/uBplPmB9V5+DPE4=;
        b=a2+li6yNPB7ZfSjC+W1u0x4KJmM/gtWdVf1LathZqESddTt1xlAwT5hxuBmtqygbxX
         2A0L8pve4gfzAsODMQRUKZFm9czPF5bvAkNpeocXsd+uoO+g0Z36SBebDP2USL2gGSYt
         m1OePXPxgVPkb65ILTbNjxi/vqzFqOWPoGh7ncZqFpbnaE+xiNRN9BUa9CeYqdPp+z+Y
         yQQubhGOBhTk3Q4S11ECW9NLppB+o4noFObGvGACLyCjSgLDVw+aH/oqvXu0NpKhM0O7
         TLa1lfT/c/f6QaYip68qd0Rgp9lLbBGU6eaShcPpXnNA+ujpfWBR2YmWkIV9FA4S7W3O
         Y+cg==
X-Gm-Message-State: AG10YOSoog939bmnRZSTFO4qj/sX3taKRqM9QY/MfXDODOcKKy97St6BsRJy3bORVynhtQ==
X-Received: by 10.140.109.98 with SMTP id k89mr57984678qgf.69.1456430962249;
        Thu, 25 Feb 2016 12:09:22 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id a196sm3872295qha.49.2016.02.25.12.09.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 12:09:21 -0800 (PST)
In-Reply-To: <56CF55ED.9040906@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287427>

On Thu, 2016-02-25 at 19:28 +0000, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi David,
> 
> No, you are not having flashbacks - you forgot to make the
> register_ref_storage_backend() function static. ;-)

Oops!  Must have lost that in all of the rebasing!  Will fix, thanks.

> BTW, I still have two symbols showing as exported but not used,
> namely:
> 
>     $ diff nsc psc1
>     ...
>     32a35,36
>     > refs.o	- resolve_ref_unsafe_submodule
>     > refs/files-backend.o	- do_for_each_per_worktree_ref
>     $ 
> 
> Both of these symbols are used by the lmdb backend, so I'm assuming
> that
> they are part of the 'refs API' and will (may?) be used by other
> alternate
> reference backends. Is that the case?

Yes.
