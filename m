From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] git-subtree: Add prune mode
Date: Mon, 2 Aug 2010 18:02:55 +0200
Message-ID: <AANLkTinR1OSt-3O4FQ8QBMm60LFZ_jU8u6mzenZdCDTd@mail.gmail.com>
References: <1280654756-9039-1-git-send-email-santi@agolina.net> 
	<AANLkTinLuMwGw_0gXDBBdgT=eg2T_eqtRCNHh2PgV-7U@mail.gmail.com> 
	<AANLkTi=U2=ZYXnxW3GVteB9GtxFP41GRzcTejzLE2S8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 18:03:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfxUC-0006g6-QB
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 18:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab0HBQDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 12:03:18 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64802 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab0HBQDQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 12:03:16 -0400
Received: by pvc7 with SMTP id 7so1397000pvc.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 09:03:15 -0700 (PDT)
Received: by 10.114.102.3 with SMTP id z3mr7581032wab.71.1280764995589; Mon, 
	02 Aug 2010 09:03:15 -0700 (PDT)
Received: by 10.231.36.6 with HTTP; Mon, 2 Aug 2010 09:02:55 -0700 (PDT)
In-Reply-To: <AANLkTi=U2=ZYXnxW3GVteB9GtxFP41GRzcTejzLE2S8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152418>

On Mon, Aug 2, 2010 at 12:41 PM, Santi B=E9jar <santi@agolina.net> wrot=
e:
> On Mon, Aug 2, 2010 at 4:54 AM, Avery Pennarun <apenwarr@gmail.com> w=
rote:
>> On Sun, Aug 1, 2010 at 5:25 AM, Santi B=E9jar <santi@agolina.net> wr=
ote:
>>> Add prune mode (flag --prune) with the following properties:
>>>
>>> * The history must be as clean as possible
>>> * The directory content must be equal to the external module,
>>> =A0at least when you add/update it[b]
>>> * The subproject should be able to switch back and forth between
>>> =A0different versions.
>>>
>>> [b] A consequence of this is that it loses all changes
>>> =A0 =A0made in the subtree. If they are important you have to extra=
ct
>>> =A0 =A0them, apply them and add the subproject back.
>>
>> I think I started to reply to this before but I can't quite remember
>> what happened. =A0Anyway, I have several concerns with this patch:
>>
>> - calling it "prune" is pretty incorrect. =A0It doesn't remove anyth=
ing
>> from your history.
>
> It removes the history of the subproject.
> And --squash does not squash your history. We are talking about the
> subproject, not the superproject.
>
>> =A0It silently loses patches from your tree, but
>> that's not "pruning" really. =A0I suggest "--squash
>> --discard-local-changes" or something. =A0ie. it's a variant of squa=
sh,
>> and it throws things away. =A0We want both of those to be clear.
>
> It's not a variant of squash, it is completely different, but it
> shares some properties. One tries to keep your local changes, the
> other no.

I just wanted to add one thing. For me "--squash
--discard-local-changes" would be something like --squash but with
"git merge -s theirs", so totally different from the --prune mode. I
cannot be a flag to --squash.

I'm open to discuss the name of the flag, but for now I found --prune
the best one. And as it is only used with "git subtree add" I don't
think it should be about "discard local changes".

Have fun,
Santi
