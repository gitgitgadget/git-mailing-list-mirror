From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCHv6 4/4] Write to $XDG_CONFIG_HOME/git/config file
Date: Sat, 9 Jun 2012 10:25:55 -0700
Message-ID: <CAJDDKr4bKhWgXEfVGBEyw=HcuYm-jE5K3daDkJU_9NDsurGBUg@mail.gmail.com>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338988885-21933-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<CAJDDKr6sCrwy99-5-sOaAuNjYmnw73CicF3PyYMe8hvf38oFvg@mail.gmail.com>
	<7vipf1aty2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 19:27:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdPRL-0003d8-NI
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 19:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab2FIR0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jun 2012 13:26:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51660 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab2FIRZz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2012 13:25:55 -0400
Received: by yhmm54 with SMTP id m54so1895473yhm.19
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=78U4R+ZAbyQkmiuCPOfGErsi4GCYjGMGnmtgsr6qSc0=;
        b=odd3VUWXwBp5HSINaQBiJmd09cJHYosDmSTjo17zf931tZvW12Vqu3kjHGUdTdrg9S
         gQi7D2KkjLaFGR1LnpiGzXj7Gkrjtv/TgOM7ENSlunuXMluuB5wKHmc0V6v8gZD6Q2f4
         Ks132Ek9chERyQQ9oZO/R2b/NRHGS6QkzZE6tmBkeAz2ysSAlcJddSnpjcqBNNWG1wfD
         kMO1DDLmMozczys/gYlwLm5YaWvJtsF364ywVSooNAsejwCdor+G0DK2u9wkfdeo3QhN
         Uh9GUn9vAjtSp8mwZwehC4xVPHqNqdNkQOURSo6Ihy//PRDa2vjh/mjkkTrGReJ75chu
         CRMg==
Received: by 10.101.166.38 with SMTP id t38mr3963272ano.72.1339262755224; Sat,
 09 Jun 2012 10:25:55 -0700 (PDT)
Received: by 10.147.41.5 with HTTP; Sat, 9 Jun 2012 10:25:55 -0700 (PDT)
In-Reply-To: <7vipf1aty2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199551>

On Fri, Jun 8, 2012 at 11:19 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> David Aguilar <davvid@gmail.com> writes:
>
>> I'm all for this change too.
>
> Do you mean just the general direction, or including the
> implementation?

General direction, including the backwards-compatibility
concerns described in the commit message.


>> I did a little research RE: the OSX and Windows question.
>>
>> glib makes no differentiation between OSX and Linux,
>> but Windows does have its own #ifdef.
>>
>> http://git.gnome.org/browse/glib/tree/glib/gutils.c#n1251
>>
>> I certainly don't think this should affect this series,
>> I'm just noting it as something that the Windows folks might
>> care about. =C2=A0Perhaps something for compat/ in the future?
>>
>> The downside to doing the same as glib is more documentation.
>> The upside is... consistency?
>
> Probably. =C2=A0I think we should follow whatever existing and preval=
ent
> practice is, and my gut feeling is that we would end up first doing
> POSIX only thing in my tree, and msysgit folks will quickly feed me
> updates to tweak the behaviour to match what of Windows version.

That sounds good to me.
Thanks,
--=20
David
