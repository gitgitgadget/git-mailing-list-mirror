From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Mon, 7 Feb 2011 13:14:36 +0700
Message-ID: <AANLkTimG6s5vSCnisJCt-EXkcJGXfY4Y3WtdB_netU08@mail.gmail.com>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com> <7vsjw0v11p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu@a-pb-sasl-sd.pobox.com, Matthieu.Moy@gr.pobox.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 07:15:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmKNY-0008JJ-Rh
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 07:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab1BGGPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 01:15:09 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:54468 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab1BGGPI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 01:15:08 -0500
Received: by wwi17 with SMTP id 17so2527592wwi.1
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 22:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=oU6Cn79CilTPVpe+/vDBCb5xjqFXZ+H7bM5cuPrCQo0=;
        b=n4+2K8Aq2vEj3Mzzw+poEaQ2XFhE0p7M2iXDFXYyNtKbvx7dO7pmPrWmuBR3PwS7HD
         RlW48p7xX83heRaXK4ZM4hIuEFZrUsWmur+xjQxSBZm3cxpWBHaAh4IL+k6qLtCHBGzy
         MfZmsIFzvJnlmoIsCKo4KIgF83GASK73+tkqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WcgdJgoRFhLTk3ZY3qJDs3uSBxwM49rNf4s9kxghFD5H0C8ysVC8IlYtEIj3x9aLLB
         uFWpoExygC4GjNAQcVB4B7EBwA9Zn2FuNJyVR+K6Xa/WkMofQ0vIn0JbHjboMbOujh3i
         YQAvUmw1CAvUAgGOSkaMa+R67zZLTQRgh9YYc=
Received: by 10.216.87.130 with SMTP id y2mr13691566wee.58.1297059306720; Sun,
 06 Feb 2011 22:15:06 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Sun, 6 Feb 2011 22:14:36 -0800 (PST)
In-Reply-To: <7vsjw0v11p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166234>

On Mon, Feb 7, 2011 at 12:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> When -u was introduced in dfdac5d (git-add -u: match the index with
>> working tree., 2007-04-20), "add -u" (without pathspec) added
>> everything. Shortly after, 2ed2c22 (git-add -u paths... now works fr=
om
>> subdirectory, 2007-08-16) broke it while fixing something related.
>
> As long as the command takes pathspecs, it should never be tree-wide.
> Making it tree-wide when there is no pathspec is even worse.

git log -p and diff family all can take pathspecs. All default to
tree-wide without pathspecs. This is what I'm doing all the time:

git diff
# checking, ok, looks good
git add -u
# ack, need to come to root dir first
--=20
Duy
