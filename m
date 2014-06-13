From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: [PATCH v6] Add an explicit GIT_DIR to the list of excludes
Date: Fri, 13 Jun 2014 09:10:22 -0700
Message-ID: <CAKpPgvf=OGRHFv81x2b_PVqzALbSWHaJvejyy5w7aS_P+QFA6w@mail.gmail.com>
References: <CACsJy8Cgu792Tamej3+_9w=Krg8nezYYA6k604gikebHG=yVUg@mail.gmail.com>
 <1402529308-3940-1-git-send-email-pasha.bolokhov@gmail.com> <53994667.90209@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 18:11:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvU48-0003ap-LM
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 18:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbaFMQKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 12:10:54 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:60421 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbaFMQKo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 12:10:44 -0400
Received: by mail-ob0-f175.google.com with SMTP id wm4so2254093obc.34
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=O4TP9yCKxMtJEZ0ea3fuidbHBmgfl5w8G4bR/PENTUw=;
        b=gmPKD54qb/R08KTccUlFJGOAw9aOJoLKiAiqdBy+c2gnkNxuYCmNi5qzJUdCYHbNuW
         iTsAdkVVTT2iBxv4QaFmKrn5HDbyIxarRDlhOY9sD6Q2Bp7yiMcuBgoUZKq7Mng9EINo
         g61C9ehyFy9B4VZFVbl+DqJcYVyGnCTt+ZO5lRgurGr8rRoPev0rUfLR8bXo6C5iJORN
         vsvihhuQjApRV1ShWgeE5wzG1MlD+BT4Tmx1qi7B5iJhPBNVhpOrjbQV6isevqHo2kVb
         L44Qln4Ie5Gm4ZE/KcD5G1C/iLN5OMk5ng3tZHEhB29eEfb+bvg/EtRKzOfqW/WylBxB
         9FZA==
X-Received: by 10.60.176.73 with SMTP id cg9mr3761162oec.76.1402675843818;
 Fri, 13 Jun 2014 09:10:43 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Fri, 13 Jun 2014 09:10:22 -0700 (PDT)
In-Reply-To: <53994667.90209@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251606>

>> +             test_cmp status.actual.2 status.expect.2
>
> It is customary to call the files 'expect' and 'actual'. Furthermore,
> swap the order so that in case of a failure the diff shows how the
> actual text was changed from the expected text:
>
>                 test_cmp status.expect.2 status.actual.2

So, is naming the files "status.expect.2" instead of just
"expect"/"actual" ok or not?
Those prefixes "status" etc just help sorting out where the problem
lies that causes the test to fail. But let me know if this is too
"detailed"

>
> Moreover, test_*_fail helpers are intended to be used only with git
> commands; we don't expect system commands to fail in unexpected ways.

Ok, no problem, will change that. The only thing, I saw this in other
tests, so decided to use it too. Those tests use "test_mighf_fail rm"
and "ls" seemingly without invocation of git
