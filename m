From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] grep: don't call regexec() for fixed strings
Date: Mon, 12 Jan 2009 16:32:36 +0100
Message-ID: <81b0412b0901120732t1bd1978awdc4be47767e02863@mail.gmail.com>
References: <4967D8F8.9070508@lsrfire.ath.cx> <4967DB4A.2000702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jan 12 16:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMOnj-0006Gr-9k
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 16:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbZALPcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 10:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbZALPcj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 10:32:39 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:42962 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbZALPci (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 10:32:38 -0500
Received: by wf-out-1314.google.com with SMTP id 27so11403571wfd.4
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 07:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iloffteAWIc/sD90mr6pYAZSMV9UEsJzab+heFDEsDY=;
        b=irJFzpn55OpJZLX5vtjnpcwAaWTojrFNkCg266AI5g6zrhUiiGLSS0VoU0NNIh4Fuh
         DHXaQBta3kaRIUqyyn+7HfjIBylHJVW8hXgBpEaJXev63pJcjdCq2zwafV8EdSndvfY1
         O95cW2lyAoyjHGYDWgUXbKcQGWLiA6vQ7Ot4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FXfXReUG/c44fvaNYFi5f4913sF1Hm4v30jUb4Tj6oUprksc9TaRVE799MHfuQgkMD
         of9gKwPKm9RR/ZHfA1eFHBikqQT2I5VWiX7TqlD0S8Md27pTfPOlU2Ti/zOaMTFV2j6B
         5oyHpBdjpimyU6U+cwUCs89ianf/jKYlDA5p8=
Received: by 10.114.234.13 with SMTP id g13mr19333231wah.64.1231774356863;
        Mon, 12 Jan 2009 07:32:36 -0800 (PST)
Received: by 10.114.179.4 with HTTP; Mon, 12 Jan 2009 07:32:36 -0800 (PST)
In-Reply-To: <4967DB4A.2000702@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105348>

MjAwOS8xLzEwIFJlbsOpIFNjaGFyZmUgPHJlbmUuc2NoYXJmZUBsc3JmaXJlLmF0aC5jeD46Cj4g
K3N0YXRpYyBpbnQgaXNyZWdleHNwZWNpYWwoaW50IGMpCj4gK3sKPiArICAgICAgIHJldHVybiBp
c3NwZWNpYWwoYykgfHwgYyA9PSAnJCcgfHwgYyA9PSAnKCcgfHwgYyA9PSAnKScgfHwgYyA9PSAn
KycgfHwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYyA9PSAnLicgfHwgYyA9PSAn
XicgfHwgYyA9PSAneycgfHwgYyA9PSAnfCc7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgaXNfZml4
ZWQoY29uc3QgY2hhciAqcykKPiArewo+ICsgICAgICAgd2hpbGUgKCFpc3JlZ2V4c3BlY2lhbCgq
cykpCj4gKyAgICAgICAgICAgICAgIHMrKzsKPiArICAgICAgIHJldHVybiAhKnM7Cj4gK30KCnN0
cmNocj8K
