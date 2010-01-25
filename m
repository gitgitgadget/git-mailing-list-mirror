From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 20:48:22 +0100
Message-ID: <40aa078e1001251148p6263feeevc85a3223f85873@mail.gmail.com>
References: <201001250155.47664.robin.rosenberg@dewire.com>
	 <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302>
	 <40aa078e1001250957h292f8b01me8f7dec4ba2b425b@mail.gmail.com>
	 <201001252037.41497.robin.rosenberg@dewire.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 20:50:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZUvE-0005Lm-18
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 20:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab0AYTsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 14:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932Ab0AYTsY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 14:48:24 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:36581 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab0AYTsY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 14:48:24 -0500
Received: by fxm20 with SMTP id 20so3950210fxm.21
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 11:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rt0w8KJx5rQsq+Z0IVlvGQ6CxUUlC6jUXPSEZup3SoI=;
        b=mir+8zJpAbv28wFM0JmmTcCkV3gAeZygfvy7WdVrG5LufVJ8YAXRnCCoEcO3wFMDC+
         4pOhpztMnx65HtZjlNTd9QL2DTwAbKyo1zNL75vNjAqwvra24xADODo1lDlWP3nYgIR0
         S6O+cVRlPik2vfUz3Myu6tnzHuggNpTZCjANE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=B7FG+IH/NK934f4cpUcQggG9U6lb2KIuykByvpgjF26X+NVr4m31CX2ddfa+HNJ7LV
         Vr7yKwH8pfvj/4IdeqU/2D6W6+BHzGbogx4ZylMvqYd6kQcZ9dSlyWNgk8xwrJB94EFB
         yEPlMkISMdEf2jzk3p3W3GlYAjKJpEvuld0P0=
Received: by 10.216.88.10 with SMTP id z10mr998392wee.108.1264448902431; Mon, 
	25 Jan 2010 11:48:22 -0800 (PST)
In-Reply-To: <201001252037.41497.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137986>

On Mon, Jan 25, 2010 at 8:37 PM, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
> m=E5ndagen den 25 januari 2010 18.57.06 skrev =A0Erik Faye-Lund:
>> On Mon, Jan 25, 2010 at 6:34 PM, Johannes Schindelin
>>
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > And even a simple "cd" with them does not work.
>>
>> But it does, at least for me - both in bash and cmd.exe. I just need=
t.
>
> In cmd,exe surprises me a bit. pushd \\server\share is not the same
> as it maps a drive and then uses it to cd.
>
> -- robin
>

My guess would be that Dscho mentioned this because git internally
does a chdir() to the path that is cloned, so currently chdir'ing must
be supported for clone to work with a "local repo".

--=20
Erik "kusma" Faye-Lund
