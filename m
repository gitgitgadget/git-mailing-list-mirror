From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/5] revision.c: get rid of struct rev_info.prune_data
Date: Thu, 10 Mar 2011 13:52:41 +0700
Message-ID: <AANLkTintigx=smQisL9FPLs93btDYJQPnU9bsSws0T0L@mail.gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 <1299726819-5576-4-git-send-email-pclouds@gmail.com> <7vhbbb7ays.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 07:53:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxZkM-0001fb-Bd
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 07:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab1CJGxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 01:53:13 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58756 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab1CJGxM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 01:53:12 -0500
Received: by wwa36 with SMTP id 36so1595830wwa.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 22:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=jL9MZUiQWpkRGMYguf18NjuwNz8BsI128vSVWc3QKUc=;
        b=aDliKRgr2fa3t+I6oGs1iSO2MblhokU4ItKE5wdzkPYL431tMQtVfpMvQbsKR57kCH
         0WhNA0SZr9eXSza54RwMSnOtX8MwqSxDFBX2h5cTkQy5Zg1S9pRtOFQkL+QJ62pf/9ku
         lCag5dH9Mth/oJrjI/vA2Ks4OhRXqen7f7enA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UYyGeJ190q1WXneMpix2EE0tr0HMZs8byrt+A2rnOmGId0mKrIe8INsM1ErMPuTtdb
         MwrfsqUDHKFlqrzlXpOTjaNVEJRxggSnutiABEIUbaWecMJuVU4XP2f/ryBWMpzwwkZI
         Gz+Zo8F54ovVTvLFQvNnhe99zy/29kyUGDXZo=
Received: by 10.216.123.69 with SMTP id u47mr6609021weh.16.1299739991105; Wed,
 09 Mar 2011 22:53:11 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Wed, 9 Mar 2011 22:52:41 -0800 (PST)
In-Reply-To: <7vhbbb7ays.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168792>

2011/3/10 Junio C Hamano <gitster@pobox.com>:
>> In some places, this pathspec is used, in other places another
>> ... but i'm
>> not sure why diffopt can't be used in place of pruning.
>
> A command in the "log" family uses revision traversal and uses one
> pathspec (pruning.pathspec) to cull side branches and skip irrelevant
> commits, and another pathspec (diffopt.pathspec) to specify how the f=
ound
> commit is shown. =C2=A0Off the top of my head, currently the only cas=
e the
> pathspec of these diff options differ is when --full-diff is used, bu=
t
> they are independent concepts.

OK then I did it wrong. I should have removed prune_data in favor of
pruning.pathspec, leaving diffopt.pathspec intact.
--=20
Duy
