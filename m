From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/11] Large blob fixes
Date: Tue, 28 Feb 2012 08:23:01 +0700
Message-ID: <CACsJy8D9Mfs5OvpLsoEqMAoJ3PR9Hka_V+4Mzmc3GpsZtYtm-g@mail.gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com> <7v7gz89kws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 02:23:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2BnD-00059y-Az
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 02:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965495Ab2B1BXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 20:23:34 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:54126 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965491Ab2B1BXd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 20:23:33 -0500
Received: by wejx9 with SMTP id x9so661658wej.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 17:23:32 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.216.134.74 as permitted sender) client-ip=10.216.134.74;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.216.134.74 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.216.134.74])
        by 10.216.134.74 with SMTP id r52mr8312590wei.19.1330392212280 (num_hops = 1);
        Mon, 27 Feb 2012 17:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Y5/15yEp6mXK6cbpF9P21cxBdBXXdpSZU1LKO7FNlnQ=;
        b=n1Q5eIFNv81mfxCPuCUBGyhOLqnHvyVifQ2j86zAbU+XG1Yxp911St3cAsrjAGcu1u
         E7AyG2VGW8EtFohumNQe/IBLcBjZLm5PIf4wO+BViY7p9cUJTunYvXmI2Q3Hcvt+7Ugf
         nXDaqQ1HQVMAnYEqNg+vnuldPGA6r5qwWp5pk=
Received: by 10.216.134.74 with SMTP id r52mr6597998wei.19.1330392212186; Mon,
 27 Feb 2012 17:23:32 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Mon, 27 Feb 2012 17:23:01 -0800 (PST)
In-Reply-To: <7v7gz89kws.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191694>

2012/2/28 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> These patches make sure we avoid keeping whole blob in memory, at
>> least in common cases. Blob-only streaming code paths are opened to
>> accomplish that.
>
> Some in the series seem to be unrelated to the above, namely, the
> index-pack ones.

index-pack patches in this series can make "index-pack --verify"
worse, but it's already not so good. Will take the --verify patch out.
I will need better strategy than blindly skipping sha-1 collision test
when --verify is specified.
--=20
Duy
