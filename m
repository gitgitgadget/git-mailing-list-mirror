From: Miles Bader <miles@gnu.org>
Subject: Re: git diff --added (Re: Command-line interface thoughts)
Date: Mon, 13 Jun 2011 04:46:34 +0000
Message-ID: <BANLkTikUOXwN9YrC25_mo2z5EWcsjrkg7A@mail.gmail.com>
References: <201106051311.00951.jnareb@gmail.com> <201106101844.16146.jnareb@gmail.com>
 <4DF25D50.5020107@ira.uka.de> <201106102035.42525.jnareb@gmail.com>
 <4DF29EA5.60502@ira.uka.de> <20110613034347.GA4222@elie> <buotybu2wx7.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 06:47:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVz3Z-000240-QI
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 06:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836Ab1FMErQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2011 00:47:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40533 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1FMErP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2011 00:47:15 -0400
Received: by bwz15 with SMTP id 15so3435789bwz.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 21:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0CYTDJ6QTTaQ2Fk8W3NqxBC+JOqtgaeWFc+hHoTebTo=;
        b=N0zwHNX3gWMobwg7ZeLjMmLpeSCuG9L+uvfkDwLA/dgi5l/Zq/WzB15lLR+52Qb/oA
         BaIlCZPoXUS5h7r5WBfLDeKZS40FZgRFWgWORtoyNnwh8qQc+exob7B/O2gSUr41/YAZ
         UxqFnlGDq8p5hKCoQUIHCvi3TPZVr9dgDYAss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=cwcjarJAQzoQBnKA8MjkF2RifOItqixn0alPASDRtx8s52+h6H6/x0KPWQdee46Uyr
         ivByZ55TtHEh2yGEB1mr1s4EwjM6QOJDixQWynBgEnvwlKFJ+anoo0+WHHs0cGmCg+a7
         YGGfmLqZj2RAXxwRpKCrsojFmF9BlTtBVBQdo=
Received: by 10.204.172.66 with SMTP id k2mr1301562bkz.125.1307940434195; Sun,
 12 Jun 2011 21:47:14 -0700 (PDT)
Received: by 10.204.39.65 with HTTP; Sun, 12 Jun 2011 21:46:34 -0700 (PDT)
In-Reply-To: <buotybu2wx7.fsf@dhlpc061.dev.necel.com>
X-Google-Sender-Auth: y-KNi4fi3qTgvjobp14bFXX2ym8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175682>

On Mon, Jun 13, 2011 at 4:11 AM, Miles Bader <miles@gnu.org> wrote:
>> Do you think it would be valuable to introduce --added as a synonym
>> for --cached and slowly steer documentation to encourage the latter
>> in place of the former?
>
> "--added" sounds very awkward though; "--staged" is much more natural=
=2E

I should note _why_ this is so:

The main problem is well-known -- that "git add" is a bit overloaded
and slightly awkward in some case (e.g., to remove a file, you need to
add it...).  But whatever, it works well enough, because people are
used to it.

However in the case of git diff, if one sees "git diff --added", it
sounds like it means "show me a diff of added files" -- but the term
"added files" is ambiguous; and the fact that "git add" is in fact,
overloaded with multiple meanings doesn't really help, the basic
ambiguity makes "git diff --added" awkward and unclear.

A far better way would be to (1) make "git diff --staged" an alias for
"git-diff --cached" (2) start promoting "git stage" in documentation,
instead of "git add".

-Miles

--=20
Cat is power. =A0Cat is peace.
