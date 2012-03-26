From: Phil Hord <phil.hord@gmail.com>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 14:29:24 -0400
Message-ID: <CABURp0oJwM-KtdBRVHgvOaqFVjA-MEAfJoJH=52Y=QRcgFL+3Q@mail.gmail.com>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
 <7vvclvrrad.fsf@alter.siamese.dyndns.org> <20120324165536.GA17932@neilslaptop.think-freely.org>
 <7v1uofqoa7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:29:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEfv-0007nY-S9
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859Ab2CZS3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 14:29:46 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50494 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932796Ab2CZS3p (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 14:29:45 -0400
Received: by lahj13 with SMTP id j13so4138680lah.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DnRh7SCA2UMY4JP8HocEYoXd1qE8uh+rfJdZtVxuLkw=;
        b=MyK69H9Gwg3cmqOEWzkss/nenkPxJdZHomDAsJOxXw005v1Xadw+Ag6PdHjm2GZKS0
         oQJ8R1JRLNYo2EMYCVJ2xOYwxxJ5uoiXzM4lrv7Z9ev1Nx6LqSA7iK12h7wrW/5Mzxis
         ojufpsR+tic0GEuvkT6FgIzv/0jPxLFg0z70NT0dWHfT0ZaUJbj1yGktZXZRsJEwZwPU
         SzpR4uA/NMhDKCH3wdUX/7GNS1C2q3wYpHMu4rIL7ra9vwBmwjXrEqdCXK7BtiLdQTza
         p3opSQ1B7a9nLRV9z/uXA6IjHUrCMEGYWQ4ootJ/aeN7PuCCFpouBbFoAhUyve+bjD4i
         deYQ==
Received: by 10.152.112.100 with SMTP id ip4mr16984717lab.1.1332786584254;
 Mon, 26 Mar 2012 11:29:44 -0700 (PDT)
Received: by 10.112.55.43 with HTTP; Mon, 26 Mar 2012 11:29:24 -0700 (PDT)
In-Reply-To: <7v1uofqoa7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193950>

On Mon, Mar 26, 2012 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
>
>> Is there a way to differentiate a commit that is made empty as the result of a
>> previous patch in the rebase, and a commit that is simply empty?
>
> An empty commit has the same tree object as its parent commit.
>
>> I agree, I think perhaps adding an --allow-empty option to the rebase logic, so
>> that empty commits (or perhaps just initially empty, as opposed to commits made
>> empty) would be very beneficial.
>
> Yeah, that probably may make sense.


Can we have three behaviors?

A: Current mode, stop and error on empty commits
B: --keep-empty, to retain empty commits without further notice
C: --purge-empty, to remove empty commits without further notice

Phil
