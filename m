From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] branch -d: refuse deleting a branch which is currently
 checked out
Date: Tue, 29 Mar 2016 14:47:10 -0400
Message-ID: <CAPig+cRd8DzW+SaX6vwa7cv8pgMZKQL_dzWy8mDOYn7QkCtM8g@mail.gmail.com>
References: <CAPig+cSCC+OzotkTx89iS+t4DRd3F+QoHP4n-v_+rxXU2R+2LA@mail.gmail.com>
	<cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
	<1459149771-14790-1-git-send-email-k@rhe.jp>
	<CAPig+cSzTwup6ojboVkP8nMR91-ZUU9FCbAK5NcrcohfFh2taQ@mail.gmail.com>
	<20160329092802.GA17915@chikuwa.rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:47:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akyfp-0003cs-MY
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 20:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbcC2SrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 14:47:14 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34261 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbcC2SrL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 14:47:11 -0400
Received: by mail-vk0-f66.google.com with SMTP id e6so3465680vkh.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=TkW4BEzBGZmuqCJCGPU+p9RHwuKC7IG1W8GPqjDG80g=;
        b=sEVNqGiLrXbKeJLXAMDi69AOyknK2dipReY3O97D44RMddgcAcnB2RoZVLoLPFSgZX
         S93+m0/32Dx7PoCl79LeUfZqDJc6EfrYOZcx/TfdeQ9C6DLIOG9+LQvB7e8QdCaZvR57
         cPczQQcQeCmkn4ydAjtHuzVCBKmavRfaOJerwFNkOdEtU/g4tUbi+3FYLAYqJ3TU/uhe
         X9CqyE+51ffbHZspkpCqUwT7nXP3FrOuneNo4r2vjpnpdXQwKfJbAl30Sz639H/yrcmn
         nS6sJOET1piJ9e3Oj6MOwOz7YVMABGV32x6KboZ8qYb+jaY24sQu39gyOGQDRxMey1Jx
         D3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TkW4BEzBGZmuqCJCGPU+p9RHwuKC7IG1W8GPqjDG80g=;
        b=fdaeLK0BRdOMo/ye5/0uDP8pPuNF3kWtolf76QJZXrtQl/aRzeQ5HcaofDkGdjMI7/
         x7h3VZlnQxVggFIpWp3aj+7ZgEs5X2RiotZvylJ41LwhnnXkpKSA8owR0H4ZqgwfXf4e
         hWx9LFynstUG3oAY/vbvtMfsUDsLJuttM2AC2ztQucApUuZhh/vo/TcJzmQzLcBlju9J
         HToU0uWSE089Cad/+seaO5TLkHNZ82lrGfqRiWG0dy9AMVTJhhXi0YjIyOJp3USI6Rx8
         h0u8+/edgidrIjNnSm8XQfZtDXHlSaAitKJHgETGrhVUzond1If6hce3oXislbmoySbn
         kDew==
X-Gm-Message-State: AD7BkJJKImgHIU99t4k27dIRStPDCnWDkkueUnGIZHD4mqpfbut9PCmpPQ6p2faw0t/y1jr9huEvZox5iD6DBg==
X-Received: by 10.159.38.49 with SMTP id 46mr2204199uag.139.1459277231034;
 Tue, 29 Mar 2016 11:47:11 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 11:47:10 -0700 (PDT)
In-Reply-To: <20160329092802.GA17915@chikuwa.rhe.jp>
X-Google-Sender-Auth: 517CB1Pc6sc7Y6t9QdWHZf0ybcM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290159>

On Tue, Mar 29, 2016 at 5:28 AM, Kazuki Yamaguchi <k@rhe.jp> wrote:
> On Mon, Mar 28, 2016 at 12:51:21PM -0400, Eric Sunshine wrote:
>> On Mon, Mar 28, 2016 at 3:22 AM, Kazuki Yamaguchi <k@rhe.jp> wrote:
>> > +               if (kinds == FILTER_REFS_BRANCHES) {
>> > +                       char *worktree = find_shared_symref("HEAD", name);
>> > +                       if (worktree) {
>> > +                               error(_("Cannot delete the branch '%s' "
>> > +                                       "which is currently checked out at '%s'"),
>> > +                                     bname.buf, worktree);
>> > +                               free(worktree);
>>
>> Would it make sense to show all worktrees at which this branch is
>> checked out, rather than only one, or is that not worth the effort and
>> extra code ugliness?
>
> I thought one is enough.
> I think the worktrees usually won't be more than one, considering
> "git worktree add" requires additional option to check out an already
> checked out branch. Also, since the branch is not actually deleted at
> that time, the user can safely retry after checking "git worktree list".

Fair enough. A more thorough error message can be done a future
enhancement if there is a need for it.
