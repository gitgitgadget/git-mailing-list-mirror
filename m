From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not allowed
Date: Thu, 13 Oct 2011 17:56:45 +1100
Message-ID: <CACsJy8C6o_-SM4oCM6o5-VDXFy5PBXsE0oL_uhYH1_Zk9h06QQ@mail.gmail.com>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org> <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net> <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013055924.GA24019@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 09:02:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REFJN-0002FI-Tk
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 09:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab1JMHCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 03:02:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38019 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab1JMHCc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 03:02:32 -0400
Received: by bkbzt4 with SMTP id zt4so1038389bkb.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=e/eELG7UPcxUVcwlRWvMj8/j9Mv6fLq7bovQzftkkEY=;
        b=FTcG+Axk6UPRYT6retAIFYc2tt/Eq+Nu8iLzQz7mEMhPAELADsrn2oUdDR8Efhxia6
         yf+uFO4hAm07dvUa1Z3v2RngdybPWWqunUXX4JmHHJer9gBj14iqBiyI7KBJ2HDUEdA8
         OS+R3mb+E6kBdUbcPsrJw7iugGwSBY9EXDKdI=
Received: by 10.204.128.78 with SMTP id j14mr1558311bks.42.1318489035109; Wed,
 12 Oct 2011 23:57:15 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 12 Oct 2011 23:56:45 -0700 (PDT)
In-Reply-To: <20111013055924.GA24019@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183444>

On Thu, Oct 13, 2011 at 4:59 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguyen Thai Ngoc Duy wrote:
>
>> How about allow users to select which messages they want to print? W=
e
>> can even go further, allowing users to specify the messages themselv=
es..
> [...]
>> + =C2=A0 =C2=A0 { "service not enabled", "message.serviceNotEnabled"=
 },
>> + =C2=A0 =C2=A0 { "no such repository", "message.noSuchRepository" }=
,
>> + =C2=A0 =C2=A0 { "repository not exported", "message.repositoryNotE=
xported" },
>
> I administer a private server that is only accessible as "localhost".
> :) =C2=A0This much customization would leave me confused about what t=
he
> right choices are and what the choices mean (even if I were to make
> the server public and start having security worries).

--informative-errors is your friend. All errors are enabled.

> What is the intended use --- translation? =C2=A0The idealist in me th=
inks
> that should be taken care of on the client side, if at all. =C2=A0(Th=
is
> way, we would not be preventing especially friendly clients from
> offering pertinent detailed advice for each error condition.
> Alternatively, maybe some day the protocol will want to provide a way
> for clients to indicate a preferred language and message verbosity.)

Translation could be fun to do, but it's more about how much admins
want to reveal. For example, I may only want to show "service not
enabled" and "no such repository", not the last one, which simply
becomes "access denied".

Again I'm not real admin and this may be just bogus.
--=20
Duy
