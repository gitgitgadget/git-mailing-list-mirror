From: Stefan Zager <szager@google.com>
Subject: Re: [PATCH] Make the global packed_git variable static to sha1_file.c.
Date: Wed, 12 Feb 2014 10:26:22 -0800
Message-ID: <CAHOQ7J-2BkQOr+_BF42ja4pWaUWkt8OC-YE0ETwHAYsmrubi=A@mail.gmail.com>
References: <20140212015727.1D63A403D3@wince.sfo.corp.google.com>
	<52FB22F3.8070100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 19:26:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDeVv-0008D4-Uu
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbaBLS0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:26:24 -0500
Received: from mail-ve0-f181.google.com ([209.85.128.181]:49915 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbaBLS0X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:26:23 -0500
Received: by mail-ve0-f181.google.com with SMTP id cz12so7508736veb.26
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=u95PiFRY5clq+p0nbOXsfvgYkUtTi+fcu6p1fk4Hji4=;
        b=JAmjr1eA7sdr2PbHqS60IxV6p7G5VX2jRnM2RZ44+n1diL6KfgkOrZ/fKNY4Pk4wfW
         SMR3hjKQD1F25NuBkJyBYXHcVZArx+OYLvNVopzLkgBnpfZ1syh+h7NHkz9dH/KxO4Uo
         bPZCiDaI6itr5jDJ5w7VYFvTnsvkrxZlCplQvlqcTygwvFreanJ2iDz8fVWe7DS+dz7p
         JHZgy6+O+S10oE9exxoda05ezcI6cZSq/BsQErslKLNgdREqgzLOzkUwNuIHTxXhTDgv
         ikG6mnEkB/YwCHCpjcTeDFI9gfyv2JIoQ51UEiB8v7Td0dZjDwDTH3OSUbwijIPL+h7T
         RDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=u95PiFRY5clq+p0nbOXsfvgYkUtTi+fcu6p1fk4Hji4=;
        b=HLz2TxqjWshu1UrKW+lRkMwZZACdGK3bsxCP19u/wzmAUvoFkC5dy6TneyoxNO/Kwn
         6jDeFdCI8j9pFiNyHPyhaYs5onSQErY8AiKrL0h9FnEb2Gs3uWkwu0ir1R+b0bl58K4f
         WDuYYb+8coc8hKrb5MOm6MViF7v03BmsgZvP0ABEHbmsAKTFRBiBYdwYoZMdiBNbB4Zn
         RZVPrRq7fKnPcvatfEaN0OMfwGbU6pryewTF6Fg7MpywLSVHyM0hYBGLYX76ngavww0a
         FI/iry6tzJb7RY2gd6TE24yduTHuKGpM+6Vf20ss6/P7x89U0Tx8q+FhWcebqzKSG2Nh
         +qkA==
X-Gm-Message-State: ALoCoQljOXStMvfVwq9lkYUqA2CunkbosSJ1AMzs30XjlVGhkQ2SlqkrKKfbE/uXJ6oXp332m8cEZRh4RvCm5j3Sf/XQAaanjckrRonNW9+eaFHsSLJ5zvUXfuEhCYYlWvUEw8bAb76ZfHu9vL45Ec40RJ9GGN4IHFEWRsLgANUtK0p15lcFoo2LtgnUO+ntIduVQcNgacIG
X-Received: by 10.58.100.100 with SMTP id ex4mr33959502veb.2.1392229582408;
 Wed, 12 Feb 2014 10:26:22 -0800 (PST)
Received: by 10.52.168.226 with HTTP; Wed, 12 Feb 2014 10:26:22 -0800 (PST)
In-Reply-To: <52FB22F3.8070100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242003>

On Tue, Feb 11, 2014 at 11:29 PM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi,
>
> On 12/02/14 14:57, Stefan Zager wrote:
>> From b4796d9d99c03b0b7cddd50808a41413e45f1129 Mon Sep 17 00:00:00 2001
>> From: Stefan Zager <szager@chromium.org>
>> Date: Mon, 10 Feb 2014 16:55:12 -0800
>> Subject: [PATCH] Make the global packed_git variable static to sha1_file.c.
>
> I'm not really qualified to comment on substance but there are some
> basic style issues w.r.t. whitespace namely using 4 spaces for indent
> and mixing tabs/spaces. This might seem pedantic for the first round of
> a patch but it does put off reviewers.
>
> From Documentation/CodingGuidelines:
>
>  - We use tabs to indent, and interpret tabs as taking up to
>    8 spaces.

My bad, I will upload a fixed patch.  In my defense: I edited the code
in emacs and then ran "M-x tabify" over the entire file.  But that had
the unfortunate side effect of adding a bunch of whitespace-only
changes to the diff, illuminating the fact that there is already mixed
whitespace in the existing code.  So I had to go back and selectively
tabify my changes, and I clearly missed a bunch.

If anyone has a recommendation for a less labor-intensive way to do
this in emacs, I'd be very grateful.

Thanks,

Stefan
