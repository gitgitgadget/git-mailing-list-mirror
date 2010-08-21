From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: t5560-http-backend-noserver.sh fails on FreeBSD 8.1-STABLE
Date: Sat, 21 Aug 2010 01:57:59 -0600
Message-ID: <AANLkTimPpiO2RBbNNo0Z8mFm1VH_Ujk7HVskYvh=X2Fc@mail.gmail.com>
References: <AANLkTin8KvXBn4R3-_2_wG3B3QU9F1X0Ax69Rrb1cw1y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 09:58:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmiyA-0003X7-G1
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 09:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434Ab0HUH6W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Aug 2010 03:58:22 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43253 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0HUH6V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Aug 2010 03:58:21 -0400
Received: by eyg5 with SMTP id 5so2641888eyg.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=eOHGpTOM4m7EKmgBRuwU+l7Wr/Jc6zEaYZgnDJaxoWM=;
        b=aLV+WyIfteXTz5Vtc7nZeK8Sc42DeFVi6qBR9AXvqAMIOjkewHyz1//Ft2qM7/8dYf
         9Y/+uDNulB8Tb49XTI9ohDRH3VL89RB+wZbRe4J9QZVS2HM8QcanUmFzpLHx2U9OwV2L
         f9rJ8UpRj2Yr5B3wKJa2h7Jxp47JC6Lnyv3sU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=hr4GdUEGT97XTceoqPuPWU8DfF8XdNazNEaJzIV6Jj4JKMLIAbBKpJh/SCMZYnxIVE
         Bi7IpYeRRPEYkxgaLqaDcghiKDrH+YqF8mzH0EDiywpDZ6GjCwcLpw8TEPguuarV0s0L
         lJno3m9CZYaTobqm4hRTJSmy57EISHt3qZsKs=
Received: by 10.213.112.201 with SMTP id x9mr2273058ebp.56.1282377499573; Sat,
 21 Aug 2010 00:58:19 -0700 (PDT)
Received: by 10.14.45.13 with HTTP; Sat, 21 Aug 2010 00:57:59 -0700 (PDT)
In-Reply-To: <AANLkTin8KvXBn4R3-_2_wG3B3QU9F1X0Ax69Rrb1cw1y@mail.gmail.com>
X-Google-Sender-Auth: 1rY7cNBaPdziCPPo8pe1PgmfDgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154122>

On Thu, Aug 19, 2010 at 9:56 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> I haven't investigate this, but here's the failure output:
>
> ok 7 - static file if http.getanyfile false fails
>
> expecting success:
> =A0 =A0 =A0 =A0log_div "uploadpack default"
> =A0 =A0 =A0 =A0GET info/refs?service=3Dgit-upload-pack "200 OK" =A0&&
> =A0 =A0 =A0 =A0POST git-upload-pack 0000 "200 OK"
>
> --- exp 2010-08-19 15:56:14.000000000 +0000
> +++ act 2010-08-19 15:56:14.000000000 +0000
> @@ -1 +1 @@
> -Status: 200 OK
> +Status: 404 Not Found
> not ok - 8 http.uploadpack default enabled
> #
> # =A0 =A0 =A0 =A0 =A0 =A0 =A0 log_div "uploadpack default"
> # =A0 =A0 =A0 =A0 =A0 =A0 =A0 GET info/refs?service=3Dgit-upload-pack=
 "200 OK" =A0&&
> # =A0 =A0 =A0 =A0 =A0 =A0 =A0 POST git-upload-pack 0000 "200 OK"
> #
>

Thanks for the report.  Is this a new breakage and what version is it
failing on?

Do you ever test with GIT_TEST_HTTPD set?  If not, can you please try t=
his
     export GIT_TEST_HTTPD=3D1 && ./t5561-http-backend.sh -d -i -v
and report back?  Hopefully the test suite will automatically find
apache on FreeBSD, otherwise you may need to give it some hints (see
lib-httpd.sh).

Thanks,
Tarmigan
