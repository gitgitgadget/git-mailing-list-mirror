From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v6 0/4] cat-file: add a '--literally' option
Date: Thu, 02 Apr 2015 16:23:13 +0530
Message-ID: <551D1F99.5040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 12:53:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdckU-0005Sb-Vj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 12:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbbDBKxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 06:53:21 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33991 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbbDBKxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 06:53:17 -0400
Received: by pactp5 with SMTP id tp5so80890845pac.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 03:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=Yg24SRFvLzTg4XwwfXr3KiWFIedHsC3d5z15SLJjSBs=;
        b=LZTd3Pp7ObEsRhY9nsssGLvdepa4GcdjBGdtDg+lx1rTMVjq6Vr5YfVfqk1LqYczDn
         mJ5ZHF0+84CfMg34Znyaa+ItK5PCm0+fypvI9kQRaKrh8lGes3yz0ySkkF4JZKycb1SO
         s+NMY+0mNxXdYlj2rNplLAtbm2dXKGksDUmuOSuWGb8QqbG+4IzRezcTaSScmJsj1ejI
         cYPWUrZy+IiQLCiV0zrZgSL39vJCfIiWcaKNDw/s55fyl9+bhJQoHH/poqB/cEP8CJj6
         LOO3ViDuajrrToRN1ihOT0FcRKrry2MOkQaDYaS9cRXZS4pNQCwKkxlN1Hx7Hnvv/oTf
         uP3w==
X-Received: by 10.66.101.73 with SMTP id fe9mr87069904pab.156.1427971997486;
        Thu, 02 Apr 2015 03:53:17 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id w17sm4658644pdj.6.2015.04.02.03.53.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2015 03:53:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266634>

The changes made in this version are :

*  unpack_sha1_header_to_strbuf() now checks for Z_STREAM_END and also
the return is not changed to status (as per Junios suggestion) as this 
breaks the check done in sha1_loose_object_info() as the return is 
sometimes Z_BUF_ERROR (-5).

* In sha1_loose_object_info() if the status is set, then change the type 
to status. Also check for this in cat-file.c

* Add documentation and tests for the same.

Thanks for your suggestions.
