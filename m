From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Issue when changing staged files in a pre-commit hook
Date: Wed, 20 Jan 2016 06:26:35 +0700
Message-ID: <CACsJy8DxQnGV5JZnHuvA1Zbpf2BuGdmMF+YNiq51HNK+8vW56Q@mail.gmail.com>
References: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
 <CACsJy8DhiYiie7+Cw3PkPJpSX7CGp-r2Mu98mLp4OMhhGdsXgQ@mail.gmail.com> <xmqq1t9dbe9y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Niek van der Kooy <niekvanderkooy@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 00:27:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLfgQ-0003VD-3I
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 00:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933503AbcASX1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 18:27:11 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33637 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933499AbcASX1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 18:27:06 -0500
Received: by mail-lf0-f47.google.com with SMTP id m198so201585512lfm.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 15:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2hSU5ulgBdlr5gSfP25JMxGqKBtnsfMZUGLHLRB/KpI=;
        b=TmDt4PlvcIKOpLV9vzDm1fnh8t0aXOLBMfqV10rCEVba4nOW6FnIIk93tMgvidc7T0
         4QwkWkZRHsE/l7K6HrC6pnnRq4T3JhJwTy3hmMjgs5MLrqum2CkfLDq07+HmciRHduXl
         ndKEALP+GIdwW7Lc4uAnKVvTY6HYOTxKQElmTjcVXX3vX64MA3wv/qKNQC5w4YVLDIol
         CaXMS4K6kPeM2QMb9ySLzCrfvyFA8VT0mcX7MT73V4QTq6qwOOVpOUFrdYjSxZBstvzQ
         wVeAAzWLEin4NUMlyJGZTCYH1Sd78sHIWibWXIi8PJgxUlSnSt67Vtx9rI0t3yl/mhAb
         vNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2hSU5ulgBdlr5gSfP25JMxGqKBtnsfMZUGLHLRB/KpI=;
        b=N56bohjDBl9Zhx9+j6U5eTsdFZsOwH9xU+Vq5E7JC7q3feVccbGk1GZSAgEWI3UDLi
         ElkPomyOwa45XmNAuwjrgtnwqHsLp4p0ZiMhVpMS7pNWorHWCX0oAUdXPYiY/Dc+w68L
         nLugQSkp5LBQJDTsXiGqn6C/8Oj5peCzNGcw7GqjQfrDiMdsj/qMhaw8ElSSoHOwP2zs
         h8l1uBFoBqrG+ZRkGa5dQZlIUPE+XakXFpjaoXD7d5JG+qCfoIZ+e0OFwdAEJUZvF9RV
         NyQPdyP9c84NEq6XcMZ/h1/xYiZAv8QUfzjRIeaD7oCEvgEu7PYrtMi/RcNXgj6ikzJ0
         kYwA==
X-Gm-Message-State: ALoCoQmtq0LFZntXqcjR3Ll3ud3KuvQeJeyH3BwrhGdu0vre55Cnv2BtlfhNob5TrY7rUzgSs7+QWq0KDJhzzdoPOVUta3XkIg==
X-Received: by 10.25.17.229 with SMTP id 98mr9671112lfr.3.1453246025076; Tue,
 19 Jan 2016 15:27:05 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 19 Jan 2016 15:26:35 -0800 (PST)
In-Reply-To: <xmqq1t9dbe9y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284396>

On Wed, Jan 20, 2016 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I think it's the intended behavior.
>
> Yeah, pre-commit was designed for inspecting and rejecting, not for
> tweaking and munging.  Perhaps "git commit" can be tightened to make
> sure that pre-commit that returns successfully did not muck with the
> working tree and the index?

That was my impression from the docs, but then I saw this comment,

/*
* Re-read the index as pre-commit hook could have updated it,
* and write it out as a tree.  We must do this before we invoke
* the editor and after we invoke run_status above.
*/

which comes from 2888605 (builtin-commit: fix partial-commit support -
2007-11-18) that admits "the hook can modify it (the index)". And I
was about to update the docs, but the other way around, about updating
index and side effects.
-- 
Duy
