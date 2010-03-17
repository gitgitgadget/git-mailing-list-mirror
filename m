From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Wed, 17 Mar 2010 12:44:52 -0400
Message-ID: <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> 
	<4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> 
	<4B8B9BF1.10408@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com> 
	<4BA104C7.5020207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 17 17:45:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrwN0-0007EZ-Cv
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 17:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab0CQQpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 12:45:15 -0400
Received: from mail-yw0-f201.google.com ([209.85.211.201]:48308 "EHLO
	mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab0CQQpN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 12:45:13 -0400
Received: by ywh39 with SMTP id 39so502917ywh.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Z+beqmWBfh7DC4qcFOdWzhiR+PxvlxwRMmROjurKbvs=;
        b=gNZJf5OXDAeRJvGQyG+UyxLi9Y+tv3dsNbkhh+KMvWvSnrcZdo9eq4v8o6RJcUejfV
         aK7Jwo9R/tPCDvCl8Ih/nF2yO0mZec+PwNX2NlVA10DbBKzjz4seFyr+HQ7qsnddiXyn
         dqeKdOkxEk5IhPvHbK5OL30SZvTGDSB5LBqSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MjdCpTidEPUMu2U2whHqk6LGqfL9glBo1LoZOFtyHQx+2JaijNQVl80XhkEauxzAfw
         8pIF9UVmWIGE8qCjtQL5ojrrU5PQ3oPqvqchkfjPsqeqWhSFbzclt7q4B+rGeNXDyZzb
         Qw4lK2ertuA56MfcyuC5yqdsin2rt/qcx2Bmg=
Received: by 10.150.93.19 with SMTP id q19mr784539ybb.229.1268844312093; Wed, 
	17 Mar 2010 09:45:12 -0700 (PDT)
In-Reply-To: <4BA104C7.5020207@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142413>

On Wed, Mar 17, 2010 at 12:35 PM, Markus Elfring <Markus.Elfring@web.de=
> wrote:
> -When <paths> are not given, this command switches branches by
> -updating the index, working tree, and HEAD to reflect the specified
> -branch.
> +When <paths> are not given, this command marks the specified branch
> +as the next commit target. (The reference "HEAD" points to its tip.)
> +Checking out another branch (branch switching) is designed to carry
> +your local modifications across with you. The working tree is not
> +restored to the state of its last commit.
>
> =A0If `-b` is given, a new branch is created and checked out, as if
> =A0linkgit:git-branch[1] were called; in this case you can

The new version spends all the time talking about weird exceptions and
none of the time actually saying what the basic functionality is
supposed to be.  How about this:

--
When <paths> are not given, this command switches from your current
branch to the given branch.  This is done by updating HEAD to point at
the given branch, reading the new branch's content into the index, and
checking out the content into your working tree.  Where possible, any
files you have modified in your current working tree or index remain
modified in the newly-checked-out branch.  This cannot be done,
however, when those modified files differ between the old and new
branches, in which case the checkout will abort in order to avoid
losing your changes.  You might want to use 'git stash' in this case.
--

Have fun,

Avery
