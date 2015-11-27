From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: GIT_INDEX_FILE relative paths are relative to the work tree
Date: Fri, 27 Nov 2015 16:35:35 +0100
Message-ID: <CACsJy8CzGJxXNy1n+=AzOvPXjp983i_L1tg-_G+9i=qVd7FxmA@mail.gmail.com>
References: <CA+6di1=4GwDg1kksJiKrVtDYSy=Sk=opWcg0=Ekwf0-OoQ2X9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: "Jack O'Connor" <oconnor663@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 16:36:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2L4D-00005e-Sl
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 16:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbbK0PgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 10:36:08 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35453 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbbK0PgH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 10:36:07 -0500
Received: by lfdl133 with SMTP id l133so132672803lfd.2
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 07:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wsxnOiikhE88qEOxJ0agbvYN9ySXU2xO9OAYTJpmUbk=;
        b=WVpUXZ1i+oIVB+tl9Tim1Y+5i6UKQNwprc3f1kVD/YBiKj5DCJ58ByI+7H5K5S/632
         hcyjYDEcbsagk28Tb7GDSRZwWhXHHiOfILFk76oHYO8vrIxlVpmUWmrEK1+pC8OmbPg2
         XeadgRc3FTQoD4YrVe33eO67d5jo1LASEZVsRpt0PEoB8n6xhqbdxplEjXNAJH5MM+jO
         qGJfGsX/Qoj+COOhbY524Addl2P9Be17X/iUodUuz/o5LJGFJDROQ6Oh5l3cfMjCO4z8
         gMU04an5cRQ9Jrf5qbiXO5aUkMkaJ6Pr2ZdeJpHhTzcFuc4irdlKBoBbaNF90dsyCXzb
         2WvA==
X-Received: by 10.112.16.135 with SMTP id g7mr21224092lbd.80.1448638565354;
 Fri, 27 Nov 2015 07:36:05 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Fri, 27 Nov 2015 07:35:35 -0800 (PST)
In-Reply-To: <CA+6di1=4GwDg1kksJiKrVtDYSy=Sk=opWcg0=Ekwf0-OoQ2X9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281778>

On Fri, Nov 27, 2015 at 4:17 PM, Jack O'Connor <oconnor663@gmail.com> wrote:
> When I use a relative path in the GIT_INDEX_FILE environment variable,
> git interprets that path relative to the the work tree. This can be
> confusing if my cwd is some subdirectory of my project; in that case
> an index file is created in the project root rather than in my cwd. It
> can also be confusing if I'm using --git-dir and --work-tree, in which
> case the path is interpreted relative to the latter.
>
> Is this behavior intentional? If so, I think it would be worth
> mentioning in the documentation for GIT_INDEX_FILE. But I can't think
> of a case where I would ever want an index file to end up inside my
> work tree.

It would be more intuitive if $GIT_INDEX_FILE is relative to user's
current directory, not some random work tree root. And mentioning it
as such is not sufficient, we may be able to access the index file
without a work tree. This variable is so old that I'm afraid changing
its behavior will break stuff, so probably best to document "relative
$GIT_INDEX_FILE is undefined behavior"

> This also comes up in http://stackoverflow.com/a/7645492/823869. Using
> absolute paths is a workaround.



-- 
Duy
