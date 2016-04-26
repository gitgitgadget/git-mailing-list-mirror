From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: Supporting .git/hooks/$NAME.d/* && /etc/git/hooks/$NAME.d/*
Date: Tue, 26 Apr 2016 18:09:34 +0200
Message-ID: <CACBZZX6CRBQ5qOBdwamqJMz+_QU-cmVfA7iLTyjOCYentjx-mw@mail.gmail.com>
References: <CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com>
 <xmqq4mapmvjq.fsf@gitster.mtv.corp.google.com> <CACBZZX6AYBYeb5S4nEBhYbx1r=icJ81JGYBx5=H4wacPhHjFbQ@mail.gmail.com>
 <571F6FB5.2000305@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:10:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av5Yl-0005Ai-VC
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbcDZQJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 12:09:56 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:33946 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbcDZQJz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 12:09:55 -0400
Received: by mail-qg0-f65.google.com with SMTP id d90so1249906qgd.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6AiIhKtIYzlB08TZWXS+wXZAsfnULRJaQvEs5ZHC62o=;
        b=WAwTeT6Nd4stFNxg9Wey15qErjNpjcp5FSYKXOg8FgFy7GmxsZYh/L+FMobymOduTh
         a0KWSoB33CSBOPOwpbd4DrsFsN91oXtjug+xq1A5yfZqddDHwJKE36RpCgMmu3Nv1WSJ
         nIsZ0Ar9LMseMvd6ZftFxXiUaP8d1PQylTU99JvcUeL3CPsx6cwgOp+/Px4FzDctnVff
         5q3gpyTAV4mtqq++30y9nqMiQPjx69u+4G0+ZsVzAWfJvINHPMNc39hgXjSfnRnNtzx5
         /fvv+UURmiBkU8qpeVeZIkISUS3iVCrqB8uMtL1QXIJRFZlCqf8aktTkTayZSWBAAVU6
         OVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6AiIhKtIYzlB08TZWXS+wXZAsfnULRJaQvEs5ZHC62o=;
        b=hLSMi/Dl6aHSTk+EvVYQFTab7dCpv5xeCp6wkDY08J1whT8DFVXXhr63M+Ic8WIy1m
         Dl8eP0h7wbq0kPog75JStgElTzTsO6w0ESNdGFaIrlF8nCVnwGdjaFZmQZmmDPTy1adv
         VJG8p4Q8FPQC075gtgbR1s6Kq9nkuIj0BqH5QPUR3bSAqMFLB4XHgzOJl06RAY9kYCP2
         OkjjBSkutIn8nQGKrU08Gkh4ObLdx2psO8Jd9Os3CQxP1EiBKGBlMadC8i8hDbw3Wv8b
         HkB+4JiNWed9DYLamQUIoTpwxeieMvIPXms2Dgm8liIX8ZpfHxGAei8A8oqwwbqYtYTu
         lXWg==
X-Gm-Message-State: AOPr4FXUEU40O8EjdL8QWW3PaSMQ/iTiLQwhSuut/Yo8kIbEZFr5zNMOheJ+2Q8EGg6aj46zJm+U24YskiZ4zQ==
X-Received: by 10.140.29.97 with SMTP id a88mr3075283qga.45.1461686994399;
 Tue, 26 Apr 2016 09:09:54 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Tue, 26 Apr 2016 09:09:34 -0700 (PDT)
In-Reply-To: <571F6FB5.2000305@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292607>

On Tue, Apr 26, 2016 at 3:40 PM, Marc Branchaud <marcnarc@xiplink.com> =
wrote:
> On 2016-04-26 06:58 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> Makes sense to have an experimental.* config tree for git for stuff =
like this.
>
> I disagree.
>
> * If the point is to express some kind of warning to users, I think t=
he
> community has been much better served by leaving experimental setting=
s
> undocumented (or documented only in unmerged topic branches).  It fee=
ls like
> an experimental.* tree is a doorway to putting experimental features =
in
> official releases, which seems odd considering that (IMHO) git has so=
 far
> done very well with the carefully-planned-out integration of all sort=
s of
> features.
>
> * Part of the experiment is coming up with appropriate configuration =
knobs,
> including where those knobs should live.  Often such considerations l=
ead to a
> better implementation for the feature.  Dumping things into an experi=
mental.*
> tree would merely postpone that part of the feature's design.
>
> * Such a tree creates a flag day when the experimental feature eventu=
ally
> becomes a "real" feature. That'll annoy any early adopters. Sure, the=
y
> *should* be prepared to deal with config tree bike-shedding, but stil=
l that
> extra churn seems unnecessary.

By "stuff like this", yeah I did mean, and I assume Junio means,
putting "experimental" features in official releases.

E.g. perl does this, if you type "perldoc experimental" on a Linux box
you'll get the documentation.

Basically you can look at patches to a project on a spectrum of:

 1. You hacked something up locally
 2. It's in someone's *.git repo as a POC
 3. It's a third-party patch series used by a bunch of people
 4. In an official release but documented as experimental
 5. In an official release as a first-rate feature

Something like an experimental.WHATEVER=3Dbool flag provides #4.

I think aside from this feature just leaving these things undocumented
really provides the worst of both worlds.

Now you have some feature that's undocumented *because* you're not
sure about it, but you can't ever be sure about it unless people
actually use it, and if it's not documented at all effectively it's as
visible as some third-party patch series. I.e. only people really
involved in the project will ever use it.

Which is why perl has the "experimental" subsystem, it allows for
playing around with features the maintainers aren't quite sure about
in official releases, and the users know they're opting in to trying
something unstable that may go away or have its semantics changed from
under them.
