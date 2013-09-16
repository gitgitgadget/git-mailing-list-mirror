From: Matthieu Vachon <matthieu.o.vachon@gmail.com>
Subject: .gitattributes and defaulting to binary
Date: Mon, 16 Sep 2013 17:35:24 -0400
Message-ID: <CAOTvmonjWtUM42ATpEu+s6GVcpTO10BT0izXVB_aqK2npgRfWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 16 23:35:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLgSA-0002KV-6g
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 23:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204Ab3IPVf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 17:35:26 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:33890 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab3IPVfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 17:35:25 -0400
Received: by mail-we0-f179.google.com with SMTP id x55so4172256wes.24
        for <git@vger.kernel.org>; Mon, 16 Sep 2013 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=unVzC2FbBQ+8aKJ2VjmMoC8DJ5Nx5wDnTrz/SpC9XhA=;
        b=aP29RQrE86zk+MdD9mlzE2V6nO60vbI8phvirGuKOejIutrrnHfnfCU8UPlSoLB3y8
         5+WqzNf9Zft0PsENMMUT24GWin8JLLI4oxrezJFEPJT2F//b4Vwl5P1CtguP5QeRafEV
         BmjLFPVuiWk7OjkhalwdXygyY8pJ84V2Jgz8DTENCniQtEfHQUoLhYo5Vxb3hfIkVmHm
         eQcuMtwZyILX390xvF9H41UsiOL03vj/UBXXMPIGRYdKcAp1rKGeSX08tdjNk/W6nCWK
         D4tFzAFi7vV4svWiMKPC6OC6s1iFNnaT5OmBud2cca9mQB9K7nC10fLQ6xXFkhe7iJl4
         RcTQ==
X-Received: by 10.180.89.225 with SMTP id br1mr15143547wib.50.1379367324719;
 Mon, 16 Sep 2013 14:35:24 -0700 (PDT)
Received: by 10.216.152.194 with HTTP; Mon, 16 Sep 2013 14:35:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234844>

Hi all,

I would like to craft my `.gitattributes` in a way that all files
expect those specified in it are treated as binary from a line-ending
normalization point of view (and diff viewing).

But I was not able to achieve it right now. When having this in my
`.gitattributes`, git treats all files as binary, even the one
explicitly specified like `*.txt`:

    *.txt text
    * binary

I tried with:

    *.txt text
    * -text

And it does not seem to work correctly neither because then, my
`test.txt` file is not having correct line ending when setting
`core.eol` to `crlf` (or using `eol=crlf` in the `.gitattributes`
file).

So, is it possible to do something like that? If yes, is my sample
`.gitattributes` should work?

Regards,
Matt
