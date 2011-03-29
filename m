From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] enable "no-done" extension only when fetching over smart-http
Date: Tue, 29 Mar 2011 10:24:12 -0700
Message-ID: <AANLkTimg5_9dQDq8Xa9pJsx9f6UrNewih+WirKcOP42i@mail.gmail.com>
References: <7vlizxsv82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 19:24:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4cem-0001Dx-4j
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab1C2RYf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 13:24:35 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46099 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab1C2RYf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 13:24:35 -0400
Received: by vxi39 with SMTP id 39so324480vxi.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 10:24:34 -0700 (PDT)
Received: by 10.52.68.175 with SMTP id x15mr51324vdt.163.1301419473847; Tue,
 29 Mar 2011 10:24:33 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Tue, 29 Mar 2011 10:24:12 -0700 (PDT)
In-Reply-To: <7vlizxsv82.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170284>

On Tue, Mar 29, 2011 at 10:16, Junio C Hamano <gitster@pobox.com> wrote=
:
> When 'no-done' protocol extension is used, the upload-pack (i.e. the
> server side) process stops listening to the fetch-pack after issuing =
the
> final NAK, and starts sending the generated pack data back, but there=
 may
> be more "have" send by the latter in flight that the fetch-pack is
> expecting to be responded with ACK/NAK. =A0This will typically result=
 in a
> deadlock (both will block on write that the other end never reads) or
> SIGPIPE on the fetch-pack end (upload-pack will finish writing a smal=
l
> pack and goes away).
>
> Disable it unless fetch-pack is running under smart-http, where there=
 is
> no such streaming issue.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

--=20
Shawn.
