From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH 1/2] Prevent force-updating of the current branch
Date: Tue, 23 Aug 2011 12:20:23 -0700
Message-ID: <CAOTq_ptTsO01XvjMcBcWNaOQHvwm7cHP2AzSRpbSzox-NNj7Rg@mail.gmail.com>
References: <1313876989-16328-1-git-send-email-conrad.irwin@gmail.com>
 <1313876989-16328-2-git-send-email-conrad.irwin@gmail.com> <7v39gsrnuc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 21:20:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvwWm-0001pN-Ui
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 21:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab1HWTUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 15:20:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62722 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab1HWTUo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 15:20:44 -0400
Received: by gya6 with SMTP id 6so337436gya.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bB/PXW+lzp3hZwtykxFfC/WcEb5SLruXstKVM/fPiYQ=;
        b=Q06wqzIfNGKjBYG8Du3lIRAzvcuNszXeyWJPdCP1LuNF/SPkjySTBUdnYQSChEr8vd
         BdYITBvzOXIMWswWBa+um1NrowZ2eK138nnazmuQQ0MOFxCAPlG4PDucZsGpBJ3xOv04
         JZh4O4U/OOBgbQcjrSgwxJtb1RoLAd2GT1ghg=
Received: by 10.236.157.104 with SMTP id n68mr2009175yhk.74.1314127243148;
 Tue, 23 Aug 2011 12:20:43 -0700 (PDT)
Received: by 10.236.95.131 with HTTP; Tue, 23 Aug 2011 12:20:23 -0700 (PDT)
In-Reply-To: <7v39gsrnuc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179961>

On Tue, Aug 23, 2011 at 11:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Conrad Irwin <conrad.irwin@gmail.com> writes:
>
>> git branch -M <foo> <current-branch> could be used to change the branch
>> to which HEAD points, without the necessary house-keeping that git reset
>> normally does to make this operation sensible. It would leave the reflog
>> in a confusing state (you would be warned when trying to read it) and
>> had an apparently side-effect of staging the diff between <current branch>
>> and <foo>.
>
> The last two lines are redundant (it is "without the house-keeping of
> reset"); I'll remove "and had an apparently...".

That's fine by me.

>> git checkout -f already guarded against this problem, and aborted with
>> a fatal error.
>
> I assume you mean "branch -f". I'll rewrite it so, and in the present
> tense.

Yes. Thank you.

>
>> git branch -M, git checkout -B and git branch -f now use the same checks
>> before allowing a branch to be created. These prevent you from updating
>> the current branch.
>
> Looks good ;-). Also the patch looks good, too.
>

Glad to hear :).

Conrad
