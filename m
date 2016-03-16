From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Can't git stash after using git add -N
Date: Wed, 16 Mar 2016 18:09:56 +0700
Message-ID: <CACsJy8CtPAdJavKPLo3B-s-x5QVzAjNRqOM+MgbjpRbCOSGkXQ@mail.gmail.com>
References: <20160315230754.GA12058@cloud> <xmqq8u1j7193.fsf@gitster.mtv.corp.google.com>
 <20160316020000.GB12130@cloud> <xmqqvb4n58ko.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:11:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag9MN-0002oX-CX
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 12:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966584AbcCPLLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 07:11:00 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:32781 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965967AbcCPLK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 07:10:27 -0400
Received: by mail-lf0-f44.google.com with SMTP id h198so16434138lfh.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/M4gVvz6ZYpyxtJC8JhW5GcTP1UIfbLO7XB8N5HPERI=;
        b=nA9BhrsP7ke3Nj1HUICq/OPqJux3/Ho1hXNiUjbOIfJ+gtZ5CzpyOdz4FcChK/GInU
         6Vxforlw8vFYvqNvLOhq9seKN5qYMh4/ynCI9s4E9fRGn3D3ma/y5BuCKyOMKkFL4PQ7
         fKPq3QleNf1mGy+iU97/47rTXsIUym6oRKOW9kfn9UjQvYR3bk1Kz01WcBbrWfX0cw4v
         PDDhfjJxXhsZDs7ufjjKL5HNvxKnfh5XWzfBqFzoEVAQ/zsRQ1VNr0BN/VZQWEg8MGvN
         SBUKGqKnjh6peCxSf/H31sDqTGi1Hxw0d7DcQDsJ3dfP4u1qLkj0KxTk9wmfEFrRD4Py
         tUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/M4gVvz6ZYpyxtJC8JhW5GcTP1UIfbLO7XB8N5HPERI=;
        b=Af6BxNETPh/dvPqoi97eopOgxyS19Ff4yXAtdK19GZRGuZntOUi3R03caDLBWcV7cZ
         po3T+BTUigPfds8QjzUuYfAQovG+on6WZv7mUCd4a1xPOzWbBYgRfoFoPW73agfinbpF
         do9t7pxIct8kO601uIQpOe23QGrYaRr8ukOT4iCqNE/MUV+FjMmBDiVpoyWAeKapPDtx
         O1wlxYwfAoYD+H3U96eiOdan9XGV6rR0uTWZeKbiaziOF89ZqdORB2y9Tr115l0Srl2r
         NCZT4CpsGH6fVdvly8/edw4DBkRUOe7unjwNYHGmrCGX05WwJu4vma+bBYKHCrX9Gat9
         6m4w==
X-Gm-Message-State: AD7BkJKiq5yPMKOaA3oALXOQHPpFF2vuX7NjfAYY2nj5sy3F3M76Sr96/FBfP8qcHyuv3eOPaf8+5qhNqjic0g==
X-Received: by 10.25.23.94 with SMTP id n91mr924229lfi.3.1458126626145; Wed,
 16 Mar 2016 04:10:26 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 16 Mar 2016 04:09:56 -0700 (PDT)
In-Reply-To: <xmqqvb4n58ko.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288958>

On Wed, Mar 16, 2016 at 11:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
>
>> As far as I can tell, if I run "git add -N" on a file, and then commit
>> without adding the file contents, it gets committed as an empty file.
>
> Is that true?  Git once worked like that in earlier days, but I
> think write-tree (hence commit) would simply ignore intent-to-add
> entries from its resulting tree.

We have at least one problem, probably because of the confusion in
diff code (I haven't checked further), which may be fixed once i
re-fix d95d728 (diff-lib.c: adjust position of i-t-a entries in diff -
2015-03-16)

> /tmp $ git init a
Initialized empty Git repository in /tmp/a/.git/
> /tmp $ cd a
> /tmp/a $ git ci --allow-empty -m 1
[master (root-commit) 4d8aed4] 1
> /tmp/a $ git add -N new
fatal: pathspec 'new' did not match any files

So far so good..

> /tmp/a $ touch new
> /tmp/a $ git add -N new

OK let's delete "new" and trigger this problem

> /tmp/a $ rm new
> /tmp/a $ git ci -m NOOOO
[master ce2e4bb] NOOOO
> /tmp/a $ git cat-file commit HEAD|grep ^tree
tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> /tmp/a $ git cat-file commit HEAD^|grep ^tree
tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904

The second commit should not be created. git-commit is somehow fooled
that there's changes to commit.
-- 
Duy
