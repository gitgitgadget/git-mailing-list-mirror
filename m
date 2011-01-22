From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Sat, 22 Jan 2011 14:46:40 +0200
Message-ID: <AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Stephen Kelly <steveire@gmail.com>, KDE PIM <kde-pim@kde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 22 13:46:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pgcrf-0007LR-UU
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 13:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab1AVMqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Jan 2011 07:46:44 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36164 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab1AVMqn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Jan 2011 07:46:43 -0500
Received: by fxm20 with SMTP id 20so2652365fxm.19
        for <git@vger.kernel.org>; Sat, 22 Jan 2011 04:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G6+WViTMCgRmjlz75z1UhpnXHn7ABX4jHJtpMuNGT8M=;
        b=ncgoW49y4035EsKc2CLav73M5cVPURK8K8J0JNl7+mggIcIZoA4xSbiHS9chvRJP//
         XxLRfeIlukbLYJPbxUPkEhj0JVjf+5R2/P5+zw6XqWTx8WZWnzb1oAiiXV7tqpI54NEW
         kIXJLsi7r7I8ZoAugAjX+9EnVjVNH1GkYwsTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xZADvY7lu9VQlHdycXQlV4K+txYW6bzEHxzxmNCntCWQllsEQj//b2ugUhap2Af36S
         y7RIxLBNozsPdDlpuOeuGESkwvm37UTqVxRN/dbNFRXdTltxnRyCA/Y2kQ84KarOJixf
         jSXh2yOUMEhvTG5TvZLfEgoVqadELtcZpdNiA=
Received: by 10.223.101.131 with SMTP id c3mr1568105fao.95.1295700401541; Sat,
 22 Jan 2011 04:46:41 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Sat, 22 Jan 2011 04:46:40 -0800 (PST)
In-Reply-To: <7vk4hyp38i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165412>

On Fri, Jan 21, 2011 at 7:37 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I don't fully understand the issue, so excuse me if this is totally
>> wrong, but wouldn't a rule like 'you can't create a branch for which
>> there's already a symbolic ref' do the trick?
>
> But whose symbolic ref are you checking against? =C2=A0Your own, or o=
nes in
> somebody else's repository that you haven't recently updated from?

The local ones. That means that somebody can't create a 'HEAD' branch
locally, and can't push a 'HEAD' branch either, as the remote server
would already have a 'HEAD' symbolic link. And actually, if for some
reason I have a FOO_HEAD, and I fetch a branch called bob/FOO_HEAD,
obviously the local symbolic ref without namespace should take
precedence.

--=20
=46elipe Contreras
