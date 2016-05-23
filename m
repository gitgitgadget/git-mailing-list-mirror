From: Nathan Collins <nathan.collins@gmail.com>
Subject: [BUG?] Spaces not allowed in directory names in .git/info/attributes
Date: Mon, 23 May 2016 12:06:27 -0700
Message-ID: <CAO8RVveOwrS6+pTnHY36d1Nk_B_VJD022W9i8STnNb-KyMkqNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 21:07:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vC7-00014J-Db
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbcEWTHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:07:09 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33522 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbcEWTHI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:07:08 -0400
Received: by mail-yw0-f171.google.com with SMTP id h19so27234141ywc.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=8gUenrHakag+ltq4mtavxnC6gH5dyMRzNoMEn60HvrI=;
        b=Z51oj0uSH8J+7po9iNeMKptlv2tq+q/HBcu1hl7+txJWEXdB38YrPFmYcIHZfW3kXH
         2lB4Bqbu1v63O/M1dN9b7WXl+0ON4Np4wlkjssk/1++va2LsPr2vdMYim6rNk4iFshyM
         kxbluMODgmRe6wFDEytMa4PenGNYCpNWV2anGgqf0Vb+vp0N0rr24vq4g2o5ORW/1nUv
         AQn/6zJF1gCS9oSZXLMrE3PmXi+c6vakfQKwIYQNYCjtLIxooesL8UCntiHlTf3G6TYn
         uj23vhgyxw3qrAwDRb80rXs5ThbdQOwz1z6GlZTWPOCvSZn2NeoVlhkmhuYvbCfL89oi
         ndZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8gUenrHakag+ltq4mtavxnC6gH5dyMRzNoMEn60HvrI=;
        b=SxrDmuIfL/W+QASIE3gwx9JpTH+yi2VnWIxyGVFwlJNgSsugE8yaNCBh5nA3Gqf5oZ
         YARS38mP3J3uyQ12y/4208G7SXiN96g7WI6rnxRKpcryxXWdeQEBe/ioHDCRuDVAZ58Y
         s50FZrPe7do6xdIGT6rLlzTODtCEAzV3UYVFgzViepUYXG7RQH38VI+bxMFV6VcnglpG
         uvFzL33f7EVKptOc2+a2VM8jXuSne/5PVD5sAK3urGTMCgTKdImSKePXQIASdGH9u0/P
         XQ6nmtVG5gta+4+dnTKuXQphGm7QDB6BO48/oIPeUsjZHyd3NO6c4Cakh6L9/9StdskM
         2wQg==
X-Gm-Message-State: ALyK8tKfAi4DIjLKPCHTGccZ12wP/Xy/DqUyStc3M6VJham8f6tzwLlwVS9aPyXiT8xqc7tCWDA2XM1NzcVcpg==
X-Received: by 10.129.164.129 with SMTP id b123mr247716ywh.108.1464030427064;
 Mon, 23 May 2016 12:07:07 -0700 (PDT)
Received: by 10.83.81.5 with HTTP; Mon, 23 May 2016 12:06:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295351>

Example session:

    $ git init test.git
    Initialized empty Git repository in /tmp/test.git/.git/
    $ cd test.git
    $ mkdir "dir name"
    $ touch dir\ name/file.txt
    $ echo "dir\\ name/file.txt -text -whitespace" >> .git/info/attributes
    $ git add dir\ name/file.txt
    name/file.txt is not a valid attribute name: .git/info/attributes:1

I'm using

    $ git --version
    git version 2.5.0

Cheers,

-nathan
