From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2015, #06; Sun, 22)
Date: Wed, 25 Feb 2015 17:20:31 +0700
Message-ID: <CACsJy8C7inU3ZDA_do-D94-WQB9oTme4DfPwwPUm_LtWmp8VuQ@mail.gmail.com>
References: <xmqqk2z9vd38.fsf@gitster.dls.corp.google.com> <54EB30F0.4010404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 11:21:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQZ5d-0000k4-N9
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 11:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbbBYKVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 05:21:07 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:65482 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbBYKVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 05:21:04 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so34381536igk.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 02:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i4w5XoO6Spb8zapWWOlZ6g7fQEE3VUc7WHAiN8UHa8s=;
        b=ZsXWC45GdpzMnso74+RJJBFubakmcXf1Uhz8qWJDiAXV5lcEKOy+rKw5wxFAr4PIvs
         olKc/2fMTSOUNUyFBT73pe8bpqbcKvxJqmgbls4Gre8jETrrJauGNfIZvwXng+hhvNR4
         S88t6ytfbtcF0G5yTqbypCWdA3HUfDOMLhIu0vMfcfyn2E9NOgio+c6VEtKuwCcYVhs7
         Wn0YUSFT7yc9qn76oUbUQ1YgGrJOQ4u2cC93yHTYmsnmUdUGfQvSkXjEZ6TQvSkh95/4
         jKw8+98WKC0IvgmGt2p1mkMUbGeVY/jZuBmWPgJ+pCZQALorDjGeFufRNR1f5PbagOvU
         BFgg==
X-Received: by 10.107.11.140 with SMTP id 12mr3475026iol.5.1424859662619; Wed,
 25 Feb 2015 02:21:02 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 25 Feb 2015 02:20:31 -0800 (PST)
In-Reply-To: <54EB30F0.4010404@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264380>

On Mon, Feb 23, 2015 at 8:53 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Junio C Hamano venit, vidit, dixit 22.02.2015 22:41:
>
>> [Stalled]
>>
>> * nd/list-files (2015-02-09) 21 commits
>>  . t3080: tests for git-list-files
>>  . list-files: -M aka diff-cached
>>  . list-files -F: show submodules with the new indicator '&'
>>  . list-files: add -F/--classify
>>  . list-files: show directories as well as files
>>  . list-files: do not show duplicate cached entries
>>  . list-files: sort output and remove duplicates
>>  . list-files: add -t back
>>  . list-files: add -1 short for --no-column
>>  . list-files: add -R/--recursive short for --max-depth=-1
>>  . list-files: -u does not imply showing stages
>>  . list-files: make alias 'ls' default to 'list-files'
>>  . list-files: a user friendly version of ls-files and more
>>  . ls-files: support --max-depth
>>  . ls-files: add --column
>>  . ls-files: add --color to highlight file names
>>  . ls-files: buffer full item in strbuf before printing
>>  . ls_colors.c: highlight submodules like directories
>>  . ls_colors.c: add a function to color a file name
>>  . ls_colors.c: parse color.ls.* from config file
>>  . ls_colors.c: add $LS_COLORS parsing code
>>
>>  A new "git list-files" Porcelain command, "ls-files" with bells and
>>  whistles.
>>
>>  No comments?  No reviews?  No interests?
>
> I like the result a lot (I admit - I like colors in terminals).
> Since the aim is a user facing command I'm wondering whether the status
> symbols really should be those from "ls-files" or rather those from
> "status -s" (and diff --name-files). (Yes, that would require two chars.)
>
> status, status -s and the like are in an ordinary user's tool box.
> ls-files isn't, at least not with "-t", which we even mark as deprecated.

Noted. Will do.

> That makes me wonder, though, how difficult it would be to
> wt_status_collect_unchanged() and to leverage the status machinery
> rather than ls-files.

Hmm.. let me think about it. In a way this git-list-files is like an
alternative to git-status, perhaps you're right..
-- 
Duy
