From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 17/20] transport-helper: change import semantics
Date: Mon, 4 Jul 2011 16:58:59 -0500
Message-ID: <20110704215859.GA8909@elie>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-18-git-send-email-srabbelier@gmail.com>
 <20110619233822.GJ23893@elie>
 <CAGdFq_iTojuvVAdB6sC7-Kro9E49q_1Lfh87Yy4nR5BTdZ1eaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 23:59:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdrAg-0007Oc-UH
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 23:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab1GDV7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jul 2011 17:59:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60258 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab1GDV7I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2011 17:59:08 -0400
Received: by iwn6 with SMTP id 6so4729728iwn.19
        for <git@vger.kernel.org>; Mon, 04 Jul 2011 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7jH1RHO9sLLAv1h6KmO65LYj+EonIJ0HLAARH8p+JbI=;
        b=Nhm/v0ZyTc/AYsH6EekoV2DOfmHp0IuSMrls00lt8kHICdFHwd30mqFoR96Rx1rQO5
         P9HjP5TI+2H1qII3Qv8scvMJcnJc8TPIh67FR3We8M7q+OB/4NrOzv2OdWbPl59rKbDE
         hsAh8DAcIYx7o/R/06Ysga5Q9ctnp2mCb2HYI=
Received: by 10.42.225.195 with SMTP id it3mr7644440icb.7.1309816748073;
        Mon, 04 Jul 2011 14:59:08 -0700 (PDT)
Received: from elie (adsl-68-255-111-183.dsl.chcgil.ameritech.net [68.255.111.183])
        by mx.google.com with ESMTPS id f19sm3821899ibl.66.2011.07.04.14.59.05
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Jul 2011 14:59:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_iTojuvVAdB6sC7-Kro9E49q_1Lfh87Yy4nR5BTdZ1eaA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176605>

Sverre Rabbelier wrote:
> On Mon, Jun 20, 2011 at 01:38, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> I think that for learnability, it would be better to use
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0import <ref>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0import <ref>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0[blank line]
>>
>> since that is consistent with "fetch" and "push". =C2=A0I'll try moc=
king up
>> a patch for that tonight.
>
> That would mean the only change compared to the current behavior is
> the additional blank line, yes?

It would mean no change compared to the current behavior. :)
disconnect_helper() writes the blank line.

That's why no patch came; sorry, I should have mentioned so.
