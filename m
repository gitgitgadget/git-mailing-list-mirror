From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] t7011: Mark fixed test as such
Date: Sun, 29 Nov 2009 15:47:35 +0700
Message-ID: <fcaeb9bf0911290047t43ea3040x730e04baa81d8a98@mail.gmail.com>
References: <0327ed3d7c4621f205d2d111254d716bd1b06c28.1259432535.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 09:47:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEfRW-00017L-04
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 09:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbZK2Ira (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 03:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbZK2Ira
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 03:47:30 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:41246 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbZK2Ir3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 03:47:29 -0500
Received: by pwi3 with SMTP id 3so1635295pwi.21
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=XJU+b7h8ZI9uN723Q1nyF4shZko1EhH63pCpEo4/fiE=;
        b=FpMWyT5ryQxWIRu8JueCBgWgItPC/16FctvvDgYlbVJDJfyibvbFyLYPAUDs6QF5y/
         hTgc1JR7k0kvpUH0LhrUGKf/mMfO/TbZjrp0MjQbJUPcLXUhbfWNZJmdyrfTEnlmP+iq
         veDFaKj0Rg1mW8o+rRyW3RRJO4RwFyY2C/0f0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eLDtSsSGg3al/yP+PUF0zg+IWBZdNfpLrsJe+PaH9V0fTuFfiLQPxZewQZm7zXRx4w
         KcBva2tEzJBNc7LuhC1+GUsC221NW9dfoFCpnOxS8aLIbPW2XXjzF0kxPQsGcdbzba7A
         8CE+3sT1JzlTSIIpoIg/Ty5UIlwYwjrrH7Vfs=
Received: by 10.115.99.11 with SMTP id b11mr4654243wam.17.1259484455859; Sun, 
	29 Nov 2009 00:47:35 -0800 (PST)
In-Reply-To: <0327ed3d7c4621f205d2d111254d716bd1b06c28.1259432535.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134004>

On 11/29/09, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Test 16/17 had been fixed since its introduction in b4d1690 (Teach Git
>  to respect skip-worktree bit (reading part), 2009-08-20). So, mark it as
>  expect_success rather than expect_failure.
>
>  Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

No ACK. See below.

>  ---
>  I'm actually wondering about 17/17 as well.
>  If commit is called with a file name then shouldn't it simply commit the
>  current state of the file in the worktree, no matter what the index or
>  skip-worktree say? I therefore think 17/17 should be expect_success
>  and have no test_must_fail.

Both 16/17 and 17/17 ensure that Git won't look at files on worktree
if they are marked as skip-worktree (by definition of skip-worktree,
you can safely ignore worktree, otherwise you would not mark them as
such). 16/17 happens to pass, not because it does not touch worktree,
but because the base index does not have "1", which happens to is the
same situation in 16/17 (test commit when "1" is gone). The result is
OK but it is actually not (17/17 shows this clearer as it commits the
worktree version).
-- 
Duy
