From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: 195b7ca6 breaks t9010 at current master
Date: Tue, 29 Mar 2011 15:37:10 +0200
Message-ID: <AANLkTi=pDM2AXwLWtQQmp77dAzhooFSMXHtKAoN_S8_a@mail.gmail.com>
References: <AANLkTik0CNXY9bKGOa9Xmai_OPQgExfLsFs1yN2pCVr8@mail.gmail.com>
	<20110329042446.GB25693@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 15:37:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Z6l-0000HC-Sm
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 15:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab1C2NhN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 09:37:13 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46002 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab1C2NhM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 09:37:12 -0400
Received: by vxi39 with SMTP id 39so122968vxi.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ebf/2LiSqZ6uHpJsRQehGNnxyXo5zq2fwEuZnhaeE5U=;
        b=rqlDmvdm6qkkpeYmGlUvthWkLcSYMbtIZw2AxGV0pq6ddVPDsqYjVxtxZIK8+fcVOY
         3H09b2/ugCruwLbgnvku+G1Q2yAC5lKmY3MOXfnAJ5WeSbKr48AisFeGl6xUngEhVp0m
         RTY9MZUBxIwsbUgNQxsua+rSj545Neo1as5PU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Ghe2BGGE97FqfLojCEa4+gTZKqUSfUKZFTdAaG+6NKQGu30miByc3KD4r8ssZCkjbs
         gnb8blWhBD80BfcIpDludLukmuJV3YKEzP+gQAiyup3EXomYu75StDof3qZxhdHt7mx1
         j1wAzgqgacg+CtKToVUcurbyXPM4qk6Dj545k=
Received: by 10.52.73.196 with SMTP id n4mr7293325vdv.227.1301405830845; Tue,
 29 Mar 2011 06:37:10 -0700 (PDT)
Received: by 10.52.166.163 with HTTP; Tue, 29 Mar 2011 06:37:10 -0700 (PDT)
In-Reply-To: <20110329042446.GB25693@elie>
X-Google-Sender-Auth: RBBgQPv-pJKMWURHczNexdmwOto
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170268>

On 29 March 2011 06:24, Jonathan Nieder <jrnieder@gmail.com> wrote:
> =C3=98yvind A. Holm wrote:
> > When running "make test" at current master (v1.7.4.2-406-gbe919d5),
> > t9010-svn-fe.sh fails. Bisecting shows that 195b7ca6 ("vcs-svn:
> > handle log message with embedded NUL") breaks the test.
>
> Could you try with the following patch applied? =C2=A0It comes from
> squashing the last two patches from the svn-fe branch:
>
> * tests: make sure input to sed is newline terminated
> * vcs-svn: add missing cast to printf argument

Thanks a lot. Yes, that works. It seems as it's "vcs-svn: add missing
cast to printf argument" that does the trick, at least t9010 doesn't
fail after that's applied. ... And it has reached the official master
now (as 8cc299d), seems it got pushed after I went to bed. I'm running =
a
test on current master (07514c8) now, and things look fine so far.

Regards,
=C3=98yvind
