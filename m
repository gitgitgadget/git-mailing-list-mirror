From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 09:43:35 +0100
Message-ID: <r2vfbd9d3991004120143td6f90410j60c7c002b15d5db6@mail.gmail.com>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
	 <4BC2D61B.7050902@drmicha.warpmail.net>
	 <7vk4sdm5kw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 10:43:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1FFF-0005HC-JC
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 10:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab0DLInh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 04:43:37 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:41854 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab0DLIng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 04:43:36 -0400
Received: by qyk9 with SMTP id 9so3581994qyk.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D8K3h0a+xWUUgj3HPWYo1cPimr7MpQeKYbaB2DhnFYY=;
        b=WYdWKrMMgRwgqRR1GbGM5WvZeqzWbFqnq3gyK70Mljmve7KV/lBXWFo0T0u+FBAZQJ
         Ica+WWOc3Ceq/FBVLsL1F8A2tRw3HglC+/D1HeYC7VIYwbnbahzAOP3TCX937pemqJIU
         9C5tNvOQaUZ60VxMQ+yqMlQbzi/p2pMyRzJcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VnuiyLQL3uCttnxMybE6GCQWdou1g+klbqSlBcVJ0b7CDD9VtCTi5BiIsXnEQv8DrT
         uCQ/0aGg+Uz8hpplmr0D1ziNZZ5dPjGmaO2qi0ymMsqRdKRcSJQE/RrbegdDgBuFIcaK
         OLOF/F6kW+fjjBP7WLoKq0AH/VSpmyTHbrDQk=
Received: by 10.229.223.196 with HTTP; Mon, 12 Apr 2010 01:43:35 -0700 (PDT)
In-Reply-To: <7vk4sdm5kw.fsf@alter.siamese.dyndns.org>
Received: by 10.229.239.148 with SMTP id kw20mr5575324qcb.10.1271061815363; 
	Mon, 12 Apr 2010 01:43:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144714>

On Mon, Apr 12, 2010 at 9:35 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> @@ -1043,7 +1043,7 @@ X-Mailer: git-send-email $gitversion
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0defined $smtp_=
server_port ? "port=3D$smtp_server_port" : "";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $smtp_authuser) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $smtp_authuser && $smtp_aut=
huser ne '') {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!defined $smtp_aut=
hpass) {
>

That would work but introduces a special case for smtpuser.  Do you
think users may wish to unset override other options too?

Stefan
