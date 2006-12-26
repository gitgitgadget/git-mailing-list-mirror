From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Errors when updating an old git.git repository
Date: Tue, 26 Dec 2006 16:37:43 +0100
Message-ID: <8c5c35580612260737vae2669dkac6a81fe863484d4@mail.gmail.com>
References: <87d566ww3r.fsf@trews52.bothi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 16:37:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzENA-0004i5-KG
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 16:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWLZPhp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 10:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbWLZPhp
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 10:37:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:56269 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932689AbWLZPho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 10:37:44 -0500
Received: by nf-out-0910.google.com with SMTP id l35so3011215nfa
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 07:37:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AripzOY+X69FrNxVtiF0Qie6mehF9up1rn9MzeQp1srTiKp07NOf3O84S9zVxoQaOrpaPxcNTxvlY+GE1edB20odGr4biaM2or1V4Q96Kwh8J+g1lmI8HC+S4lVCIQB+F4TmJCkWfkxI63FfI/SSZLkmhjneTFbSs49D9uPz++k=
Received: by 10.82.190.2 with SMTP id n2mr792115buf.1167147463140;
        Tue, 26 Dec 2006 07:37:43 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Tue, 26 Dec 2006 07:37:43 -0800 (PST)
To: "Hannu Koivisto" <azure@iki.fi>
In-Reply-To: <87d566ww3r.fsf@trews52.bothi.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35422>

On 12/26/06, Hannu Koivisto <azure@iki.fi> wrote:
> error: no such remote ref refs/heads/jc/bind
> error: no such remote ref refs/heads/jc/bind-2
> error: no such remote ref refs/heads/gb/diffdelta

I guess you have some branch references in the file
.git/remotes/origin that shouldn't be there, so you can just remove
the lines that mention  'jc/bind', 'jc/bind-2' and 'gb/diffdelta' from
that file.

> * refs/heads/pu: not updating to non-fast forward branch 'pu' of git://git.kernel.org/pub/scm/git/git
>   old...new: 0c9951a...f959571

The pu branch is rebased all the time so it needs a '+' in
.git/remotes/origin to be automatically updated, like this:

Pull: +pu:pu

(or you can run 'git pull -f' to force the update)

-- 
larsh
