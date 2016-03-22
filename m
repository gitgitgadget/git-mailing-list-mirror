From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule helper: accept '.' for repositories with no submodules
Date: Tue, 22 Mar 2016 14:16:40 -0700
Message-ID: <CAGZ79ka=EJ-L+Zaqh0kWUdjmyUva3fEcbwJn18uxshe3R5ABBQ@mail.gmail.com>
References: <1458669579-32160-1-git-send-email-sbeller@google.com>
	<xmqqy49agx98.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaMa3CyJ-Y9Xn9QShzTUGythos+pmKZXQ7m-2c0bF0u9A@mail.gmail.com>
	<xmqqoaa6gtuu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Per Cederqvist <cederp@opera.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:16:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiTfS-00008z-Nh
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbcCVVQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:16:43 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36753 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbcCVVQl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:16:41 -0400
Received: by mail-yw0-f178.google.com with SMTP id g3so271261447ywa.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Q1IyyIN5GkDCh2tV0Czgn3HXYKG+/6pt8BsoYaRX41A=;
        b=YLtDg/h87Xs6neN25PCxSuKX0vLplf85Xtkt5UeahdqMOZYZ5oaEe1LZ3ATrQ0SpTf
         K4HjWx2HxduK8cZLgz9mg7ahsiuxQFFBSWGnzZ1YwxLy0VcfYPrFb0bAknQEtsiM0YYi
         11q4YjXI5f8cWhWYNwQlNGbcTZ7JesR3H6GfTzwwIqZ83VGOhmh38KzVt1cExYmXBFRe
         5+/I6ouOE4O5d7cd0fQ2puyMIRx7lR3ziqqLBEeC2pSXlzwMr1jSm02Z1YsguHrfrDe5
         gvUlDKVYsBKyYe37srqHMtKQE4RajoRsDYgJdKLEqLOf6nd1fAn7OvzgnYz9SOvTTb2u
         RGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Q1IyyIN5GkDCh2tV0Czgn3HXYKG+/6pt8BsoYaRX41A=;
        b=Ld8h8FjIfGcT8FdEbcmc7OgVrsg2WYfW2rHMGKj/sbe7XAVv/fLNQK6p1HW5kgqhJF
         CLp6g4PVpcRGpv6nFDSqC7snYN5XetakVTOyoaqqOe8zRKv4nvAKMdm2xelYINyoA+qD
         WEikm70aRRnvUHBCflFUJfthYfvUbjPE+ID5kFEqGZzTlfUQT8YNJmpkSmm2KZZGYlVf
         3RIs4Qauh04fcWgpDvKAB4SmxXX+tzq1qjIciAWIJLhr16Y9qTt9eG+MPTp8PZYyqdkb
         JhdPFVSdQuCr3OHH22Sw63gLXC4oofUqe7PIFtdJwgobeycXI0O8j1CThmSM0KML11hd
         MgLw==
X-Gm-Message-State: AD7BkJLYYW3NHAh6Wg1n6Ai2Il8SwNAuGEGJqdXNP1Bm4Fa8JHTdH7xCb3vWTepeDYO2li9HmRr8iP0fV0Zk86dO
X-Received: by 10.129.108.145 with SMTP id h139mr19255820ywc.320.1458681400865;
 Tue, 22 Mar 2016 14:16:40 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Tue, 22 Mar 2016 14:16:40 -0700 (PDT)
In-Reply-To: <xmqqoaa6gtuu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289563>

On Tue, Mar 22, 2016 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Maybe we can also special case the "force" argument only here for
>> Cedars use case.  ("git submodule deinit ." complains because
>> there are no further submodules, but -f solves the complaint?)
>
> I think that would have been the most sensible thing to do when
> we were adding "git submodule deinit", and it would be the most
> sensible behaviour in the longer term.
>
>
>> So I have 2 goals in mind:
>
>> * Git suggested to use '.' explicitly, so it should just work
>> --even for a completely empty repository (see the test for it)
>
> I actually view this as either a low-prio goal or even a
> non-goal, as long as we have a sensible migration plan to stop
> suggesting '.'.
>
>> * Eventually -- not in this patch, but a later patch targeted
>> at master -- we want to remove the recommendation to use '.',
>> and allow no arguments or a different argument for "all
>> submodules".
>
>> git add uses '.' for it though, so '.' seems right and valid.
>> git add '*' is also valid.
>
> Perhaps I am misunderstanding what you want.  Do you want a
> regular file that happens to match pathspec to prevent
> module_list from noticing "pathspec did not match" situation and
> giving the user an error?  That would be the "match-pathspec first
> and then mode-check" behaviour, that is the same as v2.6.x
> series [*1*].
>
>> Maybe combine the second idea with a slight refactoring of
>> parse_pathspec, such that you can pass a callback function to
>> parse_pathspec which can decided on each file if it is a file
>> to inspect. (i.e. for our usecase we'd check for ce_mode to be
>> GITLINK, another hypothetical use case would be using
>> parse_pathspec for finding all files with a certain property,
>> e.g. finding all files ending in .c or files written in all
>> capital letters or such)
>>
>> Then you could do a conditional parse_pathspec over the partial
>> repository which matched
>> the additional filtering function.
>>
>
> I do not think that buys us much.  You have already shown how to
> implement "filter first and then pathspec match" if a caller
> wants to (which turned out to be a regression in this case, but
> that is besides the point).

And by including this filtering into the pathspec machine we can pass
a flag DONT_BREAK_ON_NO_FILTER_RESULTS_WHEN_HAVING_OTHER_MATCHES
(name for illustration purpose only ;) which is how I understand this
regression?

>
>
>
> [Footnote]
>
> *1* If not, then similaritly with "git add" does not have much
>     to do with what module_list() should do.  "git add $pathspec"
>     fails if there is nothing that matches the pathspec, but
>     "module_list" wants to complain if $pathspec does not match
>     any submodule.  And it is an accident that "git add ." in
>     an empty directory does not complain (indeed "git add '*'"
>     does complain because it sidesteps the accident).
>
>
