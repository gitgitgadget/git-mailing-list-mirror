From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git grep does not support multi-byte characters (like UTF-8)
Date: Mon, 6 Jul 2015 19:23:52 +0700
Message-ID: <CACsJy8BH_QJss57uMJNE=ojNT5vBWKN=eEdrBBS38g6As-UH6A@mail.gmail.com>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Plamen Totev <plamen.totev@abv.bg>
X-From: git-owner@vger.kernel.org Mon Jul 06 14:24:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC5Rq-0002cC-1c
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 14:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155AbbGFMYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 08:24:25 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38340 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbbGFMYW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2015 08:24:22 -0400
Received: by igrv9 with SMTP id v9so113637994igr.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IXFGj0+EQ5DVqW+Llm9DTxBK7j9zxMS3Op/HQxGEQp0=;
        b=0XicVtAEeRKXaE3xlydTr2mKpCtl0l/lfsx6MR/axWTJMw9OD0+4zLuaFYn/nYX77R
         MmvWKNcRe0HySgrM+NHroCCYv6nEVsKb5BGUBlIcehiMp6ulEHNlGNdQ4MyWuHn9y6Gu
         ftjfhcM6HhNcxQMxj3VLIjOULQs09bpcn467YDJQ6IngQHzc8ZSjojNRRTg7cMHxDgsP
         OCLOLcQawDaO2TCdxTelWruh04Xomg73wL0bgJyDUIsGxVVTse1T+15Bz9GL+HQVDtuD
         zC87VTMw4asIGm/Rv7w6esBzXQyEqEAMuqwvIVLf47cF2DDcjGi9pufR6BewITNtmIi6
         d4kQ==
X-Received: by 10.43.172.68 with SMTP id nx4mr32726304icc.48.1436185461918;
 Mon, 06 Jul 2015 05:24:21 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Mon, 6 Jul 2015 05:23:52 -0700 (PDT)
In-Reply-To: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273383>

On Mon, Jul 6, 2015 at 6:28 PM, Plamen Totev <plamen.totev@abv.bg> wrote:
> Hello,
>
> It looks like the git grep command does not support multi-byte character sets like UTF-8. As a result some of the grep functionality is not working. For example if you search for non Latin words the ignore case flag does not have effect(the search is case sensitive). I suspect there are some regular expressions that will not work as expected too.

I think we over-optimized a bit. If you your system provides regex
with locale support (e.g. Linux) and you don't explicitly use fallback
regex implementation, it should work. I suppose your test patterns
look "fixed" (i.e. no regex special characters)? Can you try just add
"." and see if case insensitive matching works?
-- 
Duy
