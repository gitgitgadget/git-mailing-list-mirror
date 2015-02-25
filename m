From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Wed, 25 Feb 2015 20:46:37 +0700
Message-ID: <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
References: <54EDBEC2.8090107@peralex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Noel Grandin <noel@peralex.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 14:47:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQcJ1-00017x-GK
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 14:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbbBYNrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 08:47:09 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35591 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbBYNrI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 08:47:08 -0500
Received: by iecrl12 with SMTP id rl12so4953475iec.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 05:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UXFiaLdRzIabmUCf0WqWVYCXvKe83Yryq5gUm8nubIE=;
        b=PDNyXQLVl8e3pUbmzGhw+Xi1AyN8byrUxAv+M3sPQVp5iaHfBFzWSPamq4on+Oe44k
         gL5jH27mQeU/SLBBuT+IXnH/yOBjYAkI8IeBlalkTRTUnyejJfFFnGUxjkWmxlHp7TZy
         eA5tBaaA9O8x9wMnNNNdEqCMF2frloPnjhVBSK1x2B4b73mROTRUvoiGSDLb2g5SShON
         tSMjFk1RuYwsaxZTZtorjLemFMwJwoa192lzN8Ij9EyggwfTzxH2YHwK0tASfqRWuAra
         ostfZ4Yhf+uRRB0IjFdeTOOqYAiijmaGoHa2vcK0S0UWNWq/8M6Pq9yhS5M1Q0avZA4T
         Wrlg==
X-Received: by 10.42.109.20 with SMTP id j20mr3654113icp.27.1424872027687;
 Wed, 25 Feb 2015 05:47:07 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 25 Feb 2015 05:46:37 -0800 (PST)
In-Reply-To: <54EDBEC2.8090107@peralex.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264393>

On Wed, Feb 25, 2015 at 7:23 PM, Noel Grandin <noel@peralex.com> wrote:
> What would be nice is a per-user/repo config setting that excludes certain
> files and paths from the 'git grep' search.
>
> Does this sound reasonable/acceptable?

There is no config setting to do that, but since v1.9.5 you can use
':!' or ':(exclude) to exclude paths, for example

git grep foo -- '*.c' ':!src/ ':!*foo*.c'

will exclude .c files in src directory or contains "foo". If you use
some exclude patterns often, you can write a short script. Perhaps we
could support pathspec macros (similar to git-attr macros), stored in
config file. You still need to type, but it'll be a lot shorter.
-- 
Duy
