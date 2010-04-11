From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: nd/setup
Date: Sun, 11 Apr 2010 19:57:06 +0200
Message-ID: <w2mfcaeb9bf1004111057g58cefafdqc1cc30a8c9f82032@mail.gmail.com>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
	 <20100408073825.GA15153@coredump.intra.peff.net>
	 <20100408214233.GA32441@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:57:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11PH-0001dp-PR
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab0DKR5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 13:57:10 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:41821 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab0DKR5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 13:57:08 -0400
Received: by ewy20 with SMTP id 20so1716817ewy.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8M97n0Va5oY2/EuKPJenNSQR00107iif3lbQDqyzL0w=;
        b=gmpq7cJv2EETTMu7hCvjIg2FpoA+c07PwADZWRbPkdAUKxYgq0DXd/OWXBuePtMUmd
         13+8E94e65kk6Lfkb3MxHQ0dzsirLs4d9HvA/QXUgkAmrUqrbh8UHNIzj2ZtPsoPmzJ8
         uFSubaFg9fXtqwcC0VOqahm89mxwfX7pYBzLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OvNr0wjmTBVZwNzfm6i8n0N7TUL2qmArx+Aa10HXRXtmvJEfO9QFYqkq5lOLYQmZSL
         qCJktCiUupvOW/4Jz+9t1ljpcH0n48LQC+YmCimV/uVKLlUkj8kzVrzhHqZKR2Rm3bWn
         OfnNvxeOBhOiCoo8ce8Ia7qA5otsRNMwIUEGU=
Received: by 10.213.105.130 with HTTP; Sun, 11 Apr 2010 10:57:06 -0700 (PDT)
In-Reply-To: <20100408214233.GA32441@progeny.tock>
Received: by 10.213.46.74 with SMTP id i10mr1830194ebf.36.1271008626683; Sun, 
	11 Apr 2010 10:57:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144671>

2010/4/8 Jonathan Nieder <jrnieder@gmail.com>:
> Jeff King wrote:
>> On Wed, Apr 07, 2010 at 05:48:02PM -0700, Junio C Hamano wrote:
>
>>> * nd/setup (2010-04-05) 43 commits
> [...]
>> Probably one or both
>> of us should look at it before applying it to next, but assuming it
>> passes a basic sanity check, I think the best thing will be to get i=
t in
>> 'next' early so we can shake out any bugs during the next cycle.
>
> I don=E2=80=99t think it=E2=80=99s anywhere near master material yet.

No it's not. I spent a bit of time on it this morning. A few notes:

- My logic to restore repo state in run_builtin, patch "Guard
unallowed access..", is just broken, and will lead to many die()s (or
warning()s with the squash)
 - "git -p init" will not work, pager problem again.
--=20
Duy
