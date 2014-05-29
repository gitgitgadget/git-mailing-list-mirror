From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Thu, 29 May 2014 17:50:56 +0700
Message-ID: <CACsJy8BREpVFKq3mW=Lwn+uNm1r40Xe8f4EyXLFN2yybZRT0oA@mail.gmail.com>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Rodrigo Fernandes <rtfrodrigo@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 12:51:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpxvy-0003C1-7A
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 12:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbaE2Kve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 06:51:34 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:45019 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757240AbaE2Kv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 06:51:29 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so374566qga.20
        for <git@vger.kernel.org>; Thu, 29 May 2014 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vwAgCHxvSAplZ4kCJVRVZMyQgBq0FL7w9nIMNtIxDGc=;
        b=rgZiz/lf/s1+iJsV6RPwqcw/eMVKBNHlgt7vFcwWDoGI4yaBW49zkvHwK1fHJ0GBb7
         pVXfyt4dKgUrML1S/1+v/Em6tqy4aCSS8135V3OImLUqPApP+mgNPJE+0vNcr8caoDn3
         w7ljR9qzlyqrZsvcj2UHb5Is+xURZmwsFrb/L+vwBXiNRl5h8V/mvbBOfUJUy6GTuCZ2
         FnfBnI5E/PieKyaIZpT8c5StAlGqE5NvV4CGRY6gQ2EYGJn9hzq7j3qsHVnQgyh8sYn4
         X+lR58V/DXRedoY0yV/eebaIjhz6i5zOPHpfOpJAm0vTNJS8aYcDRuVt6pVnLVAEtH4v
         jt3w==
X-Received: by 10.224.160.202 with SMTP id o10mr9040127qax.8.1401360687753;
 Thu, 29 May 2014 03:51:27 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 29 May 2014 03:50:56 -0700 (PDT)
In-Reply-To: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250359>

On Thu, May 29, 2014 at 5:29 PM, Rodrigo Fernandes <rtfrodrigo@gmail.com> wrote:
> I get an empty response on the date field, but since pretty has `%ad`
> it should follow the --date and return the date even if wrong.
>
> ...
>
> I tried to check the source code but have no idea where to start,
> maybe if you point me on some direction I can take a look for my self.

pretty.c, format_commit_one() -> format_person_part() ->
show_ident_date() -> show_date(). The last one is in date.c
-- 
Duy
