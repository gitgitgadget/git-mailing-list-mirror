From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/8] dir.c: unify is_excluded and is_path_excluded APIs
Date: Mon, 18 Mar 2013 18:00:53 -0400
Message-ID: <CAPig+cRMndy=OLci6nZF9HDn7y9WgCZT=_f_w4CdQEno5h6VaQ@mail.gmail.com>
References: <514775FA.9080304@gmail.com>
	<5147790E.1090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 23:01:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHi7p-0000PB-0W
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 23:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab3CRWA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 18:00:56 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:51159 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab3CRWAz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 18:00:55 -0400
Received: by mail-la0-f50.google.com with SMTP id ec20so6881482lab.9
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=xNAhY6jtFlfdVfxDOyB/NFGsQd9xr+FWDHv1f6T9wu4=;
        b=0LAcXaFvrinN1EyNrs7ZGfMvnCeoT/NdaHNP2v1KFYE25+LwgLnC4W56mJrHtCt+Ta
         qCYxE3AdnuxAcaE/vH6IbTtBaBtw9Er+vS+Spi63rdnoAx0GDLTgEDKy8RuzSaT+EiM8
         HkWYOVPkp7Mt8Fh3h8JFYkGJUZjSaBQ07SkbsWMeFV6WhzC5nZHTee0zHQgFcZ5dLr3t
         //eElepQliep55HiubCVZYscSbHnQxrCKGoChKiJ+Ckg10VMXsJlqovQ0UZWTNTx1tuO
         9gO0ST8eCG2YCcbwpeDIkwINR/mlY1fB0BvriOmoP1bevcjjoG/CrpXyr2CRW4FJm20n
         fQ+g==
X-Received: by 10.112.41.101 with SMTP id e5mr6861443lbl.120.1363644053224;
 Mon, 18 Mar 2013 15:00:53 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Mon, 18 Mar 2013 15:00:53 -0700 (PDT)
In-Reply-To: <5147790E.1090107@gmail.com>
X-Google-Sender-Auth: 1iqgGjSAlM8rFfCLqU2qvuu0rlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218457>

On Mon, Mar 18, 2013 at 4:29 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Directories could also be excluded by exclude patterns specified on the
> command line or .git/info/exclude, so we cannot simply skip prep_exclude
> entirely if there's no .gitignore file name (dir_struct.exclude_per_dir).
> Move this check to just before acutally reading the file.

s/acutally/actually/
