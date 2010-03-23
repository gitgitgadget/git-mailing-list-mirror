From: Phil Lawrence <prlawrence@gmail.com>
Subject: git grep -a doesn't find string in binary file
Date: Tue, 23 Mar 2010 16:06:58 -0600
Message-ID: <530ac78e1003231506x295080cey858a5f393548cc53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 23 23:07:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuCFl-0001JJ-8B
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 23:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab0CWWHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 18:07:03 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:33414 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab0CWWHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 18:07:00 -0400
Received: by qyk9 with SMTP id 9so1219229qyk.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=1+YI62AnkCcptybF130PwVqcPOXi/FWqRByLSeARG9c=;
        b=lXmFs+XYzg+wE4gBc33AMs0s7u+m2ZQDkwrfLCgR+KH05G2OscFDPbgdu3DD7idxrn
         TH6uDhUE6m2WTpVoPGvXRjbfmZlkRarHmf6HoKE6wWFgQkkN+XPljYZGvTJ8aeGeQtc8
         5rM1dO87k326r4PCYN7SH3IWKGFyOLCJ3ziY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=aWe/Osn+eR+fvPDklTzbN7j6syRtm/cl+1vEdKjI4ZUVySSU+c4zEXCB1ljif43XKz
         lKSs2oA7XHI+PuLdcu8gxg8TGhxBg6CGCn3We3hhyAzTXb6Lpa6uCdXRseTaUrXo09aY
         nwtYYlNTNi+blBYeDe05UfkHdy+8aI/Fvb7Cw=
Received: by 10.229.241.82 with SMTP id ld18mr1806591qcb.60.1269382018558; 
	Tue, 23 Mar 2010 15:06:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143054>

I have a binary file with the string 'SEGMENT4' inside:
    $ strings AR/reports/BMCD_AGED_AR_CUST.rdf | grep -i segment4
    (CC.SEGMENT1 || '\n' || SEGMENT2 || '\n' || SEGMENT3 || '\n' || SEGMENT4 ...

grep sees it:
    $ grep -li segment4 AR/reports/BMCD_AGED_AR_CUST.rdf | wc -l
          1

git grep does not:
    $ git grep -a -li segment4 AR/reports/BMCD_AGED_AR_CUST.rdf | wc -l
          0

What am I missing?

Here is my environment info:
    $ uname -a
    MINGW32_NT-5.1 B8058 1.0.12(0.46/3/2) 2010-02-05 01:08 i686 unknown

    $ git --version
    git version 1.7.0.2.msysgit.0

Thank you,
Phil Lawrence
