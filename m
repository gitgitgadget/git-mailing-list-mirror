From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Getting rid of a stale remote?
Date: Tue, 6 Apr 2010 14:25:07 -0400
Message-ID: <x2uc115fd3c1004061125i695f66bbi9f949ccc1958750@mail.gmail.com>
References: <x2jc115fd3c1004061103z3154b6b3ge34493260f12925e@mail.gmail.com> 
	<w2if3271551004061107rb25b83b9p19a284f19e7d4f87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 20:25:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzDTA-00077w-VD
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 20:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370Ab0DFSZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 14:25:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53522 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757164Ab0DFSZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 14:25:41 -0400
Received: by gwb19 with SMTP id 19so70021gwb.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=igEfrjZ2K4jRfnhmiulHGc9T1LcksKD+OMjkPgfQWAA=;
        b=t7f8TTIkxisXTpudG+QlgCZAfwrQwVrX2cdTDRa3xzjvPPIgxrOImRY9IoRjabJg7p
         gNMnEQwbBBxyv3IJaPzj6mfvfmKzhPcqPX+skI1x1VcHRUO9rXHUf3Q2iPLMOy+4uDeO
         R9C2GeLmSegrbJ07zhEkAtXM2dQeOA2sGWn8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JdEeWzRhhnR5P03tf7yP2BmN3grtCS/PtVZvjBrzUA6sLlAHQhQgDMc1HdMe1kWIN+
         edA0SK2xfIHS9P8xmtwATrwihIfLDOEth7ZhPKuvV9m/Q6gvq588EgHyLVKUzNDrlBRG
         KKQNNJBIi8gyiidt7tpI/4SRUShzD64j9/7gU=
Received: by 10.100.209.20 with HTTP; Tue, 6 Apr 2010 11:25:07 -0700 (PDT)
In-Reply-To: <w2if3271551004061107rb25b83b9p19a284f19e7d4f87@mail.gmail.com>
Received: by 10.101.129.40 with SMTP id g40mr4764543ann.127.1270578328125; 
	Tue, 06 Apr 2010 11:25:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144164>

On Tue, Apr 6, 2010 at 2:07 PM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
>> I'm trying to get rid of a stale remote. =C2=A0I deleted the remote =
via
>> `git remote rm <remote>` and that removed it from .git/config but fo=
r
>> some reason the references stayed in the listing of `git branch -a`.
>
> See `git remote prune`.

=46rom the remote man page:
>   prune
>       Deletes all stale tracking branches under <name>. These stale b=
ranches
>       have already been removed from the remote repository referenced=
 by
>       <name>, but are still locally available in "remotes/<name>".

I'm unclear as to how this solves my problem.  Consider the following:

    $ git remote
    a
    b
    c
    $ git branch -a
    a
    b
    c
    remotes/a/branch
    remotes/b/branch
    remotes/c/branch
    remotes/d/branch
    $ git remote prune d
    fatal: 'd' does not appear to be a git repository
    fatal: The remote end hung up unexpectedly
    $ git remote rm d
    error: Could not remove config section 'remote.d'

I would like to get rid of the `remotes/d/branch` entry.

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
